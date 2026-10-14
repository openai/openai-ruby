# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        ProjectHostedToolPermissions = Projects::ProjectHostedToolPermissions

        module Projects
          class ProjectHostedToolPermissions < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions,
                  OpenAI::Internal::AnyHash
                )
              end

            # Permission state for a single hosted tool on a project.
            sig do
              returns(
                OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::CodeInterpreter
              )
            end
            attr_reader :code_interpreter

            sig do
              params(
                code_interpreter:
                  OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::CodeInterpreter::OrHash
              ).void
            end
            attr_writer :code_interpreter

            # Permission state for a single hosted tool on a project.
            sig do
              returns(
                OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::FileSearch
              )
            end
            attr_reader :file_search

            sig do
              params(
                file_search:
                  OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::FileSearch::OrHash
              ).void
            end
            attr_writer :file_search

            # Permission state for a single hosted tool on a project.
            sig do
              returns(
                OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::ImageGeneration
              )
            end
            attr_reader :image_generation

            sig do
              params(
                image_generation:
                  OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::ImageGeneration::OrHash
              ).void
            end
            attr_writer :image_generation

            # Permission state for a single hosted tool on a project.
            sig do
              returns(
                OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::Mcp
              )
            end
            attr_reader :mcp

            sig do
              params(
                mcp:
                  OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::Mcp::OrHash
              ).void
            end
            attr_writer :mcp

            # Permission state for a single hosted tool on a project.
            sig do
              returns(
                OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::WebSearch
              )
            end
            attr_reader :web_search

            sig do
              params(
                web_search:
                  OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::WebSearch::OrHash
              ).void
            end
            attr_writer :web_search

            # Represents hosted tool permissions for a project.
            sig do
              params(
                code_interpreter:
                  OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::CodeInterpreter::OrHash,
                file_search:
                  OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::FileSearch::OrHash,
                image_generation:
                  OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::ImageGeneration::OrHash,
                mcp:
                  OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::Mcp::OrHash,
                web_search:
                  OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::WebSearch::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              # Permission state for a single hosted tool on a project.
              code_interpreter:,
              # Permission state for a single hosted tool on a project.
              file_search:,
              # Permission state for a single hosted tool on a project.
              image_generation:,
              # Permission state for a single hosted tool on a project.
              mcp:,
              # Permission state for a single hosted tool on a project.
              web_search:
            )
            end

            sig do
              override.returns(
                {
                  code_interpreter:
                    OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::CodeInterpreter,
                  file_search:
                    OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::FileSearch,
                  image_generation:
                    OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::ImageGeneration,
                  mcp:
                    OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::Mcp,
                  web_search:
                    OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::WebSearch
                }
              )
            end
            def to_hash
            end

            class CodeInterpreter < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::CodeInterpreter,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Whether the hosted tool is enabled for the project.
              sig { returns(T::Boolean) }
              attr_accessor :enabled

              # Permission state for a single hosted tool on a project.
              sig { params(enabled: T::Boolean).returns(T.attached_class) }
              def self.new(
                # Whether the hosted tool is enabled for the project.
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
                    OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::FileSearch,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Whether the hosted tool is enabled for the project.
              sig { returns(T::Boolean) }
              attr_accessor :enabled

              # Permission state for a single hosted tool on a project.
              sig { params(enabled: T::Boolean).returns(T.attached_class) }
              def self.new(
                # Whether the hosted tool is enabled for the project.
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
                    OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::ImageGeneration,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Whether the hosted tool is enabled for the project.
              sig { returns(T::Boolean) }
              attr_accessor :enabled

              # Permission state for a single hosted tool on a project.
              sig { params(enabled: T::Boolean).returns(T.attached_class) }
              def self.new(
                # Whether the hosted tool is enabled for the project.
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
                    OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::Mcp,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Whether the hosted tool is enabled for the project.
              sig { returns(T::Boolean) }
              attr_accessor :enabled

              # Permission state for a single hosted tool on a project.
              sig { params(enabled: T::Boolean).returns(T.attached_class) }
              def self.new(
                # Whether the hosted tool is enabled for the project.
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
                    OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::WebSearch,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Whether the hosted tool is enabled for the project.
              sig { returns(T::Boolean) }
              attr_accessor :enabled

              # Permission state for a single hosted tool on a project.
              sig { params(enabled: T::Boolean).returns(T.attached_class) }
              def self.new(
                # Whether the hosted tool is enabled for the project.
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
