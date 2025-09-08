# typed: strong

module OpenAI
  module Models
    RealtimeSessionClientSecret = Realtime::RealtimeSessionClientSecret

    module Realtime
      class RealtimeSessionClientSecret < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeSessionClientSecret,
              OpenAI::Internal::AnyHash
            )
          end

        # Timestamp for when the token expires. Currently, all tokens expire after one
        # minute.
        sig { returns(Integer) }
        attr_accessor :expires_at

        # Ephemeral key usable in client environments to authenticate connections to the
        # Realtime API. Use this in client-side environments rather than a standard API
        # token, which should only be used server-side.
        sig { returns(String) }
        attr_accessor :value

        # Ephemeral key returned by the API.
        sig do
          params(expires_at: Integer, value: String).returns(T.attached_class)
        end
        def self.new(
          # Timestamp for when the token expires. Currently, all tokens expire after one
          # minute.
          expires_at:,
          # Ephemeral key usable in client environments to authenticate connections to the
          # Realtime API. Use this in client-side environments rather than a standard API
          # token, which should only be used server-side.
          value:
        )
        end

        sig { override.returns({ expires_at: Integer, value: String }) }
        def to_hash
        end
      end
    end
  end
end
