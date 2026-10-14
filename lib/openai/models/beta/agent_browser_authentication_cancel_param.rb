# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentBrowserAuthenticationCancelParam < OpenAI::Internal::Type::BaseModel
        # @!attribute action
        #
        #   @return [Symbol, :cancel]
        required :action, const: :cancel

        # @!attribute type
        #
        #   @return [Symbol, :browser_authentication]
        required :type, const: :browser_authentication

        # @!method initialize(action: :cancel, type: :browser_authentication)
        #   @param action [Symbol, :cancel]
        #   @param type [Symbol, :browser_authentication]
      end
    end
  end
end
