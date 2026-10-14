# frozen_string_literal: true

module OpenAI
  module Models
    module Safety
      # @see OpenAI::Resources::Safety::Alerts#retrieve
      class SafetyAlert < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute error_type
        #
        #   @return [Symbol, OpenAI::Models::Safety::SafetyAlert::ErrorType]
        required :error_type, enum: -> { OpenAI::Safety::SafetyAlert::ErrorType }

        # @!attribute model
        #
        #   @return [String]
        required :model, String

        # @!attribute object
        #
        #   @return [Symbol, :"safety.alert"]
        required :object, const: :"safety.alert"

        # @!attribute reason
        #   A customer-safe description derived from error_type, or null for zero data
        #   retention requests.
        #
        #   @return [String, nil]
        required :reason, String, nil?: true

        # @!attribute request_id
        #
        #   @return [String]
        required :request_id, String

        # @!attribute request_paused
        #   Whether block registration succeeded for this request. This does not confirm
        #   that response execution stopped.
        #
        #   @return [Boolean]
        required :request_paused, OpenAI::Internal::Type::Boolean

        # @!attribute response_id
        #
        #   @return [String]
        required :response_id, String

        # @!attribute detailed_explanation
        #   A generated explanation, temporarily available for eligible zero data retention
        #   alerts. Omitted when unavailable.
        #
        #   @return [String, nil]
        optional :detailed_explanation, String, nil?: true

        # @!method initialize(id:, created_at:, error_type:, model:, reason:, request_id:, request_paused:, response_id:, detailed_explanation: nil, object: :"safety.alert")
        #   @param id [String]
        #
        #   @param created_at [Integer]
        #
        #   @param error_type [Symbol, OpenAI::Models::Safety::SafetyAlert::ErrorType]
        #
        #   @param model [String]
        #
        #   @param reason [String, nil]
        #     A customer-safe description derived from error_type, or null for zero data
        #     retention requests.
        #
        #   @param request_id [String]
        #
        #   @param request_paused [Boolean]
        #     Whether block registration succeeded for this request. This does not confirm
        #     that response execution stopped.
        #
        #   @param response_id [String]
        #
        #   @param detailed_explanation [String, nil]
        #     A generated explanation, temporarily available for eligible zero data retention
        #     alerts. Omitted when unavailable.
        #
        #   @param object [Symbol, :"safety.alert"]

        # @see OpenAI::Models::Safety::SafetyAlert#error_type
        module ErrorType
          extend OpenAI::Internal::Type::Enum

          POTENTIALLY_UNINTENDED_DATA_TRANSFER = :potentially_unintended_data_transfer
          POTENTIALLY_UNINTENDED_DATA_ACCESS = :potentially_unintended_data_access
          POTENTIALLY_UNINTENDED_DESTRUCTIVE_ACTIVITY = :potentially_unintended_destructive_activity
          OTHER = :other

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end

    SafetyAlert = Safety::SafetyAlert
  end
end
