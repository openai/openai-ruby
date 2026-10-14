# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class DataRetentionUpdateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::DataRetentionUpdateParams,
                OpenAI::Internal::AnyHash
              )
            end

          # The desired organization data retention type.
          sig do
            returns(
              OpenAI::Admin::Organization::DataRetentionUpdateParams::RetentionType::OrSymbol
            )
          end
          attr_accessor :retention_type

          sig do
            params(
              retention_type:
                OpenAI::Admin::Organization::DataRetentionUpdateParams::RetentionType::OrSymbol,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # The desired organization data retention type.
            retention_type:,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                retention_type:
                  OpenAI::Admin::Organization::DataRetentionUpdateParams::RetentionType::OrSymbol,
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          # The desired organization data retention type.
          module RetentionType
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Admin::Organization::DataRetentionUpdateParams::RetentionType
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            ZERO_DATA_RETENTION =
              T.let(
                :zero_data_retention,
                OpenAI::Admin::Organization::DataRetentionUpdateParams::RetentionType::TaggedSymbol
              )
            MODIFIED_ABUSE_MONITORING =
              T.let(
                :modified_abuse_monitoring,
                OpenAI::Admin::Organization::DataRetentionUpdateParams::RetentionType::TaggedSymbol
              )
            ENHANCED_ZERO_DATA_RETENTION =
              T.let(
                :enhanced_zero_data_retention,
                OpenAI::Admin::Organization::DataRetentionUpdateParams::RetentionType::TaggedSymbol
              )
            ENHANCED_MODIFIED_ABUSE_MONITORING =
              T.let(
                :enhanced_modified_abuse_monitoring,
                OpenAI::Admin::Organization::DataRetentionUpdateParams::RetentionType::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Admin::Organization::DataRetentionUpdateParams::RetentionType::TaggedSymbol
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
