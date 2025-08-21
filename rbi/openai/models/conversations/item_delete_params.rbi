# typed: strong

module OpenAI
  module Models
    module Conversations
      class ItemDeleteParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Conversations::ItemDeleteParams,
              OpenAI::Internal::AnyHash
            )
          end

        sig { returns(String) }
        attr_accessor :conversation_id

        sig do
          params(
            conversation_id: String,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(conversation_id:, request_options: {})
        end

        sig do
          override.returns(
            { conversation_id: String, request_options: OpenAI::RequestOptions }
          )
        end
        def to_hash
        end
      end
    end
  end
end
