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

        # A sequence number for this chunk of the stream response.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.audio.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when there is a partial audio response.
        sig do
          params(delta: String, sequence_number: Integer, type: Symbol).returns(
            T.attached_class
          )
        end
        def self.new(
          # A chunk of Base64 encoded response audio bytes.
          delta:,
          # A sequence number for this chunk of the stream response.
          sequence_number:,
          # The type of the event. Always `response.audio.delta`.
          type: :"response.audio.delta"
        )
        end

        sig do
          override.returns(
            { delta: String, sequence_number: Integer, type: Symbol }
          )
        end
        def to_hash
        end
      end
    end
  end
end
