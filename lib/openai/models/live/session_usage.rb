# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class SessionUsage < OpenAI::Internal::Type::BaseModel
        # @!attribute seconds
        #   The cumulative Live audio duration in seconds. Do not sum this value across
        #   usage events.
        #
        #   @return [Float]
        required :seconds, Float

        # @!method initialize(seconds:)
        #   Cumulative audio duration for a Live session. Values are totals for the session,
        #   not increments to sum across usage events.
        #
        #   @param seconds [Float]
        #     The cumulative Live audio duration in seconds. Do not sum this value across
        #     usage events.
      end
    end
  end
end
