# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::AdminAPIKeys#create
        class AdminAPIKeyCreateResponse < OpenAI::Models::Admin::Organization::AdminAPIKey
          # @!attribute value
          #   The value of the API key. Only shown on create.
          #
          #   @return [String]
          required :value, String

          # @!method initialize(value:)
          #   Represents an individual Admin API key in an org.
          #
          #   @param value [String] The value of the API key. Only shown on create.
        end
      end
    end
  end
end
