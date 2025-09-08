# typed: strong

module OpenAI
  module Models
    module Realtime
      class ClientSecretCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ClientSecretCreateParams,
              OpenAI::Internal::AnyHash
            )
          end

        # Configuration for the client secret expiration. Expiration refers to the time
        # after which a client secret will no longer be valid for creating sessions. The
        # session itself may continue after that time once started. A secret can be used
        # to create multiple sessions until it expires.
        sig do
          returns(
            T.nilable(OpenAI::Realtime::ClientSecretCreateParams::ExpiresAfter)
          )
        end
        attr_reader :expires_after

        sig do
          params(
            expires_after:
              OpenAI::Realtime::ClientSecretCreateParams::ExpiresAfter::OrHash
          ).void
        end
        attr_writer :expires_after

        # Session configuration to use for the client secret. Choose either a realtime
        # session or a transcription session.
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Realtime::RealtimeSessionCreateRequest,
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest
              )
            )
          )
        end
        attr_reader :session

        sig do
          params(
            session:
              T.any(
                OpenAI::Realtime::RealtimeSessionCreateRequest::OrHash,
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::OrHash
              )
          ).void
        end
        attr_writer :session

        sig do
          params(
            expires_after:
              OpenAI::Realtime::ClientSecretCreateParams::ExpiresAfter::OrHash,
            session:
              T.any(
                OpenAI::Realtime::RealtimeSessionCreateRequest::OrHash,
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::OrHash
              ),
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # Configuration for the client secret expiration. Expiration refers to the time
          # after which a client secret will no longer be valid for creating sessions. The
          # session itself may continue after that time once started. A secret can be used
          # to create multiple sessions until it expires.
          expires_after: nil,
          # Session configuration to use for the client secret. Choose either a realtime
          # session or a transcription session.
          session: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              expires_after:
                OpenAI::Realtime::ClientSecretCreateParams::ExpiresAfter,
              session:
                T.any(
                  OpenAI::Realtime::RealtimeSessionCreateRequest,
                  OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest
                ),
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        class ExpiresAfter < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::ClientSecretCreateParams::ExpiresAfter,
                OpenAI::Internal::AnyHash
              )
            end

          # The anchor point for the client secret expiration, meaning that `seconds` will
          # be added to the `created_at` time of the client secret to produce an expiration
          # timestamp. Only `created_at` is currently supported.
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::ClientSecretCreateParams::ExpiresAfter::Anchor::OrSymbol
              )
            )
          end
          attr_reader :anchor

          sig do
            params(
              anchor:
                OpenAI::Realtime::ClientSecretCreateParams::ExpiresAfter::Anchor::OrSymbol
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
                OpenAI::Realtime::ClientSecretCreateParams::ExpiresAfter::Anchor::OrSymbol,
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
                  OpenAI::Realtime::ClientSecretCreateParams::ExpiresAfter::Anchor::OrSymbol,
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
                  OpenAI::Realtime::ClientSecretCreateParams::ExpiresAfter::Anchor
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            CREATED_AT =
              T.let(
                :created_at,
                OpenAI::Realtime::ClientSecretCreateParams::ExpiresAfter::Anchor::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::ClientSecretCreateParams::ExpiresAfter::Anchor::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

        # Session configuration to use for the client secret. Choose either a realtime
        # session or a transcription session.
        module Session
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeSessionCreateRequest,
                OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest
              )
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Realtime::ClientSecretCreateParams::Session::Variants
              ]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end
