# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseAudioDeltaEvent < OpenAI::BaseModel
        # A chunk of Base64 encoded response audio bytes.
        sig { returns(String) }
        def delta
        end

        sig { params(_: String).returns(String) }
        def delta=(_)
        end

        # The type of the event. Always `response.audio.delta`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # Emitted when there is a partial audio response.
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
