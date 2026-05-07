# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeTranslationClientSecretCreateRequest < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeTranslationClientSecretCreateRequest,
              OpenAI::Internal::AnyHash
            )
          end

        # Realtime translation session configuration. Translation sessions stream source
        # audio in and translated audio plus transcript deltas out continuously.
        sig do
          returns(OpenAI::Realtime::RealtimeTranslationSessionCreateRequest)
        end
        attr_reader :session

        sig do
          params(
            session:
              OpenAI::Realtime::RealtimeTranslationSessionCreateRequest::OrHash
          ).void
        end
        attr_writer :session

        # Configuration for the client secret expiration. Expiration refers to the time
        # after which a client secret will no longer be valid for creating sessions. The
        # session itself may continue after that time once started. A secret can be used
        # to create multiple sessions until it expires.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter
            )
          )
        end
        attr_reader :expires_after

        sig do
          params(
            expires_after:
              OpenAI::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter::OrHash
          ).void
        end
        attr_writer :expires_after

        # Create a translation session and client secret for the Realtime API.
        sig do
          params(
            session:
              OpenAI::Realtime::RealtimeTranslationSessionCreateRequest::OrHash,
            expires_after:
              OpenAI::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # Realtime translation session configuration. Translation sessions stream source
          # audio in and translated audio plus transcript deltas out continuously.
          session:,
          # Configuration for the client secret expiration. Expiration refers to the time
          # after which a client secret will no longer be valid for creating sessions. The
          # session itself may continue after that time once started. A secret can be used
          # to create multiple sessions until it expires.
          expires_after: nil
        )
        end

        sig do
          override.returns(
            {
              session:
                OpenAI::Realtime::RealtimeTranslationSessionCreateRequest,
              expires_after:
                OpenAI::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter
            }
          )
        end
        def to_hash
        end

        class ExpiresAfter < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter,
                OpenAI::Internal::AnyHash
              )
            end

          # The anchor point for the client secret expiration, meaning that `seconds` will
          # be added to the `created_at` time of the client secret to produce an expiration
          # timestamp. Only `created_at` is currently supported.
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter::Anchor::OrSymbol
              )
            )
          end
          attr_reader :anchor

          sig do
            params(
              anchor:
                OpenAI::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter::Anchor::OrSymbol
            ).void
          end
          attr_writer :anchor

          # The number of seconds from the anchor point to the expiration. Select a value
          # between `10` and `7200` (2 hours). This default to 600 seconds (10 minutes) if
          # not specified.
          sig { returns(T.nilable(Integer)) }
          attr_reader :seconds

          sig { params(seconds: Integer).void }
          attr_writer :seconds

          # Configuration for the client secret expiration. Expiration refers to the time
          # after which a client secret will no longer be valid for creating sessions. The
          # session itself may continue after that time once started. A secret can be used
          # to create multiple sessions until it expires.
          sig do
            params(
              anchor:
                OpenAI::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter::Anchor::OrSymbol,
              seconds: Integer
            ).returns(T.attached_class)
          end
          def self.new(
            # The anchor point for the client secret expiration, meaning that `seconds` will
            # be added to the `created_at` time of the client secret to produce an expiration
            # timestamp. Only `created_at` is currently supported.
            anchor: nil,
            # The number of seconds from the anchor point to the expiration. Select a value
            # between `10` and `7200` (2 hours). This default to 600 seconds (10 minutes) if
            # not specified.
            seconds: nil
          )
          end

          sig do
            override.returns(
              {
                anchor:
                  OpenAI::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter::Anchor::OrSymbol,
                seconds: Integer
              }
            )
          end
          def to_hash
          end

          # The anchor point for the client secret expiration, meaning that `seconds` will
          # be added to the `created_at` time of the client secret to produce an expiration
          # timestamp. Only `created_at` is currently supported.
          module Anchor
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter::Anchor
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            CREATED_AT =
              T.let(
                :created_at,
                OpenAI::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter::Anchor::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::RealtimeTranslationClientSecretCreateRequest::ExpiresAfter::Anchor::TaggedSymbol
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
