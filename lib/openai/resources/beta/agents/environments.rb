# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Agents
        class Environments
          # @return [OpenAI::Resources::Beta::Agents::Environments::Files]
          attr_reader :files

          # @return [OpenAI::Resources::Beta::Agents::Environments::Templates]
          attr_reader :templates

          # Retrieves an execution environment's connection status and safe installed
          # metadata. See
          # [environment lifecycle](https://developers.openai.com/api/docs/guides/agents-api/environments/lifecycle).
          #
          # @overload retrieve(environment_id, request_options: {})
          #
          # @param environment_id [String]
          #   The ID of the environment.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Agents::EnvironmentInfo]
          #
          # @see OpenAI::Models::Beta::Agents::EnvironmentRetrieveParams
          def retrieve(environment_id, params = {})
            @client.request(
              method: :get,
              path: ["agents/environments/%1$s", environment_id],
              model: OpenAI::Beta::Agents::EnvironmentInfo,
              security: {bearer_auth: true},
              options: {extra_headers: {"OpenAI-Beta" => "agents=v1"}, **params[:request_options].to_h}
            )
          end

          # @api private
          #
          # @param client [OpenAI::Client]
          def initialize(client:)
            @client = client
            @files = OpenAI::Resources::Beta::Agents::Environments::Files.new(client: client)
            @templates = OpenAI::Resources::Beta::Agents::Environments::Templates.new(client: client)
          end
        end
      end
    end
  end
end
