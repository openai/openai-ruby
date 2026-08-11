# frozen_string_literal: true

module OpenAI
  module Resources
    class FineTuning
      class Alpha
        # Manage fine-tuning jobs to tailor a model to your specific training data.
        class Graders
          # Returns a wrapper that exposes the raw HTTP response for each request.
          #
          # @return [Graders::WithRawResponse]
          def with_raw_response
            WithRawResponse.new(
              resource: Graders.new(
                client: OpenAI::Internal::Transport::RawResponseClient.new(@client)
              )
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::FineTuning::Alpha::GraderRunParams} for more details.
          #
          # Run a grader.
          #
          # @overload run(grader:, model_sample:, item: nil, request_options: {})
          #
          # @param grader [OpenAI::Models::Graders::StringCheckGrader, OpenAI::Models::Graders::TextSimilarityGrader, OpenAI::Models::Graders::PythonGrader, OpenAI::Models::Graders::ScoreModelGrader, OpenAI::Models::Graders::MultiGrader] The grader used for the fine-tuning job.
          #
          # @param model_sample [String] The model sample to be evaluated. This value will be used to populate
          #
          # @param item [Object] The dataset item provided to the grader. This will be used to populate
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::FineTuning::Alpha::GraderRunResponse]
          #
          # @see OpenAI::Models::FineTuning::Alpha::GraderRunParams
          def run(params)
            parsed, options = OpenAI::FineTuning::Alpha::GraderRunParams.dump_request(params)
            @client.request(
              method: :post,
              path: "fine_tuning/alpha/graders/run",
              body: parsed,
              model: OpenAI::Models::FineTuning::Alpha::GraderRunResponse,
              security: {bearer_auth: true},
              options: options
            )
          end

          # Validate a grader.
          #
          # @overload validate(grader:, request_options: {})
          #
          # @param grader [OpenAI::Models::Graders::StringCheckGrader, OpenAI::Models::Graders::TextSimilarityGrader, OpenAI::Models::Graders::PythonGrader, OpenAI::Models::Graders::ScoreModelGrader, OpenAI::Models::Graders::MultiGrader] The grader used for the fine-tuning job.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::FineTuning::Alpha::GraderValidateResponse]
          #
          # @see OpenAI::Models::FineTuning::Alpha::GraderValidateParams
          def validate(params)
            parsed, options = OpenAI::FineTuning::Alpha::GraderValidateParams.dump_request(params)
            @client.request(
              method: :post,
              path: "fine_tuning/alpha/graders/validate",
              body: parsed,
              model: OpenAI::Models::FineTuning::Alpha::GraderValidateResponse,
              security: {bearer_auth: true},
              options: options
            )
          end

          # @api private
          #
          # @param client [OpenAI::Internal::Transport::RequestClient]
          def initialize(client:)
            @client = client
          end

          class WithRawResponse
            def run(params)
              @resource.run(params)
            end

            def validate(params)
              @resource.validate(params)
            end

            # @api private
            #
            # @param resource [Graders]
            def initialize(resource:)
              @resource = resource
            end
          end
        end
      end
    end
  end
end
