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

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.audio.transcript.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when the full audio transcript is completed.
        sig do
          params(sequence_number: Integer, type: Symbol).returns(
            T.attached_class
          )
        end
        def self.new(
          # The sequence number of this event.
          sequence_number:,
          # The type of the event. Always `response.audio.transcript.done`.
          type: :"response.audio.transcript.done"
        )
        end

        sig { override.returns({ sequence_number: Integer, type: Symbol }) }
        def to_hash
        end
      end
    end
  end
end
