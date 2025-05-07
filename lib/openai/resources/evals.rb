# frozen_string_literal: true

module OpenAI
  module Resources
    class Evals
      # @return [OpenAI::Resources::Evals::Runs]
      attr_reader :runs

      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::EvalCreateParams} for more details.
      #
      # Create the structure of an evaluation that can be used to test a model's
      # performance. An evaluation is a set of testing criteria and a datasource. After
      # creating an evaluation, you can run it on different models and model parameters.
      # We support several types of graders and datasources. For more information, see
      # the [Evals guide](https://platform.openai.com/docs/guides/evals).
      #
      # @overload create(data_source_config:, testing_criteria:, metadata: nil, name: nil, request_options: {})
      #
      # @param data_source_config [OpenAI::EvalCreateParams::DataSourceConfig::Custom, OpenAI::EvalCreateParams::DataSourceConfig::Logs] The configuration for the data source used for the evaluation runs.
      #
      # @param testing_criteria [Array<OpenAI::EvalCreateParams::TestingCriterion::LabelModel, OpenAI::EvalStringCheckGrader, OpenAI::EvalTextSimilarityGrader, OpenAI::EvalCreateParams::TestingCriterion::Python, OpenAI::EvalCreateParams::TestingCriterion::ScoreModel>] A list of graders for all eval runs in this group.
      #
      # @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
      #
      # @param name [String] The name of the evaluation.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::EvalCreateResponse]
      #
      # @see OpenAI::Models::EvalCreateParams
      def create(params)
        parsed, options = OpenAI::EvalCreateParams.dump_request(params)
        @client.request(
          method: :post,
          path: "evals",
          body: parsed,
          model: OpenAI::Models::EvalCreateResponse,
          options: options
        )
      end

      # Get an evaluation by ID.
      #
      # @overload retrieve(eval_id, request_options: {})
      #
      # @param eval_id [String] The ID of the evaluation to retrieve.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::EvalRetrieveResponse]
      #
      # @see OpenAI::Models::EvalRetrieveParams
      def retrieve(eval_id, params = {})
        @client.request(
          method: :get,
          path: ["evals/%1$s", eval_id],
          model: OpenAI::Models::EvalRetrieveResponse,
          options: params[:request_options]
        )
      end

      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::EvalUpdateParams} for more details.
      #
      # Update certain properties of an evaluation.
      #
      # @overload update(eval_id, metadata: nil, name: nil, request_options: {})
      #
      # @param eval_id [String] The ID of the evaluation to update.
      #
      # @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
      #
      # @param name [String] Rename the evaluation.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::EvalUpdateResponse]
      #
      # @see OpenAI::Models::EvalUpdateParams
      def update(eval_id, params = {})
        parsed, options = OpenAI::EvalUpdateParams.dump_request(params)
        @client.request(
          method: :post,
          path: ["evals/%1$s", eval_id],
          body: parsed,
          model: OpenAI::Models::EvalUpdateResponse,
          options: options
        )
      end

      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::EvalListParams} for more details.
      #
      # List evaluations for a project.
      #
      # @overload list(after: nil, limit: nil, order: nil, order_by: nil, request_options: {})
      #
      # @param after [String] Identifier for the last eval from the previous pagination request.
      #
      # @param limit [Integer] Number of evals to retrieve.
      #
      # @param order [Symbol, OpenAI::EvalListParams::Order] Sort order for evals by timestamp. Use `asc` for ascending order or `desc` for d
      #
      # @param order_by [Symbol, OpenAI::EvalListParams::OrderBy] Evals can be ordered by creation time or last updated time. Use
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Internal::CursorPage<OpenAI::Models::EvalListResponse>]
      #
      # @see OpenAI::Models::EvalListParams
      def list(params = {})
        parsed, options = OpenAI::EvalListParams.dump_request(params)
        @client.request(
          method: :get,
          path: "evals",
          query: parsed,
          page: OpenAI::Internal::CursorPage,
          model: OpenAI::Models::EvalListResponse,
          options: options
        )
      end

      # Delete an evaluation.
      #
      # @overload delete(eval_id, request_options: {})
      #
      # @param eval_id [String] The ID of the evaluation to delete.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::EvalDeleteResponse]
      #
      # @see OpenAI::Models::EvalDeleteParams
      def delete(eval_id, params = {})
        @client.request(
          method: :delete,
          path: ["evals/%1$s", eval_id],
          model: OpenAI::Models::EvalDeleteResponse,
          options: params[:request_options]
        )
      end

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @runs = OpenAI::Resources::Evals::Runs.new(client: client)
      end
    end
  end
end
