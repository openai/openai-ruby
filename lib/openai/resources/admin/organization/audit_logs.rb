# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        # List user actions and configuration changes within this organization.
        class AuditLogs
          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Admin::Organization::AuditLogListParams} for more details.
          #
          # List user actions and configuration changes within this organization.
          #
          # @overload list(actor_emails: nil, actor_ids: nil, after: nil, before: nil, effective_at: nil, event_types: nil, limit: nil, project_ids: nil, resource_ids: nil, request_options: {})
          #
          # @param actor_emails [Array<String>] Return only events performed by users with these emails.
          #
          # @param actor_ids [Array<String>] Return only events performed by these actors. Can be a user ID, a service accoun
          #
          # @param after [String] A cursor for use in pagination. `after` is an object ID that defines your place
          #
          # @param before [String] A cursor for use in pagination. `before` is an object ID that defines your place
          #
          # @param effective_at [OpenAI::Models::Admin::Organization::AuditLogListParams::EffectiveAt] Return only events whose `effective_at` (Unix seconds) is in this range.
          #
          # @param event_types [Array<Symbol, OpenAI::Models::Admin::Organization::AuditLogListParams::EventType>] Return only events with a `type` in one of these values. For example, `project.c
          #
          # @param limit [Integer] A limit on the number of objects to be returned. Limit can range between 1 and 1
          #
          # @param project_ids [Array<String>] Return only events for these projects.
          #
          # @param resource_ids [Array<String>] Return only events performed on these targets. For example, a project ID updated
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::ConversationCursorPage<OpenAI::Models::Admin::Organization::AuditLogListResponse>]
          #
          # @see OpenAI::Models::Admin::Organization::AuditLogListParams
          def list(params = {})
            parsed, options = OpenAI::Admin::Organization::AuditLogListParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "organization/audit_logs",
              query: query,
              page: OpenAI::Internal::ConversationCursorPage,
              model: OpenAI::Models::Admin::Organization::AuditLogListResponse,
              security: {admin_api_key_auth: true},
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
