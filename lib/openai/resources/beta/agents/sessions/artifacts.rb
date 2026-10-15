# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Agents
        class Sessions
          class Artifacts
            # Retrieves immutable metadata for one durable session artifact. See
            # [session artifacts](https://developers.openai.com/api/docs/guides/agents-api/environments/files#openai-hosted-artifacts).
            #
            # @overload retrieve(artifact_id, session_id:, request_options: {})
            #
            # @param artifact_id [String]
            #   The immutable session artifact ID.
            #
            # @param session_id [String]
            #   The ID of the session that owns the artifact.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Beta::Agents::Sessions::SessionArtifact]
            #
            # @see OpenAI::Models::Beta::Agents::Sessions::ArtifactRetrieveParams
            def retrieve(artifact_id, params)
              parsed, options = OpenAI::Beta::Agents::Sessions::ArtifactRetrieveParams.dump_request(params)
              session_id = parsed.delete(:session_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end

              @client.request(
                method: :get,
                path: ["agents/sessions/%1$s/artifacts/%2$s", session_id, artifact_id],
                headers: {"openai-beta" => "agents=v1"},
                model: OpenAI::Beta::Agents::Sessions::SessionArtifact,
                security: {bearer_auth: true},
                options: options
              )
            end

            # Lists immutable artifacts published by completed hosted session turns. See
            # [session artifacts](https://developers.openai.com/api/docs/guides/agents-api/environments/files#openai-hosted-artifacts).
            #
            # @overload list(session_id, after: nil, environment_id: nil, limit: nil, order: nil, request_options: {})
            #
            # @param session_id [String]
            #   The ID of the session.
            #
            # @param after [String]
            #   Return resources after this resource ID in the selected order.
            #
            # @param environment_id [String, nil]
            #   Restrict the listing to artifacts produced by this environment.
            #
            # @param limit [Integer]
            #   The maximum number of resources to return, between 1 and 100. Defaults to 20.
            #
            # @param order [Symbol, OpenAI::Models::Beta::Agents::Sessions::ArtifactListParams::Order]
            #   The order in which resources are returned. Defaults to `desc`.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Beta::Agents::Sessions::SessionArtifact>]
            #
            # @see OpenAI::Models::Beta::Agents::Sessions::ArtifactListParams
            def list(session_id, params = {})
              parsed, options = OpenAI::Beta::Agents::Sessions::ArtifactListParams.dump_request(params)
              query = OpenAI::Internal::Util.encode_query_params(parsed)
              @client.request(
                method: :get,
                path: ["agents/sessions/%1$s/artifacts", session_id],
                query: query,
                headers: {"openai-beta" => "agents=v1"},
                page: OpenAI::Internal::CursorPage,
                model: OpenAI::Beta::Agents::Sessions::SessionArtifact,
                security: {bearer_auth: true},
                options: options
              )
            end

            # Deletes an immutable session artifact without deleting its live environment file
            # or original Files API object. See
            # [session artifacts](https://developers.openai.com/api/docs/guides/agents-api/environments/files#openai-hosted-artifacts).
            #
            # @overload delete(artifact_id, session_id:, request_options: {})
            #
            # @param artifact_id [String]
            #   The immutable session artifact ID.
            #
            # @param session_id [String]
            #   The ID of the session that owns the artifact.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Beta::Agents::Sessions::SessionArtifactDeleted]
            #
            # @see OpenAI::Models::Beta::Agents::Sessions::ArtifactDeleteParams
            def delete(artifact_id, params)
              parsed, options = OpenAI::Beta::Agents::Sessions::ArtifactDeleteParams.dump_request(params)
              session_id = parsed.delete(:session_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end

              @client.request(
                method: :delete,
                path: ["agents/sessions/%1$s/artifacts/%2$s", session_id, artifact_id],
                headers: {"openai-beta" => "agents=v1"},
                model: OpenAI::Beta::Agents::Sessions::SessionArtifactDeleted,
                security: {bearer_auth: true},
                options: options
              )
            end

            # Downloads immutable session artifact bytes after the execution environment
            # expires. See
            # [session artifacts](https://developers.openai.com/api/docs/guides/agents-api/environments/files#openai-hosted-artifacts).
            #
            # @overload content(artifact_id, session_id:, request_options: {})
            #
            # @param artifact_id [String]
            #   The immutable session artifact ID.
            #
            # @param session_id [String]
            #   The ID of the session that owns the artifact.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [StringIO]
            #
            # @see OpenAI::Models::Beta::Agents::Sessions::ArtifactContentParams
            def content(artifact_id, params)
              parsed, options = OpenAI::Beta::Agents::Sessions::ArtifactContentParams.dump_request(params)
              session_id = parsed.delete(:session_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end

              @client.request(
                method: :get,
                path: ["agents/sessions/%1$s/artifacts/%2$s/content", session_id, artifact_id],
                headers: {"openai-beta" => "agents=v1", "accept" => "application/octet-stream"},
                model: StringIO,
                security: {bearer_auth: true},
                options: options
              )
            end

            # @api private
            #
            # @param client [OpenAI::Client]
            def initialize(client:)
              @client = client
            end
          end
        end
      end
    end
  end
end
