# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseInputAudio < OpenAI::BaseModel
        # Base64-encoded audio data.
        sig { returns(String) }
        def data
        end

        sig { params(_: String).returns(String) }
        def data=(_)
        end

        # The format of the audio data. Currently supported formats are `mp3` and `wav`.
        sig { returns(OpenAI::Models::Responses::ResponseInputAudio::Format::OrSymbol) }
        def format_
        end

        sig do
          params(_: OpenAI::Models::Responses::ResponseInputAudio::Format::OrSymbol)
            .returns(OpenAI::Models::Responses::ResponseInputAudio::Format::OrSymbol)
        end
        def format_=(_)
        end

        # The type of the input item. Always `input_audio`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

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
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseInputAudio::Format) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Responses::ResponseInputAudio::Format::TaggedSymbol) }

          MP3 = T.let(:mp3, OpenAI::Models::Responses::ResponseInputAudio::Format::OrSymbol)
          WAV = T.let(:wav, OpenAI::Models::Responses::ResponseInputAudio::Format::OrSymbol)
        end
      end
    end
  end
end
