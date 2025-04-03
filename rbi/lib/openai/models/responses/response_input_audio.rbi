# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseInputAudio < OpenAI::Internal::Type::BaseModel
        # Base64-encoded audio data.
        sig { returns(String) }
        attr_accessor :data

        # The format of the audio data. Currently supported formats are `mp3` and `wav`.
        sig { returns(OpenAI::Models::Responses::ResponseInputAudio::Format::OrSymbol) }
        attr_accessor :format_

        # The type of the input item. Always `input_audio`.
        sig { returns(Symbol) }
        attr_accessor :type

        # An audio input to the model.
        sig do
          params(
            data: String,
            format_: OpenAI::Models::Responses::ResponseInputAudio::Format::OrSymbol,
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(data:, format_:, type: :input_audio)
        end

        sig do
          override
            .returns(
              {data: String, format_: OpenAI::Models::Responses::ResponseInputAudio::Format::OrSymbol, type: Symbol}
            )
        end
        def to_hash
        end

        # The format of the audio data. Currently supported formats are `mp3` and `wav`.
        module Format
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseInputAudio::Format) }
          OrSymbol =
            T.type_alias { T.any(Symbol, String, OpenAI::Models::Responses::ResponseInputAudio::Format::TaggedSymbol) }

          MP3 = T.let(:mp3, OpenAI::Models::Responses::ResponseInputAudio::Format::TaggedSymbol)
          WAV = T.let(:wav, OpenAI::Models::Responses::ResponseInputAudio::Format::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Responses::ResponseInputAudio::Format::TaggedSymbol]) }
          def self.values
          end
        end
      end
    end
  end
end
