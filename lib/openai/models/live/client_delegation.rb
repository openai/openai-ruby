# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class ClientDelegation < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The delegation owner. Always `client` for tasks handled by your application.
        #
        #   @return [Symbol, :client]
        required :type, const: :client

        # @!method initialize(type: :client)
        #   Delegate tasks to your application. The Live session emits delegation events
        #   that your backend handles.
        #
        #   @param type [Symbol, :client]
        #     The delegation owner. Always `client` for tasks handled by your application.
      end
    end
  end
end
