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
        sig { returns(Symbol) }
        def format_
        end

        sig { params(_: Symbol).returns(Symbol) }
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
        sig { params(data: String, format_: Symbol, type: Symbol).returns(T.attached_class) }
        def self.new(data:, format_:, type: :input_audio)
        end

        sig { override.returns({data: String, format_: Symbol, type: Symbol}) }
        def to_hash
        end

        # The format of the audio data. Currently supported formats are `mp3` and `wav`.
        class Format < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          MP3 = :mp3
          WAV = :wav
        end
      end
    end
  end
end
