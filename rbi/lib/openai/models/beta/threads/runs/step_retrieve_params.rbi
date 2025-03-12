# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class StepRetrieveParams < OpenAI::BaseModel
            extend OpenAI::RequestParameters::Converter
            include OpenAI::RequestParameters

            sig { returns(String) }
            def thread_id
            end

            sig { params(_: String).returns(String) }
            def thread_id=(_)
            end

            sig { returns(String) }
            def run_id
            end

            sig { params(_: String).returns(String) }
            def run_id=(_)
            end

            sig { returns(T.nilable(T::Array[Symbol])) }
            def include
            end

            sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
            def include=(_)
            end

            sig do
              params(
                thread_id: String,
                run_id: String,
                include: T::Array[Symbol],
                request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
              )
                .returns(T.attached_class)
            end
            def self.new(thread_id:, run_id:, include: nil, request_options: {})
            end

            sig do
              override
                .returns(
                  {
                    thread_id: String,
                    run_id: String,
                    include: T::Array[Symbol],
                    request_options: OpenAI::RequestOptions
                  }
                )
            end
            def to_hash
            end
          end
        end
      end
    end
  end
end
