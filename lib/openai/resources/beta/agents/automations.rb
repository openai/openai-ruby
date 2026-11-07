# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Agents
        class Automations
          # @return [OpenAI::Resources::Beta::Agents::Automations::Invocations]
          attr_reader :invocations

          # Saves an active automation without invoking it immediately.
          #
          # @overload create(create_automation_params:, request_options: {})
          #
          # @param create_automation_params [OpenAI::Models::Beta::Agents::AutomationScheduleParam::Periodic, OpenAI::Models::Beta::Agents::AutomationScheduleParam::Once]
          #   Creates an automation without invoking it immediately.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Agents::PeriodicAutomation, OpenAI::Models::Beta::Agents::OneTimeAutomation]
          #
          # @see OpenAI::Models::Beta::Agents::AutomationCreateParams
          def create(params)
            parsed, options = OpenAI::Beta::Agents::AutomationCreateParams.dump_request(params)
            @client.request(
              method: :post,
              path: "agents/automations",
              headers: {"openai-beta" => "agents=v1"},
              body: parsed[:create_automation_params],
              model: OpenAI::Beta::Agents::Automation,
              security: {bearer_auth: true},
              options: options
            )
          end

          # Retrieves a project-owned automation.
          #
          # @overload retrieve(automation_id, request_options: {})
          #
          # @param automation_id [String]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Agents::PeriodicAutomation, OpenAI::Models::Beta::Agents::OneTimeAutomation]
          #
          # @see OpenAI::Models::Beta::Agents::AutomationRetrieveParams
          def retrieve(automation_id, params = {})
            @client.request(
              method: :get,
              path: ["agents/automations/%1$s", automation_id],
              headers: {"openai-beta" => "agents=v1"},
              model: OpenAI::Beta::Agents::Automation,
              security: {bearer_auth: true},
              options: params[:request_options]
            )
          end

          # Updates supplied fields; target and metadata replace the whole field.
          #
          # @overload update(automation_id, expression: nil, metadata: nil, name: nil, run_at: nil, target: nil, timezone: nil, request_options: {})
          #
          # @param automation_id [String]
          #
          # @param expression [String]
          #   Only accepted for periodic automations.
          #
          # @param metadata [Hash{Symbol=>String}]
          #   Replaces all metadata; omit to leave unchanged.
          #
          # @param name [String]
          #
          # @param run_at [Integer]
          #   A future Unix timestamp in seconds; accepted only before a one-time scheduled
          #   invocation exists.
          #
          # @param target [OpenAI::Models::Beta::Agents::AutomationTargetParam::NewSession, OpenAI::Models::Beta::Agents::AutomationTargetParam::ExistingSession]
          #   Replaces the complete target, retaining its type and any creator session.
          #
          # @param timezone [String]
          #   Only accepted for periodic automations.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Agents::PeriodicAutomation, OpenAI::Models::Beta::Agents::OneTimeAutomation]
          #
          # @see OpenAI::Models::Beta::Agents::AutomationUpdateParams
          def update(automation_id, params = {})
            parsed, options = OpenAI::Beta::Agents::AutomationUpdateParams.dump_request(params)
            @client.request(
              method: :post,
              path: ["agents/automations/%1$s", automation_id],
              headers: {"openai-beta" => "agents=v1"},
              body: parsed,
              model: OpenAI::Beta::Agents::Automation,
              security: {bearer_auth: true},
              options: options
            )
          end

          # Lists project-owned automations, optionally filtered by target session.
          #
          # @overload list(after: nil, limit: nil, order: nil, session_id: nil, request_options: {})
          #
          # @param after [String]
          #   Return resources after this resource ID in the selected order.
          #
          # @param limit [Integer]
          #   The maximum number of resources to return, between 1 and 100. Defaults to 20.
          #
          # @param order [Symbol, OpenAI::Models::Beta::Agents::AutomationListParams::Order]
          #   The order in which resources are returned. Defaults to `desc`.
          #
          # @param session_id [String]
          #   Matches existing-session targets, including agent-created automations.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Beta::Agents::PeriodicAutomation, OpenAI::Models::Beta::Agents::OneTimeAutomation>]
          #
          # @see OpenAI::Models::Beta::Agents::AutomationListParams
          def list(params = {})
            parsed, options = OpenAI::Beta::Agents::AutomationListParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "agents/automations",
              query: query,
              headers: {"openai-beta" => "agents=v1"},
              page: OpenAI::Internal::CursorPage,
              model: OpenAI::Beta::Agents::Automation,
              security: {bearer_auth: true},
              options: options
            )
          end

          # Deletes the automation and prevents future invocations without deleting its
          # target session.
          #
          # @overload delete(automation_id, request_options: {})
          #
          # @param automation_id [String]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Agents::AutomationDeleted]
          #
          # @see OpenAI::Models::Beta::Agents::AutomationDeleteParams
          def delete(automation_id, params = {})
            @client.request(
              method: :delete,
              path: ["agents/automations/%1$s", automation_id],
              headers: {"openai-beta" => "agents=v1"},
              model: OpenAI::Beta::Agents::AutomationDeleted,
              security: {bearer_auth: true},
              options: params[:request_options]
            )
          end

          # Pauses future scheduled delivery without stopping an active session.
          #
          # @overload pause(automation_id, request_options: {})
          #
          # @param automation_id [String]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Agents::PeriodicAutomation, OpenAI::Models::Beta::Agents::OneTimeAutomation]
          #
          # @see OpenAI::Models::Beta::Agents::AutomationPauseParams
          def pause(automation_id, params = {})
            @client.request(
              method: :post,
              path: ["agents/automations/%1$s/pause", automation_id],
              headers: {"openai-beta" => "agents=v1"},
              model: OpenAI::Beta::Agents::Automation,
              security: {bearer_auth: true},
              options: params[:request_options]
            )
          end

          # Resumes scheduled delivery; one-time automations without a pending invocation
          # require a future run_at.
          #
          # @overload resume(automation_id, request_options: {})
          #
          # @param automation_id [String]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Agents::PeriodicAutomation, OpenAI::Models::Beta::Agents::OneTimeAutomation]
          #
          # @see OpenAI::Models::Beta::Agents::AutomationResumeParams
          def resume(automation_id, params = {})
            @client.request(
              method: :post,
              path: ["agents/automations/%1$s/resume", automation_id],
              headers: {"openai-beta" => "agents=v1"},
              model: OpenAI::Beta::Agents::Automation,
              security: {bearer_auth: true},
              options: params[:request_options]
            )
          end

          # @api private
          #
          # @param client [OpenAI::Client]
          def initialize(client:)
            @client = client
            @invocations = OpenAI::Resources::Beta::Agents::Automations::Invocations.new(client: client)
          end
        end
      end
    end
  end
end
