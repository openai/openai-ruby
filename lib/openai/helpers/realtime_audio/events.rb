# frozen_string_literal: true

module OpenAI
  module Realtime
    class AudioSession
      private def receive_events
        while (raw = @connection.receive_raw)
          data = JSON.parse(raw, symbolize_names: true)
          handle_event(data)
          publish(@connection.parse_event(raw)) unless data[:type] == "response.output_audio.delta"
        end

        if @turn ||
            @vad_input ||
            @responses.any? { |_id, response| response[:status] == "in_progress" } ||
            @items.any? { |_key, item| !item[:position] }
          raise Errors::RealtimeAudioSessionError, "The remote connection closed during an unfinished audio turn."
        end

        @remote_closed = true
        @mutex.synchronize {
          @closing = true
          @changed.broadcast
        }
      rescue StandardError => error
        fail_session(error) unless closing?
      end

      private def handle_event(event)
        case event[:type]
        when "session.updated"
          unless @configuration.compatible?(event.fetch(:session))
            raise Errors::RealtimeAudioSessionError, "The server did not accept the required audio configuration."
          end

          @configured = true
        when "response.created"
          @response_generation += 1
          response = event.fetch(:response)
          @responses[response.fetch(:id)] = {status: response.fetch(:status), epoch: @conversation_epoch}
        when "response.done"
          response = event.fetch(:response)
          record = @responses.fetch(response.fetch(:id))
          record[:status] = response.fetch(:status)
          response.fetch(:output, []).each do |item|
            register_output_item(response.fetch(:id), item)
          end

          if ["failed", "incomplete", "cancelled"].include?(record[:status]) && !record[:interrupted]
            @commands << [:response_failed, [], nil]
          end

        when "response.output_item.added", "response.output_item.done"
          register_output_item(event.fetch(:response_id), event.fetch(:item))
        when "response.output_audio.delta"
          key, item = audio_item(event)
          encoded = event.fetch(:delta)
          offset = 0
          while offset < encoded.bytesize
            chunk = encoded.byteslice(offset, 65_536)
            offset += chunk.bytesize
            if offset < encoded.bytesize && chunk.include?("=")
              raise LocalAudio::FormatError, "Invalid encoded audio padding."
            end

            pcm = chunk.unpack1("m0")
            item[:bytes] += pcm.bytesize
            unless @responses.fetch(key[0])[:interrupted]
              if @configuration.playback_policy == :half_duplex
                set_gate(false)
                @playback_gated = true
              end

              @output.append(key, pcm)
            end
          end

        when "response.output_audio.done"
          key, item = audio_item(event)
          raise LocalAudio::FormatError, "Server audio ended with an incomplete PCM sample." if item[:bytes].odd?
          item[:done] = true
          @output.finish(key) unless @responses.fetch(key[0])[:interrupted]
        when "input_audio_buffer.speech_started"
          @conversation_epoch += 1
          @vad_input = {epoch: @conversation_epoch, committed: false} unless @configuration.mode == :push_to_talk
          start_local_interruption
          @commands << [:interrupt, [:user_speech], nil]
        when "input_audio_buffer.committed"
          @commit_serial += 1
          @input_frames = 0
          unless @configuration.mode == :push_to_talk
            @vad_input = {epoch: @conversation_epoch, committed: true}
            @commands << [:vad_commit, [@conversation_epoch], nil]
          end

        when "input_audio_buffer.cleared"
          @clear_serial += 1
          @vad_input = nil if @vad_input && !@vad_input[:committed]
        when "conversation.item.created", "conversation.item.added"
          id = event.fetch(:item).fetch(:id)
          @created_items[id] = true if @created_items.key?(id)
        when "conversation.item.truncated"
          @truncated[[event.fetch(:item_id), event.fetch(:content_index)]] = event.fetch(:audio_end_ms)
        when "error"
          # A correlated cancel race still requires the reconciliation task to
          # observe the matching terminal response before its control deadline.
          error = event.fetch(:error)
          if @pending_commit &&
              error[:event_id] == @pending_commit[:event_id] &&
              error[:code] == "input_audio_buffer_commit_empty"
            @pending_commit[:error] = @connection.parse_event(JSON.generate(event))
            return
          end

          correlated = @responses.any? do |_id, cancelled|
            cancelled[:cancel_event_id] &&
              cancelled[:cancel_event_id] == error[:event_id] &&
              error[:code] == "response_cancel_not_active"
          end

          correlated ||= error[:code] == "response_cancel_not_active" && @completed_cancels.key?(error[:event_id])
          raise Errors::RealtimeAudioSessionError, "The server rejected a managed audio operation." unless correlated
        end
      end

      private def audio_item(event)
        raise Errors::RealtimeAudioSessionError, "Audio arrived before device startup." unless @output
        key = [event.fetch(:response_id).dup.freeze, event.fetch(:item_id).dup.freeze, event.fetch(:content_index)].freeze
        raise Errors::RealtimeAudioSessionError, "Unsupported audio content index." unless key[2] == 0
        @responses.fetch(key[0])
        [key, @items[key] ||= {bytes: 0, done: false}]
      end

      private def register_output_item(response_id, item)
        if item[:type] == "function_call"
          @tool_calls[item.fetch(:call_id)] = @responses.fetch(response_id)[:epoch]
        end

        item.fetch(:content, []).each_with_index do |part, index|
          next unless part[:type] == "audio"
          key = [response_id.dup.freeze, item.fetch(:id).dup.freeze, index].freeze
          @items[key] ||= {bytes: 0, done: false}
        end
      end

      private def start_local_interruption
        return unless @output
        active = @responses.select do |id, response|
          response[:status] == "in_progress" || @items.any? { |key, item| key[0] == id && !item[:position] }
        end

        return if active.empty?
        active.each_value do |response|
          response[:interrupted] = true
          response[:reconciliation_pending] = true
        end

        return if @abort_thread&.alive?
        @abort_thread = Thread.new do
          @output.interrupt
        rescue StandardError => error
          @notifications << [:failure, error]
        end

        @abort_thread.report_on_exception = false
      end

      private def drain_capture(force: false)
        loop do
          frame = @capture.pop(true) rescue nil
          break unless frame
          epoch, pcm = frame
          @send_lock.acquire do
            next unless epoch == @generation_epoch && (force || @capture_gate || @finishing_turn) && !closing?
            @task.with_timeout(@options[:control_timeout]) do
              @connection.input_audio_buffer.append_bytes(pcm)
            end

            @input_frames += pcm.bytesize / 2
          end
        end
      end

      private def release_completed_output
        now = LocalAudio::MediaProcess.clock
        @completed_cancels.delete_if { |_id, deadline| deadline <= now }
        return if @reconciling || @reconciliation_running
        completed = @responses
          .select do |id, response|
            response[:status] != "in_progress" &&
              !response[:reconciliation_pending] &&
              @items.all? { |key, item| key[0] != id || item[:position] }
          end
          .keys
        return if completed.empty?
        keys = @items.keys.select { |key| completed.include?(key[0]) }
        @output&.release(keys)
        keys.each do |key|
          @items.delete(key)
          @truncated.delete([key[1], key[2]])
        end

        completed.each do |id|
          response = @responses.delete(id)
          if response[:cancel_event_id]
            @completed_cancels[response[:cancel_event_id]] = now + @options[:control_timeout]
          end
        end
      end

      private def drain_notifications
        loop do
          notification = @notifications.pop(true) rescue nil
          break unless notification
          type, *values = notification
          case type
          when :failure
            raise values.first
          when :playback_started
            key = values.first
            publish(PlaybackStarted.new(response_id: key[0], item_id: key[1], content_index: key[2]))
          when :playback_finished
            key, position, interrupted = values
            # Interruption can retire the item before the device thread delivers
            # its terminal notification. Its position was already reconciled.
            next if interrupted && !@items.key?(key)
            @items.fetch(key)[:position] = position
            unless interrupted
              publish(
                PlaybackFinished.new(response_id: key[0], item_id: key[1], content_index: key[2], position: position)
              )
            end

            @echo_until = LocalAudio::MediaProcess.clock + @options[:half_duplex_tail_duration]
          end
        end

        release_completed_output
        if @playback_gated &&
            @items.all? { |_key, item| item[:position] } &&
            @echo_until &&
            LocalAudio::MediaProcess.clock >= @echo_until
          @playback_gated = false
          set_gate(@configuration.mode != :push_to_talk || !@turn.nil?)
          input_event(:playback_gate)
        end
      end
    end
  end
end
