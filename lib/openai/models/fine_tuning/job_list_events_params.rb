# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      # @see OpenAI::Resources::FineTuning::Jobs#list_events
      class JobListEventsParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute fine_tuning_job_id
        #
        #   @return [String]
        required :fine_tuning_job_id, String

        # @!attribute after
        #   Identifier for the last event from the previous pagination request.
        #
        #   @return [String, nil]
        optional :after, String

        # @!attribute limit
        #   Number of events to retrieve.
        #
        #   @return [Integer, nil]
        optional :limit, Integer

        # @!method initialize(fine_tuning_job_id:, after: nil, limit: nil, request_options: {})
        #   @param fine_tuning_job_id [String]
        #
        #   @param after [String] Identifier for the last event from the previous pagination request.
        #
        #   @param limit [Integer] Number of events to retrieve.
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
