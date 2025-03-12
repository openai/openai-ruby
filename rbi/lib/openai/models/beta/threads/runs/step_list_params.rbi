# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class StepListParams < OpenAI::BaseModel
            extend OpenAI::RequestParameters::Converter
            include OpenAI::RequestParameters

            sig { returns(String) }
            def thread_id
            end

            sig { params(_: String).returns(String) }
            def thread_id=(_)
            end

            sig { returns(T.nilable(String)) }
            def after
            end

            sig { params(_: String).returns(String) }
            def after=(_)
            end

            sig { returns(T.nilable(String)) }
            def before
            end

            sig { params(_: String).returns(String) }
            def before=(_)
            end

            sig { returns(T.nilable(T::Array[Symbol])) }
            def include
            end

            sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
            def include=(_)
            end

            sig { returns(T.nilable(Integer)) }
            def limit
            end

            sig { params(_: Integer).returns(Integer) }
            def limit=(_)
            end

            sig { returns(T.nilable(Symbol)) }
            def order
            end

            sig { params(_: Symbol).returns(Symbol) }
            def order=(_)
            end

            sig do
              params(
                thread_id: String,
                after: String,
                before: String,
                include: T::Array[Symbol],
                limit: Integer,
                order: Symbol,
                request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
              )
                .returns(T.attached_class)
            end
            def self.new(thread_id:, after: nil, before: nil, include: nil, limit: nil, order: nil, request_options: {})
            end

            sig do
              override
                .returns(
                  {
                    thread_id: String,
                    after: String,
                    before: String,
                    include: T::Array[Symbol],
                    limit: Integer,
                    order: Symbol,
                    request_options: OpenAI::RequestOptions
                  }
                )
            end
            def to_hash
            end

            class Order < OpenAI::Enum
              abstract!

              ASC = :asc
              DESC = :desc

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
  end
end
