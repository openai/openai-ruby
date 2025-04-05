# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseReasoningItem < OpenAI::Internal::Type::BaseModel
        # The unique identifier of the reasoning content.
        sig { returns(String) }
        attr_accessor :id

        # Reasoning text contents.
        sig { returns(T::Array[OpenAI::Models::Responses::ResponseReasoningItem::Summary]) }
        attr_accessor :summary

        # The type of the object. Always `reasoning`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        sig { returns(T.nilable(OpenAI::Models::Responses::ResponseReasoningItem::Status::OrSymbol)) }
        attr_reader :status

        sig { params(status: OpenAI::Models::Responses::ResponseReasoningItem::Status::OrSymbol).void }
        attr_writer :status

        # A description of the chain of thought used by a reasoning model while generating
        # a response.
        sig do
          params(
            id: String,
            summary: T::Array[T.any(OpenAI::Models::Responses::ResponseReasoningItem::Summary, OpenAI::Internal::AnyHash)],
            status: OpenAI::Models::Responses::ResponseReasoningItem::Status::OrSymbol,
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(id:, summary:, status: nil, type: :reasoning); end

        sig do
          override
            .returns(
              {
                id: String,
                summary: T::Array[OpenAI::Models::Responses::ResponseReasoningItem::Summary],
                type: Symbol,
                status: OpenAI::Models::Responses::ResponseReasoningItem::Status::OrSymbol
              }
            )
        end
        def to_hash; end

        class Summary < OpenAI::Internal::Type::BaseModel
          # A short summary of the reasoning used by the model when generating the response.
          sig { returns(String) }
          attr_accessor :text

          # The type of the object. Always `summary_text`.
          sig { returns(Symbol) }
          attr_accessor :type

          sig { params(text: String, type: Symbol).returns(T.attached_class) }
          def self.new(text:, type: :summary_text); end

          sig { override.returns({text: String, type: Symbol}) }
          def to_hash; end
        end

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseReasoningItem::Status) }
          OrSymbol =
            T.type_alias { T.any(Symbol, String, OpenAI::Models::Responses::ResponseReasoningItem::Status::TaggedSymbol) }

          IN_PROGRESS = T.let(:in_progress, OpenAI::Models::Responses::ResponseReasoningItem::Status::TaggedSymbol)
          COMPLETED = T.let(:completed, OpenAI::Models::Responses::ResponseReasoningItem::Status::TaggedSymbol)
          INCOMPLETE = T.let(:incomplete, OpenAI::Models::Responses::ResponseReasoningItem::Status::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Responses::ResponseReasoningItem::Status::TaggedSymbol]) }
          def self.values; end
        end
      end
    end
  end
end
