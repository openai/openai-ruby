# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Threads
        class Runs
          class Steps
            # Retrieves a run step.
            #
            # @overload retrieve(step_id, thread_id:, run_id:, include: nil, request_options: {})
            #
            # @param step_id [String]
            # @param thread_id [String]
            # @param run_id [String]
            # @param include [Array<Symbol, OpenAI::Models::Beta::Threads::Runs::RunStepInclude>]
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Beta::Threads::Runs::RunStep]
            #
            # @see OpenAI::Models::Beta::Threads::Runs::StepRetrieveParams
            def retrieve(step_id, params)
              parsed, options = OpenAI::Models::Beta::Threads::Runs::StepRetrieveParams.dump_request(params)
              thread_id =
                parsed.delete(:thread_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              run_id =
                parsed.delete(:run_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              @client.request(
                method: :get,
                path: ["threads/%1$s/runs/%2$s/steps/%3$s", thread_id, run_id, step_id],
                query: parsed,
                model: OpenAI::Models::Beta::Threads::Runs::RunStep,
                options: options
              )
            end

            # Returns a list of run steps belonging to a run.
            #
            # @overload list(run_id, thread_id:, after: nil, before: nil, include: nil, limit: nil, order: nil, request_options: {})
            #
            # @param run_id [String]
            # @param thread_id [String]
            # @param after [String]
            # @param before [String]
            # @param include [Array<Symbol, OpenAI::Models::Beta::Threads::Runs::RunStepInclude>]
            # @param limit [Integer]
            # @param order [Symbol, OpenAI::Models::Beta::Threads::Runs::StepListParams::Order]
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::CursorPage<OpenAI::Models::Beta::Threads::Runs::RunStep>]
            #
            # @see OpenAI::Models::Beta::Threads::Runs::StepListParams
            def list(run_id, params)
              parsed, options = OpenAI::Models::Beta::Threads::Runs::StepListParams.dump_request(params)
              thread_id =
                parsed.delete(:thread_id) do
                  raise ArgumentError.new("missing required path argument #{_1}")
                end
              @client.request(
                method: :get,
                path: ["threads/%1$s/runs/%2$s/steps", thread_id, run_id],
                query: parsed,
                page: OpenAI::CursorPage,
                model: OpenAI::Models::Beta::Threads::Runs::RunStep,
                options: options
              )
            end

            # @api private
            #
            # @param client [OpenAI::Client]
            def initialize(client:)
              @client = client
            end
          end
        end
      end
    end
  end
end
