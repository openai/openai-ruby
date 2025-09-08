# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeAudioConfigInput < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeAudioConfigInput,
              OpenAI::Internal::AnyHash
            )
          end

        # The format of the input audio.
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCM,
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU,
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA
              )
            )
          )
        end
        attr_reader :format_

        sig do
          params(
            format_:
              T.any(
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::OrHash,
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU::OrHash,
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA::OrHash
              )
          ).void
        end
        attr_writer :format_

        # Configuration for input audio noise reduction. This can be set to `null` to turn
        # off. Noise reduction filters audio added to the input audio buffer before it is
        # sent to VAD and the model. Filtering the audio can improve VAD and turn
        # detection accuracy (reducing false positives) and model performance by improving
        # perception of the input audio.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeAudioConfigInput::NoiseReduction
            )
          )
        end
        attr_reader :noise_reduction

        sig do
          params(
            noise_reduction:
              OpenAI::Realtime::RealtimeAudioConfigInput::NoiseReduction::OrHash
          ).void
        end
        attr_writer :noise_reduction

        # Configuration for input audio transcription, defaults to off and can be set to
        # `null` to turn off once on. Input audio transcription is not native to the
        # model, since the model consumes audio directly. Transcription runs
        # asynchronously through
        # [the /audio/transcriptions endpoint](https://platform.openai.com/docs/api-reference/audio/createTranscription)
        # and should be treated as guidance of input audio content rather than precisely
        # what the model heard. The client can optionally set the language and prompt for
        # transcription, these offer additional guidance to the transcription service.
        sig { returns(T.nilable(OpenAI::Realtime::AudioTranscription)) }
        attr_reader :transcription

        sig do
          params(
            transcription: OpenAI::Realtime::AudioTranscription::OrHash
          ).void
        end
        attr_writer :transcription

        # Configuration for turn detection, ether Server VAD or Semantic VAD. This can be
        # set to `null` to turn off, in which case the client must manually trigger model
        # response. Server VAD means that the model will detect the start and end of
        # speech based on audio volume and respond at the end of user speech. Semantic VAD
        # is more advanced and uses a turn detection model (in conjunction with VAD) to
        # semantically estimate whether the user has finished speaking, then dynamically
        # sets a timeout based on this probability. For example, if user audio trails off
        # with "uhhm", the model will score a low probability of turn end and wait longer
        # for the user to continue speaking. This can be useful for more natural
        # conversations, but may have a higher latency.
        sig do
          returns(T.nilable(OpenAI::Realtime::RealtimeAudioInputTurnDetection))
        end
        attr_reader :turn_detection

        sig do
          params(
            turn_detection:
              OpenAI::Realtime::RealtimeAudioInputTurnDetection::OrHash
          ).void
        end
        attr_writer :turn_detection

        sig do
          params(
            format_:
              T.any(
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCM::OrHash,
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU::OrHash,
                OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA::OrHash
              ),
            noise_reduction:
              OpenAI::Realtime::RealtimeAudioConfigInput::NoiseReduction::OrHash,
            transcription: OpenAI::Realtime::AudioTranscription::OrHash,
            turn_detection:
              OpenAI::Realtime::RealtimeAudioInputTurnDetection::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # The format of the input audio.
          format_: nil,
          # Configuration for input audio noise reduction. This can be set to `null` to turn
          # off. Noise reduction filters audio added to the input audio buffer before it is
          # sent to VAD and the model. Filtering the audio can improve VAD and turn
          # detection accuracy (reducing false positives) and model performance by improving
          # perception of the input audio.
          noise_reduction: nil,
          # Configuration for input audio transcription, defaults to off and can be set to
          # `null` to turn off once on. Input audio transcription is not native to the
          # model, since the model consumes audio directly. Transcription runs
          # asynchronously through
          # [the /audio/transcriptions endpoint](https://platform.openai.com/docs/api-reference/audio/createTranscription)
          # and should be treated as guidance of input audio content rather than precisely
          # what the model heard. The client can optionally set the language and prompt for
          # transcription, these offer additional guidance to the transcription service.
          transcription: nil,
          # Configuration for turn detection, ether Server VAD or Semantic VAD. This can be
          # set to `null` to turn off, in which case the client must manually trigger model
          # response. Server VAD means that the model will detect the start and end of
          # speech based on audio volume and respond at the end of user speech. Semantic VAD
          # is more advanced and uses a turn detection model (in conjunction with VAD) to
          # semantically estimate whether the user has finished speaking, then dynamically
          # sets a timeout based on this probability. For example, if user audio trails off
          # with "uhhm", the model will score a low probability of turn end and wait longer
          # for the user to continue speaking. This can be useful for more natural
          # conversations, but may have a higher latency.
          turn_detection: nil
        )
        end

        sig do
          override.returns(
            {
              format_:
                T.any(
                  OpenAI::Realtime::RealtimeAudioFormats::AudioPCM,
                  OpenAI::Realtime::RealtimeAudioFormats::AudioPCMU,
                  OpenAI::Realtime::RealtimeAudioFormats::AudioPCMA
                ),
              noise_reduction:
                OpenAI::Realtime::RealtimeAudioConfigInput::NoiseReduction,
              transcription: OpenAI::Realtime::AudioTranscription,
              turn_detection: OpenAI::Realtime::RealtimeAudioInputTurnDetection
            }
          )
        end
        def to_hash
        end

        class NoiseReduction < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeAudioConfigInput::NoiseReduction,
                OpenAI::Internal::AnyHash
              )
            end

          # Type of noise reduction. `near_field` is for close-talking microphones such as
          # headphones, `far_field` is for far-field microphones such as laptop or
          # conference room microphones.
          sig do
            returns(T.nilable(OpenAI::Realtime::NoiseReductionType::OrSymbol))
          end
          attr_reader :type

          sig do
            params(type: OpenAI::Realtime::NoiseReductionType::OrSymbol).void
          end
          attr_writer :type

          # Configuration for input audio noise reduction. This can be set to `null` to turn
          # off. Noise reduction filters audio added to the input audio buffer before it is
          # sent to VAD and the model. Filtering the audio can improve VAD and turn
          # detection accuracy (reducing false positives) and model performance by improving
          # perception of the input audio.
          sig do
            params(
              type: OpenAI::Realtime::NoiseReductionType::OrSymbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Type of noise reduction. `near_field` is for close-talking microphones such as
            # headphones, `far_field` is for far-field microphones such as laptop or
            # conference room microphones.
            type: nil
          )
          end

          sig do
            override.returns(
              { type: OpenAI::Realtime::NoiseReductionType::OrSymbol }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
