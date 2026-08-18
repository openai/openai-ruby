# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          class DataRetentionUpdateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::DataRetentionUpdateParams,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :project_id

            # The desired project data retention type.
            sig do
              returns(
                OpenAI::Admin::Organization::Projects::DataRetentionUpdateParams::RetentionType::OrSymbol
              )
            end
            attr_accessor :retention_type

            sig do
              params(
                project_id: String,
                retention_type:
                  OpenAI::Admin::Organization::Projects::DataRetentionUpdateParams::RetentionType::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              project_id:,
              # The desired project data retention type.
              retention_type:,
              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  project_id: String,
                  retention_type:
                    OpenAI::Admin::Organization::Projects::DataRetentionUpdateParams::RetentionType::OrSymbol,
                  request_options: OpenAI::RequestOptions
                }
              )
            end
            def to_hash
            end

            # The desired project data retention type.
            module RetentionType
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Admin::Organization::Projects::DataRetentionUpdateParams::RetentionType
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              ORGANIZATION_DEFAULT =
                T.let(
                  :organization_default,
                  OpenAI::Admin::Organization::Projects::DataRetentionUpdateParams::RetentionType::TaggedSymbol
                )
              NONE =
                T.let(
                  :none,
                  OpenAI::Admin::Organization::Projects::DataRetentionUpdateParams::RetentionType::TaggedSymbol
                )
              ZERO_DATA_RETENTION =
                T.let(
                  :zero_data_retention,
                  OpenAI::Admin::Organization::Projects::DataRetentionUpdateParams::RetentionType::TaggedSymbol
                )
              MODIFIED_ABUSE_MONITORING =
                T.let(
                  :modified_abuse_monitoring,
                  OpenAI::Admin::Organization::Projects::DataRetentionUpdateParams::RetentionType::TaggedSymbol
                )
              ENHANCED_ZERO_DATA_RETENTION =
                T.let(
                  :enhanced_zero_data_retention,
                  OpenAI::Admin::Organization::Projects::DataRetentionUpdateParams::RetentionType::TaggedSymbol
                )
              ENHANCED_MODIFIED_ABUSE_MONITORING =
                T.let(
                  :enhanced_modified_abuse_monitoring,
                  OpenAI::Admin::Organization::Projects::DataRetentionUpdateParams::RetentionType::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Admin::Organization::Projects::DataRetentionUpdateParams::RetentionType::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end
          end
        end
      end
    end
  end
end
