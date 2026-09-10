# typed: strong

module OpenAI
  module Resources

    class Beta

      class Agents

        class Sessions

          class Subagents

            class Turns

              sig { returns(OpenAI::Resources::Beta::Agents::Sessions::Subagents::Turns::Items) }
              attr_reader :items

              # Retrieves a turn belonging to this subagent. See
              # [subagent workflows](https://developers.openai.com/api/docs/guides/agents-api/multi-agent).
              sig {
                params(
                  turn_id: String,
                  session_id: String,
                  subagent_id: String,
                  request_options: OpenAI::RequestOptions::OrHash
                )
                  .returns(OpenAI::Beta::Agents::Sessions::Turn)
              }
              def retrieve(
                # The ID of a turn belonging to this subagent.
                turn_id,
                # The ID of the session.
                session_id:,
                # The ID of the subagent in this session.
                subagent_id:,
                request_options: {}
              )
              end

              # Lists all turns of this subagent, including turns after a resume. See
              # [subagent workflows](https://developers.openai.com/api/docs/guides/agents-api/multi-agent).
              sig {
                params(
                  subagent_id: String,
                  session_id: String,
                  after: String,
                  limit: Integer,
                  order: OpenAI::Beta::Agents::Sessions::Subagents::TurnListParams::Order::OrSymbol,
                  request_options: OpenAI::RequestOptions::OrHash
                )
                  .returns(OpenAI::Internal::CursorPage[OpenAI::Beta::Agents::Sessions::Turn])
              }
              def list(
                # Path param: The ID of the subagent in this session.
                subagent_id,
                # Path param: The ID of the session.
                session_id:,
                # Query param: Return resources after this resource ID in the selected order.
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
