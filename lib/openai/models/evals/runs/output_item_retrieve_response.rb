# frozen_string_literal: true

module OpenAI
  module Models
    module Evals
      module Runs
        # @see OpenAI::Resources::Evals::Runs::OutputItems#retrieve
        class OutputItemRetrieveResponse < OpenAI::Internal::Type::BaseModel
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
          #   @return [OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample]
          required :sample, -> { OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample }

          # @!attribute status
          #   The status of the evaluation run.
          #
          #   @return [String]
          required :status, String

          # @!method initialize(id:, created_at:, datasource_item:, datasource_item_id:, eval_id:, results:, run_id:, sample:, status:, object: :"eval.run.output_item")
          #   A schema representing an evaluation run output item.
          #
          #   @param id [String]
          #   @param created_at [Integer]
          #   @param datasource_item [Hash{Symbol=>Object}]
          #   @param datasource_item_id [Integer]
          #   @param eval_id [String]
          #   @param results [Array<Hash{Symbol=>Object}>]
          #   @param run_id [String]
          #   @param sample [OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample]
          #   @param status [String]
          #   @param object [Symbol, :"eval.run.output_item"]

          # @see OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse#sample
          class Sample < OpenAI::Internal::Type::BaseModel
            # @!attribute error
            #   An object representing an error response from the Eval API.
            #
            #   @return [OpenAI::Models::Evals::EvalAPIError]
            required :error, -> { OpenAI::Models::Evals::EvalAPIError }

            # @!attribute finish_reason
            #   The reason why the sample generation was finished.
            #
            #   @return [String]
            required :finish_reason, String

            # @!attribute input
            #   An array of input messages.
            #
            #   @return [Array<OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample::Input>]
            required :input,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample::Input] }

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
            #   @return [Array<OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample::Output>]
            required :output,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample::Output] }

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
            #   @return [OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample::Usage]
            required :usage, -> { OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample::Usage }

            # @!method initialize(error:, finish_reason:, input:, max_completion_tokens:, model:, output:, seed:, temperature:, top_p:, usage:)
            #   A sample containing the input and output of the evaluation run.
            #
            #   @param error [OpenAI::Models::Evals::EvalAPIError]
            #   @param finish_reason [String]
            #   @param input [Array<OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample::Input>]
            #   @param max_completion_tokens [Integer]
            #   @param model [String]
            #   @param output [Array<OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample::Output>]
            #   @param seed [Integer]
            #   @param temperature [Float]
            #   @param top_p [Float]
            #   @param usage [OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample::Usage]

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
              #   @param content [String]
              #   @param role [String]
            end

            class Output < OpenAI::Internal::Type::BaseModel
              # @!attribute [r] content
              #   The content of the message.
              #
              #   @return [String, nil]
              optional :content, String

              # @!parse
              #   # @return [String]
              #   attr_writer :content

              # @!attribute [r] role
              #   The role of the message (e.g. "system", "assistant", "user").
              #
              #   @return [String, nil]
              optional :role, String

              # @!parse
              #   # @return [String]
              #   attr_writer :role

              # @!method initialize(content: nil, role: nil)
              #   @param content [String]
              #   @param role [String]
            end

            # @see OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample#usage
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
              #   @param cached_tokens [Integer]
              #   @param completion_tokens [Integer]
              #   @param prompt_tokens [Integer]
              #   @param total_tokens [Integer]
            end
          end
        end
      end
    end
  end
end
