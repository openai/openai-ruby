# typed: strong

module OpenAI
  module Resources
    class Evals
      sig { returns(OpenAI::Resources::Evals::Runs) }
      attr_reader :runs

      # Create the structure of an evaluation that can be used to test a model's
      # performance. An evaluation is a set of testing criteria and a datasource. After
      # creating an evaluation, you can run it on different models and model parameters.
      # We support several types of graders and datasources. For more information, see
      # the [Evals guide](https://platform.openai.com/docs/guides/evals).
      sig do
        params(
          data_source_config: T.any(
            OpenAI::Models::EvalCreateParams::DataSourceConfig::Custom,
            OpenAI::Internal::AnyHash,
            OpenAI::Models::EvalCreateParams::DataSourceConfig::StoredCompletions
          ),
          testing_criteria: T::Array[
            T.any(
              OpenAI::Models::EvalCreateParams::TestingCriterion::LabelModel,
              OpenAI::Internal::AnyHash,
              OpenAI::Models::EvalStringCheckGrader,
              OpenAI::Models::EvalTextSimilarityGrader
            )
          ],
          metadata: T.nilable(T::Hash[Symbol, String]),
          name: String,
          share_with_openai: T::Boolean,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash))
        )
          .returns(OpenAI::Models::EvalCreateResponse)
      end
      def create(
        # The configuration for the data source used for the evaluation runs.
        data_source_config:,
        # A list of graders for all eval runs in this group.
        testing_criteria:,
        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard.
        #
        # Keys are strings with a maximum length of 64 characters. Values are strings with
        # a maximum length of 512 characters.
        metadata: nil,
        # The name of the evaluation.
        name: nil,
        # Indicates whether the evaluation is shared with OpenAI.
        share_with_openai: nil,
        request_options: {}
      ); end
      # Get an evaluation by ID.
      sig do
        params(
          eval_id: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash))
        )
          .returns(OpenAI::Models::EvalRetrieveResponse)
      end
      def retrieve(
        # The ID of the evaluation to retrieve.
        eval_id,
        request_options: {}
      ); end
      # Update certain properties of an evaluation.
      sig do
        params(
          eval_id: String,
          metadata: T.nilable(T::Hash[Symbol, String]),
          name: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash))
        )
          .returns(OpenAI::Models::EvalUpdateResponse)
      end
      def update(
        # The ID of the evaluation to update.
        eval_id,
        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard.
        #
        # Keys are strings with a maximum length of 64 characters. Values are strings with
        # a maximum length of 512 characters.
        metadata: nil,
        # Rename the evaluation.
        name: nil,
        request_options: {}
      ); end
      # List evaluations for a project.
      sig do
        params(
          after: String,
          limit: Integer,
          order: OpenAI::Models::EvalListParams::Order::OrSymbol,
          order_by: OpenAI::Models::EvalListParams::OrderBy::OrSymbol,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash))
        )
          .returns(OpenAI::Internal::CursorPage[OpenAI::Models::EvalListResponse])
      end
      def list(
        # Identifier for the last eval from the previous pagination request.
        after: nil,
        # Number of evals to retrieve.
        limit: nil,
        # Sort order for evals by timestamp. Use `asc` for ascending order or `desc` for
        # descending order.
        order: nil,
        # Evals can be ordered by creation time or last updated time. Use `created_at` for
        # creation time or `updated_at` for last updated time.
        order_by: nil,
        request_options: {}
      ); end
      # Delete an evaluation.
      sig do
        params(
          eval_id: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash))
        )
          .returns(OpenAI::Models::EvalDeleteResponse)
      end
      def delete(
        # The ID of the evaluation to delete.
        eval_id,
        request_options: {}
      ); end
      # @api private
      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:); end
    end
  end
end
