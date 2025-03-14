# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseOutputMessage < OpenAI::BaseModel
        # The unique ID of the output message.
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        # The content of the output message.
        sig do
          returns(
            T::Array[T.any(OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal)]
          )
        end
        def content
        end

        sig do
          params(
            _: T::Array[T.any(OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal)]
          )
            .returns(
              T::Array[T.any(OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal)]
            )
        end
        def content=(_)
        end

        # The role of the output message. Always `assistant`.
        sig { returns(Symbol) }
        def role
        end

        sig { params(_: Symbol).returns(Symbol) }
        def role=(_)
        end

        # The status of the message input. One of `in_progress`, `completed`, or
        #   `incomplete`. Populated when input items are returned via API.
        sig { returns(Symbol) }
        def status
        end

        sig { params(_: Symbol).returns(Symbol) }
        def status=(_)
        end

        # The type of the output message. Always `message`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # An output message from the model.
        sig do
          params(
            id: String,
            content: T::Array[T.any(OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal)],
            status: Symbol,
            role: Symbol,
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(id:, content:, status:, role: :assistant, type: :message)
        end

        sig do
          override
            .returns(
              {
                id: String,
                content: T::Array[T.any(OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal)],
                role: Symbol,
                status: Symbol,
                type: Symbol
              }
            )
        end
        def to_hash
        end

        # A text output from the model.
        class Content < OpenAI::Union
          abstract!

          class << self
            sig do
              override
                .returns([OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal])
            end
            def variants
            end
          end
        end

        # The status of the message input. One of `in_progress`, `completed`, or
        #   `incomplete`. Populated when input items are returned via API.
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
