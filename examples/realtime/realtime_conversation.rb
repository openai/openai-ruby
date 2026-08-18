#!/usr/bin/env ruby
# frozen_string_literal: true

require "async"
require "async/barrier"
require "timeout"
require_relative "../../lib/openai"
require_relative "audio_files"
require_relative "event_stream"

module OpenAI
  module Examples
    module Realtime
      module Conversation
        AUDIO_BYTES_PER_SECOND = 48_000
        CHUNK_BYTES = 4_800

        class FFmpegMicrophone
          def initialize(input_format:, device:)
            @input_format = input_format
            @device = device
            @pid = nil
            @stopping = false
          end

          def each_chunk
            return enum_for(__method__) unless block_given?
            return if @stopping

            reader, writer = IO.pipe
            @pid = Process.spawn(*command, out: writer, err: $stderr)
            writer.close
            reader.binmode
            while (chunk = reader.read(CHUNK_BYTES))
              yield(chunk)
            end
          rescue Errno::ENOENT
            raise "ffmpeg was not found; install it with `brew install ffmpeg`"
          ensure
            writer&.close unless writer&.closed?
            reader&.close unless reader&.closed?
            wait_for_capture
          end

          def stop
            @stopping = true
            return unless @pid

            Process.kill("INT", @pid)
          rescue Errno::ESRCH
            nil
          end

          private def command
            [
              "ffmpeg",
              "-nostdin",
              "-loglevel",
              "error",
              "-thread_queue_size",
              "1024",
              "-f",
              @input_format,
              "-i",
              @device,
              "-ac",
              "1",
              "-ar",
              "24000",
              "-acodec",
              "pcm_s16le",
              "-f",
              "s16le",
              "pipe:1"
            ]
          end

          private def wait_for_capture
            return unless @pid

            _, status = Process.wait2(@pid)
            return if @stopping || status.success?

            raise "ffmpeg microphone capture exited with status #{status.exitstatus}"
          rescue Errno::ECHILD
            nil
          ensure
            @pid = nil
          end
        end

        class PCMFileMicrophone
          attr_reader :path

          def initialize(path)
            @path = path
            @stopping = false
          end

          def each_chunk
            return enum_for(__method__) unless block_given?

            File.open(@path, "rb") do |input|
              while !@stopping && (chunk = input.read(CHUNK_BYTES))
                yield(chunk)
                sleep(chunk.bytesize.fdiv(AUDIO_BYTES_PER_SECOND))
              end
            end
            10.times do
              break if @stopping

              yield("\0".b * CHUNK_BYTES)
              sleep(CHUNK_BYTES.fdiv(AUDIO_BYTES_PER_SECOND))
            end
          end

          def stop = @stopping = true
        end

        class FFplaySpeaker
          def initialize
            @input = nil
            @pid = nil
          end

          def write(bytes)
            start unless @input
            @input.write(bytes)
            @input.flush
          rescue Errno::EPIPE
            interrupt
            raise "ffplay stopped while playing Realtime audio"
          end

          def interrupt
            return unless @pid

            Process.kill("TERM", @pid)
            @input&.close unless @input&.closed?
            Process.wait(@pid)
          rescue Errno::ESRCH, Errno::ECHILD
            nil
          ensure
            @input = nil
            @pid = nil
          end

          alias_method :close, :interrupt

          private def start
            reader, writer = IO.pipe
            @pid = Process.spawn(*command, in: reader, out: File::NULL, err: $stderr)
            reader.close
            writer.binmode
            @input = writer
          rescue Errno::ENOENT
            raise "ffplay was not found; install it with `brew install ffmpeg`"
          ensure
            reader&.close unless reader&.closed?
          end

          private def command
            [
              "ffplay",
              "-nodisp",
              "-nostats",
              "-loglevel",
              "error",
              "-fflags",
              "nobuffer",
              "-flags",
              "low_delay",
              "-probesize",
              "32",
              "-analyzeduration",
              "0",
              "-f",
              "s16le",
              "-ar",
              "24000",
              "-ch_layout",
              "mono",
              "-i",
              "pipe:0"
            ]
          end
        end

        class PCMFileSpeaker
          attr_reader :path

          def initialize(path)
            @path = path
            @output = nil
          end

          def prepare(input_path:)
            @output ||= AudioFiles.open_output(input_path: input_path, output_path: @path)
          end

          def write(bytes)
            @output ||= File.open(@path, "wb")
            @output.write(bytes)
          end

          def interrupt = @output&.flush

          def close
            @output&.close unless @output&.closed?
          end
        end

        # Serializes every client event through one writer fiber. The one-item queue
        # preserves microphone backpressure while allowing the reader to enqueue an
        # interruption without writing to the socket itself.
        class OutboundWriter
          def initialize(connection)
            @connection = connection
            @queue = Thread::SizedQueue.new(1)
            @failure = nil
          end

          def append_audio(bytes)
            enqueue([:append_audio, bytes])
          end

          def truncate(**params)
            enqueue([:truncate, params])
          end

          def run
            while (message = @queue.pop)
              operation, payload = message
              case operation
              when :append_audio
                @connection.input_audio_buffer.append_bytes(payload)
              when :truncate
                @connection.conversation.items.truncate(**payload)
              end
            end
          rescue StandardError => e
            @failure = e
            raise
          ensure
            close
          end

          def close
            @queue.close unless @queue.closed?
          end

          private def enqueue(message)
            @queue.push(message)
          rescue ClosedQueueError
            raise @failure if @failure

            raise
          end
        end

        class AudioPlayback
          def initialize(speaker, clock: nil)
            @speaker = speaker
            @clock = clock || -> { Process.clock_gettime(Process::CLOCK_MONOTONIC) }
            @interrupted_response_id = nil
            reset_current
          end

          def write(event)
            return if interrupted?(event.response_id)

            start_response(event) unless current?(event)
            bytes = Base64.strict_decode64(event.delta)
            @speaker.write(bytes)
            @received_bytes += bytes.bytesize
          end

          def interrupt(outbound)
            expire_finished_playback
            unless @item_id
              @speaker.interrupt
              return
            end

            audio_end_ms = played_ms
            response_id = @response_id
            item_id = @item_id
            content_index = @content_index

            @speaker.interrupt
            outbound.truncate(
              item_id: item_id,
              content_index: content_index,
              audio_end_ms: audio_end_ms
            )
            @interrupted_response_id = response_id
            reset_current
            response_id
          end

          def interrupted?(response_id) = response_id == @interrupted_response_id

          def finish(response_id)
            if interrupted?(response_id)
              @interrupted_response_id = nil
            elsif response_id == @response_id
              @finished_response_id = response_id
              expire_finished_playback
            end
          end

          def close = @speaker.close

          private def current?(event)
            @response_id == event.response_id &&
              @item_id == event.item_id &&
              @content_index == event.content_index
          end

          private def start_response(event)
            @response_id = event.response_id
            @item_id = event.item_id
            @content_index = event.content_index
            @received_bytes = 0
            @started_at = @clock.call
          end

          private def played_ms
            elapsed_ms = ((@clock.call - @started_at) * 1_000).floor
            received_ms = (@received_bytes * 1_000) / AUDIO_BYTES_PER_SECOND
            [elapsed_ms, received_ms].min.clamp(0, received_ms)
          end

          private def expire_finished_playback
            return unless @finished_response_id
            return unless @finished_response_id == @response_id
            return unless elapsed_audio_bytes >= @received_bytes

            reset_current
          end

          private def elapsed_audio_bytes
            ((@clock.call - @started_at) * AUDIO_BYTES_PER_SECOND).floor
          end

          private def reset_current
            @response_id = nil
            @item_id = nil
            @content_index = nil
            @received_bytes = 0
            @started_at = nil
            @finished_response_id = nil
          end
        end

        module_function

        def configure(connection, voice:, instructions:)
          connection.session.update(
            type: :realtime,
            output_modalities: [:audio],
            instructions: instructions,
            audio: {
              input: {
                format: {type: :"audio/pcm", rate: 24_000},
                noise_reduction: {type: :near_field},
                turn_detection: {
                  type: :server_vad,
                  threshold: 0.5,
                  prefix_padding_ms: 300,
                  silence_duration_ms: 500,
                  create_response: true,
                  interrupt_response: true
                }
              },
              output: {
                format: {type: :"audio/pcm", rate: 24_000},
                voice: voice
              }
            }
          )
        end

        def forward_microphone(outbound, microphone)
          microphone.each_chunk do |chunk|
            outbound.append_audio(chunk)
          end
        end

        def handle_event(event, outbound:, playback:, output:)
          case event
          when OpenAI::Realtime::ResponseAudioDeltaEvent
            playback.write(event)
          when OpenAI::Realtime::ResponseAudioTranscriptDeltaEvent
            return if playback.interrupted?(event.response_id)

            output.print(event.delta)
            output.flush
          when OpenAI::Realtime::ResponseAudioTranscriptDoneEvent
            return if playback.interrupted?(event.response_id)

            output.puts
          when OpenAI::Realtime::InputAudioBufferSpeechStartedEvent
            output.puts if playback.interrupt(outbound)
          when OpenAI::Realtime::RealtimeErrorEvent
            raise event.error.message
          when OpenAI::Realtime::ResponseDoneEvent
            playback.finish(event.response.id)
            return if [:cancelled, :completed].include?(event.response.status)

            raise "Realtime response ended with #{event.response.status}"
          end
        end

        def stream_events(connection, microphone:, outbound:, playback:, output:, stop_after: nil)
          EventStream.each_until(connection, stop_after: stop_after) do |event|
            handle_event(event, outbound: outbound, playback: playback, output: output)
            if stop_after == "response.done" &&
                event.is_a?(OpenAI::Realtime::ResponseDoneEvent) &&
                event.response.status != :completed
              raise "Realtime response was cancelled before bounded smoke completed"
            end
          end
        ensure
          microphone.stop
        end

        def run_session(
          connection,
          microphone:,
          speaker:,
          voice:,
          instructions:,
          output: $stdout,
          stop_after: nil
        )
          configure(connection, voice: voice, instructions: instructions)
          EventStream.wait_for(
            connection,
            OpenAI::Realtime::SessionUpdatedEvent,
            closed_message: "Realtime connection closed before session.updated"
          )
          output.puts(
            "Connected. Talk naturally; speak over the model to interrupt. " \
            "Press Ctrl-C to exit. Use headphones to prevent echo."
          )
          playback = AudioPlayback.new(speaker)
          outbound = OutboundWriter.new(connection)

          barrier = Async::Barrier.new
          barrier.async do
            outbound.run
            [:writer, nil]
          rescue StandardError => e
            [:writer, e]
          end
          barrier.async do
            stream_events(
              connection,
              microphone: microphone,
              outbound: outbound,
              playback: playback,
              output: output,
              stop_after: stop_after
            )
            [:receiver, nil]
          rescue StandardError => e
            [:receiver, e]
          end
          barrier.async do
            forward_microphone(outbound, microphone)
            [:sender, nil]
          rescue StandardError => e
            [:sender, e]
          end
          barrier.wait do |task|
            result, error = task.wait
            if result == :receiver
              if error || stop_after
                connection.abort
                raise error if error

                break
              end

              next
            end
            raise error if error

            outbound.close if result == :sender
          end
        ensure
          microphone.stop
          outbound&.close
          barrier&.stop
          playback&.close || speaker.close
        end

        def run(
          client:,
          model:,
          microphone:,
          speaker:,
          voice:,
          instructions:,
          output: $stdout,
          stop_after: nil
        )
          file_backed = microphone.is_a?(PCMFileMicrophone) && speaker.is_a?(PCMFileSpeaker)
          speaker.prepare(input_path: microphone.path) if file_backed

          client.realtime.connect(model: model) do |connection|
            run_session(
              connection,
              microphone: microphone,
              speaker: speaker,
              voice: voice,
              instructions: instructions,
              output: output,
              stop_after: stop_after
            )
          end
        ensure
          speaker.close if file_backed
        end
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  begin
    input_path = ENV["REALTIME_INPUT_PCM"]
    microphone =
      if input_path
        OpenAI::Examples::Realtime::Conversation::PCMFileMicrophone.new(input_path)
      else
        default_format = RUBY_PLATFORM.include?("darwin") ? "avfoundation" : "pulse"
        default_device = RUBY_PLATFORM.include?("darwin") ? ":0" : "default"
        OpenAI::Examples::Realtime::Conversation::FFmpegMicrophone.new(
          input_format: ENV.fetch("REALTIME_AUDIO_INPUT_FORMAT", default_format),
          device: ENV.fetch("REALTIME_MIC_DEVICE", default_device)
        )
      end
    stop_after = input_path ? "response.done" : nil
    output_path = ENV["REALTIME_OUTPUT_PCM"]
    speaker =
      if output_path
        OpenAI::Examples::Realtime::Conversation::PCMFileSpeaker.new(output_path)
      else
        OpenAI::Examples::Realtime::Conversation::FFplaySpeaker.new
      end
    run = lambda do
      OpenAI::Examples::Realtime::Conversation.run(
        client: OpenAI::Client.new,
        model: ENV.fetch("OPENAI_REALTIME_MODEL", "gpt-realtime-2.1"),
        microphone: microphone,
        speaker: speaker,
        voice: ENV.fetch("OPENAI_REALTIME_VOICE", "marin"),
        instructions: ENV.fetch(
          "OPENAI_REALTIME_INSTRUCTIONS",
          "Have a natural spoken conversation. Keep each response concise."
        ),
        stop_after: stop_after
      )
    end

    timeout = ENV["OPENAI_REALTIME_TIMEOUT"]
    timeout ? Timeout.timeout(Integer(timeout)) { run.call } : run.call
  rescue Interrupt
    warn("\nConversation ended.")
  end
end
