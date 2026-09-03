# typed: strong

module OpenAI
  module Models

    module Responses

      class ResponseSteerPendingEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Responses::ResponseSteerPendingEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # An extensible enum describing why accepted steering input is still queued.
        # Clients should handle unknown values because additional reasons may be
        # introduced. Known values include:
        #
        # - `waiting_for_required_input`: The response is waiting for the tool results or
        #   approval decisions identified by `required_input`.
        sig { returns(OpenAI::Responses::ResponseSteerPendingReason::Variants) }
        attr_accessor :reason

        # Input stubs identifying outstanding client-owned tool results or approval
        # decisions. Each stub contains identifying fields only; the client supplies the
        # result before including it in `response.create`.
        sig {
          returns(
            T::Array[
              T.any(
                OpenAI::Responses::ResponseSteerRequiredInput::FunctionCallOutput,
                OpenAI::Responses::ResponseSteerRequiredInput::CustomToolCallOutput,
                OpenAI::Responses::ResponseSteerRequiredInput::ComputerCallOutput,
                OpenAI::Responses::ResponseSteerRequiredInput::ShellCallOutput,
                OpenAI::Responses::ResponseSteerRequiredInput::ApplyPatchCallOutput,
                OpenAI::Responses::ResponseSteerRequiredInput::ToolSearchOutput,
                OpenAI::Responses::ResponseSteerRequiredInput::McpApprovalResponse
              )
            ]
          )
        }
        attr_accessor :required_input

        # The sequence number for this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The steering submission that remains queued.
        sig { returns(OpenAI::Responses::ResponseSteerPendingEvent::Steer) }
        attr_reader :steer

        sig { params(steer: OpenAI::Responses::ResponseSteerPendingEvent::Steer::OrHash).void }
        attr_writer :steer

        # The event discriminator. Always `response.steer.pending`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The WebSocket lane that emitted this event. This field is present when the
        # target response's `response.create` event supplied a `stream_id`.
        sig { returns(T.nilable(String)) }
        attr_reader :stream_id

        sig { params(stream_id: String).void }
        attr_writer :stream_id

        # Emitted when accepted steering input remains queued after the target response
        # completes. The server still owns the input. Do not resend it. The successor's
        # `response.created` event is the commit point.
        #
        # When `reason` is `waiting_for_required_input`, this event follows
        # `response.completed` while the response waits for the tool results or approval
        # decisions identified by `required_input`. Copy those stubs, fill their result
        # fields using the ordinary `response.create` input schemas, and submit one
        # continuation per parent with the same `previous_response_id` and WebSocket lane.
        # Use saved results without rerunning tools. The queued steering input is
        # prepended in submission order to the continuation's input. That explicit request
        # retains its own settings.
        #
        # This notification is emitted at most once per steering submission. Multiple
        # submissions for the same parent can report the same required inputs; they do not
        # each require a separate continuation.
        sig do
          params(

            reason: T.any(Symbol, String),

            required_input: T::Array[
              T.any(
                OpenAI::Responses::ResponseSteerRequiredInput::FunctionCallOutput::OrHash,
                OpenAI::Responses::ResponseSteerRequiredInput::CustomToolCallOutput::OrHash,
                OpenAI::Responses::ResponseSteerRequiredInput::ComputerCallOutput::OrHash,
                OpenAI::Responses::ResponseSteerRequiredInput::ShellCallOutput::OrHash,
                OpenAI::Responses::ResponseSteerRequiredInput::ApplyPatchCallOutput::OrHash,
                OpenAI::Responses::ResponseSteerRequiredInput::ToolSearchOutput::OrHash,
                OpenAI::Responses::ResponseSteerRequiredInput::McpApprovalResponse::OrHash
              )
            ],

            sequence_number: Integer,

            steer: OpenAI::Responses::ResponseSteerPendingEvent::Steer::OrHash,

            stream_id: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # An extensible enum describing why accepted steering input is still queued.
          # Clients should handle unknown values because additional reasons may be
          # introduced. Known values include:
          #
          # - `waiting_for_required_input`: The response is waiting for the tool results or
          #   approval decisions identified by `required_input`.
          reason:,

          # Input stubs identifying outstanding client-owned tool results or approval
          # decisions. Each stub contains identifying fields only; the client supplies the
          # result before including it in `response.create`.
          required_input:,

          # The sequence number for this event.
          sequence_number:,

          # The steering submission that remains queued.
          steer:,

          # The WebSocket lane that emitted this event. This field is present when the
          # target response's `response.create` event supplied a `stream_id`.
          stream_id: nil,

          # The event discriminator. Always `response.steer.pending`.

          type: :"response.steer.pending"
        )
        end

        sig do
          override.returns(
            {
              reason: OpenAI::Responses::ResponseSteerPendingReason::Variants,
              required_input: T::Array[
                T.any(
                  OpenAI::Responses::ResponseSteerRequiredInput::FunctionCallOutput,
                  OpenAI::Responses::ResponseSteerRequiredInput::CustomToolCallOutput,
                  OpenAI::Responses::ResponseSteerRequiredInput::ComputerCallOutput,
                  OpenAI::Responses::ResponseSteerRequiredInput::ShellCallOutput,
                  OpenAI::Responses::ResponseSteerRequiredInput::ApplyPatchCallOutput,
                  OpenAI::Responses::ResponseSteerRequiredInput::ToolSearchOutput,
                  OpenAI::Responses::ResponseSteerRequiredInput::McpApprovalResponse
                )
              ],
              sequence_number: Integer,
              steer: OpenAI::Responses::ResponseSteerPendingEvent::Steer,
              type: Symbol,
              stream_id: String
            }
          )
        end
        def to_hash
        end

        class Steer < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Responses::ResponseSteerPendingEvent::Steer,
              OpenAI::Internal::AnyHash
            )
          end

          # The ID assigned to the steering submission.
          sig { returns(String) }
          attr_accessor :id

          # The ID of the response being steered.
          sig { returns(String) }
          attr_accessor :previous_response_id

          # The steering submission that remains queued.
          sig do
            params(

              id: String,

              previous_response_id: String
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The ID assigned to the steering submission.
            id:,

            # The ID of the response being steered.

            previous_response_id:
          )
          end

          sig do
            override.returns(
              {id: String, previous_response_id: String}
            )
          end
          def to_hash
          end

        end

      end

    end

  end
end
