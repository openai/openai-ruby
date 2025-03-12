# typed: strong

module OpenAI
  module Models
    module Responses
      class EasyInputMessage < OpenAI::BaseModel
        sig { returns(T.any(String, OpenAI::Models::Responses::ResponseInputMessageContentList)) }
        def content
        end

        sig do
          params(_: T.any(String, OpenAI::Models::Responses::ResponseInputMessageContentList))
            .returns(T.any(String, OpenAI::Models::Responses::ResponseInputMessageContentList))
        end
        def content=(_)
        end

        sig { returns(Symbol) }
        def role
        end

        sig { params(_: Symbol).returns(Symbol) }
        def role=(_)
        end

        sig { returns(T.nilable(Symbol)) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig do
          params(
            content: T.any(String, OpenAI::Models::Responses::ResponseInputMessageContentList),
            role: Symbol,
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(content:, role:, type: nil)
        end

        sig do
          override
            .returns(
              {content: T.any(String, OpenAI::Models::Responses::ResponseInputMessageContentList), role: Symbol, type: Symbol}
            )
        end
        def to_hash
        end

        class Content < OpenAI::Union
          abstract!

          class << self
            sig do
              override
                .returns([[NilClass, String], [NilClass, OpenAI::Models::Responses::ResponseInputMessageContentList]])
            end
            private def variants
            end
          end
        end

        class Role < OpenAI::Enum
          abstract!

          USER = :user
          ASSISTANT = :assistant
          SYSTEM = :system
          DEVELOPER = :developer

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end

        class Type < OpenAI::Enum
          abstract!

          MESSAGE = :message

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
