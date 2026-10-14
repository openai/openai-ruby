# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        module Projects

          class APIKeyUpdateParams < OpenAI::Internal::Type::BaseModel

            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash = T.type_alias do
              T.any(
                OpenAI::Admin::Organization::Projects::APIKeyUpdateParams,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :project_id

            sig { returns(String) }
            attr_accessor :api_key_id

            # Number of seconds from this request until the API key expires. Must comply with
            # the organization and project expiry policies. Expired keys cannot be updated.
            # Retrying resets the expiry relative to the new request.
            sig { returns(Integer) }
            attr_accessor :expires_in_seconds

            sig do
              params(

                project_id: String,

                api_key_id: String,

                expires_in_seconds: Integer,

                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(T.attached_class)
            end
            def self.new(

              project_id:,

              api_key_id:,

              # Number of seconds from this request until the API key expires. Must comply with
              # the organization and project expiry policies. Expired keys cannot be updated.
              # Retrying resets the expiry relative to the new request.
              expires_in_seconds:,

              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  project_id: String,
                  api_key_id: String,
                  expires_in_seconds: Integer,
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
