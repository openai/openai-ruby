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

        # The cumulative Live audio duration in seconds. Do not sum this value across
        # usage events.
        sig { returns(Float) }
        attr_accessor :seconds

        # Cumulative audio duration for a Live session. Values are totals for the session,
        # not increments to sum across usage events.
        sig do
          params(

            seconds: Float
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The cumulative Live audio duration in seconds. Do not sum this value across
          # usage events.

          seconds:
        )
        end

        sig do
          override.returns(
            {seconds: Float}
          )
        end
        def to_hash
        end

      end

    end

  end
end
