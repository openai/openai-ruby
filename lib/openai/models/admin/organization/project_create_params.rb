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

          # @!attribute geography
          #   Create the project with the specified data residency region. Your organization
          #   must have access to Data residency functionality in order to use. See
          #   [data residency controls](https://platform.openai.com/docs/guides/your-data#data-residency-controls)
          #   to review the functionality and limitations of setting this field.
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::ProjectCreateParams::Geography, nil]
          optional :geography, enum: -> { OpenAI::Admin::Organization::ProjectCreateParams::Geography }

          # @!method initialize(name:, geography: nil, request_options: {})
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Admin::Organization::ProjectCreateParams} for more details.
          #
          #   @param name [String] The friendly name of the project, this name appears in reports.
          #
          #   @param geography [Symbol, OpenAI::Models::Admin::Organization::ProjectCreateParams::Geography] Create the project with the specified data residency region. Your organization m
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          # Create the project with the specified data residency region. Your organization
          # must have access to Data residency functionality in order to use. See
          # [data residency controls](https://platform.openai.com/docs/guides/your-data#data-residency-controls)
          # to review the functionality and limitations of setting this field.
          module Geography
            extend OpenAI::Internal::Type::Enum

            US = :US
            EU = :EU
            JP = :JP
            IN = :IN
            KR = :KR
            CA = :CA
            AU = :AU
            SG = :SG

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
