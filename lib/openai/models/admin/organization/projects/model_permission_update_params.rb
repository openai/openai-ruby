# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::ModelPermissions#update
          class ModelPermissionUpdateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute project_id
            #
            #   @return [String]
            required :project_id, String

            # @!attribute mode
            #   The model permissions mode to apply.
            #
            #   @return [Symbol, OpenAI::Models::Admin::Organization::Projects::ModelPermissionUpdateParams::Mode]
            required :mode, enum: -> { OpenAI::Admin::Organization::Projects::ModelPermissionUpdateParams::Mode }

            # @!attribute model_ids
            #   The model IDs included in this permissions policy.
            #
            #   @return [Array<String>]
            required :model_ids, OpenAI::Internal::Type::ArrayOf[String]

            # @!method initialize(project_id:, mode:, model_ids:, request_options: {})
            #   @param project_id [String]
            #
            #   @param mode [Symbol, OpenAI::Models::Admin::Organization::Projects::ModelPermissionUpdateParams::Mode] The model permissions mode to apply.
            #
            #   @param model_ids [Array<String>] The model IDs included in this permissions policy.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

            # The model permissions mode to apply.
            module Mode
              extend OpenAI::Internal::Type::Enum

              ALLOW_LIST = :allow_list
              DENY_LIST = :deny_list

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end
        end
      end
    end
  end
end
