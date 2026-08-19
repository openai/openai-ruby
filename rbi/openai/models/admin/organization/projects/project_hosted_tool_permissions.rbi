# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        ProjectHostedToolPermissions = Projects::ProjectHostedToolPermissions

        module Projects

          class ProjectHostedToolPermissions < OpenAI::Internal::Type::BaseModel

            OrHash = T.type_alias do
              T.any(
                OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions,
                OpenAI::Internal::AnyHash
              )
            end

            # Permission state for a single hosted tool on a project.
            sig { returns(OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::CodeInterpreter) }
            attr_reader :code_interpreter

            sig {
              params(
                code_interpreter: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::CodeInterpreter::OrHash
              )
                .void
            }
            attr_writer :code_interpreter

            # Permission state for a single hosted tool on a project.
            sig { returns(OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::FileSearch) }
            attr_reader :file_search

            sig {
              params(
                file_search: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::FileSearch::OrHash
              )
                .void
            }
            attr_writer :file_search

            # Permission state for a single hosted tool on a project.
            sig { returns(OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::ImageGeneration) }
            attr_reader :image_generation

            sig {
              params(
                image_generation: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::ImageGeneration::OrHash
              )
                .void
            }
            attr_writer :image_generation

            # Permission state for a single hosted tool on a project.
            sig { returns(OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::Mcp) }
            attr_reader :mcp

            sig { params(mcp: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::Mcp::OrHash).void }
            attr_writer :mcp

            # Permission state for a single hosted tool on a project.
            sig { returns(OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::WebSearch) }
            attr_reader :web_search

            sig {
              params(web_search: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::WebSearch::OrHash)
                .void
            }
            attr_writer :web_search

            # Represents hosted tool permissions for a project.
            sig do
              params(

                code_interpreter: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::CodeInterpreter::OrHash,

                file_search: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::FileSearch::OrHash,

                image_generation: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::ImageGeneration::OrHash,

                mcp: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::Mcp::OrHash,

                web_search: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::WebSearch::OrHash
              )
                .returns(T.attached_class)
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
                  code_interpreter: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::CodeInterpreter,
                  file_search: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::FileSearch,
                  image_generation: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::ImageGeneration,
                  mcp: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::Mcp,
                  web_search: OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::WebSearch
                }
              )
            end
            def to_hash
            end

            class CodeInterpreter < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::CodeInterpreter,
                  OpenAI::Internal::AnyHash
                )
              end

              # Whether the hosted tool is enabled for the project.
              sig { returns(T::Boolean) }
              attr_accessor :enabled

              # Permission state for a single hosted tool on a project.
              sig do
                params(

                  enabled: T::Boolean
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # Whether the hosted tool is enabled for the project.

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
                  OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::FileSearch,
                  OpenAI::Internal::AnyHash
                )
              end

              # Whether the hosted tool is enabled for the project.
              sig { returns(T::Boolean) }
              attr_accessor :enabled

              # Permission state for a single hosted tool on a project.
              sig do
                params(

                  enabled: T::Boolean
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # Whether the hosted tool is enabled for the project.

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
                  OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::ImageGeneration,
                  OpenAI::Internal::AnyHash
                )
              end

              # Whether the hosted tool is enabled for the project.
              sig { returns(T::Boolean) }
              attr_accessor :enabled

              # Permission state for a single hosted tool on a project.
              sig do
                params(

                  enabled: T::Boolean
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # Whether the hosted tool is enabled for the project.

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
                  OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::Mcp,
                  OpenAI::Internal::AnyHash
                )
              end

              # Whether the hosted tool is enabled for the project.
              sig { returns(T::Boolean) }
              attr_accessor :enabled

              # Permission state for a single hosted tool on a project.
              sig do
                params(

                  enabled: T::Boolean
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # Whether the hosted tool is enabled for the project.

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
                  OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::WebSearch,
                  OpenAI::Internal::AnyHash
                )
              end

              # Whether the hosted tool is enabled for the project.
              sig { returns(T::Boolean) }
              attr_accessor :enabled

              # Permission state for a single hosted tool on a project.
              sig do
                params(

                  enabled: T::Boolean
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # Whether the hosted tool is enabled for the project.

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
