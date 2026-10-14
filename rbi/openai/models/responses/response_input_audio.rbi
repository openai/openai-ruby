# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseInputAudio < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseInputAudio,
              OpenAI::Internal::AnyHash
            )
          end

        sig { returns(OpenAI::Responses::ResponseInputAudio::InputAudio) }
        attr_reader :input_audio

        sig do
          params(
            input_audio:
              OpenAI::Responses::ResponseInputAudio::InputAudio::OrHash
          ).void
        end
        attr_writer :input_audio

        # The type of the input item. Always `input_audio`.
        sig { returns(Symbol) }
        attr_accessor :type

        # An audio input to the model.
        sig do
          params(
            input_audio:
              OpenAI::Responses::ResponseInputAudio::InputAudio::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          input_audio:,
          # The type of the input item. Always `input_audio`.
          type: :input_audio
        )
        end

        sig do
          override.returns(
            {
              input_audio: OpenAI::Responses::ResponseInputAudio::InputAudio,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        class InputAudio < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponseInputAudio::InputAudio,
                OpenAI::Internal::AnyHash
              )
            end

          # Base64-encoded audio data.
          sig { returns(String) }
          attr_accessor :data

          # The format of the audio data. Currently supported formats are `mp3` and `wav`.
          sig do
            returns(
              OpenAI::Responses::ResponseInputAudio::InputAudio::Format::OrSymbol
            )
          end
          attr_accessor :format_

          sig do
            params(
              data: String,
              format_:
                OpenAI::Responses::ResponseInputAudio::InputAudio::Format::OrSymbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Base64-encoded audio data.
            data:,
            # The format of the audio data. Currently supported formats are `mp3` and `wav`.
            format_:
          )
          end

          sig do
            override.returns(
              {
                data: String,
                format_:
                  OpenAI::Responses::ResponseInputAudio::InputAudio::Format::OrSymbol
              }
            )
          end
          def to_hash
          end

          # The format of the audio data. Currently supported formats are `mp3` and `wav`.
          module Format
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Responses::ResponseInputAudio::InputAudio::Format
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            MP3 =
              T.let(
                :mp3,
                OpenAI::Responses::ResponseInputAudio::InputAudio::Format::TaggedSymbol
              )
            WAV =
              T.let(
                :wav,
                OpenAI::Responses::ResponseInputAudio::InputAudio::Format::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Responses::ResponseInputAudio::InputAudio::Format::TaggedSymbol
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
end
