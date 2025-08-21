# typed: strong

module OpenAI
  module Models
    module Conversations
      class ItemRetrieveParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Conversations::ItemRetrieveParams,
              OpenAI::Internal::AnyHash
            )
          end

        sig { returns(String) }
        attr_accessor :conversation_id

        # Additional fields to include in the response. See the `include` parameter for
        # [listing Conversation items above](https://platform.openai.com/docs/api-reference/conversations/list-items#conversations_list_items-include)
        # for more information.
        sig do
          returns(
            T.nilable(T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol])
          )
        end
        attr_reader :include

        sig do
          params(
            include: T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol]
          ).void
        end
        attr_writer :include

        sig do
          params(
            conversation_id: String,
            include: T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol],
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          conversation_id:,
          # Additional fields to include in the response. See the `include` parameter for
          # [listing Conversation items above](https://platform.openai.com/docs/api-reference/conversations/list-items#conversations_list_items-include)
          # for more information.
          include: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              conversation_id: String,
              include:
                T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol],
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
