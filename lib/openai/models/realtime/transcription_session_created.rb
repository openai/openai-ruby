# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class TranscriptionSessionCreated < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute session
        #   A Realtime transcription session configuration object.
        #
        #   @return [OpenAI::Models::Realtime::TranscriptionSessionCreated::Session]
        required :session, -> { OpenAI::Realtime::TranscriptionSessionCreated::Session }

        # @!attribute type
        #   The event type, must be `transcription_session.created`.
        #
        #   @return [Symbol, :"transcription_session.created"]
        required :type, const: :"transcription_session.created"

        # @!method initialize(event_id:, session:, type: :"transcription_session.created")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Realtime::TranscriptionSessionCreated} for more details.
        #
        #   Returned when a transcription session is created.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param session [OpenAI::Models::Realtime::TranscriptionSessionCreated::Session] A Realtime transcription session configuration object.
        #
        #   @param type [Symbol, :"transcription_session.created"] The event type, must be `transcription_session.created`.

        # @see OpenAI::Models::Realtime::TranscriptionSessionCreated#session
        class Session < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   Unique identifier for the session that looks like `sess_1234567890abcdef`.
          #
          #   @return [String, nil]
          optional :id, String

          # @!attribute audio
          #   Configuration for input audio for the session.
          #
          #   @return [OpenAI::Models::Realtime::TranscriptionSessionCreated::Session::Audio, nil]
          optional :audio, -> { OpenAI::Realtime::TranscriptionSessionCreated::Session::Audio }

          # @!attribute expires_at
          #   Expiration timestamp for the session, in seconds since epoch.
          #
          #   @return [Integer, nil]
          optional :expires_at, Integer

          # @!attribute include
          #   Additional fields to include in server outputs.
          #
          #   - `item.input_audio_transcription.logprobs`: Include logprobs for input audio
          #     transcription.
          #
          #   @return [Array<Symbol, OpenAI::Models::Realtime::TranscriptionSessionCreated::Session::Include>, nil]
          optional :include,
                   -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Realtime::TranscriptionSessionCreated::Session::Include] }

          # @!attribute object
          #   The object type. Always `realtime.transcription_session`.
          #
          #   @return [String, nil]
          optional :object, String

          # @!method initialize(id: nil, audio: nil, expires_at: nil, include: nil, object: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::TranscriptionSessionCreated::Session} for more
          #   details.
          #
          #   A Realtime transcription session configuration object.
          #
          #   @param id [String] Unique identifier for the session that looks like `sess_1234567890abcdef`.
          #
          #   @param audio [OpenAI::Models::Realtime::TranscriptionSessionCreated::Session::Audio] Configuration for input audio for the session.
          #
          #   @param expires_at [Integer] Expiration timestamp for the session, in seconds since epoch.
          #
          #   @param include [Array<Symbol, OpenAI::Models::Realtime::TranscriptionSessionCreated::Session::Include>] Additional fields to include in server outputs.
          #
          #   @param object [String] The object type. Always `realtime.transcription_session`.

          # @see OpenAI::Models::Realtime::TranscriptionSessionCreated::Session#audio
          class Audio < OpenAI::Internal::Type::BaseModel
            # @!attribute input
            #
            #   @return [OpenAI::Models::Realtime::TranscriptionSessionCreated::Session::Audio::Input, nil]
            optional :input, -> { OpenAI::Realtime::TranscriptionSessionCreated::Session::Audio::Input }

            # @!method initialize(input: nil)
            #   Configuration for input audio for the session.
            #
            #   @param input [OpenAI::Models::Realtime::TranscriptionSessionCreated::Session::Audio::Input]

            # @see OpenAI::Models::Realtime::TranscriptionSessionCreated::Session::Audio#input
            class Input < OpenAI::Internal::Type::BaseModel
              # @!attribute format_
              #   The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
              #
              #   @return [String, nil]
              optional :format_, String, api_name: :format

              # @!attribute noise_reduction
              #   Configuration for input audio noise reduction.
              #
              #   @return [OpenAI::Models::Realtime::TranscriptionSessionCreated::Session::Audio::Input::NoiseReduction, nil]
              optional :noise_reduction,
                       -> { OpenAI::Realtime::TranscriptionSessionCreated::Session::Audio::Input::NoiseReduction }

              # @!attribute transcription
              #   Configuration of the transcription model.
              #
              #   @return [OpenAI::Models::Realtime::TranscriptionSessionCreated::Session::Audio::Input::Transcription, nil]
              optional :transcription,
                       -> { OpenAI::Realtime::TranscriptionSessionCreated::Session::Audio::Input::Transcription }

              # @!attribute turn_detection
              #   Configuration for turn detection.
              #
              #   @return [OpenAI::Models::Realtime::TranscriptionSessionCreated::Session::Audio::Input::TurnDetection, nil]
              optional :turn_detection,
                       -> { OpenAI::Realtime::TranscriptionSessionCreated::Session::Audio::Input::TurnDetection }

              # @!method initialize(format_: nil, noise_reduction: nil, transcription: nil, turn_detection: nil)
              #   Some parameter documentations has been truncated, see
              #   {OpenAI::Models::Realtime::TranscriptionSessionCreated::Session::Audio::Input}
              #   for more details.
              #
              #   @param format_ [String] The format of input audio. Options are `pcm16`, `g711_ulaw`, or `g711_alaw`.
              #
              #   @param noise_reduction [OpenAI::Models::Realtime::TranscriptionSessionCreated::Session::Audio::Input::NoiseReduction] Configuration for input audio noise reduction.
              #
              #   @param transcription [OpenAI::Models::Realtime::TranscriptionSessionCreated::Session::Audio::Input::Transcription] Configuration of the transcription model.
              #
              #   @param turn_detection [OpenAI::Models::Realtime::TranscriptionSessionCreated::Session::Audio::Input::TurnDetection] Configuration for turn detection.

              # @see OpenAI::Models::Realtime::TranscriptionSessionCreated::Session::Audio::Input#noise_reduction
              class NoiseReduction < OpenAI::Internal::Type::BaseModel
                # @!attribute type
                #
                #   @return [Symbol, OpenAI::Models::Realtime::TranscriptionSessionCreated::Session::Audio::Input::NoiseReduction::Type, nil]
                optional :type,
                         enum: -> { OpenAI::Realtime::TranscriptionSessionCreated::Session::Audio::Input::NoiseReduction::Type }

                # @!method initialize(type: nil)
                #   Configuration for input audio noise reduction.
                #
                #   @param type [Symbol, OpenAI::Models::Realtime::TranscriptionSessionCreated::Session::Audio::Input::NoiseReduction::Type]

                # @see OpenAI::Models::Realtime::TranscriptionSessionCreated::Session::Audio::Input::NoiseReduction#type
                module Type
                  extend OpenAI::Internal::Type::Enum

                  NEAR_FIELD = :near_field
                  FAR_FIELD = :far_field

                  # @!method self.values
                  #   @return [Array<Symbol>]
                end
              end

              # @see OpenAI::Models::Realtime::TranscriptionSessionCreated::Session::Audio::Input#transcription
              class Transcription < OpenAI::Internal::Type::BaseModel
                # @!attribute language
                #   The language of the input audio. Supplying the input language in
                #   [ISO-639-1](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes) (e.g. `en`)
                #   format will improve accuracy and latency.
                #
                #   @return [String, nil]
                optional :language, String

                # @!attribute model
                #   The model to use for transcription. Can be `gpt-4o-transcribe`,
                #   `gpt-4o-mini-transcribe`, or `whisper-1`.
                #
                #   @return [Symbol, OpenAI::Models::Realtime::TranscriptionSessionCreated::Session::Audio::Input::Transcription::Model, nil]
                optional :model,
                         enum: -> { OpenAI::Realtime::TranscriptionSessionCreated::Session::Audio::Input::Transcription::Model }

                # @!attribute prompt
                #   An optional text to guide the model's style or continue a previous audio
                #   segment. The
                #   [prompt](https://platform.openai.com/docs/guides/speech-to-text#prompting)
                #   should match the audio language.
                #
                #   @return [String, nil]
                optional :prompt, String

                # @!method initialize(language: nil, model: nil, prompt: nil)
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Realtime::TranscriptionSessionCreated::Session::Audio::Input::Transcription}
                #   for more details.
                #
                #   Configuration of the transcription model.
                #
                #   @param language [String] The language of the input audio. Supplying the input language in
                #
                #   @param model [Symbol, OpenAI::Models::Realtime::TranscriptionSessionCreated::Session::Audio::Input::Transcription::Model] The model to use for transcription. Can be `gpt-4o-transcribe`, `gpt-4o-mini-tra
                #
                #   @param prompt [String] An optional text to guide the model's style or continue a previous audio segment

                # The model to use for transcription. Can be `gpt-4o-transcribe`,
                # `gpt-4o-mini-transcribe`, or `whisper-1`.
                #
                # @see OpenAI::Models::Realtime::TranscriptionSessionCreated::Session::Audio::Input::Transcription#model
                module Model
                  extend OpenAI::Internal::Type::Enum

                  GPT_4O_TRANSCRIBE = :"gpt-4o-transcribe"
                  GPT_4O_MINI_TRANSCRIBE = :"gpt-4o-mini-transcribe"
                  WHISPER_1 = :"whisper-1"

                  # @!method self.values
                  #   @return [Array<Symbol>]
                end
              end

              # @see OpenAI::Models::Realtime::TranscriptionSessionCreated::Session::Audio::Input#turn_detection
              class TurnDetection < OpenAI::Internal::Type::BaseModel
                # @!attribute prefix_padding_ms
                #
                #   @return [Integer, nil]
                optional :prefix_padding_ms, Integer

                # @!attribute silence_duration_ms
                #
                #   @return [Integer, nil]
                optional :silence_duration_ms, Integer

                # @!attribute threshold
                #
                #   @return [Float, nil]
                optional :threshold, Float

                # @!attribute type
                #   Type of turn detection, only `server_vad` is currently supported.
                #
                #   @return [String, nil]
                optional :type, String

                # @!method initialize(prefix_padding_ms: nil, silence_duration_ms: nil, threshold: nil, type: nil)
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Realtime::TranscriptionSessionCreated::Session::Audio::Input::TurnDetection}
                #   for more details.
                #
                #   Configuration for turn detection.
                #
                #   @param prefix_padding_ms [Integer]
                #
                #   @param silence_duration_ms [Integer]
                #
                #   @param threshold [Float]
                #
                #   @param type [String] Type of turn detection, only `server_vad` is currently supported.
              end
            end
          end

          module Include
            extend OpenAI::Internal::Type::Enum

            ITEM_INPUT_AUDIO_TRANSCRIPTION_LOGPROBS = :"item.input_audio_transcription.logprobs"

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
