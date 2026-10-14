# frozen_string_literal: true

module OpenAI
  module Resources
    class Admin
      class Organization
        class Invites
          # Create an invite for a user to the organization. The invite must be accepted by
          # the user before they have access to the organization.
          #
          # @overload create(email:, role:, projects: nil, request_options: {})
          #
          # @param email [String]
          #   Send an email to this address
          #
          # @param role [Symbol, OpenAI::Models::Admin::Organization::InviteCreateParams::Role]
          #   `owner` or `reader`
          #
          # @param projects [Array<OpenAI::Models::Admin::Organization::InviteCreateParams::Project>]
          #   An array of projects to which membership is granted at the same time the org
          #   invite is accepted. If omitted, the user will be invited to the default project
          #   for compatibility with legacy behavior. If empty list is passed, the user will
          #   not be invited to any projects, including the default one.
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
          # @param invite_id [String]
          #   The ID of the invite to retrieve.
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

          # Returns a list of invites in the organization.
          #
          # @overload list(after: nil, limit: nil, request_options: {})
          #
          # @param after [String]
          #   A cursor for use in pagination. `after` is an object ID that defines your place
          #   in the list. For instance, if you make a list request and receive 100 objects,
          #   ending with obj_foo, your subsequent call can include after=obj_foo in order to
          #   fetch the next page of the list.
          #
          # @param limit [Integer]
          #   A limit on the number of objects to be returned. Limit can range between 1 and
          #   100, and the default is 20.
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
          # @param invite_id [String]
          #   The ID of the invite to delete.
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
