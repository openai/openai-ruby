# typed: strong

module OpenAI
  module Resources

    class Beta

      class Agents

        class Sessions

          class Artifacts

            # Retrieves immutable metadata for one durable session artifact. See
            # [session artifacts](https://developers.openai.com/api/docs/guides/agents-api/environments/files#openai-hosted-artifacts).
            sig {
              params(artifact_id: String, session_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
                OpenAI::Beta::Agents::Sessions::SessionArtifact
              )
            }
            def retrieve(
              # The immutable session artifact ID.
              artifact_id,
              # The ID of the session that owns the artifact.
              session_id:,
              request_options: {}
            )
            end

            # Lists immutable artifacts published by completed hosted session turns. See
            # [session artifacts](https://developers.openai.com/api/docs/guides/agents-api/environments/files#openai-hosted-artifacts).
            sig {
              params(
                session_id: String,
                after: T.nilable(String),
                environment_id: T.nilable(String),
                limit: T.nilable(Integer),
                order: OpenAI::Beta::Agents::Sessions::ArtifactListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(OpenAI::Internal::CursorPage[OpenAI::Beta::Agents::Sessions::SessionArtifact])
            }
            def list(
              # The ID of the session.
              session_id,
              # Return artifacts after this immutable artifact ID.
              after: nil,
              # Restrict the listing to artifacts produced by this environment.
              environment_id: nil,
              # The maximum number of artifacts to return, between 1 and 100.
              limit: nil,
              # Sort by creation time and ID. Defaults to descending.
              order: nil,
              request_options: {}
            )
            end

            # Deletes an immutable session artifact without deleting its live environment file
            # or original Files API object. See
            # [session artifacts](https://developers.openai.com/api/docs/guides/agents-api/environments/files#openai-hosted-artifacts).
            sig {
              params(artifact_id: String, session_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
                OpenAI::Beta::Agents::Sessions::SessionArtifactDeleted
              )
            }
            def delete(
              # The immutable session artifact ID.
              artifact_id,
              # The ID of the session that owns the artifact.
              session_id:,
              request_options: {}
            )
            end

            # Downloads immutable session artifact bytes after the execution environment
            # expires. See
            # [session artifacts](https://developers.openai.com/api/docs/guides/agents-api/environments/files#openai-hosted-artifacts).
            sig {
              params(artifact_id: String, session_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
                T.all(StringIO, OpenAI::ResponseCarrier)
              )
            }
            def content(
              # The immutable session artifact ID.
              artifact_id,
              # The ID of the session that owns the artifact.
              session_id:,
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
