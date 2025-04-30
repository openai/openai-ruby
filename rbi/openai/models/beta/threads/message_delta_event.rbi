# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class MessageDeltaEvent < OpenAI::Internal::Type::BaseModel
          # The identifier of the message, which can be referenced in API endpoints.
          sig { returns(String) }
          attr_accessor :id

          # The delta containing the fields that have changed on the Message.
          sig { returns(OpenAI::Models::Beta::Threads::MessageDelta) }
          attr_reader :delta

          sig { params(delta: T.any(OpenAI::Models::Beta::Threads::MessageDelta, OpenAI::Internal::AnyHash)).void }
          attr_writer :delta

          # The object type, which is always `thread.message.delta`.
          sig { returns(Symbol) }
          attr_accessor :object

          # Represents a message delta i.e. any changed fields on a message during
          # streaming.
          sig do
            params(
              id: String,
              delta: T.any(OpenAI::Models::Beta::Threads::MessageDelta, OpenAI::Internal::AnyHash),
              object: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(
            # The identifier of the message, which can be referenced in API endpoints.
            id:,
            # The delta containing the fields that have changed on the Message.
            delta:,
            # The object type, which is always `thread.message.delta`.
            object: :"thread.message.delta"
          ); end
          sig { override.returns({id: String, delta: OpenAI::Models::Beta::Threads::MessageDelta, object: Symbol}) }
          def to_hash; end
        end
      end
    end
  end
end
