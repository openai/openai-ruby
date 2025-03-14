# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class MessageDeltaEvent < OpenAI::BaseModel
          # The identifier of the message, which can be referenced in API endpoints.
          sig { returns(String) }
          def id
          end

          sig { params(_: String).returns(String) }
          def id=(_)
          end

          # The delta containing the fields that have changed on the Message.
          sig { returns(OpenAI::Models::Beta::Threads::MessageDelta) }
          def delta
          end

          sig do
            params(_: OpenAI::Models::Beta::Threads::MessageDelta).returns(OpenAI::Models::Beta::Threads::MessageDelta)
          end
          def delta=(_)
          end

          # The object type, which is always `thread.message.delta`.
          sig { returns(Symbol) }
          def object
          end

          sig { params(_: Symbol).returns(Symbol) }
          def object=(_)
          end

          # Represents a message delta i.e. any changed fields on a message during
          #   streaming.
          sig do
            params(id: String, delta: OpenAI::Models::Beta::Threads::MessageDelta, object: Symbol)
              .returns(T.attached_class)
          end
          def self.new(id:, delta:, object: :"thread.message.delta")
          end

          sig { override.returns({id: String, delta: OpenAI::Models::Beta::Threads::MessageDelta, object: Symbol}) }
          def to_hash
          end
        end
      end
    end
  end
end
