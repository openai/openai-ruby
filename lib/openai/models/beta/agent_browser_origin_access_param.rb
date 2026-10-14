# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentBrowserOriginAccessParam < OpenAI::Internal::Type::BaseModel
        # @!attribute decision
        #   Whether to allow, deny, or cancel the requested origin access.
        #
        #   @return [Symbol, OpenAI::Models::Beta::AgentBrowserOriginAccessParam::Decision]
        required :decision, enum: -> { OpenAI::Beta::AgentBrowserOriginAccessParam::Decision }

        # @!attribute type
        #
        #   @return [Symbol, :browser_origin_access]
        required :type, const: :browser_origin_access

        # @!method initialize(decision:, type: :browser_origin_access)
        #   @param decision [Symbol, OpenAI::Models::Beta::AgentBrowserOriginAccessParam::Decision]
        #     Whether to allow, deny, or cancel the requested origin access.
        #
        #   @param type [Symbol, :browser_origin_access]

        # Whether to allow, deny, or cancel the requested origin access.
        #
        # @see OpenAI::Models::Beta::AgentBrowserOriginAccessParam#decision
        module Decision
          extend OpenAI::Internal::Type::Enum

          # Allow the browser to access this origin.
          APPROVE = :approve

          # Deny access to this origin.
          DENY = :deny

          # Dismiss this request without approving access.
          CANCEL = :cancel

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
