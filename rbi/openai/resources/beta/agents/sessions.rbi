# typed: strong

module OpenAI
  module Resources

    class Beta

      class Agents

        class Sessions

          sig { returns(OpenAI::Resources::Beta::Agents::Sessions::Subagents) }
          attr_reader :subagents

          sig { returns(OpenAI::Resources::Beta::Agents::Sessions::Artifacts) }
          attr_reader :artifacts

          sig { returns(OpenAI::Resources::Beta::Agents::Sessions::Items) }
          attr_reader :items

          sig { returns(OpenAI::Resources::Beta::Agents::Sessions::Events) }
          attr_reader :events

          sig { returns(OpenAI::Resources::Beta::Agents::Sessions::Turns) }
          attr_reader :turns

          # See {OpenAI::Resources::Beta::Agents::Sessions#create_streaming} for streaming
          # counterpart.
          #
          # Creates a managed agent session, optionally submits initial input, and returns
          # the session or streams its events when stream is true. See
          # [running sessions](https://developers.openai.com/api/docs/guides/agents-api/sessions).
          sig {
            params(
              environment: T.any(
                OpenAI::Beta::EnvironmentParam::None::OrHash,
                OpenAI::Beta::EnvironmentParam::OpenAIHosted::OrHash,
                OpenAI::Beta::EnvironmentParam::SelfHosted::OrHash
              ),
              agent: OpenAI::Beta::Agents::SessionCreateParams::Agent::OrHash,
              agent_id: String,
              input: T.nilable(OpenAI::Beta::Agents::SessionCreateParams::Input::Variants),
              metadata: T.nilable(T::Hash[Symbol, String]),
              vault_ids: T.nilable(T::Array[String]),
              stream: T.noreturn,
              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(OpenAI::Beta::AgentSession)
          }
          def create(
            # An inline execution environment or a reference to an environment template.
            environment:,
            # Agent configuration. With `agent_id`, supplied fields override the saved agent
            # for this session. Without `agent_id`, `model` is required.
            agent: nil,
            # The ID of a saved reusable agent. Omit `agent` to use its configuration
            # unchanged.
            agent_id: nil,
            # Initial input submitted when creating a session.
            input: nil,
            # Up to 16 string key-value pairs, with keys up to 64 and values up to 512
            # characters. Omission or null defaults to an empty map.
            metadata: nil,
            # The IDs of vaults made available to the session.
            vault_ids: nil,
            # There is no need to provide `stream:`. Instead, use `#create_streaming` or
            # `#create` for streaming and non-streaming use cases, respectively.
            stream: false,
            request_options: {}
          )
          end

          # See {OpenAI::Resources::Beta::Agents::Sessions#create} for non-streaming
          # counterpart.
          #
          # Creates a managed agent session, optionally submits initial input, and returns
          # the session or streams its events when stream is true. See
          # [running sessions](https://developers.openai.com/api/docs/guides/agents-api/sessions).
          sig {
            params(
              environment: T.any(
                OpenAI::Beta::EnvironmentParam::None::OrHash,
                OpenAI::Beta::EnvironmentParam::OpenAIHosted::OrHash,
                OpenAI::Beta::EnvironmentParam::SelfHosted::OrHash
              ),
              agent: OpenAI::Beta::Agents::SessionCreateParams::Agent::OrHash,
              agent_id: String,
              input: T.nilable(OpenAI::Beta::Agents::SessionCreateParams::Input::Variants),
              metadata: T.nilable(T::Hash[Symbol, String]),
              vault_ids: T.nilable(T::Array[String]),
              stream: T.noreturn,
              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(OpenAI::Internal::Stream[OpenAI::Beta::AgentSessionEvent::Variants])
          }
          def create_streaming(
            # An inline execution environment or a reference to an environment template.
            environment:,
            # Agent configuration. With `agent_id`, supplied fields override the saved agent
            # for this session. Without `agent_id`, `model` is required.
            agent: nil,
            # The ID of a saved reusable agent. Omit `agent` to use its configuration
            # unchanged.
            agent_id: nil,
            # Initial input submitted when creating a session.
            input: nil,
            # Up to 16 string key-value pairs, with keys up to 64 and values up to 512
            # characters. Omission or null defaults to an empty map.
            metadata: nil,
            # The IDs of vaults made available to the session.
            vault_ids: nil,
            # There is no need to provide `stream:`. Instead, use `#create_streaming` or
            # `#create` for streaming and non-streaming use cases, respectively.
            stream: true,
            request_options: {}
          )
          end

          # Retrieves the current state of a managed agent session. See
          # [managing sessions](https://developers.openai.com/api/docs/guides/agents-api/sessions/manage).
          sig {
            params(session_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Beta::AgentSession
            )
          }
          def retrieve(
            # The ID of the session.
            session_id,
            request_options: {}
          )
          end

          # Updates session metadata. Omitted fields are unchanged. See
          # [managing sessions](https://developers.openai.com/api/docs/guides/agents-api/sessions/manage).
          sig {
            params(
              session_id: String,
              metadata: T.nilable(T::Hash[Symbol, String]),
              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(OpenAI::Beta::AgentSession)
          }
          def update(
            # The ID of the session.
            session_id,
            # Replaces all metadata. Omit to leave unchanged, or pass null or {} to clear it.
            # Up to 16 string key-value pairs, with keys up to 64 and values up to 512
            # characters.
            metadata: nil,
            request_options: {}
          )
          end

          # Lists managed agent sessions using ID-based pagination and the requested sort
          # order. See
          # [managing sessions](https://developers.openai.com/api/docs/guides/agents-api/sessions/manage).
          sig {
            params(
              after: String,
              agent_id: String,
              limit: T.nilable(Integer),
              order: OpenAI::Beta::Agents::SessionListParams::Order::OrSymbol,
              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(OpenAI::Internal::CursorPage[OpenAI::Beta::AgentSession])
          }
          def list(
            # Return resources after this resource ID in the selected order.
            after: nil,
            # Only return sessions whose root agent has this ID. Omit to return sessions for
            # all agents.
            agent_id: nil,
            # The maximum number of resources to return.
            limit: nil,
            # Sort order by the `created_at` timestamp. Use `asc` for ascending order or
            # `desc` for descending order. Defaults to `desc`.
            order: nil,
            request_options: {}
          )
          end

          # Removes a managed agent session from the public API and returns a deletion
          # confirmation. Physical cleanup may continue asynchronously. See
          # [managing sessions](https://developers.openai.com/api/docs/guides/agents-api/sessions/manage).
          sig {
            params(session_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Beta::AgentSessionDeleted
            )
          }
          def delete(
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
