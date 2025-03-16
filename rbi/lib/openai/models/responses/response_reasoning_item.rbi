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
        sig { returns(T.nilable(Symbol)) }
        def status
        end

        sig { params(_: Symbol).returns(Symbol) }
        def status=(_)
        end

        # A description of the chain of thought used by a reasoning model while generating
        #   a response.
        sig do
          params(
            id: String,
            summary: T::Array[OpenAI::Models::Responses::ResponseReasoningItem::Summary],
            status: Symbol,
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
                status: Symbol
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
        class Status < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          IN_PROGRESS = :in_progress
          COMPLETED = :completed
          INCOMPLETE = :incomplete
        end
      end
    end
  end
end
