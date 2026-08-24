# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Projects#create
        class ProjectCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute name
          #   The friendly name of the project, this name appears in reports.
          #
          #   @return [String]
          required :name, String

          # @!attribute external_key_id
          #   External key ID to associate with the project.
          #
          #   @return [String, nil]
          optional :external_key_id, String, nil?: true

          # @!attribute geography
          #   @deprecated
          #
          #   Create the project with the specified data residency region. Your organization
          #   must have access to Data residency functionality in order to use. See
          #   [data residency controls](https://platform.openai.com/docs/guides/your-data#data-residency-controls)
          #   to review the functionality and limitations of setting this field. Deprecated:
          #   use `residency` instead. Do not provide both `geography` and `residency`.
          #
          #   @return [String, nil]
          optional :geography, String, nil?: true

          # @!attribute residency
          #   Create the project with the specified residency configuration. Your organization
          #   must have access to the requested residency configuration in order to use it.
          #   See
          #   [data residency controls](https://platform.openai.com/docs/guides/your-data#data-residency-controls)
          #   to review the functionality and limitations of setting this field.
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::ProjectCreateParams::Residency, nil]
          optional(
            :residency,
            enum: -> {
              OpenAI::Admin::Organization::ProjectCreateParams::Residency
            },
            nil?: true
          )

          # @!method initialize(name:, external_key_id: nil, geography: nil, residency: nil, request_options: {})
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Admin::Organization::ProjectCreateParams} for more details.
          #
          #   @param name [String] The friendly name of the project, this name appears in reports.
          #
          #   @param external_key_id [String, nil] External key ID to associate with the project.
          #
          #   @param geography [String, nil] Create the project with the specified data residency region. Your organization m
          #
          #   @param residency [Symbol, OpenAI::Models::Admin::Organization::ProjectCreateParams::Residency, nil] Create the project with the specified residency configuration. Your organization
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          # Create the project with the specified residency configuration. Your organization
          # must have access to the requested residency configuration in order to use it.
          # See
          # [data residency controls](https://platform.openai.com/docs/guides/your-data#data-residency-controls)
          # to review the functionality and limitations of setting this field.
          module Residency
            extend OpenAI::Internal::Type::Enum

            GLOBAL = :GLOBAL
            US_STORAGE_PROCESSING = :US_STORAGE_PROCESSING
            EU_STORAGE_PROCESSING = :EU_STORAGE_PROCESSING
            JP_STORAGE = :JP_STORAGE
            KR_STORAGE = :KR_STORAGE
            CA_STORAGE = :CA_STORAGE
            SG_STORAGE = :SG_STORAGE
            IN_STORAGE = :IN_STORAGE
            AU_STORAGE = :AU_STORAGE
            GB_STORAGE = :GB_STORAGE
            AE_STORAGE = :AE_STORAGE
            AE_STORAGE_PROCESSING = :AE_STORAGE_PROCESSING

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
