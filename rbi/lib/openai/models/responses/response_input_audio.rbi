# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseInputAudio < OpenAI::BaseModel
        sig { returns(String) }
        def data
        end

        sig { params(_: String).returns(String) }
        def data=(_)
        end

        sig { returns(Symbol) }
        def format_
        end

        sig { params(_: Symbol).returns(Symbol) }
        def format_=(_)
        end

        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig { params(data: String, format_: Symbol, type: Symbol).returns(T.attached_class) }
        def self.new(data:, format_:, type: :input_audio)
        end

        sig { override.returns({data: String, format_: Symbol, type: Symbol}) }
        def to_hash
        end

        class Format < OpenAI::Enum
          abstract!

          MP3 = :mp3
          WAV = :wav

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end
      end
    end
  end
end
