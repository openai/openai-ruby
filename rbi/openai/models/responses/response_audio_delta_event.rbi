# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseAudioDeltaEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseAudioDeltaEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # A chunk of Base64 encoded response audio bytes.
        sig { returns(String) }
        attr_accessor :delta

        # The type of the event. Always `response.audio.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when there is a partial audio response.
        sig { params(delta: String, type: Symbol).returns(T.attached_class) }
        def self.new(
          # A chunk of Base64 encoded response audio bytes.
          delta:,
          # The type of the event. Always `response.audio.delta`.
          type: :"response.audio.delta"
        )
        end

        sig { override.returns({ delta: String, type: Symbol }) }
        def to_hash
        end
      end
    end
  end
end
