# typed: strong
module OpenAI
  module Helpers
    module Beta
      module Agents
        class ResultArtifacts
          sig {
            params(
              artifacts: OpenAI::Resources::Beta::Agents::Sessions::Artifacts,
              client: OpenAI::Client,
              result: TurnResult
            )
              .void
          }
          def initialize(artifacts:, client:, result:)
          end

          sig {
            params(path: String, to: T.untyped, request_options: OpenAI::RequestOptions::OrHash).returns(
              OpenAI::Models::Beta::Agents::Sessions::SessionArtifact
            )
          }
          def download(path:, to:, request_options: {})
          end
        end
      end
    end
  end
end
