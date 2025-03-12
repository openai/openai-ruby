# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseOutputMessage < OpenAI::BaseModel
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

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

        sig { returns(Symbol) }
        def role
        end

        sig { params(_: Symbol).returns(Symbol) }
        def role=(_)
        end

        sig { returns(Symbol) }
        def status
        end

        sig { params(_: Symbol).returns(Symbol) }
        def status=(_)
        end

        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

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

        class Content < OpenAI::Union
          abstract!

          class << self
            sig do
              override
                .returns(
                  [[Symbol, OpenAI::Models::Responses::ResponseOutputText], [Symbol, OpenAI::Models::Responses::ResponseOutputRefusal]]
                )
            end
            private def variants
            end
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
