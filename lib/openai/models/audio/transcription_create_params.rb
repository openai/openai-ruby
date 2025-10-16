# frozen_string_literal: true

module OpenAI
  module Models
    module Audio
      # @see OpenAI::Resources::Audio::Transcriptions#create
      #
      # @see OpenAI::Resources::Audio::Transcriptions#create_streaming
      class TranscriptionCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute file
        #   The audio file object (not file name) to transcribe, in one of these formats:
        #   flac, mp3, mp4, mpeg, mpga, m4a, ogg, wav, or webm.
        #
        #   @return [Pathname, StringIO, IO, String, OpenAI::FilePart]
        required :file, OpenAI::Internal::Type::FileInput

        # @!attribute model
        #   ID of the model to use. The options are `gpt-4o-transcribe`,
        #   `gpt-4o-mini-transcribe`, `whisper-1` (which is powered by our open source
        #   Whisper V2 model), and `gpt-4o-transcribe-diarize`.
        #
        #   @return [String, Symbol, OpenAI::Models::AudioModel]
        required :model, union: -> { OpenAI::Audio::TranscriptionCreateParams::Model }

        # @!attribute chunking_strategy
        #   Controls how the audio is cut into chunks. When set to `"auto"`, the server
        #   first normalizes loudness and then uses voice activity detection (VAD) to choose
        #   boundaries. `server_vad` object can be provided to tweak VAD detection
        #   parameters manually. If unset, the audio is transcribed as a single block.
        #   Required when using `gpt-4o-transcribe-diarize` for inputs longer than 30
        #   seconds.
        #
        #   @return [Symbol, :auto, OpenAI::Models::Audio::TranscriptionCreateParams::ChunkingStrategy::VadConfig, nil]
        optional :chunking_strategy,
                 union: -> { OpenAI::Audio::TranscriptionCreateParams::ChunkingStrategy },
                 nil?: true

        # @!attribute include
        #   Additional information to include in the transcription response. `logprobs` will
        #   return the log probabilities of the tokens in the response to understand the
        #   model's confidence in the transcription. `logprobs` only works with
        #   response_format set to `json` and only with the models `gpt-4o-transcribe` and
        #   `gpt-4o-mini-transcribe`. This field is not supported when using
        #   `gpt-4o-transcribe-diarize`.
        #
        #   @return [Array<Symbol, OpenAI::Models::Audio::TranscriptionInclude>, nil]
        optional :include, -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Audio::TranscriptionInclude] }

        # @!attribute known_speaker_names
        #   Optional list of speaker names that correspond to the audio samples provided in
        #   `known_speaker_references[]`. Each entry should be a short identifier (for
        #   example `customer` or `agent`). Up to 4 speakers are supported.
        #
        #   @return [Array<String>, nil]
        optional :known_speaker_names, OpenAI::Internal::Type::ArrayOf[String]

        # @!attribute known_speaker_references
        #   Optional list of audio samples (as
        #   [data URLs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URLs))
        #   that contain known speaker references matching `known_speaker_names[]`. Each
        #   sample must be between 2 and 10 seconds, and can use any of the same input audio
        #   formats supported by `file`.
        #
        #   @return [Array<String>, nil]
        optional :known_speaker_references, OpenAI::Internal::Type::ArrayOf[String]

        # @!attribute language
        #   The language of the input audio. Supplying the input language in
        #   [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`)
        #   format will improve accuracy and latency.
        #
        #   @return [String, nil]
        optional :language, String

        # @!attribute prompt
        #   An optional text to guide the model's style or continue a previous audio
        #   segment. The
        #   [prompt](https://platform.openai.com/docs/guides/speech-to-text#prompting)
        #   should match the audio language. This field is not supported when using
        #   `gpt-4o-transcribe-diarize`.
        #
        #   @return [String, nil]
        optional :prompt, String

        # @!attribute response_format
        #   The format of the output, in one of these options: `json`, `text`, `srt`,
        #   `verbose_json`, `vtt`, or `diarized_json`. For `gpt-4o-transcribe` and
        #   `gpt-4o-mini-transcribe`, the only supported format is `json`. For
        #   `gpt-4o-transcribe-diarize`, the supported formats are `json`, `text`, and
        #   `diarized_json`, with `diarized_json` required to receive speaker annotations.
        #
        #   @return [Symbol, OpenAI::Models::AudioResponseFormat, nil]
        optional :response_format, enum: -> { OpenAI::AudioResponseFormat }

        # @!attribute temperature
        #   The sampling temperature, between 0 and 1. Higher values like 0.8 will make the
        #   output more random, while lower values like 0.2 will make it more focused and
        #   deterministic. If set to 0, the model will use
        #   [log probability](https://en.wikipedia.org/wiki/Log_probability) to
        #   automatically increase the temperature until certain thresholds are hit.
        #
        #   @return [Float, nil]
        optional :temperature, Float

        # @!attribute timestamp_granularities
        #   The timestamp granularities to populate for this transcription.
        #   `response_format` must be set `verbose_json` to use timestamp granularities.
        #   Either or both of these options are supported: `word`, or `segment`. Note: There
        #   is no additional latency for segment timestamps, but generating word timestamps
        #   incurs additional latency. This option is not available for
        #   `gpt-4o-transcribe-diarize`.
        #
        #   @return [Array<Symbol, OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity>, nil]
        optional :timestamp_granularities,
                 -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Audio::TranscriptionCreateParams::TimestampGranularity] }

        # @!method initialize(file:, model:, chunking_strategy: nil, include: nil, known_speaker_names: nil, known_speaker_references: nil, language: nil, prompt: nil, response_format: nil, temperature: nil, timestamp_granularities: nil, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Audio::TranscriptionCreateParams} for more details.
        #
        #   @param file [Pathname, StringIO, IO, String, OpenAI::FilePart] The audio file object (not file name) to transcribe, in one of these formats: fl
        #
        #   @param model [String, Symbol, OpenAI::Models::AudioModel] ID of the model to use. The options are `gpt-4o-transcribe`, `gpt-4o-mini-transc
        #
        #   @param chunking_strategy [Symbol, :auto, OpenAI::Models::Audio::TranscriptionCreateParams::ChunkingStrategy::VadConfig, nil] Controls how the audio is cut into chunks. When set to `"auto"`, the server firs
        #
        #   @param include [Array<Symbol, OpenAI::Models::Audio::TranscriptionInclude>] Additional information to include in the transcription response.
        #
        #   @param known_speaker_names [Array<String>] Optional list of speaker names that correspond to the audio samples provided in
        #
        #   @param known_speaker_references [Array<String>] Optional list of audio samples (as [data URLs](https://developer.mozilla.org/en-
        #
        #   @param language [String] The language of the input audio. Supplying the input language in [ISO-639-1](htt
        #
        #   @param prompt [String] An optional text to guide the model's style or continue a previous audio segment
        #
        #   @param response_format [Symbol, OpenAI::Models::AudioResponseFormat] The format of the output, in one of these options: `json`, `text`, `srt`, `verbo
        #
        #   @param temperature [Float] The sampling temperature, between 0 and 1. Higher values like 0.8 will make the
        #
        #   @param timestamp_granularities [Array<Symbol, OpenAI::Models::Audio::TranscriptionCreateParams::TimestampGranularity>] The timestamp granularities to populate for this transcription. `response_format
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        # ID of the model to use. The options are `gpt-4o-transcribe`,
        # `gpt-4o-mini-transcribe`, `whisper-1` (which is powered by our open source
        # Whisper V2 model), and `gpt-4o-transcribe-diarize`.
        module Model
          extend OpenAI::Internal::Type::Union

          variant String

          # ID of the model to use. The options are `gpt-4o-transcribe`, `gpt-4o-mini-transcribe`, `whisper-1` (which is powered by our open source Whisper V2 model), and `gpt-4o-transcribe-diarize`.
          variant enum: -> { OpenAI::AudioModel }

          # @!method self.variants
          #   @return [Array(String, Symbol, OpenAI::Models::AudioModel)]
        end

        # Controls how the audio is cut into chunks. When set to `"auto"`, the server
        # first normalizes loudness and then uses voice activity detection (VAD) to choose
        # boundaries. `server_vad` object can be provided to tweak VAD detection
        # parameters manually. If unset, the audio is transcribed as a single block.
        # Required when using `gpt-4o-transcribe-diarize` for inputs longer than 30
        # seconds.
        module ChunkingStrategy
          extend OpenAI::Internal::Type::Union

          # Automatically set chunking parameters based on the audio. Must be set to `"auto"`.
          variant const: :auto

          variant -> { OpenAI::Audio::TranscriptionCreateParams::ChunkingStrategy::VadConfig }

          class VadConfig < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   Must be set to `server_vad` to enable manual chunking using server side VAD.
            #
            #   @return [Symbol, OpenAI::Models::Audio::TranscriptionCreateParams::ChunkingStrategy::VadConfig::Type]
            required :type, enum: -> { OpenAI::Audio::TranscriptionCreateParams::ChunkingStrategy::VadConfig::Type }

            # @!attribute prefix_padding_ms
            #   Amount of audio to include before the VAD detected speech (in milliseconds).
            #
            #   @return [Integer, nil]
            optional :prefix_padding_ms, Integer

            # @!attribute silence_duration_ms
            #   Duration of silence to detect speech stop (in milliseconds). With shorter values
            #   the model will respond more quickly, but may jump in on short pauses from the
            #   user.
            #
            #   @return [Integer, nil]
            optional :silence_duration_ms, Integer

            # @!attribute threshold
            #   Sensitivity threshold (0.0 to 1.0) for voice activity detection. A higher
            #   threshold will require louder audio to activate the model, and thus might
            #   perform better in noisy environments.
            #
            #   @return [Float, nil]
            optional :threshold, Float

            # @!method initialize(type:, prefix_padding_ms: nil, silence_duration_ms: nil, threshold: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Audio::TranscriptionCreateParams::ChunkingStrategy::VadConfig}
            #   for more details.
            #
            #   @param type [Symbol, OpenAI::Models::Audio::TranscriptionCreateParams::ChunkingStrategy::VadConfig::Type] Must be set to `server_vad` to enable manual chunking using server side VAD.
            #
            #   @param prefix_padding_ms [Integer] Amount of audio to include before the VAD detected speech (in
            #
            #   @param silence_duration_ms [Integer] Duration of silence to detect speech stop (in milliseconds).
            #
            #   @param threshold [Float] Sensitivity threshold (0.0 to 1.0) for voice activity detection. A

            # Must be set to `server_vad` to enable manual chunking using server side VAD.
            #
            # @see OpenAI::Models::Audio::TranscriptionCreateParams::ChunkingStrategy::VadConfig#type
            module Type
              extend OpenAI::Internal::Type::Enum

              SERVER_VAD = :server_vad

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          # @!method self.variants
          #   @return [Array(Symbol, :auto, OpenAI::Models::Audio::TranscriptionCreateParams::ChunkingStrategy::VadConfig)]
        end

        module TimestampGranularity
          extend OpenAI::Internal::Type::Enum

          WORD = :word
          SEGMENT = :segment

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
