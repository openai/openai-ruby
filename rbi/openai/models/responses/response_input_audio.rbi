# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseInputAudio < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # Base64-encoded audio data.
        sig { returns(String) }
        attr_accessor :data

        # The format of the audio data. Currently supported formats are `mp3` and `wav`.
        sig { returns(OpenAI::Responses::ResponseInputAudio::Format::OrSymbol) }
        attr_accessor :format_

        # The type of the input item. Always `input_audio`.
        sig { returns(Symbol) }
        attr_accessor :type

        # An audio input to the model.
        sig do
          params(
            data: String,
            format_: OpenAI::Responses::ResponseInputAudio::Format::OrSymbol,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Base64-encoded audio data.
          data:,
          # The format of the audio data. Currently supported formats are `mp3` and `wav`.
          format_:,
          # The type of the input item. Always `input_audio`.
          type: :input_audio
        )
        end

        sig do
          override.returns(
            {
              data: String,
              format_: OpenAI::Responses::ResponseInputAudio::Format::OrSymbol,
              type: Symbol
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
              T.all(Symbol, OpenAI::Responses::ResponseInputAudio::Format)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          MP3 =
            T.let(
              :mp3,
              OpenAI::Responses::ResponseInputAudio::Format::TaggedSymbol
            )
          WAV =
            T.let(
              :wav,
              OpenAI::Responses::ResponseInputAudio::Format::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseInputAudio::Format::TaggedSymbol
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
