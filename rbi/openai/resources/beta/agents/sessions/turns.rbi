# typed: strong

module OpenAI
  module Resources

    class Beta

      class Agents

        class Sessions

          class Turns

            # Retrieves a turn's current status, timestamps, usage, and error. Returns 404 if
            # the turn does not belong to the session. See
            # [session turns](https://developers.openai.com/api/docs/guides/agents-api/sessions/manage#inspect-session-turns).
            sig {
              params(turn_id: String, session_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
                OpenAI::Beta::Agents::Sessions::Turn
              )
            }
            def retrieve(
              # The ID of the turn.
              turn_id,
              # The ID of the session that owns the turn.
              session_id:,
              request_options: {}
            )
            end

            # Lists turns by creation time and turn ID. The after cursor is exclusive in the
            # selected order. See
            # [session turns](https://developers.openai.com/api/docs/guides/agents-api/sessions/manage#inspect-session-turns).
            sig {
              params(
                session_id: String,
                after: String,
                limit: Integer,
                order: OpenAI::Beta::Agents::Sessions::TurnListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(OpenAI::Internal::CursorPage[OpenAI::Beta::Agents::Sessions::Turn])
            }
            def list(
              # The ID of the session.
              session_id,
              # Return resources after this resource ID in the selected order.
              after: nil,
              # The maximum number of resources to return, between 1 and 100. Defaults to 20.
              limit: nil,
              # The order in which resources are returned. Defaults to `desc`.
              order: nil,
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
