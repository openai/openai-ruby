# frozen_string_literal: true

module OpenAI
  module Resources
    class Audio
      class Transcriptions
        # Transcribes audio into the input language.
        #
        # @overload create(file:, model:, include: nil, language: nil, prompt: nil, response_format: nil, temperature: nil, timestamp_granularities: nil, request_options: {})
        #
        # @param file [IO, StringIO]
        # @param model [String, Symbol, OpenAI::Models::AudioModel]
        # @param include [Array<Symbol, OpenAI::Models::Audio::TranscriptionInclude>]
        # @param language [String]
        # @param prompt [String]
        # @param response_format [Symbol, OpenAI::Models::AudioResponseFormat]
        # @param temperature [Float]
        # @param timestamp_granularities [Array<Symbol, OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity>]
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Models::Audio::Transcription, OpenAI::Models::Audio::TranscriptionVerbose]
        #
        # @see OpenAI::Models::Audio::TranscriptionCreateParams
        def create(params)
          parsed, options = OpenAI::Models::Audio::TranscriptionCreateParams.dump_request(params)
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

        # Transcribes audio into the input language.
        #
        # @overload create_streaming(file:, model:, include: nil, language: nil, prompt: nil, response_format: nil, temperature: nil, timestamp_granularities: nil, request_options: {})
        #
        # @param file [IO, StringIO]
        # @param model [String, Symbol, OpenAI::Models::AudioModel]
        # @param include [Array<Symbol, OpenAI::Models::Audio::TranscriptionInclude>]
        # @param language [String]
        # @param prompt [String]
        # @param response_format [Symbol, OpenAI::Models::AudioResponseFormat]
        # @param temperature [Float]
        # @param timestamp_granularities [Array<Symbol, OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity>]
        # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
        #
        # @return [OpenAI::Stream<OpenAI::Models::Audio::TranscriptionTextDeltaEvent, OpenAI::Models::Audio::TranscriptionTextDoneEvent>]
        #
        # @see OpenAI::Models::Audio::TranscriptionCreateParams
        def create_streaming(params)
          parsed, options = OpenAI::Models::Audio::TranscriptionCreateParams.dump_request(params)
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
            stream: OpenAI::Stream,
            model: OpenAI::Models::Audio::TranscriptionStreamEvent,
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
