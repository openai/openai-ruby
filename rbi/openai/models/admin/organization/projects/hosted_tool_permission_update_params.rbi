# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        module Projects

          class HostedToolPermissionUpdateParams < OpenAI::Internal::Type::BaseModel

            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash = T.type_alias do
              T.any(
                OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :project_id

            # The code interpreter permission update.
            sig {
              returns(
                T.nilable(OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::CodeInterpreter)
              )
            }
            attr_reader :code_interpreter

            sig {
              params(
                code_interpreter: T.nilable(
                  OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::CodeInterpreter::OrHash
                )
              )
                .void
            }
            attr_writer :code_interpreter

            # The file search permission update.
            sig {
              returns(T.nilable(OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::FileSearch))
            }
            attr_reader :file_search

            sig {
              params(
                file_search: T.nilable(
                  OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::FileSearch::OrHash
                )
              )
                .void
            }
            attr_writer :file_search

            # The image generation permission update.
            sig {
              returns(
                T.nilable(OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::ImageGeneration)
              )
            }
            attr_reader :image_generation

            sig {
              params(
                image_generation: T.nilable(
                  OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::ImageGeneration::OrHash
                )
              )
                .void
            }
            attr_writer :image_generation

            # The MCP permission update.
            sig { returns(T.nilable(OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::Mcp)) }
            attr_reader :mcp

            sig {
              params(
                mcp: T.nilable(OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::Mcp::OrHash)
              )
                .void
            }
            attr_writer :mcp

            # The web search permission update.
            sig {
              returns(T.nilable(OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::WebSearch))
            }
            attr_reader :web_search

            sig {
              params(
                web_search: T.nilable(
                  OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::WebSearch::OrHash
                )
              )
                .void
            }
            attr_writer :web_search

            sig do
              params(

                project_id: String,

                code_interpreter: T.nilable(
                  OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::CodeInterpreter::OrHash
                ),

                file_search: T.nilable(
                  OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::FileSearch::OrHash
                ),

                image_generation: T.nilable(
                  OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::ImageGeneration::OrHash
                ),

                mcp: T.nilable(OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::Mcp::OrHash),

                web_search: T.nilable(
                  OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::WebSearch::OrHash
                ),

                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(T.attached_class)
            end
            def self.new(

              project_id:,

              # The code interpreter permission update.
              code_interpreter: nil,

              # The file search permission update.
              file_search: nil,

              # The image generation permission update.
              image_generation: nil,

              # The MCP permission update.
              mcp: nil,

              # The web search permission update.
              web_search: nil,

              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  project_id: String,
                  code_interpreter: T.nilable(
                    OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::CodeInterpreter
                  ),
                  file_search: T.nilable(
                    OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::FileSearch
                  ),
                  image_generation: T.nilable(
                    OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::ImageGeneration
                  ),
                  mcp: T.nilable(OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::Mcp),
                  web_search: T.nilable(
                    OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::WebSearch
                  ),
                  request_options: OpenAI::RequestOptions
                }
              )
            end
            def to_hash
            end

            class CodeInterpreter < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::CodeInterpreter,
                  OpenAI::Internal::AnyHash
                )
              end

              # Whether to enable the hosted tool for the project.
              sig { returns(T::Boolean) }
              attr_accessor :enabled

              # The code interpreter permission update.
              sig do
                params(

                  enabled: T::Boolean
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # Whether to enable the hosted tool for the project.

                enabled:
              )
              end

              sig do
                override.returns(
                  {enabled: T::Boolean}
                )
              end
              def to_hash
              end

            end

            class FileSearch < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::FileSearch,
                  OpenAI::Internal::AnyHash
                )
              end

              # Whether to enable the hosted tool for the project.
              sig { returns(T::Boolean) }
              attr_accessor :enabled

              # The file search permission update.
              sig do
                params(

                  enabled: T::Boolean
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # Whether to enable the hosted tool for the project.

                enabled:
              )
              end

              sig do
                override.returns(
                  {enabled: T::Boolean}
                )
              end
              def to_hash
              end

            end

            class ImageGeneration < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::ImageGeneration,
                  OpenAI::Internal::AnyHash
                )
              end

              # Whether to enable the hosted tool for the project.
              sig { returns(T::Boolean) }
              attr_accessor :enabled

              # The image generation permission update.
              sig do
                params(

                  enabled: T::Boolean
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # Whether to enable the hosted tool for the project.

                enabled:
              )
              end

              sig do
                override.returns(
                  {enabled: T::Boolean}
                )
              end
              def to_hash
              end

            end

            class Mcp < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::Mcp,
                  OpenAI::Internal::AnyHash
                )
              end

              # Whether to enable the hosted tool for the project.
              sig { returns(T::Boolean) }
              attr_accessor :enabled

              # The MCP permission update.
              sig do
                params(

                  enabled: T::Boolean
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # Whether to enable the hosted tool for the project.

                enabled:
              )
              end

              sig do
                override.returns(
                  {enabled: T::Boolean}
                )
              end
              def to_hash
              end

            end

            class WebSearch < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::WebSearch,
                  OpenAI::Internal::AnyHash
                )
              end

              # Whether to enable the hosted tool for the project.
              sig { returns(T::Boolean) }
              attr_accessor :enabled

              # The web search permission update.
              sig do
                params(

                  enabled: T::Boolean
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # Whether to enable the hosted tool for the project.

                enabled:
              )
              end

              sig do
                override.returns(
                  {enabled: T::Boolean}
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
end
