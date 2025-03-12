# typed: strong

module OpenAI
  module Resources
    class Beta
      class Threads
        class Runs
          class Steps
            sig do
              params(
                step_id: String,
                thread_id: String,
                run_id: String,
                include: T::Array[Symbol],
                request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
              )
                .returns(OpenAI::Models::Beta::Threads::Runs::RunStep)
            end
            def retrieve(step_id, thread_id:, run_id:, include: nil, request_options: {})
            end

            sig do
              params(
                run_id: String,
                thread_id: String,
                after: String,
                before: String,
                include: T::Array[Symbol],
                limit: Integer,
                order: Symbol,
                request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
              )
                .returns(OpenAI::CursorPage[OpenAI::Models::Beta::Threads::Runs::RunStep])
            end
            def list(
              run_id,
              thread_id:,
              after: nil,
              before: nil,
              include: nil,
              limit: nil,
              order: nil,
              request_options: {}
            )
            end

            sig { params(client: OpenAI::Client).returns(T.attached_class) }
            def self.new(client:)
            end
          end
        end
      end
    end
  end
end
