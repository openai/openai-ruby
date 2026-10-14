# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::HostedToolPermissions#retrieve
          class ProjectHostedToolPermissions < OpenAI::Internal::Type::BaseModel
            # @!attribute code_interpreter
            #   Permission state for a single hosted tool on a project.
            #
            #   @return [OpenAI::Models::Admin::Organization::Projects::ProjectHostedToolPermissions::CodeInterpreter]
            required :code_interpreter,
                     -> { OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::CodeInterpreter }

            # @!attribute file_search
            #   Permission state for a single hosted tool on a project.
            #
            #   @return [OpenAI::Models::Admin::Organization::Projects::ProjectHostedToolPermissions::FileSearch]
            required :file_search,
                     -> { OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::FileSearch }

            # @!attribute image_generation
            #   Permission state for a single hosted tool on a project.
            #
            #   @return [OpenAI::Models::Admin::Organization::Projects::ProjectHostedToolPermissions::ImageGeneration]
            required :image_generation,
                     -> { OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::ImageGeneration }

            # @!attribute mcp
            #   Permission state for a single hosted tool on a project.
            #
            #   @return [OpenAI::Models::Admin::Organization::Projects::ProjectHostedToolPermissions::Mcp]
            required :mcp, -> { OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::Mcp }

            # @!attribute web_search
            #   Permission state for a single hosted tool on a project.
            #
            #   @return [OpenAI::Models::Admin::Organization::Projects::ProjectHostedToolPermissions::WebSearch]
            required :web_search,
                     -> { OpenAI::Admin::Organization::Projects::ProjectHostedToolPermissions::WebSearch }

            # @!method initialize(code_interpreter:, file_search:, image_generation:, mcp:, web_search:)
            #   Represents hosted tool permissions for a project.
            #
            #   @param code_interpreter [OpenAI::Models::Admin::Organization::Projects::ProjectHostedToolPermissions::CodeInterpreter] Permission state for a single hosted tool on a project.
            #
            #   @param file_search [OpenAI::Models::Admin::Organization::Projects::ProjectHostedToolPermissions::FileSearch] Permission state for a single hosted tool on a project.
            #
            #   @param image_generation [OpenAI::Models::Admin::Organization::Projects::ProjectHostedToolPermissions::ImageGeneration] Permission state for a single hosted tool on a project.
            #
            #   @param mcp [OpenAI::Models::Admin::Organization::Projects::ProjectHostedToolPermissions::Mcp] Permission state for a single hosted tool on a project.
            #
            #   @param web_search [OpenAI::Models::Admin::Organization::Projects::ProjectHostedToolPermissions::WebSearch] Permission state for a single hosted tool on a project.

            # @see OpenAI::Models::Admin::Organization::Projects::ProjectHostedToolPermissions#code_interpreter
            class CodeInterpreter < OpenAI::Internal::Type::BaseModel
              # @!attribute enabled
              #   Whether the hosted tool is enabled for the project.
              #
              #   @return [Boolean]
              required :enabled, OpenAI::Internal::Type::Boolean

              # @!method initialize(enabled:)
              #   Permission state for a single hosted tool on a project.
              #
              #   @param enabled [Boolean] Whether the hosted tool is enabled for the project.
            end

            # @see OpenAI::Models::Admin::Organization::Projects::ProjectHostedToolPermissions#file_search
            class FileSearch < OpenAI::Internal::Type::BaseModel
              # @!attribute enabled
              #   Whether the hosted tool is enabled for the project.
              #
              #   @return [Boolean]
              required :enabled, OpenAI::Internal::Type::Boolean

              # @!method initialize(enabled:)
              #   Permission state for a single hosted tool on a project.
              #
              #   @param enabled [Boolean] Whether the hosted tool is enabled for the project.
            end

            # @see OpenAI::Models::Admin::Organization::Projects::ProjectHostedToolPermissions#image_generation
            class ImageGeneration < OpenAI::Internal::Type::BaseModel
              # @!attribute enabled
              #   Whether the hosted tool is enabled for the project.
              #
              #   @return [Boolean]
              required :enabled, OpenAI::Internal::Type::Boolean

              # @!method initialize(enabled:)
              #   Permission state for a single hosted tool on a project.
              #
              #   @param enabled [Boolean] Whether the hosted tool is enabled for the project.
            end

            # @see OpenAI::Models::Admin::Organization::Projects::ProjectHostedToolPermissions#mcp
            class Mcp < OpenAI::Internal::Type::BaseModel
              # @!attribute enabled
              #   Whether the hosted tool is enabled for the project.
              #
              #   @return [Boolean]
              required :enabled, OpenAI::Internal::Type::Boolean

              # @!method initialize(enabled:)
              #   Permission state for a single hosted tool on a project.
              #
              #   @param enabled [Boolean] Whether the hosted tool is enabled for the project.
            end

            # @see OpenAI::Models::Admin::Organization::Projects::ProjectHostedToolPermissions#web_search
            class WebSearch < OpenAI::Internal::Type::BaseModel
              # @!attribute enabled
              #   Whether the hosted tool is enabled for the project.
              #
              #   @return [Boolean]
              required :enabled, OpenAI::Internal::Type::Boolean

              # @!method initialize(enabled:)
              #   Permission state for a single hosted tool on a project.
              #
              #   @param enabled [Boolean] Whether the hosted tool is enabled for the project.
            end
          end
        end

        ProjectHostedToolPermissions = Projects::ProjectHostedToolPermissions
      end
    end
  end
end
