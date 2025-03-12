# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseAudioDeltaEvent < OpenAI::BaseModel
        sig { returns(String) }
        def delta
        end

        sig { params(_: String).returns(String) }
        def delta=(_)
        end

        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig { params(delta: String, type: Symbol).returns(T.attached_class) }
        def self.new(delta:, type: :"response.audio.delta")
        end

        sig { override.returns({delta: String, type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end
