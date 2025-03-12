# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFunctionToolCall < OpenAI::BaseModel
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        sig { returns(String) }
        def arguments
        end

        sig { params(_: String).returns(String) }
        def arguments=(_)
        end

        sig { returns(String) }
        def call_id
        end

        sig { params(_: String).returns(String) }
        def call_id=(_)
        end

        sig { returns(String) }
        def name
        end

        sig { params(_: String).returns(String) }
        def name=(_)
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
          params(id: String, arguments: String, call_id: String, name: String, status: Symbol, type: Symbol)
            .returns(T.attached_class)
        end
        def self.new(id:, arguments:, call_id:, name:, status: nil, type: :function_call)
        end

        sig do
          override
            .returns({
                       id: String,
                       arguments: String,
                       call_id: String,
                       name: String,
                       type: Symbol,
                       status: Symbol
                     })
        end
        def to_hash
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
