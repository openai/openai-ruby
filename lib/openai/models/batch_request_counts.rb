# frozen_string_literal: true

module OpenAI
  module Models
    class BatchRequestCounts < OpenAI::Internal::Type::BaseModel
      # @!attribute completed
      #   Number of requests that have been completed successfully.
      #
      #   @return [Integer]
      required :completed, Integer

      # @!attribute failed
      #   Number of requests that have failed.
      #
      #   @return [Integer]
      required :failed, Integer

      # @!attribute total
      #   Total number of requests in the batch.
      #
      #   @return [Integer]
      required :total, Integer

      # @!method initialize(completed:, failed:, total:)
      #   The request counts for different statuses within the batch.
      #
      #   @param completed [Integer]
      #   @param failed [Integer]
      #   @param total [Integer]
    end
  end
end
