# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      # Configuration options for tracing. Set to null to disable tracing. Once tracing
      # is enabled for a session, the configuration cannot be modified.
      #
      # `auto` will create a trace for the session with default values for the workflow
      # name, group id, and metadata.
      module RealtimeTracingConfig
        extend OpenAI::Internal::Type::Union

        # Default tracing mode for the session.
        variant const: :auto

        # Granular configuration for tracing.
        variant -> { OpenAI::Realtime::RealtimeTracingConfig::TracingConfiguration }

        class TracingConfiguration < OpenAI::Internal::Type::BaseModel
          # @!attribute group_id
          #   The group id to attach to this trace to enable filtering and grouping in the
          #   traces dashboard.
          #
          #   @return [String, nil]
          optional :group_id, String

          # @!attribute metadata
          #   The arbitrary metadata to attach to this trace to enable filtering in the traces
          #   dashboard.
          #
          #   @return [Object, nil]
          optional :metadata, OpenAI::Internal::Type::Unknown

          # @!attribute workflow_name
          #   The name of the workflow to attach to this trace. This is used to name the trace
          #   in the traces dashboard.
          #
          #   @return [String, nil]
          optional :workflow_name, String

          # @!method initialize(group_id: nil, metadata: nil, workflow_name: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::RealtimeTracingConfig::TracingConfiguration} for more
          #   details.
          #
          #   Granular configuration for tracing.
          #
          #   @param group_id [String] The group id to attach to this trace to enable filtering and
          #
          #   @param metadata [Object] The arbitrary metadata to attach to this trace to enable
          #
          #   @param workflow_name [String] The name of the workflow to attach to this trace. This is used to
        end

        # @!method self.variants
        #   @return [Array(Symbol, :auto, OpenAI::Models::Realtime::RealtimeTracingConfig::TracingConfiguration)]
      end
    end
  end
end
