# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeClientSecretConfig < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeClientSecretConfig,
              OpenAI::Internal::AnyHash
            )
          end

        # Configuration for the ephemeral token expiration.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeClientSecretConfig::ExpiresAfter
            )
          )
        end
        attr_reader :expires_after

        sig do
          params(
            expires_after:
              OpenAI::Realtime::RealtimeClientSecretConfig::ExpiresAfter::OrHash
          ).void
        end
        attr_writer :expires_after

        # Configuration options for the generated client secret.
        sig do
          params(
            expires_after:
              OpenAI::Realtime::RealtimeClientSecretConfig::ExpiresAfter::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # Configuration for the ephemeral token expiration.
          expires_after: nil
        )
        end

        sig do
          override.returns(
            {
              expires_after:
                OpenAI::Realtime::RealtimeClientSecretConfig::ExpiresAfter
            }
          )
        end
        def to_hash
        end

        class ExpiresAfter < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeClientSecretConfig::ExpiresAfter,
                OpenAI::Internal::AnyHash
              )
            end

          # The anchor point for the ephemeral token expiration. Only `created_at` is
          # currently supported.
          sig do
            returns(
              OpenAI::Realtime::RealtimeClientSecretConfig::ExpiresAfter::Anchor::OrSymbol
            )
          end
          attr_accessor :anchor

          # The number of seconds from the anchor point to the expiration. Select a value
          # between `10` and `7200`.
          sig { returns(T.nilable(Integer)) }
          attr_reader :seconds

          sig { params(seconds: Integer).void }
          attr_writer :seconds

          # Configuration for the ephemeral token expiration.
          sig do
            params(
              anchor:
                OpenAI::Realtime::RealtimeClientSecretConfig::ExpiresAfter::Anchor::OrSymbol,
              seconds: Integer
            ).returns(T.attached_class)
          end
          def self.new(
            # The anchor point for the ephemeral token expiration. Only `created_at` is
            # currently supported.
            anchor:,
            # The number of seconds from the anchor point to the expiration. Select a value
            # between `10` and `7200`.
            seconds: nil
          )
          end

          sig do
            override.returns(
              {
                anchor:
                  OpenAI::Realtime::RealtimeClientSecretConfig::ExpiresAfter::Anchor::OrSymbol,
                seconds: Integer
              }
            )
          end
          def to_hash
          end

          # The anchor point for the ephemeral token expiration. Only `created_at` is
          # currently supported.
          module Anchor
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Realtime::RealtimeClientSecretConfig::ExpiresAfter::Anchor
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            CREATED_AT =
              T.let(
                :created_at,
                OpenAI::Realtime::RealtimeClientSecretConfig::ExpiresAfter::Anchor::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::RealtimeClientSecretConfig::ExpiresAfter::Anchor::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end
      end
    end
  end
end
