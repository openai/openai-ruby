# typed: strong

module OpenAI
  module Models

    module Responses

      class ResponseSteerFailedEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Responses::ResponseSteerFailedEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # Information about why the input could not be committed.
        sig { returns(OpenAI::Responses::ResponseSteerFailedEvent::Error) }
        attr_reader :error

        sig { params(error: OpenAI::Responses::ResponseSteerFailedEvent::Error::OrHash).void }
        attr_writer :error

        # The sequence number for this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The steering submission that could not be committed.
        sig { returns(OpenAI::Responses::ResponseSteerFailedEvent::Steer) }
        attr_reader :steer

        sig { params(steer: OpenAI::Responses::ResponseSteerFailedEvent::Steer::OrHash).void }
        attr_writer :steer

        # The event discriminator. Always `response.steer.failed`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The WebSocket lane that emitted this event, when the target response is
        # available and its `response.create` event supplied a `stream_id`.
        sig { returns(T.nilable(String)) }
        attr_reader :stream_id

        sig { params(stream_id: String).void }
        attr_writer :stream_id

        # Emitted when steering input is rejected or cannot be committed to a successor
        # response. Returns the original, uncommitted input so the client can carry it
        # into `response.create` when appropriate. Invalid input must be corrected before
        # retrying.
        #
        # Failures after acceptance include the same steering ID. Failures before an ID is
        # allocated omit `steer.id`. A lost connection or missing acknowledgement leaves
        # the outcome unknown; it is not proof that the input was rejected.
        sig do
          params(

            error: OpenAI::Responses::ResponseSteerFailedEvent::Error::OrHash,

            sequence_number: Integer,

            steer: OpenAI::Responses::ResponseSteerFailedEvent::Steer::OrHash,

            stream_id: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Information about why the input could not be committed.
          error:,

          # The sequence number for this event.
          sequence_number:,

          # The steering submission that could not be committed.
          steer:,

          # The WebSocket lane that emitted this event, when the target response is
          # available and its `response.create` event supplied a `stream_id`.
          stream_id: nil,

          # The event discriminator. Always `response.steer.failed`.

          type: :"response.steer.failed"
        )
        end

        sig do
          override.returns(
            {
              error: OpenAI::Responses::ResponseSteerFailedEvent::Error,
              sequence_number: Integer,
              steer: OpenAI::Responses::ResponseSteerFailedEvent::Steer,
              type: Symbol,
              stream_id: String
            }
          )
        end
        def to_hash
        end

        class Error < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Responses::ResponseSteerFailedEvent::Error,
              OpenAI::Internal::AnyHash
            )
          end

          # A machine-readable steering error code. Clients should handle unknown values
          # because additional codes may be introduced. Known values include:
          #
          # - `response_not_found`: The target response is not available on this connection.
          # - `invalid_input`: The event or input failed validation.
          # - `steering_not_supported`: The model or response execution mode does not
          #   support steering.
          # - `too_many_pending_steers`: Too much steering input is pending for the
          #   response.
          # - `response_already_completed`: The response completed and is no longer
          #   accepting steering input.
          # - `response_not_active`: The response is no longer accepting steering input.
          # - `successor_creation_failed`: The successor response could not be created.
          sig { returns(OpenAI::Responses::ResponseSteerErrorCode::Variants) }
          attr_accessor :code

          # A human-readable description of the error.
          sig { returns(String) }
          attr_accessor :message

          # The error type. Always `invalid_request_error`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Information about why the input could not be committed.
          sig do
            params(

              code: T.any(OpenAI::Responses::ResponseSteerErrorCode::OrSymbol, String),

              message: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # A machine-readable steering error code. Clients should handle unknown values
            # because additional codes may be introduced. Known values include:
            #
            # - `response_not_found`: The target response is not available on this connection.
            # - `invalid_input`: The event or input failed validation.
            # - `steering_not_supported`: The model or response execution mode does not
            #   support steering.
            # - `too_many_pending_steers`: Too much steering input is pending for the
            #   response.
            # - `response_already_completed`: The response completed and is no longer
            #   accepting steering input.
            # - `response_not_active`: The response is no longer accepting steering input.
            # - `successor_creation_failed`: The successor response could not be created.
            code:,

            # A human-readable description of the error.
            message:,

            # The error type. Always `invalid_request_error`.

            type: :invalid_request_error
          )
          end

          sig do
            override.returns(
              {code: OpenAI::Responses::ResponseSteerErrorCode::Variants, message: String, type: Symbol}
            )
          end
          def to_hash
          end

        end

        class Steer < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Responses::ResponseSteerFailedEvent::Steer,
              OpenAI::Internal::AnyHash
            )
          end

          # Input to queue for a continuation of the response. Uses the same string or
          # input-item shape as `response.create.input`, with a non-empty array when
          # supplying input items.
          #
          # Steering accepts only messages with the `user` role. Each message may contain
          # only `type`, `role`, and `content`, with `content` as a string or an array of
          # `input_text`, `input_image`, and `input_file` parts. The optional `type` must be
          # `message`. Other roles, tool outputs, and item types are not supported for
          # steering.
          sig { returns(OpenAI::Responses::ResponseSteerInput::Variants) }
          attr_accessor :input

          # The ID of the response that was targeted for steering.
          sig { returns(String) }
          attr_accessor :previous_response_id

          # The ID assigned to the steering submission, if one was allocated.
          sig { returns(T.nilable(String)) }
          attr_reader :id

          sig { params(id: String).void }
          attr_writer :id

          # The steering submission that could not be committed.
          sig do
            params(

              input: T.any(
                String,
                T::Array[OpenAI::Responses::ResponseSteerInput::ResponseSteerInputItemList::Variants]
              ),

              previous_response_id: String,

              id: String
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Input to queue for a continuation of the response. Uses the same string or
            # input-item shape as `response.create.input`, with a non-empty array when
            # supplying input items.
            #
            # Steering accepts only messages with the `user` role. Each message may contain
            # only `type`, `role`, and `content`, with `content` as a string or an array of
            # `input_text`, `input_image`, and `input_file` parts. The optional `type` must be
            # `message`. Other roles, tool outputs, and item types are not supported for
            # steering.
            input:,

            # The ID of the response that was targeted for steering.
            previous_response_id:,

            # The ID assigned to the steering submission, if one was allocated.

            id: nil
          )
          end

          sig do
            override.returns(
              {input: OpenAI::Responses::ResponseSteerInput::Variants, previous_response_id: String, id: String}
            )
          end
          def to_hash
          end

        end

      end

    end

  end
end
