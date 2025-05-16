# frozen_string_literal: true

module OpenAI
  module Models
    module Evals
      module Runs
        # @see OpenAI::Resources::Evals::Runs::OutputItems#list
        class OutputItemListResponse < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   Unique identifier for the evaluation run output item.
          #
          #   @return [String]
          required :id, String

          # @!attribute created_at
          #   Unix timestamp (in seconds) when the evaluation run was created.
          #
          #   @return [Integer]
          required :created_at, Integer

          # @!attribute datasource_item
          #   Details of the input data source item.
          #
          #   @return [Hash{Symbol=>Object}]
          required :datasource_item, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

          # @!attribute datasource_item_id
          #   The identifier for the data source item.
          #
          #   @return [Integer]
          required :datasource_item_id, Integer

          # @!attribute eval_id
          #   The identifier of the evaluation group.
          #
          #   @return [String]
          required :eval_id, String

          # @!attribute object
          #   The type of the object. Always "eval.run.output_item".
          #
          #   @return [Symbol, :"eval.run.output_item"]
          required :object, const: :"eval.run.output_item"

          # @!attribute results
          #   A list of results from the evaluation run.
          #
          #   @return [Array<Hash{Symbol=>Object}>]
          required :results,
                   OpenAI::Internal::Type::ArrayOf[OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]]

          # @!attribute run_id
          #   The identifier of the evaluation run associated with this output item.
          #
          #   @return [String]
          required :run_id, String

          # @!attribute sample
          #   A sample containing the input and output of the evaluation run.
          #
          #   @return [OpenAI::Models::Evals::Runs::OutputItemListResponse::Sample]
          required :sample, -> { OpenAI::Models::Evals::Runs::OutputItemListResponse::Sample }

          # @!attribute status
          #   The status of the evaluation run.
          #
          #   @return [String]
          required :status, String

          # @!method initialize(id:, created_at:, datasource_item:, datasource_item_id:, eval_id:, results:, run_id:, sample:, status:, object: :"eval.run.output_item")
          #   A schema representing an evaluation run output item.
          #
          #   @param id [String] Unique identifier for the evaluation run output item.
          #
          #   @param created_at [Integer] Unix timestamp (in seconds) when the evaluation run was created.
          #
          #   @param datasource_item [Hash{Symbol=>Object}] Details of the input data source item.
          #
          #   @param datasource_item_id [Integer] The identifier for the data source item.
          #
          #   @param eval_id [String] The identifier of the evaluation group.
          #
          #   @param results [Array<Hash{Symbol=>Object}>] A list of results from the evaluation run.
          #
          #   @param run_id [String] The identifier of the evaluation run associated with this output item.
          #
          #   @param sample [OpenAI::Models::Evals::Runs::OutputItemListResponse::Sample] A sample containing the input and output of the evaluation run.
          #
          #   @param status [String] The status of the evaluation run.
          #
          #   @param object [Symbol, :"eval.run.output_item"] The type of the object. Always "eval.run.output_item".

          # @see OpenAI::Models::Evals::Runs::OutputItemListResponse#sample
          class Sample < OpenAI::Internal::Type::BaseModel
            # @!attribute error
            #   An object representing an error response from the Eval API.
            #
            #   @return [OpenAI::Evals::EvalAPIError]
            required :error, -> { OpenAI::Evals::EvalAPIError }

            # @!attribute finish_reason
            #   The reason why the sample generation was finished.
            #
            #   @return [String]
            required :finish_reason, String

            # @!attribute input
            #   An array of input messages.
            #
            #   @return [Array<OpenAI::Models::Evals::Runs::OutputItemListResponse::Sample::Input>]
            required :input,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Evals::Runs::OutputItemListResponse::Sample::Input] }

            # @!attribute max_completion_tokens
            #   The maximum number of tokens allowed for completion.
            #
            #   @return [Integer]
            required :max_completion_tokens, Integer

            # @!attribute model
            #   The model used for generating the sample.
            #
            #   @return [String]
            required :model, String

            # @!attribute output
            #   An array of output messages.
            #
            #   @return [Array<OpenAI::Models::Evals::Runs::OutputItemListResponse::Sample::Output>]
            required :output,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Evals::Runs::OutputItemListResponse::Sample::Output] }

            # @!attribute seed
            #   The seed used for generating the sample.
            #
            #   @return [Integer]
            required :seed, Integer

            # @!attribute temperature
            #   The sampling temperature used.
            #
            #   @return [Float]
            required :temperature, Float

            # @!attribute top_p
            #   The top_p value used for sampling.
            #
            #   @return [Float]
            required :top_p, Float

            # @!attribute usage
            #   Token usage details for the sample.
            #
            #   @return [OpenAI::Models::Evals::Runs::OutputItemListResponse::Sample::Usage]
            required :usage, -> { OpenAI::Models::Evals::Runs::OutputItemListResponse::Sample::Usage }

            # @!method initialize(error:, finish_reason:, input:, max_completion_tokens:, model:, output:, seed:, temperature:, top_p:, usage:)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Evals::Runs::OutputItemListResponse::Sample} for more details.
            #
            #   A sample containing the input and output of the evaluation run.
            #
            #   @param error [OpenAI::Evals::EvalAPIError] An object representing an error response from the Eval API.
            #
            #   @param finish_reason [String] The reason why the sample generation was finished.
            #
            #   @param input [Array<OpenAI::Models::Evals::Runs::OutputItemListResponse::Sample::Input>] An array of input messages.
            #
            #   @param max_completion_tokens [Integer] The maximum number of tokens allowed for completion.
            #
            #   @param model [String] The model used for generating the sample.
            #
            #   @param output [Array<OpenAI::Models::Evals::Runs::OutputItemListResponse::Sample::Output>] An array of output messages.
            #
            #   @param seed [Integer] The seed used for generating the sample.
            #
            #   @param temperature [Float] The sampling temperature used.
            #
            #   @param top_p [Float] The top_p value used for sampling.
            #
            #   @param usage [OpenAI::Models::Evals::Runs::OutputItemListResponse::Sample::Usage] Token usage details for the sample.

            class Input < OpenAI::Internal::Type::BaseModel
              # @!attribute content
              #   The content of the message.
              #
              #   @return [String]
              required :content, String

              # @!attribute role
              #   The role of the message sender (e.g., system, user, developer).
              #
              #   @return [String]
              required :role, String

              # @!method initialize(content:, role:)
              #   An input message.
              #
              #   @param content [String] The content of the message.
              #
              #   @param role [String] The role of the message sender (e.g., system, user, developer).
            end

            class Output < OpenAI::Internal::Type::BaseModel
              # @!attribute content
              #   The content of the message.
              #
              #   @return [String, nil]
              optional :content, String

              # @!attribute role
              #   The role of the message (e.g. "system", "assistant", "user").
              #
              #   @return [String, nil]
              optional :role, String

              # @!method initialize(content: nil, role: nil)
              #   @param content [String] The content of the message.
              #
              #   @param role [String] The role of the message (e.g. "system", "assistant", "user").
            end

            # @see OpenAI::Models::Evals::Runs::OutputItemListResponse::Sample#usage
            class Usage < OpenAI::Internal::Type::BaseModel
              # @!attribute cached_tokens
              #   The number of tokens retrieved from cache.
              #
              #   @return [Integer]
              required :cached_tokens, Integer

              # @!attribute completion_tokens
              #   The number of completion tokens generated.
              #
              #   @return [Integer]
              required :completion_tokens, Integer

              # @!attribute prompt_tokens
              #   The number of prompt tokens used.
              #
              #   @return [Integer]
              required :prompt_tokens, Integer

              # @!attribute total_tokens
              #   The total number of tokens used.
              #
              #   @return [Integer]
              required :total_tokens, Integer

              # @!method initialize(cached_tokens:, completion_tokens:, prompt_tokens:, total_tokens:)
              #   Token usage details for the sample.
              #
              #   @param cached_tokens [Integer] The number of tokens retrieved from cache.
              #
              #   @param completion_tokens [Integer] The number of completion tokens generated.
              #
              #   @param prompt_tokens [Integer] The number of prompt tokens used.
              #
              #   @param total_tokens [Integer] The total number of tokens used.
            end
          end
        end
      end
    end
  end
end
