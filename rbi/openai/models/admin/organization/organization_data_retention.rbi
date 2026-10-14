# typed: strong

module OpenAI
  module Models
    module Admin
      OrganizationDataRetention = Organization::OrganizationDataRetention

      module Organization
        class OrganizationDataRetention < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::OrganizationDataRetention,
                OpenAI::Internal::AnyHash
              )
            end

          # The object type, which is always `organization.data_retention`.
          sig { returns(Symbol) }
          attr_accessor :object

          # The configured organization data retention type.
          sig do
            returns(
              OpenAI::Admin::Organization::OrganizationDataRetention::Type::TaggedSymbol
            )
          end
          attr_accessor :type

          # Represents the organization's data retention control setting.
          sig do
            params(
              type:
                OpenAI::Admin::Organization::OrganizationDataRetention::Type::OrSymbol,
              object: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The configured organization data retention type.
            type:,
            # The object type, which is always `organization.data_retention`.
            object: :"organization.data_retention"
          )
          end

          sig do
            override.returns(
              {
                object: Symbol,
                type:
                  OpenAI::Admin::Organization::OrganizationDataRetention::Type::TaggedSymbol
              }
            )
          end
          def to_hash
          end

          # The configured organization data retention type.
          module Type
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Admin::Organization::OrganizationDataRetention::Type
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            ZERO_DATA_RETENTION =
              T.let(
                :zero_data_retention,
                OpenAI::Admin::Organization::OrganizationDataRetention::Type::TaggedSymbol
              )
            MODIFIED_ABUSE_MONITORING =
              T.let(
                :modified_abuse_monitoring,
                OpenAI::Admin::Organization::OrganizationDataRetention::Type::TaggedSymbol
              )
            ENHANCED_ZERO_DATA_RETENTION =
              T.let(
                :enhanced_zero_data_retention,
                OpenAI::Admin::Organization::OrganizationDataRetention::Type::TaggedSymbol
              )
            ENHANCED_MODIFIED_ABUSE_MONITORING =
              T.let(
                :enhanced_modified_abuse_monitoring,
                OpenAI::Admin::Organization::OrganizationDataRetention::Type::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Admin::Organization::OrganizationDataRetention::Type::TaggedSymbol
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
