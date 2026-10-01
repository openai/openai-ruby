# frozen_string_literal: true

module OpenAI
  module Helpers
    module Beta
      module Agents
        # Artifact downloads scoped to one completed result (beta).
        class ResultArtifacts
          # @api private
          def initialize(artifacts:, client:, result:)
            @artifacts = artifacts
            @client = client
            @session_id = result.session_id.dup.freeze
            @turn_id = result.turn_id.dup.freeze
          end

          # Download the exact turn/path to a caller-selected local path or writer.
          # Returns the immutable artifact record that supplied the bytes.
          def download(path:, to:, request_options: {})
            request_options = request_options
              .to_h
              .merge(extra_headers: {"OpenAI-Beta" => "agents=v1"}.merge(request_options.to_h[:extra_headers].to_h))
            match = nil
            @artifacts
              .list(@session_id, order: :asc, limit: 100, request_options: request_options)
              .auto_paging_each do |artifact|
                next unless artifact.turn_id == @turn_id && artifact.path == path
                raise ArgumentError, "More than one artifact matches the result turn and path" if match
                match = artifact
              end

            raise ArgumentError, "No artifact matches the result turn and path" unless match

            transfer(match.id, to, request_options)

            match
          end

          private

          def transfer(artifact_id, destination, options)
            writer = nil
            opened = lambda do
              writer = if destination.is_a?(String) || destination.is_a?(Pathname)
                File.open(destination, "wb")
              else
                destination
              end
            end

            request = {
              method: :get,
              path: ["agents/sessions/%1$s/artifacts/%2$s/content", @session_id, artifact_id],
              headers: {"accept" => "application/octet-stream"},
              security: {bearer_auth: true},
              options: options
            }
            @client.request_streaming_body(request, opened) { |chunk| writer.write(chunk) }
          ensure
            writer.close if writer && !writer.equal?(destination)
          end
        end
      end
    end
  end
end
