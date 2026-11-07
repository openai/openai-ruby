# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        module Environments

          class FileCreateParams < OpenAI::Internal::Type::BaseModel

            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Environments::FileCreateParams,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :environment_id

            # A file materialized in an OpenAI-hosted execution environment.
            sig {
              returns(
                T.any(
                  OpenAI::Beta::HostedEnvironmentFileParam::FileID,
                  OpenAI::Beta::HostedEnvironmentFileParam::Inline
                )
              )
            }
            attr_accessor :hosted_environment_file_param

            sig do
              params(

                environment_id: String,

                hosted_environment_file_param: T.any(
                  OpenAI::Beta::HostedEnvironmentFileParam::FileID::OrHash,
                  OpenAI::Beta::HostedEnvironmentFileParam::Inline::OrHash
                ),

                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(T.attached_class)
            end
            def self.new(

              environment_id:,

              # A file materialized in an OpenAI-hosted execution environment.
              hosted_environment_file_param:,

              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  environment_id: String,
                  hosted_environment_file_param: T.any(
                    OpenAI::Beta::HostedEnvironmentFileParam::FileID,
                    OpenAI::Beta::HostedEnvironmentFileParam::Inline
                  ),
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
