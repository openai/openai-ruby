# typed: strong

module OpenAI
  module Resources

    class Beta

      class Agents

        class Environments

          sig { returns(OpenAI::Resources::Beta::Agents::Environments::Files) }
          attr_reader :files

          sig { returns(OpenAI::Resources::Beta::Agents::Environments::Templates) }
          attr_reader :templates

          # Retrieves an execution environment's connection status and safe installed
          # metadata. See
          # [environment lifecycle](https://developers.openai.com/api/docs/guides/agents-api/environments/lifecycle).
          sig {
            params(environment_id: String, request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Beta::Agents::EnvironmentInfo
            )
          }
          def retrieve(
            # The ID of the environment.
            environment_id,
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
