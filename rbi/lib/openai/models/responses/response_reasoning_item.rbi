# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseReasoningItem < OpenAI::BaseModel
        # The unique identifier of the reasoning content.
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        # Reasoning text contents.
        sig { returns(T::Array[OpenAI::Models::Responses::ResponseReasoningItem::Summary]) }
        def summary
        end

        sig do
          params(_: T::Array[OpenAI::Models::Responses::ResponseReasoningItem::Summary])
            .returns(T::Array[OpenAI::Models::Responses::ResponseReasoningItem::Summary])
        end
        def summary=(_)
        end

        # The type of the object. Always `reasoning`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        #   Populated when items are returned via API.
        sig { returns(T.nilable(OpenAI::Models::Responses::ResponseReasoningItem::Status::OrSymbol)) }
        def status
        end

        sig do
          params(_: OpenAI::Models::Responses::ResponseReasoningItem::Status::OrSymbol)
            .returns(OpenAI::Models::Responses::ResponseReasoningItem::Status::OrSymbol)
        end
        def status=(_)
        end

        # A description of the chain of thought used by a reasoning model while generating
        #   a response.
        sig do
          params(
            id: String,
            summary: T::Array[OpenAI::Models::Responses::ResponseReasoningItem::Summary],
            status: OpenAI::Models::Responses::ResponseReasoningItem::Status::OrSymbol,
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(id:, summary:, status: nil, type: :reasoning)
        end

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
        def to_hash
        end

        class Summary < OpenAI::BaseModel
          # A short summary of the reasoning used by the model when generating the response.
          sig { returns(String) }
          def text
          end

          sig { params(_: String).returns(String) }
          def text=(_)
          end

          # The type of the object. Always `summary_text`.
          sig { returns(Symbol) }
          def type
          end

          sig { params(_: Symbol).returns(Symbol) }
          def type=(_)
          end

          sig { params(text: String, type: Symbol).returns(T.attached_class) }
          def self.new(text:, type: :summary_text)
          end

          sig { override.returns({text: String, type: Symbol}) }
          def to_hash
          end
        end

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        #   Populated when items are returned via API.
        module Status
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseReasoningItem::Status) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Responses::ResponseReasoningItem::Status::TaggedSymbol) }

          IN_PROGRESS = T.let(:in_progress, OpenAI::Models::Responses::ResponseReasoningItem::Status::OrSymbol)
          COMPLETED = T.let(:completed, OpenAI::Models::Responses::ResponseReasoningItem::Status::OrSymbol)
          INCOMPLETE = T.let(:incomplete, OpenAI::Models::Responses::ResponseReasoningItem::Status::OrSymbol)
        end
      end
    end
  end
end
