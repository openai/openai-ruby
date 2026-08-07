# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::HostedToolPermissions#update
          class HostedToolPermissionUpdateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute project_id
            #
            #   @return [String]
            required :project_id, String

            # @!attribute code_interpreter
            #   The code interpreter permission update.
            #
            #   @return [OpenAI::Models::Admin::Organization::Projects::HostedToolPermissionUpdateParams::CodeInterpreter, nil]
            optional :code_interpreter,
                     -> {
                       OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::CodeInterpreter
                     },
                     nil?: true

            # @!attribute file_search
            #   The file search permission update.
            #
            #   @return [OpenAI::Models::Admin::Organization::Projects::HostedToolPermissionUpdateParams::FileSearch, nil]
            optional :file_search,
                     -> {
                       OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::FileSearch
                     },
                     nil?: true

            # @!attribute image_generation
            #   The image generation permission update.
            #
            #   @return [OpenAI::Models::Admin::Organization::Projects::HostedToolPermissionUpdateParams::ImageGeneration, nil]
            optional :image_generation,
                     -> {
                       OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::ImageGeneration
                     },
                     nil?: true

            # @!attribute mcp
            #   The MCP permission update.
            #
            #   @return [OpenAI::Models::Admin::Organization::Projects::HostedToolPermissionUpdateParams::Mcp, nil]
            optional :mcp,
                     -> { OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::Mcp },
                     nil?: true

            # @!attribute web_search
            #   The web search permission update.
            #
            #   @return [OpenAI::Models::Admin::Organization::Projects::HostedToolPermissionUpdateParams::WebSearch, nil]
            optional :web_search,
                     -> {
                       OpenAI::Admin::Organization::Projects::HostedToolPermissionUpdateParams::WebSearch
                     },
                     nil?: true

            # @!method initialize(project_id:, code_interpreter: nil, file_search: nil, image_generation: nil, mcp: nil, web_search: nil, request_options: {})
            #   @param project_id [String]
            #
            #   @param code_interpreter [OpenAI::Models::Admin::Organization::Projects::HostedToolPermissionUpdateParams::CodeInterpreter, nil] The code interpreter permission update.
            #
            #   @param file_search [OpenAI::Models::Admin::Organization::Projects::HostedToolPermissionUpdateParams::FileSearch, nil] The file search permission update.
            #
            #   @param image_generation [OpenAI::Models::Admin::Organization::Projects::HostedToolPermissionUpdateParams::ImageGeneration, nil] The image generation permission update.
            #
            #   @param mcp [OpenAI::Models::Admin::Organization::Projects::HostedToolPermissionUpdateParams::Mcp, nil] The MCP permission update.
            #
            #   @param web_search [OpenAI::Models::Admin::Organization::Projects::HostedToolPermissionUpdateParams::WebSearch, nil] The web search permission update.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

            class CodeInterpreter < OpenAI::Internal::Type::BaseModel
              # @!attribute enabled
              #   Whether to enable the hosted tool for the project.
              #
              #   @return [Boolean]
              required :enabled, OpenAI::Internal::Type::Boolean

              # @!method initialize(enabled:)
              #   The code interpreter permission update.
              #
              #   @param enabled [Boolean] Whether to enable the hosted tool for the project.
            end

            class FileSearch < OpenAI::Internal::Type::BaseModel
              # @!attribute enabled
              #   Whether to enable the hosted tool for the project.
              #
              #   @return [Boolean]
              required :enabled, OpenAI::Internal::Type::Boolean

              # @!method initialize(enabled:)
              #   The file search permission update.
              #
              #   @param enabled [Boolean] Whether to enable the hosted tool for the project.
            end

            class ImageGeneration < OpenAI::Internal::Type::BaseModel
              # @!attribute enabled
              #   Whether to enable the hosted tool for the project.
              #
              #   @return [Boolean]
              required :enabled, OpenAI::Internal::Type::Boolean

              # @!method initialize(enabled:)
              #   The image generation permission update.
              #
              #   @param enabled [Boolean] Whether to enable the hosted tool for the project.
            end

            class Mcp < OpenAI::Internal::Type::BaseModel
              # @!attribute enabled
              #   Whether to enable the hosted tool for the project.
              #
              #   @return [Boolean]
              required :enabled, OpenAI::Internal::Type::Boolean

              # @!method initialize(enabled:)
              #   The MCP permission update.
              #
              #   @param enabled [Boolean] Whether to enable the hosted tool for the project.
            end

            class WebSearch < OpenAI::Internal::Type::BaseModel
              # @!attribute enabled
              #   Whether to enable the hosted tool for the project.
              #
              #   @return [Boolean]
              required :enabled, OpenAI::Internal::Type::Boolean

              # @!method initialize(enabled:)
              #   The web search permission update.
              #
              #   @param enabled [Boolean] Whether to enable the hosted tool for the project.
            end
          end
        end
      end
    end
  end
end
