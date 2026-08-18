# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeTranscriptionSessionCreateRequest < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest,
              OpenAI::Internal::AnyHash
            )
          end

        # The type of session to create. Always `transcription` for transcription
        # sessions.
        sig { returns(Symbol) }
        attr_accessor :type

        # Configuration for input and output audio.
        sig do
          returns(
            T.nilable(OpenAI::Realtime::RealtimeTranscriptionSessionAudio)
          )
        end
        attr_reader :audio

        sig do
          params(
            audio: OpenAI::Realtime::RealtimeTranscriptionSessionAudio::OrHash
          ).void
        end
        attr_writer :audio

        # Additional fields to include in server outputs.
        #
        # `item.input_audio_transcription.logprobs`: Include logprobs for input audio
        # transcription.
        sig do
          returns(
            T.nilable(
              T::Array[
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Include::OrSymbol
              ]
            )
          )
        end
        attr_reader :include

        sig do
          params(
            include:
              T::Array[
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Include::OrSymbol
              ]
          ).void
        end
        attr_writer :include

        # Realtime transcription session object configuration.
        sig do
          params(
            audio: OpenAI::Realtime::RealtimeTranscriptionSessionAudio::OrHash,
            include:
              T::Array[
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Include::OrSymbol
              ],
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Configuration for input and output audio.
          audio: nil,
          # Additional fields to include in server outputs.
          #
          # `item.input_audio_transcription.logprobs`: Include logprobs for input audio
          # transcription.
          include: nil,
          # The type of session to create. Always `transcription` for transcription
          # sessions.
          type: :transcription
        )
        end

        sig do
          override.returns(
            {
              type: Symbol,
              audio: OpenAI::Realtime::RealtimeTranscriptionSessionAudio,
              include:
                T::Array[
                  OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Include::OrSymbol
                ]
            }
          )
        end
        def to_hash
        end

        module Include
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Include
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          ITEM_INPUT_AUDIO_TRANSCRIPTION_LOGPROBS =
            T.let(
              :"item.input_audio_transcription.logprobs",
              OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Include::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Include::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
