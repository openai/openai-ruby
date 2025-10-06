# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class ChatKitWorkflow < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   Identifier of the workflow backing the session.
        #
        #   @return [String]
        required :id, String

        # @!attribute state_variables
        #   State variable key-value pairs applied when invoking the workflow. Defaults to
        #   null when no overrides were provided.
        #
        #   @return [Hash{Symbol=>String, Boolean, Float}, nil]
        required :state_variables,
                 -> { OpenAI::Internal::Type::HashOf[union: OpenAI::Beta::ChatKitWorkflow::StateVariable] },
                 nil?: true

        # @!attribute tracing
        #   Tracing settings applied to the workflow.
        #
        #   @return [OpenAI::Models::Beta::ChatKitWorkflow::Tracing]
        required :tracing, -> { OpenAI::Beta::ChatKitWorkflow::Tracing }

        # @!attribute version
        #   Specific workflow version used for the session. Defaults to null when using the
        #   latest deployment.
        #
        #   @return [String, nil]
        required :version, String, nil?: true

        # @!method initialize(id:, state_variables:, tracing:, version:)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::ChatKitWorkflow} for more details.
        #
        #   Workflow metadata and state returned for the session.
        #
        #   @param id [String] Identifier of the workflow backing the session.
        #
        #   @param state_variables [Hash{Symbol=>String, Boolean, Float}, nil] State variable key-value pairs applied when invoking the workflow. Defaults to n
        #
        #   @param tracing [OpenAI::Models::Beta::ChatKitWorkflow::Tracing] Tracing settings applied to the workflow.
        #
        #   @param version [String, nil] Specific workflow version used for the session. Defaults to null when using the

        module StateVariable
          extend OpenAI::Internal::Type::Union

          variant String

          variant OpenAI::Internal::Type::Boolean

          variant Float

          # @!method self.variants
          #   @return [Array(String, Boolean, Float)]
        end

        # @see OpenAI::Models::Beta::ChatKitWorkflow#tracing
        class Tracing < OpenAI::Internal::Type::BaseModel
          # @!attribute enabled
          #   Indicates whether tracing is enabled.
          #
          #   @return [Boolean]
          required :enabled, OpenAI::Internal::Type::Boolean

          # @!method initialize(enabled:)
          #   Tracing settings applied to the workflow.
          #
          #   @param enabled [Boolean] Indicates whether tracing is enabled.
        end
      end
    end
  end
end
