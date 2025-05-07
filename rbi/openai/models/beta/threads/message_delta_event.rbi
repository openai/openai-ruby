# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class MessageDeltaEvent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # The identifier of the message, which can be referenced in API endpoints.
          sig { returns(String) }
          attr_accessor :id

          # The delta containing the fields that have changed on the Message.
          sig { returns(OpenAI::Beta::Threads::MessageDelta) }
          attr_reader :delta

          sig do
            params(delta: OpenAI::Beta::Threads::MessageDelta::OrHash).void
          end
          attr_writer :delta

          # The object type, which is always `thread.message.delta`.
          sig { returns(Symbol) }
          attr_accessor :object

          # Represents a message delta i.e. any changed fields on a message during
          # streaming.
          sig do
            params(
              id: String,
              delta: OpenAI::Beta::Threads::MessageDelta::OrHash,
              object: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The identifier of the message, which can be referenced in API endpoints.
            id:,
            # The delta containing the fields that have changed on the Message.
            delta:,
            # The object type, which is always `thread.message.delta`.
            object: :"thread.message.delta"
          )
          end

          sig do
            override.returns(
              {
                id: String,
                delta: OpenAI::Beta::Threads::MessageDelta,
                object: Symbol
              }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
