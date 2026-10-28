# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::ExternalKeys#validate
        class ExternalKeyValidateResponse < OpenAI::Internal::Type::BaseModel
          # @!attribute status
          #
          #   @return [String]
          required :status, String

          # @!method initialize(status:)
          #   @param status [String]
        end
      end
    end
  end
end
