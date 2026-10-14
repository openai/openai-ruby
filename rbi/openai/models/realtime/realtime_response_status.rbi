# typed: strong

module OpenAI
  module Models

    module Realtime

      class RealtimeResponseStatus < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Realtime::RealtimeResponseStatus,
            OpenAI::Internal::AnyHash
          )
        end

        # A description of the error that caused the response to fail, populated when the
        # `status` is `failed`.
        sig { returns(T.nilable(OpenAI::Realtime::RealtimeResponseStatus::Error)) }
        attr_reader :error

        sig { params(error: OpenAI::Realtime::RealtimeResponseStatus::Error::OrHash).void }
        attr_writer :error

        # The reason the Response did not complete. For a `cancelled` Response, one of
        # `turn_detected` (the server VAD detected a new start of speech) or
        # `client_cancelled` (the client sent a cancel event). For an `incomplete`
        # Response, one of `max_output_tokens` or `content_filter` (the server-side safety
        # filter activated and cut off the response).
        sig { returns(T.nilable(OpenAI::Realtime::RealtimeResponseStatus::Reason::OrSymbol)) }
        attr_reader :reason

        sig { params(reason: OpenAI::Realtime::RealtimeResponseStatus::Reason::OrSymbol).void }
        attr_writer :reason

        # The type of error that caused the response to fail, corresponding with the
        # `status` field (`completed`, `cancelled`, `incomplete`, `failed`).
        sig { returns(T.nilable(OpenAI::Realtime::RealtimeResponseStatus::Type::OrSymbol)) }
        attr_reader :type

        sig { params(type: OpenAI::Realtime::RealtimeResponseStatus::Type::OrSymbol).void }
        attr_writer :type

        # Additional details about the status.
        sig do
          params(

            error: OpenAI::Realtime::RealtimeResponseStatus::Error::OrHash,

            reason: OpenAI::Realtime::RealtimeResponseStatus::Reason::OrSymbol,

            type: OpenAI::Realtime::RealtimeResponseStatus::Type::OrSymbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # A description of the error that caused the response to fail, populated when the
          # `status` is `failed`.
          error: nil,

          # The reason the Response did not complete. For a `cancelled` Response, one of
          # `turn_detected` (the server VAD detected a new start of speech) or
          # `client_cancelled` (the client sent a cancel event). For an `incomplete`
          # Response, one of `max_output_tokens` or `content_filter` (the server-side safety
          # filter activated and cut off the response).
          reason: nil,

          # The type of error that caused the response to fail, corresponding with the
          # `status` field (`completed`, `cancelled`, `incomplete`, `failed`).

          type: nil
        )
        end

        sig do
          override.returns(
            {
              error: OpenAI::Realtime::RealtimeResponseStatus::Error,
              reason: OpenAI::Realtime::RealtimeResponseStatus::Reason::OrSymbol,
              type: OpenAI::Realtime::RealtimeResponseStatus::Type::OrSymbol
            }
          )
        end
        def to_hash
        end

        class Error < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeResponseStatus::Error,
              OpenAI::Internal::AnyHash
            )
          end

          # Error code, if any.
          sig { returns(T.nilable(String)) }
          attr_reader :code

          sig { params(code: String).void }
          attr_writer :code

          # The type of error.
          sig { returns(T.nilable(String)) }
          attr_reader :type

          sig { params(type: String).void }
          attr_writer :type

          # A description of the error that caused the response to fail, populated when the
          # `status` is `failed`.
          sig do
            params(

              code: String,

              type: String
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Error code, if any.
            code: nil,

            # The type of error.

            type: nil
          )
          end

          sig do
            override.returns(
              {code: String, type: String}
            )
          end
          def to_hash
          end

        end

        # The reason the Response did not complete. For a `cancelled` Response, one of
        # `turn_detected` (the server VAD detected a new start of speech) or
        # `client_cancelled` (the client sent a cancel event). For an `incomplete`
        # Response, one of `max_output_tokens` or `content_filter` (the server-side safety
        # filter activated and cut off the response).
        module Reason
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Realtime::RealtimeResponseStatus::Reason) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TURN_DETECTED = T.let(:turn_detected, OpenAI::Realtime::RealtimeResponseStatus::Reason::TaggedSymbol)
          CLIENT_CANCELLED = T.let(:client_cancelled, OpenAI::Realtime::RealtimeResponseStatus::Reason::TaggedSymbol)
          MAX_OUTPUT_TOKENS = T.let(:max_output_tokens, OpenAI::Realtime::RealtimeResponseStatus::Reason::TaggedSymbol)
          CONTENT_FILTER = T.let(:content_filter, OpenAI::Realtime::RealtimeResponseStatus::Reason::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Realtime::RealtimeResponseStatus::Reason::TaggedSymbol]) }
          def self.values
          end
        end

        # The type of error that caused the response to fail, corresponding with the
        # `status` field (`completed`, `cancelled`, `incomplete`, `failed`).
        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Realtime::RealtimeResponseStatus::Type) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          COMPLETED = T.let(:completed, OpenAI::Realtime::RealtimeResponseStatus::Type::TaggedSymbol)
          CANCELLED = T.let(:cancelled, OpenAI::Realtime::RealtimeResponseStatus::Type::TaggedSymbol)
          INCOMPLETE = T.let(:incomplete, OpenAI::Realtime::RealtimeResponseStatus::Type::TaggedSymbol)
          FAILED = T.let(:failed, OpenAI::Realtime::RealtimeResponseStatus::Type::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Realtime::RealtimeResponseStatus::Type::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
