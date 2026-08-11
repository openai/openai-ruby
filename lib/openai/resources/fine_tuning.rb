# frozen_string_literal: true

module OpenAI
  module Resources
    class FineTuning
      # Returns a wrapper that exposes the raw HTTP response for each request.
      #
      # @return [FineTuning::WithRawResponse]
      def with_raw_response
        WithRawResponse.new(
          resource: FineTuning.new(
            client: OpenAI::Internal::Transport::RawResponseClient.new(@client)
          )
        )
      end

      # @return [OpenAI::Resources::FineTuning::Methods]
      attr_reader :methods_

      # Manage fine-tuning jobs to tailor a model to your specific training data.
      # @return [OpenAI::Resources::FineTuning::Jobs]
      attr_reader :jobs

      # @return [OpenAI::Resources::FineTuning::Checkpoints]
      attr_reader :checkpoints

      # @return [OpenAI::Resources::FineTuning::Alpha]
      attr_reader :alpha

      # @api private
      #
      # @param client [OpenAI::Internal::Transport::RequestClient]
      def initialize(client:)
        @client = client
        @methods_ = OpenAI::Resources::FineTuning::Methods.new(client: client)
        @jobs = OpenAI::Resources::FineTuning::Jobs.new(client: client)
        @checkpoints = OpenAI::Resources::FineTuning::Checkpoints.new(client: client)
        @alpha = OpenAI::Resources::FineTuning::Alpha.new(client: client)
      end

      class WithRawResponse
        # Manage fine-tuning jobs to tailor a model to your specific training data.
        # @return [OpenAI::Resources::FineTuning::Jobs::WithRawResponse]
        attr_reader :jobs

        # @return [OpenAI::Resources::FineTuning::Checkpoints::WithRawResponse]
        attr_reader :checkpoints

        # @return [OpenAI::Resources::FineTuning::Alpha::WithRawResponse]
        attr_reader :alpha

        # @api private
        #
        # @param resource [FineTuning]
        def initialize(resource:)
          @resource = resource

          @jobs =
            OpenAI::Resources::FineTuning::Jobs::WithRawResponse.new(
              resource: @resource.jobs
            )

          @checkpoints =
            OpenAI::Resources::FineTuning::Checkpoints::WithRawResponse.new(
              resource: @resource.checkpoints
            )

          @alpha =
            OpenAI::Resources::FineTuning::Alpha::WithRawResponse.new(
              resource: @resource.alpha
            )
        end
      end
    end
  end
end
