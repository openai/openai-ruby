# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Automations
          # @see OpenAI::Resources::Beta::Agents::Automations::Invocations#create
          class InvocationCreateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute automation_id
            #
            #   @return [String]
            required :automation_id, String

            # @!method initialize(automation_id:, request_options: {})
            #   @param automation_id [String]
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
