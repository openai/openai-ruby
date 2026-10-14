# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      # @see OpenAI::Resources::FineTuning::Jobs#retrieve
      class JobRetrieveParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute fine_tuning_job_id
        #
        #   @return [String]
        required :fine_tuning_job_id, String

        # @!method initialize(fine_tuning_job_id:, request_options: {})
        #   @param fine_tuning_job_id [String]
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
