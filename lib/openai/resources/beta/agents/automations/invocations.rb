# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Agents
        class Automations
          class Invocations
            # Queues a manual delivery without changing the saved schedule.
            #
            # @overload create(automation_id, request_options: {})
            #
            # @param automation_id [String]
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Beta::Agents::Automations::AutomationInvocation]
            #
            # @see OpenAI::Models::Beta::Agents::Automations::InvocationCreateParams
            def create(automation_id, params = {})
              @client.request(
                method: :post,
                path: ["agents/automations/%1$s/invocations", automation_id],
                headers: {"openai-beta" => "agents=v1"},
                model: OpenAI::Beta::Agents::Automations::AutomationInvocation,
                security: {bearer_auth: true},
                options: params[:request_options]
              )
            end

            # Retrieves a delivery record for a project-owned automation.
            #
            # @overload retrieve(invocation_id, automation_id:, request_options: {})
            #
            # @param invocation_id [String]
            # @param automation_id [String]
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Beta::Agents::Automations::AutomationInvocation]
            #
            # @see OpenAI::Models::Beta::Agents::Automations::InvocationRetrieveParams
            def retrieve(invocation_id, params)
              parsed, options = OpenAI::Beta::Agents::Automations::InvocationRetrieveParams.dump_request(params)
              automation_id = parsed.delete(:automation_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end

              @client.request(
                method: :get,
                path: ["agents/automations/%1$s/invocations/%2$s", automation_id, invocation_id],
                headers: {"openai-beta" => "agents=v1"},
                model: OpenAI::Beta::Agents::Automations::AutomationInvocation,
                security: {bearer_auth: true},
                options: options
              )
            end

            # Lists delivery records for a project-owned automation.
            #
            # @overload list(automation_id, after: nil, limit: nil, order: nil, request_options: {})
            #
            # @param automation_id [String]
            #
            # @param after [String]
            #   Return resources after this resource ID in the selected order.
            #
            # @param limit [Integer]
            #   The maximum number of resources to return, between 1 and 100. Defaults to 20.
            #
            # @param order [Symbol, OpenAI::Models::Beta::Agents::Automations::InvocationListParams::Order]
            #   The order in which resources are returned. Defaults to `desc`.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Beta::Agents::Automations::AutomationInvocation>]
            #
            # @see OpenAI::Models::Beta::Agents::Automations::InvocationListParams
            def list(automation_id, params = {})
              parsed, options = OpenAI::Beta::Agents::Automations::InvocationListParams.dump_request(params)
              query = OpenAI::Internal::Util.encode_query_params(parsed)
              @client.request(
                method: :get,
                path: ["agents/automations/%1$s/invocations", automation_id],
                query: query,
                headers: {"openai-beta" => "agents=v1"},
                page: OpenAI::Internal::CursorPage,
                model: OpenAI::Beta::Agents::Automations::AutomationInvocation,
                security: {bearer_auth: true},
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
