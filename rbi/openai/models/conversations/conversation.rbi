# typed: strong

module OpenAI
  module Models
    module Conversations
      class Conversation < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Conversations::Conversation,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the conversation.
        sig { returns(String) }
        attr_accessor :id

        # The time at which the conversation was created, measured in seconds since the
        # Unix epoch.
        sig { returns(Integer) }
        attr_accessor :created_at

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard. Keys are strings with a maximum
        # length of 64 characters. Values are strings with a maximum length of 512
        # characters.
        sig { returns(T.anything) }
        attr_accessor :metadata

        # The object type, which is always `conversation`.
        sig { returns(Symbol) }
        attr_accessor :object

        sig do
          params(
            id: String,
            created_at: Integer,
            metadata: T.anything,
            object: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the conversation.
          id:,
          # The time at which the conversation was created, measured in seconds since the
          # Unix epoch.
          created_at:,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard. Keys are strings with a maximum
          # length of 64 characters. Values are strings with a maximum length of 512
          # characters.
          metadata:,
          # The object type, which is always `conversation`.
          object: :conversation
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              metadata: T.anything,
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
