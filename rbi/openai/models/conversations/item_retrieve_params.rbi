# typed: strong

module OpenAI
  module Models

    module Conversations

      class ItemRetrieveParams < OpenAI::Internal::Type::BaseModel

        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias do
          T.any(
            OpenAI::Conversations::ItemRetrieveParams,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(String) }
        attr_accessor :conversation_id

        sig { returns(String) }
        attr_accessor :item_id

        # Additional fields to include in the response. See the `include` parameter for
        # [listing Conversation items above](https://developers.openai.com/api/reference/resources/conversations/subresources/items/methods/list#%28resource%29%20conversations.items%20%3E%20%28method%29%20list%20%3E%20%28params%29%20default%20%3E%20%28param%29%20include%20%3E%20%28schema%29)
        # for more information.
        sig { returns(T.nilable(T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol])) }
        attr_reader :include

        sig { params(include: T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol]).void }
        attr_writer :include

        sig do
          params(

            conversation_id: String,

            item_id: String,

            include: T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol],

            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          conversation_id:,

          item_id:,

          # Additional fields to include in the response. See the `include` parameter for
          # [listing Conversation items above](https://developers.openai.com/api/reference/resources/conversations/subresources/items/methods/list#%28resource%29%20conversations.items%20%3E%20%28method%29%20list%20%3E%20%28params%29%20default%20%3E%20%28param%29%20include%20%3E%20%28schema%29)
          # for more information.
          include: nil,

          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              conversation_id: String,
              item_id: String,
              include: T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol],
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
