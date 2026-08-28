# typed: strong

module OpenAI
  module Models
    module Responses
      sig do
        params(
          items: T.any(
            T::Enumerable[
              T.any(
                OpenAI::Responses::ResponseInputItem::Variants,
                OpenAI::Responses::ResponseOutputItem::Variants,
                OpenAI::Responses::ResponseItem::Variants,
                T::Hash[T.any(String, Symbol), T.anything]
              )
            ],
            OpenAI::Responses::ResponseItemList
          )
        )
          .returns(T::Array[OpenAI::Responses::ResponseInputItem::Variants])
      end
      def self.to_input_items(items)
      end

      sig do
        params(
          item: T.any(
            OpenAI::Responses::ResponseInputItem::Variants,
            OpenAI::Responses::ResponseOutputItem::Variants,
            OpenAI::Responses::ResponseItem::Variants,
            T::Hash[T.any(String, Symbol), T.anything]
          )
        )
          .returns(T.nilable(OpenAI::Responses::ResponseInputItem::Variants))
      end
      def self.to_input_item(item)
      end
    end
  end
end
