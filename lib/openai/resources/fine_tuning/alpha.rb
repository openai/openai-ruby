# frozen_string_literal: true

module OpenAI
  module Resources
    class FineTuning
      class Alpha
        # Returns a wrapper that exposes the raw HTTP response for each request.
        #
        # @return [Alpha::WithRawResponse]
        def with_raw_response
          WithRawResponse.new(
            resource: Alpha.new(
              client: OpenAI::Internal::Transport::RawResponseClient.new(@client)
            )
          )
        end

        # Manage fine-tuning jobs to tailor a model to your specific training data.
        # @return [OpenAI::Resources::FineTuning::Alpha::Graders]
        attr_reader :graders

        # @api private
        #
        # @param client [OpenAI::Internal::Transport::RequestClient]
        def initialize(client:)
          @client = client
          @graders = OpenAI::Resources::FineTuning::Alpha::Graders.new(client: client)
        end

        class WithRawResponse
          # Manage fine-tuning jobs to tailor a model to your specific training data.
          # @return [OpenAI::Resources::FineTuning::Alpha::Graders::WithRawResponse]
          attr_reader :graders

          # @api private
          #
          # @param resource [Alpha]
          def initialize(resource:)
            @resource = resource

            @graders =
              OpenAI::Resources::FineTuning::Alpha::Graders::WithRawResponse.new(
                resource: @resource.graders
              )
          end
        end
      end
    end
  end
end
