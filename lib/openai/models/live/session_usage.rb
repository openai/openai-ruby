# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class SessionUsage < OpenAI::Internal::Type::BaseModel
        # @!attribute seconds
        #   The cumulative billable duration in whole seconds. When present, the active and
        #   paused breakdown adds up to this total.
        #
        #   @return [Float]
        required :seconds, Float

        # @!attribute active_seconds
        #   The remaining billable seconds attributed to active audio and any unused prepaid
        #   duration.
        #
        #   @return [Integer, nil]
        optional :active_seconds, Integer

        # @!attribute paused_seconds
        #   Billable time attributed to paused inference at the configured rate, rounded
        #   down to whole seconds.
        #
        #   @return [Integer, nil]
        optional :paused_seconds, Integer

        # @!method initialize(seconds:, active_seconds: nil, paused_seconds: nil)
        #   Cumulative billable duration for a Live session. Eligible WebRTC sessions also
        #   report the active and paused breakdown. Do not sum values across usage events.
        #
        #   @param seconds [Float]
        #     The cumulative billable duration in whole seconds. When present, the active and
        #     paused breakdown adds up to this total.
        #
        #   @param active_seconds [Integer]
        #     The remaining billable seconds attributed to active audio and any unused prepaid
        #     duration.
        #
        #   @param paused_seconds [Integer]
        #     Billable time attributed to paused inference at the configured rate, rounded
        #     down to whole seconds.
      end
    end
  end
end
