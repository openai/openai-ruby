# frozen_string_literal: true

module OpenAI
  module Resources
    class Audio
      class Transcriptions
        # See {OpenAI::Resources::Audio::Transcriptions#create_streaming} for streaming
        # counterpart.
        #
        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Audio::TranscriptionCreateParams} for more details.
        #
        # Transcribes audio into the input language.
        #
        # @overload create(file:, model:, chunking_strategy: nil, include: nil, language: nil, prompt: nil, response_format: nil, temperature: nil, timestamp_granularities: nil, request_options: {})
        #
        # @param file [Pathname, StringIO, IO, String, OpenAI::FilePart] The audio file object (not file name) to transcribe, in one of these formats: fl
        #
        # @param model [String, Symbol, OpenAI::AudioModel] ID of the model to use. The options are `gpt-4o-transcribe`, `gpt-4o-mini-transc
        #
        # @param chunking_strategy [Symbol, :auto, OpenAI::Audio::TranscriptionCreateParams::ChunkingStrategy::VadConfig, nil] Controls how the audio is cut into chunks. When set to `"auto"`, the server firs
        #
        # @param include [Array<Symbol, OpenAI::Audio::TranscriptionInclude>] Additional information to include in the transcription response.
        #
        # @param language [String] The language of the input audio. Supplying the input language in [ISO-639-1](htt
        #
        # @param prompt [String] An optional text to guide the model's style or continue a previous audio segment
        #
        # @param response_format [Symbol, OpenAI::AudioResponseFormat] The format of the output, in one of these options: `json`, `text`, `srt`, `verbo
        #
        # @param temperature [Float] The sampling temperature, between 0 and 1. Higher values like 0.8 will make the
        #
        # @param timestamp_granularities [Array<Symbol, OpenAI::Audio::TranscriptionCreateParams::TimestampGranularity>] The timestamp granularities to populate for this transcription. `response_format
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Audio::Transcription, OpenAI::Audio::TranscriptionVerbose]
        #
        # @see OpenAI::Models::Audio::TranscriptionCreateParams
        def create(params)
          parsed, options = OpenAI::Audio::TranscriptionCreateParams.dump_request(params)
          if parsed[:stream]
            message = "Please use `#create_streaming` for the streaming use case."
            raise ArgumentError.new(message)
          end
          @client.request(
            method: :post,
            path: "audio/transcriptions",
            headers: {"content-type" => "multipart/form-data"},
            body: parsed,
            model: OpenAI::Models::Audio::TranscriptionCreateResponse,
            options: options
          )
        end

        # See {OpenAI::Resources::Audio::Transcriptions#create} for non-streaming
        # counterpart.
        #
        # Some parameter documentations has been truncated, see
        # {OpenAI::Models::Audio::TranscriptionCreateParams} for more details.
        #
        # Transcribes audio into the input language.
        #
        # @overload create_streaming(file:, model:, chunking_strategy: nil, include: nil, language: nil, prompt: nil, response_format: nil, temperature: nil, timestamp_granularities: nil, request_options: {})
        #
        # @param file [Pathname, StringIO, IO, String, OpenAI::FilePart] The audio file object (not file name) to transcribe, in one of these formats: fl
        #
        # @param model [String, Symbol, OpenAI::AudioModel] ID of the model to use. The options are `gpt-4o-transcribe`, `gpt-4o-mini-transc
        #
        # @param chunking_strategy [Symbol, :auto, OpenAI::Audio::TranscriptionCreateParams::ChunkingStrategy::VadConfig, nil] Controls how the audio is cut into chunks. When set to `"auto"`, the server firs
        #
        # @param include [Array<Symbol, OpenAI::Audio::TranscriptionInclude>] Additional information to include in the transcription response.
        #
        # @param language [String] The language of the input audio. Supplying the input language in [ISO-639-1](htt
        #
        # @param prompt [String] An optional text to guide the model's style or continue a previous audio segment
        #
        # @param response_format [Symbol, OpenAI::AudioResponseFormat] The format of the output, in one of these options: `json`, `text`, `srt`, `verbo
        #
        # @param temperature [Float] The sampling temperature, between 0 and 1. Higher values like 0.8 will make the
        #
        # @param timestamp_granularities [Array<Symbol, OpenAI::Audio::TranscriptionCreateParams::TimestampGranularity>] The timestamp granularities to populate for this transcription. `response_format
        #
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Internal::Stream<OpenAI::Audio::TranscriptionTextDeltaEvent, OpenAI::Audio::TranscriptionTextDoneEvent>]
        #
        # @see OpenAI::Models::Audio::TranscriptionCreateParams
        def create_streaming(params)
          parsed, options = OpenAI::Audio::TranscriptionCreateParams.dump_request(params)
          unless parsed.fetch(:stream, true)
            message = "Please use `#create` for the non-streaming use case."
            raise ArgumentError.new(message)
          end
          parsed.store(:stream, true)
          @client.request(
            method: :post,
            path: "audio/transcriptions",
            headers: {"content-type" => "multipart/form-data", "accept" => "text/event-stream"},
            body: parsed,
            stream: OpenAI::Internal::Stream,
            model: OpenAI::Audio::TranscriptionStreamEvent,
            options: options
          )
        end

        # @api private
        #
        # @param client [OpenAI::Client]
        def initialize(client:)
          @client = client
        end
      end
    end
  end
end
