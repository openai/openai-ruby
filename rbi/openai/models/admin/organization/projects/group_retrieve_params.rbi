# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          class GroupRetrieveParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::GroupRetrieveParams,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :project_id

            sig { returns(String) }
            attr_accessor :group_id

            # The type of group to retrieve.
            sig do
              returns(
                T.nilable(
                  OpenAI::Admin::Organization::Projects::GroupRetrieveParams::GroupType::OrSymbol
                )
              )
            end
            attr_reader :group_type

            sig do
              params(
                group_type:
                  OpenAI::Admin::Organization::Projects::GroupRetrieveParams::GroupType::OrSymbol
              ).void
            end
            attr_writer :group_type

            sig do
              params(
                project_id: String,
                group_id: String,
                group_type:
                  OpenAI::Admin::Organization::Projects::GroupRetrieveParams::GroupType::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              project_id:,
              group_id:,
              # The type of group to retrieve.
              group_type: nil,
              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  project_id: String,
                  group_id: String,
                  group_type:
                    OpenAI::Admin::Organization::Projects::GroupRetrieveParams::GroupType::OrSymbol,
                  request_options: OpenAI::RequestOptions
                }
              )
            end
            def to_hash
            end

            # The type of group to retrieve.
            module GroupType
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Admin::Organization::Projects::GroupRetrieveParams::GroupType
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              GROUP =
                T.let(
                  :group,
                  OpenAI::Admin::Organization::Projects::GroupRetrieveParams::GroupType::TaggedSymbol
                )
              TENANT_GROUP =
                T.let(
                  :tenant_group,
                  OpenAI::Admin::Organization::Projects::GroupRetrieveParams::GroupType::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Admin::Organization::Projects::GroupRetrieveParams::GroupType::TaggedSymbol
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
