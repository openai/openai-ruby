# frozen_string_literal: true

module OpenAI
  module Realtime
    class AudioSession
      private def control(operation, *arguments)
        case operation
        when :start
          start_devices
        when :mute
          change_mute(true)
        when :unmute
          change_mute(false)
        when :interrupt
          begin_interruption(arguments.first || :manual)
          reconcile
        when :start_turn
          begin_turn
        when :finish_turn
          complete_turn(*arguments)
        when :send_text
          create_text(*arguments)
        when :submit_tool_output
          create_tool_output(*arguments)
        when :respond
          create_response(epoch: arguments.first)
        when :vad_commit
          unless arguments.first == @conversation_epoch
            @vad_input = nil if @vad_input && @vad_input[:epoch] == arguments.first
            return nil
          end

          begin_interruption(:user_speech)
          reconcile
          create_response(epoch: arguments.first, vad_commit: true)
          @vad_input = nil if @vad_input && @vad_input[:epoch] == arguments.first
        when :response_failed
          begin_interruption(:response_error)
          reconcile
        else
          raise Errors::RealtimeAudioStateError, "Unsupported audio control."
        end
      end

      private def start_devices
        return self if state == :running
        @output = background(cleanup: -> (output) { output.close }) do
          AudioOutput.new(
            device: @output_device,
            buffer_duration: @options[:output_buffer_duration],
            directory: @options[:playback_directory],
            notifications: @notifications,
            control_timeout: @options[:control_timeout],
            cleanup_timeout: @options[:cleanup_timeout]
          )
        end

        @microphone = background(cleanup: -> (microphone) { microphone.stop }) do
          LocalAudio::Microphone.new(
            device: @input_device,
            frame_duration: @options[:frame_duration],
            buffer_duration: @options[:input_buffer_duration],
            control_timeout: @options[:control_timeout],
            cleanup_timeout: @options[:cleanup_timeout]
          )
        end

        @mutex.synchronize { @state = :running }
        @capture_thread = Thread.new do
          @microphone.each_frame do |generation, pcm|
            @mutex.synchronize do
              if (@capture_gate || @finishing_turn) && generation == @generation_epoch && !@closing
                @capture.push([generation, pcm], true)
              end
            end
          end

        rescue ThreadError
          @notifications << [:failure, LocalAudio::CaptureOverflowError.new("Microphone transmission fell behind.")]
        rescue StandardError => error
          @notifications << [:failure, error] unless closing?
        end

        @capture_thread.report_on_exception = false
        await { @microphone.started? }
        set_gate(@configuration.mode != :push_to_talk)
        input_event(:started)
        self
      end

      private def require_running
        raise Errors::RealtimeAudioStateError, "Call start before using audio controls." unless state == :running
      end

      private def set_gate(open)
        request = @mutex.synchronize do
          @gate_request = (@gate_request || 0) + 1
          @capture.clear
          @capture_gate = false
          @gate_request
        end

        return unless open && !@muted && !@playback_gated && !closing?
        generation = background { @microphone.fence }
        @mutex.synchronize do
          if request == @gate_request && !@muted && !@playback_gated && !@closing
            @generation_epoch = generation
            @capture_gate = true
          end
        end
      end

      private def input_event(reason)
        publish(InputStateChanged.new(capturing: @capture_gate, muted: @muted, reason: reason))
      end

      private def change_mute(value)
        require_running
        return self if @muted == value
        @muted = value
        set_gate(false)
        clear_input if value
        set_gate(@configuration.mode != :push_to_talk || !@turn.nil?) unless value
        input_event(value ? :muted : :unmuted)
        self
      end

      private def clear_input
        serial = @clear_serial
        send_wire(type: "input_audio_buffer.clear")
        await { @clear_serial > serial }
        @input_frames = 0
      end

      private def begin_turn
        require_running
        unless @configuration.mode == :push_to_talk
          raise Errors::RealtimeAudioStateError, "start_turn requires push-to-talk mode."
        end

        raise Errors::RealtimeAudioStateError, "An input turn is already active." if @turn
        raise Errors::RealtimeAudioStateError, "Unmute before starting an input turn." if @muted
        begin_interruption(:new_input)
        start_reconciliation
        @conversation_epoch += 1
        @turn = InputTurn.new(self)
        @input_frames = 0
        @turn_action = nil
        wait_for_echo_tail
        @playback_gated = false
        set_gate(true)
        @turn
      end

      private def complete_turn(turn, action)
        require_running
        if (completion = turn.completion_for(self))
          completed_action, error = completion
          raise error if error && action == :commit
          return nil if action == completed_action
          raise Errors::RealtimeAudioStateError, "Input turn already finished with a different outcome."
        end

        unless turn.equal?(@turn)
          raise Errors::RealtimeAudioStateError, "Input turn is stale or belongs to another session."
        end
        # Stop accepting new capture and drain the already accepted frame fence.
        @mutex.synchronize {
          @capture_gate = false
          @finishing_turn = true
        }
        background { @microphone.fence }
        drain_capture(force: true)
        @send_lock.acquire { |_value| nil }
        @finishing_turn = false
        if action == :discard
          clear_input
        else
          if @input_frames.zero?
            set_gate(true)
            raise Errors::RealtimeAudioStateError, "Cannot commit an empty input turn."
          end

          serial = @commit_serial
          commit = {event_id: "audio_commit_#{SecureRandom.hex(12)}"}
          @pending_commit = commit
          send_wire(type: "input_audio_buffer.commit", event_id: commit[:event_id])
          await { @commit_serial > serial || commit[:error] }
          @pending_commit = nil
          if commit[:error]
            clear_input
            error = Errors::RealtimeAudioTurnError.new(event: commit[:error])
            @turn.record_completion(:failed, error: error)
            @turn = nil
            input_event(:turn_discarded)
            raise error
          end

          reconcile
        end

        @turn.record_completion(action)
        @turn = nil
        input_event(action == :discard ? :turn_discarded : :turn_committed)
        create_response if action == :commit
        nil
      end

      private def create_text(text)
        require_running
        raise ArgumentError, "text must be a nonempty String" unless text.is_a?(String) && !text.empty?
        raise Errors::RealtimeAudioStateError, "Finish the active input turn first." if @turn
        begin_interruption(:new_input)
        reconcile
        @conversation_epoch += 1
        id = "audio_#{SecureRandom.hex(12)}"
        @created_items[id] = false
        send_wire(
          type: "conversation.item.create",
          item: {
            id: id,
            type: "message",
            role: "user",
            content: [{type: "input_text", text: text}]
          }
        )
        await { @created_items[id] }
        @created_items.delete(id)
        create_response
        nil
      end

      private def create_tool_output(call_id, output)
        require_running
        raise ArgumentError, "output must be a String" unless output.is_a?(String)
        raise Errors::RealtimeAudioStateError, "Unknown tool call." unless @tool_calls.key?(call_id)
        if @tool_outputs.key?(call_id)
          unless @tool_outputs[call_id] == Digest::SHA256.digest(output)
            raise Errors::RealtimeAudioStateError, "Tool output conflicts with a confirmed submission."
          end

          return nil
        end

        id = "audio_#{SecureRandom.hex(12)}"
        @created_items[id] = false
        send_wire(
          type: "conversation.item.create",
          item: {id: id, type: "function_call_output", call_id: call_id, output: output}
        )
        await { @created_items[id] }
        @created_items.delete(id)
        @tool_outputs[call_id] = Digest::SHA256.digest(output).freeze
        nil
      end

      private def create_response(epoch: @conversation_epoch, vad_commit: false)
        require_running
        reconcile if @reconciling
        if @turn || (@vad_input && (!vad_commit || !@vad_input[:committed]))
          raise Errors::RealtimeAudioStateError, "An input turn is still active."
        end

        if @responses.any? { |_id, response| response[:status] == "in_progress" }
          raise Errors::RealtimeAudioStateError, "A response is still generating."
        end

        if @tool_calls.any? { |id, call_epoch| call_epoch == @conversation_epoch && !@tool_outputs.key?(id) }
          raise Errors::RealtimeAudioStateError, "Submit all tool outputs before requesting continuation."
        end

        return nil unless epoch == @conversation_epoch
        count = @response_generation
        @send_lock.acquire do
          return nil unless epoch == @conversation_epoch
          if @vad_input && (!vad_commit || !@vad_input[:committed])
            raise Errors::RealtimeAudioStateError, "An input turn is still active."
          end

          @connection.send_event(type: "response.create")
        end

        await { @response_generation > count }
        nil
      end

      private def begin_interruption(reason)
        require_running
        return if @reconciling
        ids = @responses
          .select do |id, response|
            response[:reconciliation_pending] ||
              response[:status] == "in_progress" ||
              @items.any? { |key, item| key[0] == id && !item[:position] }
          end
          .keys
        return if ids.empty?
        @reconciling = {ids: ids, reason: reason}
        ids.each { |id| @responses.fetch(id)[:interrupted] = true }
        positions = background do
          @abort_thread&.join
          @output.interrupt
        end

        @playback_gated = true if @configuration.playback_policy == :half_duplex
        @echo_until = LocalAudio::MediaProcess.clock + @options[:half_duplex_tail_duration]
        @items.each { |key, item| item[:position] ||= positions[key] if ids.include?(key[0]) }
        ids.each do |id|
          next unless @responses.fetch(id)[:status] == "in_progress"
          event_id = "audio_cancel_#{SecureRandom.hex(12)}"
          @responses.fetch(id)[:cancel_event_id] = event_id
          send_wire(type: "response.cancel", response_id: id, event_id: event_id)
        end
      end

      private def start_reconciliation
        return if @reconciliation_running || !@reconciling
        @reconciliation_running = true
        @reconciliation_task = @task.async do
          @last_interruption = perform_reconciliation
        rescue StandardError => error
          fail_session(error) unless closing?
        ensure
          @reconciliation_running = false
        end
      end

      private def reconcile
        return Interruption.new(items: []) unless @reconciling || @reconciliation_running
        start_reconciliation
        await { !@reconciliation_running }
        raise_failure
        @last_interruption
      end

      private def perform_reconciliation
        return Interruption.new(items: []) unless @reconciling
        ids = @reconciling[:ids]
        await { ids.none? { |id| @responses.fetch(id)[:status] == "in_progress" } }
        records = []
        @items.each do |key, item|
          next unless ids.include?(key[0])
          position = item[:position] ||= LocalAudio::PlaybackPosition.new(played_frames: 0)
          unless key[2] == 0
            raise Errors::RealtimeAudioSessionError, "The server returned an unsupported audio content index."
          end

          records << ItemPosition.new(response_id: key[0], item_id: key[1], content_index: key[2], position: position)
          next if item[:done] && position.played_frames * 2 == item[:bytes]
          cutoff = position.played_frames * 1000 / 24_000
          send_wire(type: "conversation.item.truncate", item_id: key[1], content_index: key[2], audio_end_ms: cutoff)
          await { @truncated[[key[1], key[2]]] == cutoff }
          item[:position] = position
          publish(
            PlaybackInterrupted.new(
              response_id: key[0],
              item_id: key[1],
              content_index: key[2],
              position: position,
              reason: @reconciling[:reason]
            )
          )
        end

        ids.each { |id| @responses.fetch(id)[:reconciliation_pending] = false }
        @reconciling = nil
        Interruption.new(items: records)
      end

      private def wait_for_echo_tail
        return unless @configuration.playback_policy == :half_duplex && @echo_until
        delay = @echo_until - LocalAudio::MediaProcess.clock
        @task.sleep(delay) if delay.positive?
      end
    end
  end
end
