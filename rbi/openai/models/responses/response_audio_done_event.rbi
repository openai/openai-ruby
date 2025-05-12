# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseAudioDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseAudioDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The type of the event. Always `response.audio.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when the audio response is complete.
        sig { params(type: Symbol).returns(T.attached_class) }
        def self.new(
          # The type of the event. Always `response.audio.done`.
          type: :"response.audio.done"
        )
        end

        sig { override.returns({ type: Symbol }) }
        def to_hash
        end
      end
    end
  end
end
