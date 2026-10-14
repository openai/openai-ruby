# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        ProjectDataRetention = Projects::ProjectDataRetention

        module Projects
          class ProjectDataRetention < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::ProjectDataRetention,
                  OpenAI::Internal::AnyHash
                )
              end

            # The object type, which is always `project.data_retention`.
            sig { returns(Symbol) }
            attr_accessor :object

            # The configured project data retention type.
            sig do
              returns(
                OpenAI::Admin::Organization::Projects::ProjectDataRetention::Type::TaggedSymbol
              )
            end
            attr_accessor :type

            # Represents a project's data retention control setting.
            sig do
              params(
                type:
                  OpenAI::Admin::Organization::Projects::ProjectDataRetention::Type::OrSymbol,
                object: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The configured project data retention type.
              type:,
              # The object type, which is always `project.data_retention`.
              object: :"project.data_retention"
            )
            end

            sig do
              override.returns(
                {
                  object: Symbol,
                  type:
                    OpenAI::Admin::Organization::Projects::ProjectDataRetention::Type::TaggedSymbol
                }
              )
            end
            def to_hash
            end

            # The configured project data retention type.
            module Type
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Admin::Organization::Projects::ProjectDataRetention::Type
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              ORGANIZATION_DEFAULT =
                T.let(
                  :organization_default,
                  OpenAI::Admin::Organization::Projects::ProjectDataRetention::Type::TaggedSymbol
                )
              NONE =
                T.let(
                  :none,
                  OpenAI::Admin::Organization::Projects::ProjectDataRetention::Type::TaggedSymbol
                )
              ZERO_DATA_RETENTION =
                T.let(
                  :zero_data_retention,
                  OpenAI::Admin::Organization::Projects::ProjectDataRetention::Type::TaggedSymbol
                )
              MODIFIED_ABUSE_MONITORING =
                T.let(
                  :modified_abuse_monitoring,
                  OpenAI::Admin::Organization::Projects::ProjectDataRetention::Type::TaggedSymbol
                )
              ENHANCED_ZERO_DATA_RETENTION =
                T.let(
                  :enhanced_zero_data_retention,
                  OpenAI::Admin::Organization::Projects::ProjectDataRetention::Type::TaggedSymbol
                )
              ENHANCED_MODIFIED_ABUSE_MONITORING =
                T.let(
                  :enhanced_modified_abuse_monitoring,
                  OpenAI::Admin::Organization::Projects::ProjectDataRetention::Type::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Admin::Organization::Projects::ProjectDataRetention::Type::TaggedSymbol
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
