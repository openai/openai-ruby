# typed: strong

module OpenAI
  module Models

    module Live

      class SessionUsage < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::SessionUsage,
            OpenAI::Internal::AnyHash
          )
        end

        # The cumulative billable duration in whole seconds. When present, the active and
        # paused breakdown adds up to this total.
        sig { returns(Float) }
        attr_accessor :seconds

        # The remaining billable seconds attributed to active audio and any unused prepaid
        # duration.
        sig { returns(T.nilable(Integer)) }
        attr_reader :active_seconds

        sig { params(active_seconds: Integer).void }
        attr_writer :active_seconds

        # Billable time attributed to paused inference at the configured rate, rounded
        # down to whole seconds.
        sig { returns(T.nilable(Integer)) }
        attr_reader :paused_seconds

        sig { params(paused_seconds: Integer).void }
        attr_writer :paused_seconds

        # Cumulative billable duration for a Live session. Eligible WebRTC sessions also
        # report the active and paused breakdown. Do not sum values across usage events.
        sig do
          params(

            seconds: Float,

            active_seconds: Integer,

            paused_seconds: Integer
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The cumulative billable duration in whole seconds. When present, the active and
          # paused breakdown adds up to this total.
          seconds:,

          # The remaining billable seconds attributed to active audio and any unused prepaid
          # duration.
          active_seconds: nil,

          # Billable time attributed to paused inference at the configured rate, rounded
          # down to whole seconds.

          paused_seconds: nil
        )
        end

        sig do
          override.returns(
            {seconds: Float, active_seconds: Integer, paused_seconds: Integer}
          )
        end
        def to_hash
        end

      end

    end

  end
end
