# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeMcpApprovalResponse < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeMcpApprovalResponse,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the approval response.
        sig { returns(String) }
        attr_accessor :id

        # The ID of the approval request being answered.
        sig { returns(String) }
        attr_accessor :approval_request_id

        # Whether the request was approved.
        sig { returns(T::Boolean) }
        attr_accessor :approve

        # The type of the item. Always `mcp_approval_response`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional reason for the decision.
        sig { returns(T.nilable(String)) }
        attr_accessor :reason

        # A Realtime item responding to an MCP approval request.
        sig do
          params(
            id: String,
            approval_request_id: String,
            approve: T::Boolean,
            reason: T.nilable(String),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the approval response.
          id:,
          # The ID of the approval request being answered.
          approval_request_id:,
          # Whether the request was approved.
          approve:,
          # Optional reason for the decision.
          reason: nil,
          # The type of the item. Always `mcp_approval_response`.
          type: :mcp_approval_response
        )
        end

        sig do
          override.returns(
            {
              id: String,
              approval_request_id: String,
              approve: T::Boolean,
              type: Symbol,
              reason: T.nilable(String)
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
