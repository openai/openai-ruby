# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ChatSessionWorkflowParam < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   Identifier for the workflow invoked by the session.
          #
          #   @return [String]
          required :id, String

          # @!attribute state_variables
          #   State variables forwarded to the workflow. Keys may be up to 64 characters,
          #   values must be primitive types, and the map defaults to an empty object.
          #
          #   @return [Hash{Symbol=>String, Boolean, Float}, nil]
          optional :state_variables,
                   -> { OpenAI::Internal::Type::HashOf[union: OpenAI::Beta::ChatKit::ChatSessionWorkflowParam::StateVariable] }

          # @!attribute tracing
          #   Optional tracing overrides for the workflow invocation. When omitted, tracing is
          #   enabled by default.
          #
          #   @return [OpenAI::Models::Beta::ChatKit::ChatSessionWorkflowParam::Tracing, nil]
          optional :tracing, -> { OpenAI::Beta::ChatKit::ChatSessionWorkflowParam::Tracing }

          # @!attribute version
          #   Specific workflow version to run. Defaults to the latest deployed version.
          #
          #   @return [String, nil]
          optional :version, String

          # @!method initialize(id:, state_variables: nil, tracing: nil, version: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::ChatKit::ChatSessionWorkflowParam} for more details.
          #
          #   Workflow reference and overrides applied to the chat session.
          #
          #   @param id [String] Identifier for the workflow invoked by the session.
          #
          #   @param state_variables [Hash{Symbol=>String, Boolean, Float}] State variables forwarded to the workflow. Keys may be up to 64 characters, valu
          #
          #   @param tracing [OpenAI::Models::Beta::ChatKit::ChatSessionWorkflowParam::Tracing] Optional tracing overrides for the workflow invocation. When omitted, tracing is
          #
          #   @param version [String] Specific workflow version to run. Defaults to the latest deployed version.

          module StateVariable
            extend OpenAI::Internal::Type::Union

            variant String

            variant OpenAI::Internal::Type::Boolean

            variant Float

            # @!method self.variants
            #   @return [Array(String, Boolean, Float)]
          end

          # @see OpenAI::Models::Beta::ChatKit::ChatSessionWorkflowParam#tracing
          class Tracing < OpenAI::Internal::Type::BaseModel
            # @!attribute enabled
            #   Whether tracing is enabled during the session. Defaults to true.
            #
            #   @return [Boolean, nil]
            optional :enabled, OpenAI::Internal::Type::Boolean

            # @!method initialize(enabled: nil)
            #   Optional tracing overrides for the workflow invocation. When omitted, tracing is
            #   enabled by default.
            #
            #   @param enabled [Boolean] Whether tracing is enabled during the session. Defaults to true.
          end
        end
      end
    end
  end
end
