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

        # The sequence number of the delta.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.audio.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when the audio response is complete.
        sig do
          params(sequence_number: Integer, type: Symbol).returns(
            T.attached_class
          )
        end
        def self.new(
          # The sequence number of the delta.
          sequence_number:,
          # The type of the event. Always `response.audio.done`.
          type: :"response.audio.done"
        )
        end

        sig { override.returns({ sequence_number: Integer, type: Symbol }) }
        def to_hash
        end
      end
    end
  end
end
