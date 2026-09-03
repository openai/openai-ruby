# typed: strong

module OpenAI
  module Models

    BetaResponseSteerEvent = Beta::BetaResponseSteerEvent

    module Beta

      class BetaResponseSteerEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::BetaResponseSteerEvent,
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
        sig {
          returns(T.any(String, T::Array[OpenAI::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::Variants]))
        }
        attr_accessor :input

        # The ID of the response to steer on this WebSocket connection.
        sig { returns(String) }
        attr_accessor :previous_response_id

        # The event discriminator. Always `response.steer`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Queues user input to steer a response on this WebSocket connection. Input can
        # contain text, images, and files. Steering is supported only for single-agent
        # responses on models and execution modes that support steering. Responses bound
        # to a conversation or using automatic compaction do not support steering.
        #
        # A `response.steer.accepted` event acknowledges that the server owns the queued
        # input, not that it has been applied. The successor's `response.created` event is
        # the commit point. Input that cannot be committed is returned in
        # `response.steer.failed`.
        #
        # Steering may cause the active response to finish at a safe output boundary with
        # `response.incomplete` and `incomplete_details.reason` set to `steered`, followed
        # automatically by a successor `response.created`. Normal completion can also be
        # followed by an automatic successor. Automatic successors inherit the previous
        # response's settings and continue from it with the queued input.
        #
        # If the response stops for client-owned tool output or approval, accepted
        # steering input remains queued and `response.steer.pending` is emitted after
        # `response.completed`. Fill the `required_input` stubs from that event with saved
        # tool results or approval decisions, and send one explicit `response.create` per
        # parent with the same `previous_response_id` and WebSocket lane. Do not rerun
        # tools or resend accepted steering input. The queued input is prepended in
        # submission order to that request's input, and the explicit request retains its
        # own settings.
        #
        # This event accepts only `type`, `previous_response_id`, and `input`. Do not send
        # `stream_id`; the target response determines the WebSocket lane.
        sig do
          params(

            input: T.any(String, T::Array[OpenAI::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::Variants]),

            previous_response_id: String,

            type: Symbol
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

          # The ID of the response to steer on this WebSocket connection.
          previous_response_id:,

          # The event discriminator. Always `response.steer`.

          type: :"response.steer"
        )
        end

        sig do
          override.returns(
            {
              input: T.any(String, T::Array[OpenAI::Beta::BetaResponseSteerInput::ResponseSteerInputItemList::Variants]),
              previous_response_id: String,
              type: Symbol
            }
          )
        end
        def to_hash
        end

      end

    end

  end
end
