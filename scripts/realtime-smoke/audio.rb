# frozen_string_literal: true

require "stringio"
require "timeout"

require_relative "../../examples/realtime/websocket_transcription"
require_relative "../../examples/realtime/websocket_voice_turn"

module RealtimeSmoke
  # These are smoke fixture limits, not SDK/API payload limits.
  class Audio
    DEADLINE = 60
    INPUT_BYTES = 6 * 24_000 * 2
    OUTPUT_TOKENS = 128
    SPEECH = "Say hello."

    def initialize(client:, deadline: DEADLINE)
      @client = client
      @deadline = deadline
    end

    def run
      Timeout.timeout(@deadline) do
        pcm = synthetic_speech
        File.open(File::NULL, "wb") do |sink|
          OpenAI::Examples::Realtime::WebSocketTranscription.run(
            client: @client,
            input: StringIO.new(pcm),
            model: "gpt-4o-mini-transcribe",
            output: sink
          )
          voice(pcm, sink)
          nil
        end
      end
    end

    private def synthetic_speech
      speech = @client.audio.speech.create(
        model: "gpt-4o-mini-tts",
        voice: "marin",
        response_format: :pcm,
        input: SPEECH
      )
      pcm = speech.read(INPUT_BYTES + 1)
      unless pcm && pcm.bytesize.between?(4_800, INPUT_BYTES) && pcm.bytesize.even?
        raise "Synthetic fixture outside smoke bounds"
      end

      pcm
    ensure
      speech&.close
    end

    private def wait_for_commit(connection)
      connection.each do |event|
        case event
        when OpenAI::Realtime::InputAudioBufferCommittedEvent
          return true
        when OpenAI::Realtime::RealtimeErrorEvent
          raise "Realtime API error"
        end
      end

      raise "Voice input was not committed"
    end

    private def voice(pcm, sink)
      @client.realtime.connect(model: "gpt-realtime-2.1", reconnect: false) do |connection|
        connection.session.update(
          type: :realtime,
          output_modalities: [:audio],
          instructions: "Say hello briefly.",
          max_output_tokens: OUTPUT_TOKENS,
          tools: [],
          audio: {
            input: {format: {type: :"audio/pcm", rate: 24_000}, turn_detection: nil},
            output: {format: {type: :"audio/pcm", rate: 24_000}, voice: "marin"}
          }
        )
        pcm.bytes.each_slice(9_600) do |chunk|
          connection.input_audio_buffer.append_bytes(chunk.pack("C*"))
        end

        connection.input_audio_buffer.commit
        wait_for_commit(connection)
        connection.response.create(max_output_tokens: OUTPUT_TOKENS)
        OpenAI::Examples::Realtime::WebSocketVoiceTurn.stream_response(
          connection,
          audio_output: sink,
          output: sink
        )
      end
    end
  end
end
