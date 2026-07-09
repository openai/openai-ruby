# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # @see OpenAI::Resources::Beta::Responses#delete
      class ResponseDeleteParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute response_id
        #
        #   @return [String]
        required :response_id, String

        # @!attribute betas
        #
        #   @return [Array<Symbol, OpenAI::Models::Beta::ResponseDeleteParams::Beta>, nil]
        optional :betas, -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Beta::ResponseDeleteParams::Beta] }

        # @!method initialize(response_id:, betas: nil, request_options: {})
        #   @param response_id [String]
        #   @param betas [Array<Symbol, OpenAI::Models::Beta::ResponseDeleteParams::Beta>]
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        module Beta
          extend OpenAI::Internal::Type::Enum

          RESPONSES_MULTI_AGENT_V1 = :"responses_multi_agent=v1"

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
