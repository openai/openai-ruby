# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          class ModelPermissionUpdateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::ModelPermissionUpdateParams,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :project_id

            # The model permissions mode to apply.
            sig do
              returns(
                OpenAI::Admin::Organization::Projects::ModelPermissionUpdateParams::Mode::OrSymbol
              )
            end
            attr_accessor :mode

            # The model IDs included in this permissions policy.
            sig { returns(T::Array[String]) }
            attr_accessor :model_ids

            sig do
              params(
                project_id: String,
                mode:
                  OpenAI::Admin::Organization::Projects::ModelPermissionUpdateParams::Mode::OrSymbol,
                model_ids: T::Array[String],
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              project_id:,
              # The model permissions mode to apply.
              mode:,
              # The model IDs included in this permissions policy.
              model_ids:,
              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  project_id: String,
                  mode:
                    OpenAI::Admin::Organization::Projects::ModelPermissionUpdateParams::Mode::OrSymbol,
                  model_ids: T::Array[String],
                  request_options: OpenAI::RequestOptions
                }
              )
            end
            def to_hash
            end

            # The model permissions mode to apply.
            module Mode
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Admin::Organization::Projects::ModelPermissionUpdateParams::Mode
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              ALLOW_LIST =
                T.let(
                  :allow_list,
                  OpenAI::Admin::Organization::Projects::ModelPermissionUpdateParams::Mode::TaggedSymbol
                )
              DENY_LIST =
                T.let(
                  :deny_list,
                  OpenAI::Admin::Organization::Projects::ModelPermissionUpdateParams::Mode::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Admin::Organization::Projects::ModelPermissionUpdateParams::Mode::TaggedSymbol
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
