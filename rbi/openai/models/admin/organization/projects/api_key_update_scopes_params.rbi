# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        module Projects

          class APIKeyUpdateScopesParams < OpenAI::Internal::Type::BaseModel

            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash = T.type_alias do
              T.any(
                OpenAI::Admin::Organization::Projects::APIKeyUpdateScopesParams,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :project_id

            sig { returns(T::Array[String]) }
            attr_accessor :scopes

            sig do
              params(

                project_id: String,

                scopes: T::Array[String],

                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(T.attached_class)
            end
            def self.new(

              project_id:,

              scopes:,

              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  project_id: String,
                  scopes: T::Array[String],
                  request_options: OpenAI::RequestOptions
                }
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
