# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      # @see OpenAI::Resources::FineTuning::Jobs#retrieve
      class JobRetrieveParams < OpenAI::BaseModel
        # @!parse
        #   extend OpenAI::Type::RequestParameters::Converter
        include OpenAI::RequestParameters

        # @!parse
        #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        #   #
        #   def initialize(request_options: {}, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
