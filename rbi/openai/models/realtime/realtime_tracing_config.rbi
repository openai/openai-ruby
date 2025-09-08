# typed: strong

module OpenAI
  module Models
    module Realtime
      # Realtime API can write session traces to the
      # [Traces Dashboard](/logs?api=traces). Set to null to disable tracing. Once
      # tracing is enabled for a session, the configuration cannot be modified.
      #
      # `auto` will create a trace for the session with default values for the workflow
      # name, group id, and metadata.
      module RealtimeTracingConfig
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              Symbol,
              OpenAI::Realtime::RealtimeTracingConfig::TracingConfiguration
            )
          end

        class TracingConfiguration < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeTracingConfig::TracingConfiguration,
                OpenAI::Internal::AnyHash
              )
            end

          # The group id to attach to this trace to enable filtering and grouping in the
          # Traces Dashboard.
          sig { returns(T.nilable(String)) }
          attr_reader :group_id

          sig { params(group_id: String).void }
          attr_writer :group_id

          # The arbitrary metadata to attach to this trace to enable filtering in the Traces
          # Dashboard.
          sig { returns(T.nilable(T.anything)) }
          attr_reader :metadata

          sig { params(metadata: T.anything).void }
          attr_writer :metadata

          # The name of the workflow to attach to this trace. This is used to name the trace
          # in the Traces Dashboard.
          sig { returns(T.nilable(String)) }
          attr_reader :workflow_name

          sig { params(workflow_name: String).void }
          attr_writer :workflow_name

          # Granular configuration for tracing.
          sig do
            params(
              group_id: String,
              metadata: T.anything,
              workflow_name: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The group id to attach to this trace to enable filtering and grouping in the
            # Traces Dashboard.
            group_id: nil,
            # The arbitrary metadata to attach to this trace to enable filtering in the Traces
            # Dashboard.
            metadata: nil,
            # The name of the workflow to attach to this trace. This is used to name the trace
            # in the Traces Dashboard.
            workflow_name: nil
          )
          end

          sig do
            override.returns(
              { group_id: String, metadata: T.anything, workflow_name: String }
            )
          end
          def to_hash
          end
        end

        sig do
          override.returns(
            T::Array[OpenAI::Realtime::RealtimeTracingConfig::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
