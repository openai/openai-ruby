# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Agents
        class Environments
          class Files
            # Copies inline bytes or a Files API file into a connected execution environment.
            # See
            # [environment files](https://developers.openai.com/api/docs/guides/agents-api/environments/files).
            #
            # @overload create(environment_id, hosted_environment_file_param:, request_options: {})
            #
            # @param environment_id [String]
            #   The ID of the environment.
            #
            # @param hosted_environment_file_param [OpenAI::Models::Beta::HostedEnvironmentFileParam::FileID, OpenAI::Models::Beta::HostedEnvironmentFileParam::Inline]
            #   A file materialized in an OpenAI-hosted execution environment.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Models::Beta::Agents::Environments::EnvironmentFile]
            #
            # @see OpenAI::Models::Beta::Agents::Environments::FileCreateParams
            def create(environment_id, params)
              parsed, options = OpenAI::Beta::Agents::Environments::FileCreateParams.dump_request(params)
              @client.request(
                method: :post,
                path: ["agents/environments/%1$s/files", environment_id],
                body: parsed[:hosted_environment_file_param],
                model: OpenAI::Beta::Agents::Environments::EnvironmentFile,
                security: {bearer_auth: true},
                options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **options}
              )
            end

            # Lists live files on a connected execution environment with optional directory
            # filtering and opaque cursor pagination. See
            # [environment files](https://developers.openai.com/api/docs/guides/agents-api/environments/files).
            #
            # @overload list(environment_id, limit: nil, order: nil, page: nil, path: nil, request_options: {})
            #
            # @param environment_id [String]
            #   The ID of the environment.
            #
            # @param limit [Integer, nil]
            #   The maximum number of files to return, between 1 and 100.
            #
            # @param order [Symbol, OpenAI::Models::Beta::Agents::Environments::FileListParams::Order]
            #   Sort by case-sensitive path components. Defaults to descending.
            #
            # @param page [String]
            #   The opaque token from the previous page. Keep the same path, order, and limit.
            #
            # @param path [String, nil]
            #   Restrict the listing to this absolute workspace directory.
            #
            # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
            #
            # @return [OpenAI::Internal::TokenPage<OpenAI::Models::Beta::Agents::Environments::EnvironmentFile>]
            #
            # @see OpenAI::Models::Beta::Agents::Environments::FileListParams
            def list(environment_id, params = {})
              parsed, options = OpenAI::Beta::Agents::Environments::FileListParams.dump_request(params)
              query = OpenAI::Internal::Util.encode_query_params(parsed)
              @client.request(
                method: :get,
                path: ["agents/environments/%1$s/files", environment_id],
                query: query,
                page: OpenAI::Internal::TokenPage,
                model: OpenAI::Beta::Agents::Environments::EnvironmentFile,
                security: {bearer_auth: true},
                options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **options}
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
