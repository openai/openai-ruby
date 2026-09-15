# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseCompactionCompactingEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item_id
        #   The ID of the compaction output item.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the compaction output item.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of the event that was emitted.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event, always `response.compaction.compacting`.
        #
        #   @return [Symbol, :"response.compaction.compacting"]
        required :type, const: :"response.compaction.compacting"

        # @!method initialize(item_id:, output_index:, sequence_number:, type: :"response.compaction.compacting")
        #   Emitted when new summary content is sampled for a compaction trigger. Contains
        #   no summary content.
        #
        #   @param item_id [String]
        #     The ID of the compaction output item.
        #
        #   @param output_index [Integer]
        #     The index of the compaction output item.
        #
        #   @param sequence_number [Integer]
        #     The sequence number of the event that was emitted.
        #
        #   @param type [Symbol, :"response.compaction.compacting"]
        #     The type of the event, always `response.compaction.compacting`.
      end
    end
  end
end
