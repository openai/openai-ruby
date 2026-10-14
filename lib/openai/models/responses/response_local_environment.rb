# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseLocalEnvironment < OpenAI::Internal::Type::BaseModel
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
  end
end
