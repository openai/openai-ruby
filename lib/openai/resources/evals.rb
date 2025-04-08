# frozen_string_literal: true

module OpenAI
  module Resources
    class Evals
      # @return [OpenAI::Resources::Evals::Runs]
      attr_reader :runs

      # Create the structure of an evaluation that can be used to test a model's
      # performance. An evaluation is a set of testing criteria and a datasource. After
      # creating an evaluation, you can run it on different models and model parameters.
      # We support several types of graders and datasources. For more information, see
      # the [Evals guide](https://platform.openai.com/docs/guides/evals).
      #
      # @overload create(data_source_config:, testing_criteria:, metadata: nil, name: nil, share_with_openai: nil, request_options: {})
      #
      # @param data_source_config [OpenAI::Models::EvalCreateParams::DataSourceConfig::Custom, OpenAI::Models::EvalCreateParams::DataSourceConfig::StoredCompletions]
      # @param testing_criteria [Array<OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel, OpenAI::Models::EvalStringCheckGrader, OpenAI::Models::EvalTextSimilarityGrader>]
      # @param metadata [Hash{Symbol=>String}, nil]
      # @param name [String]
      # @param share_with_openai [Boolean]
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::EvalCreateResponse]
      #
      # @see OpenAI::Models::EvalCreateParams
      def create(params)
        parsed, options = OpenAI::Models::EvalCreateParams.dump_request(params)
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
      # @param eval_id [String]
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

      # Update certain properties of an evaluation.
      #
      # @overload update(eval_id, metadata: nil, name: nil, request_options: {})
      #
      # @param eval_id [String]
      # @param metadata [Hash{Symbol=>String}, nil]
      # @param name [String]
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::EvalUpdateResponse]
      #
      # @see OpenAI::Models::EvalUpdateParams
      def update(eval_id, params = {})
        parsed, options = OpenAI::Models::EvalUpdateParams.dump_request(params)
        @client.request(
          method: :post,
          path: ["evals/%1$s", eval_id],
          body: parsed,
          model: OpenAI::Models::EvalUpdateResponse,
          options: options
        )
      end

      # List evaluations for a project.
      #
      # @overload list(after: nil, limit: nil, order: nil, order_by: nil, request_options: {})
      #
      # @param after [String]
      # @param limit [Integer]
      # @param order [Symbol, OpenAI::Models::EvalListParams::Order]
      # @param order_by [Symbol, OpenAI::Models::EvalListParams::OrderBy]
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Internal::CursorPage<OpenAI::Models::EvalListResponse>]
      #
      # @see OpenAI::Models::EvalListParams
      def list(params = {})
        parsed, options = OpenAI::Models::EvalListParams.dump_request(params)
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
      # @param eval_id [String]
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
