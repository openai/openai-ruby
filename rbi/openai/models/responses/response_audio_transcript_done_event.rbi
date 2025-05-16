# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseAudioTranscriptDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseAudioTranscriptDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The type of the event. Always `response.audio.transcript.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when the full audio transcript is completed.
        sig { params(type: Symbol).returns(T.attached_class) }
        def self.new(
          # The type of the event. Always `response.audio.transcript.done`.
          type: :"response.audio.transcript.done"
        )
        end

        sig { override.returns({ type: Symbol }) }
        def to_hash
        end
      end
    end
  end
end
