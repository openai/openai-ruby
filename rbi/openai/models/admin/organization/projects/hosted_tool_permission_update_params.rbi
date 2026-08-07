# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          class HostedToolPermissionUpdateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :project_id

            # The code interpreter permission update.
            sig do
              returns(
                T.nilable(
                  OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::CodeInterpreter
                )
              )
            end
            attr_reader :code_interpreter

            sig do
              params(
                code_interpreter:
                  T.nilable(
                    OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::CodeInterpreter::OrHash
                  )
              ).void
            end
            attr_writer :code_interpreter

            # The file search permission update.
            sig do
              returns(
                T.nilable(
                  OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::FileSearch
                )
              )
            end
            attr_reader :file_search

            sig do
              params(
                file_search:
                  T.nilable(
                    OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::FileSearch::OrHash
                  )
              ).void
            end
            attr_writer :file_search

            # The image generation permission update.
            sig do
              returns(
                T.nilable(
                  OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::ImageGeneration
                )
              )
            end
            attr_reader :image_generation

            sig do
              params(
                image_generation:
                  T.nilable(
                    OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::ImageGeneration::OrHash
                  )
              ).void
            end
            attr_writer :image_generation

            # The MCP permission update.
            sig do
              returns(
                T.nilable(
                  OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::Mcp
                )
              )
            end
            attr_reader :mcp

            sig do
              params(
                mcp:
                  T.nilable(
                    OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::Mcp::OrHash
                  )
              ).void
            end
            attr_writer :mcp

            # The web search permission update.
            sig do
              returns(
                T.nilable(
                  OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::WebSearch
                )
              )
            end
            attr_reader :web_search

            sig do
              params(
                web_search:
                  T.nilable(
                    OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::WebSearch::OrHash
                  )
              ).void
            end
            attr_writer :web_search

            sig do
              params(
                project_id: String,
                code_interpreter:
                  T.nilable(
                    OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::CodeInterpreter::OrHash
                  ),
                file_search:
                  T.nilable(
                    OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::FileSearch::OrHash
                  ),
                image_generation:
                  T.nilable(
                    OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::ImageGeneration::OrHash
                  ),
                mcp:
                  T.nilable(
                    OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::Mcp::OrHash
                  ),
                web_search:
                  T.nilable(
                    OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::WebSearch::OrHash
                  ),
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(T.attached_class)
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
                  code_interpreter:
                    T.nilable(
                      OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::CodeInterpreter
                    ),
                  file_search:
                    T.nilable(
                      OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::FileSearch
                    ),
                  image_generation:
                    T.nilable(
                      OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::ImageGeneration
                    ),
                  mcp:
                    T.nilable(
                      OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::Mcp
                    ),
                  web_search:
                    T.nilable(
                      OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::WebSearch
                    ),
                  request_options: OpenAI::RequestOptions
                }
              )
            end
            def to_hash
            end

            class CodeInterpreter < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::CodeInterpreter,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Whether to enable the hosted tool for the project.
              sig { returns(T::Boolean) }
              attr_accessor :enabled

              # The code interpreter permission update.
              sig { params(enabled: T::Boolean).returns(T.attached_class) }
              def self.new(
                # Whether to enable the hosted tool for the project.
                enabled:
              )
              end

              sig { override.returns({ enabled: T::Boolean }) }
              def to_hash
              end
            end

            class FileSearch < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::FileSearch,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Whether to enable the hosted tool for the project.
              sig { returns(T::Boolean) }
              attr_accessor :enabled

              # The file search permission update.
              sig { params(enabled: T::Boolean).returns(T.attached_class) }
              def self.new(
                # Whether to enable the hosted tool for the project.
                enabled:
              )
              end

              sig { override.returns({ enabled: T::Boolean }) }
              def to_hash
              end
            end

            class ImageGeneration < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::ImageGeneration,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Whether to enable the hosted tool for the project.
              sig { returns(T::Boolean) }
              attr_accessor :enabled

              # The image generation permission update.
              sig { params(enabled: T::Boolean).returns(T.attached_class) }
              def self.new(
                # Whether to enable the hosted tool for the project.
                enabled:
              )
              end

              sig { override.returns({ enabled: T::Boolean }) }
              def to_hash
              end
            end

            class Mcp < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::Mcp,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Whether to enable the hosted tool for the project.
              sig { returns(T::Boolean) }
              attr_accessor :enabled

              # The MCP permission update.
              sig { params(enabled: T::Boolean).returns(T.attached_class) }
              def self.new(
                # Whether to enable the hosted tool for the project.
                enabled:
              )
              end

              sig { override.returns({ enabled: T::Boolean }) }
              def to_hash
              end
            end

            class WebSearch < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::WebSearch,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Whether to enable the hosted tool for the project.
              sig { returns(T::Boolean) }
              attr_accessor :enabled

              # The web search permission update.
              sig { params(enabled: T::Boolean).returns(T.attached_class) }
              def self.new(
                # Whether to enable the hosted tool for the project.
                enabled:
              )
              end

              sig { override.returns({ enabled: T::Boolean }) }
              def to_hash
              end
            end
          end
        end
      end
    end
  end
end
