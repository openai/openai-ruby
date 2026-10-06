# typed: strong

module OpenAI
  module Resources

    class Beta

      class Agents

        class Sessions

          class Turns

            class Items

              # Lists items belonging to one root-agent turn, including its interactions with
              # subagents. See
              # [inspecting agent output](https://developers.openai.com/api/docs/guides/agents-api/observability).
              sig {
                params(
                  turn_id: String,
                  session_id: String,
                  after: String,
                  limit: Integer,
                  order: OpenAI::Beta::Agents::Sessions::Turns::ItemListParams::Order::OrSymbol,
                  request_options: OpenAI::RequestOptions::OrHash
                )
                  .returns(OpenAI::Internal::ConversationCursorPage[OpenAI::Beta::AgentSessionItem::Variants])
              }
              def list(
                # Path param: The ID of the turn.
                turn_id,
                # Path param: The ID of the session that owns the turn.
                session_id:,
                # Query param: Return items after this cursor in the selected order. Pass the
                # previous response's last_id, which can differ from the last item's ID.
                after: nil,
                # Query param: The maximum number of resources to return, between 1 and 100.
                # Defaults to 20.
                limit: nil,
                # Query param: The order in which resources are returned. Defaults to `desc`.
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
end
