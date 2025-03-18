# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseInputMessageItem < OpenAI::BaseModel
        # The unique ID of the message input.
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        # A list of one or many input items to the model, containing different content
        #   types.
        sig { returns(OpenAI::Models::Responses::ResponseInputMessageContentList) }
        def content
        end

        sig do
          params(_: OpenAI::Models::Responses::ResponseInputMessageContentList)
            .returns(OpenAI::Models::Responses::ResponseInputMessageContentList)
        end
        def content=(_)
        end

        # The role of the message input. One of `user`, `system`, or `developer`.
        sig { returns(Symbol) }
        def role
        end

        sig { params(_: Symbol).returns(Symbol) }
        def role=(_)
        end

        # The status of item. One of `in_progress`, `completed`, or `incomplete`.
        #   Populated when items are returned via API.
        sig { returns(T.nilable(Symbol)) }
        def status
        end

        sig { params(_: Symbol).returns(Symbol) }
        def status=(_)
        end

        # The type of the message input. Always set to `message`.
        sig { returns(T.nilable(Symbol)) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig do
          params(
            id: String,
            content: OpenAI::Models::Responses::ResponseInputMessageContentList,
            role: Symbol,
            status: Symbol,
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(id:, content:, role:, status: nil, type: nil)
        end

        sig do
          override
            .returns(
              {
                id: String,
                content: OpenAI::Models::Responses::ResponseInputMessageContentList,
                role: Symbol,
                status: Symbol,
                type: Symbol
              }
            )
        end
        def to_hash
        end

        # The role of the message input. One of `user`, `system`, or `developer`.
        class Role < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          USER = :user
          SYSTEM = :system
          DEVELOPER = :developer
        end

        # The status of item. One of `in_progress`, `completed`, or `incomplete`.
        #   Populated when items are returned via API.
        class Status < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          IN_PROGRESS = :in_progress
          COMPLETED = :completed
          INCOMPLETE = :incomplete
        end

        # The type of the message input. Always set to `message`.
        class Type < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          MESSAGE = :message
        end
      end
    end
  end
end
