# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        module Projects

          class ServiceTierSettingRetrieveParams < OpenAI::Internal::Type::BaseModel

            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash = T.type_alias do
              T.any(
                OpenAI::Admin::Organization::Projects::ServiceTierSettingRetrieveParams,
                OpenAI::Internal::AnyHash
              )
            end

            # The ID of the project
            sig { returns(String) }
            attr_accessor :project_id

            sig do
              params(

                project_id: String,

                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The ID of the project
              project_id:,

              request_options: {}
            )
            end

            sig do
              override.returns(
                {project_id: String, request_options: OpenAI::RequestOptions}
              )
            end
            def to_hash
            end

          end

        end

      end

    end

  end
end
