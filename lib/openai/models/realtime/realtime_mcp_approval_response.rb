# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeMcpApprovalResponse < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the approval response.
        #
        #   @return [String]
        required :id, String

        # @!attribute approval_request_id
        #   The ID of the approval request being answered.
        #
        #   @return [String]
        required :approval_request_id, String

        # @!attribute approve
        #   Whether the request was approved.
        #
        #   @return [Boolean]
        required :approve, OpenAI::Internal::Type::Boolean

        # @!attribute type
        #   The type of the item. Always `mcp_approval_response`.
        #
        #   @return [Symbol, :mcp_approval_response]
        required :type, const: :mcp_approval_response

        # @!attribute reason
        #   Optional reason for the decision.
        #
        #   @return [String, nil]
        optional :reason, String, nil?: true

        # @!method initialize(id:, approval_request_id:, approve:, reason: nil, type: :mcp_approval_response)
        #   A Realtime item responding to an MCP approval request.
        #
        #   @param id [String] The unique ID of the approval response.
        #
        #   @param approval_request_id [String] The ID of the approval request being answered.
        #
        #   @param approve [Boolean] Whether the request was approved.
        #
        #   @param reason [String, nil] Optional reason for the decision.
        #
        #   @param type [Symbol, :mcp_approval_response] The type of the item. Always `mcp_approval_response`.
      end
    end
  end
end
