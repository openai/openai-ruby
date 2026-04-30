# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Invites
          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Admin::Organization::InviteCreateParams} for more details.
          #
          # Create an invite for a user to the organization. The invite must be accepted by
          # the user before they have access to the organization.
          #
          # @overload create(email:, role:, projects: nil, request_options: {})
          #
          # @param email [String] Send an email to this address
          #
          # @param role [Symbol, OpenAI::Models::Admin::Organization::InviteCreateParams::Role] `owner` or `reader`
          #
          # @param projects [Array<OpenAI::Models::Admin::Organization::InviteCreateParams::Project>] An array of projects to which membership is granted at the same time the org inv
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::Invite]
          #
          # @see OpenAI::Models::Admin::Organization::InviteCreateParams
          def create(params)
            parsed, options = OpenAI::Admin::Organization::InviteCreateParams.dump_request(params)
            @client.request(
              method: :post,
              path: "organization/invites",
              body: parsed,
              model: OpenAI::Admin::Organization::Invite,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Retrieves an invite.
          #
          # @overload retrieve(invite_id, request_options: {})
          #
          # @param invite_id [String] The ID of the invite to retrieve.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::Invite]
          #
          # @see OpenAI::Models::Admin::Organization::InviteRetrieveParams
          def retrieve(invite_id, params = {})
            @client.request(
              method: :get,
              path: ["organization/invites/%1$s", invite_id],
              model: OpenAI::Admin::Organization::Invite,
              security: {admin_api_key_auth: true},
              options: params[:request_options]
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Admin::Organization::InviteListParams} for more details.
          #
          # Returns a list of invites in the organization.
          #
          # @overload list(after: nil, limit: nil, request_options: {})
          #
          # @param after [String] A cursor for use in pagination. `after` is an object ID that defines your place
          #
          # @param limit [Integer] A limit on the number of objects to be returned. Limit can range between 1 and 1
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::ConversationCursorPage<OpenAI::Models::Admin::Organization::Invite>]
          #
          # @see OpenAI::Models::Admin::Organization::InviteListParams
          def list(params = {})
            parsed, options = OpenAI::Admin::Organization::InviteListParams.dump_request(params)
            query = OpenAI::Internal::Util.encode_query_params(parsed)
            @client.request(
              method: :get,
              path: "organization/invites",
              query: query,
              page: OpenAI::Internal::ConversationCursorPage,
              model: OpenAI::Admin::Organization::Invite,
              security: {admin_api_key_auth: true},
              options: options
            )
          end

          # Delete an invite. If the invite has already been accepted, it cannot be deleted.
          #
          # @overload delete(invite_id, request_options: {})
          #
          # @param invite_id [String] The ID of the invite to delete.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Admin::Organization::InviteDeleteResponse]
          #
          # @see OpenAI::Models::Admin::Organization::InviteDeleteParams
          def delete(invite_id, params = {})
            @client.request(
              method: :delete,
              path: ["organization/invites/%1$s", invite_id],
              model: OpenAI::Models::Admin::Organization::InviteDeleteResponse,
              security: {admin_api_key_auth: true},
              options: params[:request_options]
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
