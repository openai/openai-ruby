# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::DataRetention#retrieve
          class ProjectDataRetention < OpenAI::Internal::Type::BaseModel
            # @!attribute object
            #   The object type, which is always `project.data_retention`.
            #
            #   @return [Symbol, :"project.data_retention"]
            required :object, const: :"project.data_retention"

            # @!attribute type
            #   The configured project data retention type.
            #
            #   @return [Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectDataRetention::Type]
            required :type, enum: -> { OpenAI::Admin::Organization::Projects::ProjectDataRetention::Type }

            # @!method initialize(type:, object: :"project.data_retention")
            #   Represents a project's data retention control setting.
            #
            #   @param type [Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectDataRetention::Type] The configured project data retention type.
            #
            #   @param object [Symbol, :"project.data_retention"] The object type, which is always `project.data_retention`.

            # The configured project data retention type.
            #
            # @see OpenAI::Models::Admin::Organization::Projects::ProjectDataRetention#type
            module Type
              extend OpenAI::Internal::Type::Enum

              ORGANIZATION_DEFAULT = :organization_default
              NONE = :none
              ZERO_DATA_RETENTION = :zero_data_retention
              MODIFIED_ABUSE_MONITORING = :modified_abuse_monitoring
              ENHANCED_ZERO_DATA_RETENTION = :enhanced_zero_data_retention
              ENHANCED_MODIFIED_ABUSE_MONITORING = :enhanced_modified_abuse_monitoring

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end
        end

        ProjectDataRetention = Projects::ProjectDataRetention
      end
    end
  end
end
