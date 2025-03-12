# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseReasoningItem < OpenAI::BaseModel
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        sig { returns(T::Array[OpenAI::Models::Responses::ResponseReasoningItem::Summary]) }
        def summary
        end

        sig do
          params(_: T::Array[OpenAI::Models::Responses::ResponseReasoningItem::Summary])
            .returns(T::Array[OpenAI::Models::Responses::ResponseReasoningItem::Summary])
        end
        def summary=(_)
        end

        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig { returns(T.nilable(Symbol)) }
        def status
        end

        sig { params(_: Symbol).returns(Symbol) }
        def status=(_)
        end

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
          sig { returns(String) }
          def text
          end

          sig { params(_: String).returns(String) }
          def text=(_)
          end

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

        class Status < OpenAI::Enum
          abstract!

          IN_PROGRESS = :in_progress
          COMPLETED = :completed
          INCOMPLETE = :incomplete

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end
      end
    end
  end
end
