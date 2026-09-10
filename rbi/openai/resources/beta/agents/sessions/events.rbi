# typed: strong

module OpenAI
  module Resources

    class Beta

      class Agents

        class Sessions

          class Events

            # Submits message, cancellation, or tool-result events to a managed agent session.
            # See
            # [session events](https://developers.openai.com/api/docs/guides/agents-api/sessions/events).
            sig {
              params(
                session_id: String,
                events: T::Array[
                  T.any(
                    OpenAI::Beta::AgentSessionInputParam::AgentSessionInputMessage::OrHash,
                    OpenAI::Beta::AgentSessionInputParam::AgentSessionInputCancel::OrHash,
                    OpenAI::Beta::AgentSessionInputParam::AgentSessionInputToolResult::OrHash
                  )
                ],
                idempotency_key: String,
                request_options: OpenAI::RequestOptions::OrHash
              )
                .void
            }
            def create(
              # Path param: The ID of the session.
              session_id,
              # Body param: The input events to submit to the session.
              events:,
              # Header param: An optional client-generated key that makes retries of submitted
              # messages idempotent.
              idempotency_key: nil,
              request_options: {}
            )
            end

            # Streams live events for an agent session. See
            # [session events](https://developers.openai.com/api/docs/guides/agents-api/sessions/events).
            sig {
              params(session_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
                OpenAI::Internal::Stream[OpenAI::Beta::AgentSessionEvent::Variants]
              )
            }
            def stream_streaming(
              # The ID of the session.
              session_id,
              request_options: {}
            )
            end

            # @api private
            sig { params(client: OpenAI::Client).returns(T.attached_class) }
            def self.new(client:)
            end
          end

        end

      end

    end

  end
end
