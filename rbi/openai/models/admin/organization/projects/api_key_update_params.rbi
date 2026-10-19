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
            # Retrying resets the expiry relative to the new request. Omit to keep the current
            # expiration.
            sig { returns(T.nilable(Integer)) }
            attr_reader :expires_in_seconds

            sig { params(expires_in_seconds: Integer).void }
            attr_writer :expires_in_seconds

            # Replace the API key scope restrictions. Omit to leave scopes unchanged. An empty
            # array removes key restrictions (All permissions), subject to the owner's
            # effective permissions. Use ["api.all.read"] for read-only access. Scopes do not
            # change the owner's roles or grant administrative permissions.
            sig { returns(T.nilable(T::Array[String])) }
            attr_reader :scopes

            sig { params(scopes: T::Array[String]).void }
            attr_writer :scopes

            sig do
              params(

                project_id: String,

                api_key_id: String,

                expires_in_seconds: Integer,

                scopes: T::Array[String],

                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(T.attached_class)
            end
            def self.new(

              project_id:,

              api_key_id:,

              # Number of seconds from this request until the API key expires. Must comply with
              # the organization and project expiry policies. Expired keys cannot be updated.
              # Retrying resets the expiry relative to the new request. Omit to keep the current
              # expiration.
              expires_in_seconds: nil,

              # Replace the API key scope restrictions. Omit to leave scopes unchanged. An empty
              # array removes key restrictions (All permissions), subject to the owner's
              # effective permissions. Use ["api.all.read"] for read-only access. Scopes do not
              # change the owner's roles or grant administrative permissions.
              scopes: nil,

              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  project_id: String,
                  api_key_id: String,
                  expires_in_seconds: Integer,
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
