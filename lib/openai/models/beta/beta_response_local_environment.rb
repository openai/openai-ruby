# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
module OpenAI
  module Models
    module Beta
      class BetaResponseLocalEnvironment < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The environment type. Always `local`.
        #
        #   @return [Symbol, :local]
        required :type, const: :local

        # @!method initialize(type: :local)
        #   Represents the use of a local environment to perform shell actions.
        #
        #   @param type [Symbol, :local] The environment type. Always `local`.
      end
    end

    BetaResponseLocalEnvironment = Beta::BetaResponseLocalEnvironment
  end
end
