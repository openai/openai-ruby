# frozen_string_literal: true

module OpenAI
  module Resources
    class FineTuning
      class Checkpoints
        # Returns a wrapper that exposes the raw HTTP response for each request.
        #
        # @return [Checkpoints::WithRawResponse]
        def with_raw_response
          WithRawResponse.new(
            resource: Checkpoints.new(
              client: OpenAI::Internal::Transport::RawResponseClient.new(@client)
            )
          )
        end

        # Manage fine-tuning jobs to tailor a model to your specific training data.
        # @return [OpenAI::Resources::FineTuning::Checkpoints::Permissions]
        attr_reader :permissions

        # @api private
        #
        # @param client [OpenAI::Internal::Transport::RequestClient]
        def initialize(client:)
          @client = client
          @permissions = OpenAI::Resources::FineTuning::Checkpoints::Permissions.new(client: client)
        end

        class WithRawResponse
          # Manage fine-tuning jobs to tailor a model to your specific training data.
          # @return [OpenAI::Resources::FineTuning::Checkpoints::Permissions::WithRawResponse]
          attr_reader :permissions

          # @api private
          #
          # @param resource [Checkpoints]
          def initialize(resource:)
            @resource = resource

            @permissions =
              OpenAI::Resources::FineTuning::Checkpoints::Permissions::WithRawResponse.new(
                resource: @resource.permissions
              )
          end
        end
      end
    end
  end
end
