# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      module Alpha
        # @see OpenAI::Resources::FineTuning::Alpha::Graders#run
        class GraderRunResponse < OpenAI::Internal::Type::BaseModel
          # @!attribute metadata
          #
          #   @return [OpenAI::Models::FineTuning::Alpha::GraderRunResponse::Metadata]
          required :metadata, -> { OpenAI::Models::FineTuning::Alpha::GraderRunResponse::Metadata }

          # @!attribute model_grader_token_usage_per_model
          #
          #   @return [Hash{Symbol=>Object}]
          required :model_grader_token_usage_per_model,
                   OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

          # @!attribute reward
          #
          #   @return [Float]
          required :reward, Float

          # @!attribute sub_rewards
          #
          #   @return [Hash{Symbol=>Object}]
          required :sub_rewards, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

          # @!method initialize(metadata:, model_grader_token_usage_per_model:, reward:, sub_rewards:)
          #   @param metadata [OpenAI::Models::FineTuning::Alpha::GraderRunResponse::Metadata]
          #   @param model_grader_token_usage_per_model [Hash{Symbol=>Object}]
          #   @param reward [Float]
          #   @param sub_rewards [Hash{Symbol=>Object}]

          # @see OpenAI::Models::FineTuning::Alpha::GraderRunResponse#metadata
          class Metadata < OpenAI::Internal::Type::BaseModel
            # @!attribute errors
            #
            #   @return [OpenAI::Models::FineTuning::Alpha::GraderRunResponse::Metadata::Errors]
            required :errors, -> { OpenAI::Models::FineTuning::Alpha::GraderRunResponse::Metadata::Errors }

            # @!attribute execution_time
            #
            #   @return [Float]
            required :execution_time, Float

            # @!attribute name
            #
            #   @return [String]
            required :name, String

            # @!attribute sampled_model_name
            #
            #   @return [String, nil]
            required :sampled_model_name, String, nil?: true

            # @!attribute scores
            #
            #   @return [Hash{Symbol=>Object}]
            required :scores, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

            # @!attribute token_usage
            #
            #   @return [Integer, nil]
            required :token_usage, Integer, nil?: true

            # @!attribute type
            #
            #   @return [String]
            required :type, String

            # @!method initialize(errors:, execution_time:, name:, sampled_model_name:, scores:, token_usage:, type:)
            #   @param errors [OpenAI::Models::FineTuning::Alpha::GraderRunResponse::Metadata::Errors]
            #   @param execution_time [Float]
            #   @param name [String]
            #   @param sampled_model_name [String, nil]
            #   @param scores [Hash{Symbol=>Object}]
            #   @param token_usage [Integer, nil]
            #   @param type [String]

            # @see OpenAI::Models::FineTuning::Alpha::GraderRunResponse::Metadata#errors
            class Errors < OpenAI::Internal::Type::BaseModel
              # @!attribute formula_parse_error
              #
              #   @return [Boolean]
              required :formula_parse_error, OpenAI::Internal::Type::Boolean

              # @!attribute invalid_variable_error
              #
              #   @return [Boolean]
              required :invalid_variable_error, OpenAI::Internal::Type::Boolean

              # @!attribute model_grader_parse_error
              #
              #   @return [Boolean]
              required :model_grader_parse_error, OpenAI::Internal::Type::Boolean

              # @!attribute model_grader_refusal_error
              #
              #   @return [Boolean]
              required :model_grader_refusal_error, OpenAI::Internal::Type::Boolean

              # @!attribute model_grader_server_error
              #
              #   @return [Boolean]
              required :model_grader_server_error, OpenAI::Internal::Type::Boolean

              # @!attribute model_grader_server_error_details
              #
              #   @return [String, nil]
              required :model_grader_server_error_details, String, nil?: true

              # @!attribute other_error
              #
              #   @return [Boolean]
              required :other_error, OpenAI::Internal::Type::Boolean

              # @!attribute python_grader_runtime_error
              #
              #   @return [Boolean]
              required :python_grader_runtime_error, OpenAI::Internal::Type::Boolean

              # @!attribute python_grader_runtime_error_details
              #
              #   @return [String, nil]
              required :python_grader_runtime_error_details, String, nil?: true

              # @!attribute python_grader_server_error
              #
              #   @return [Boolean]
              required :python_grader_server_error, OpenAI::Internal::Type::Boolean

              # @!attribute python_grader_server_error_type
              #
              #   @return [String, nil]
              required :python_grader_server_error_type, String, nil?: true

              # @!attribute sample_parse_error
              #
              #   @return [Boolean]
              required :sample_parse_error, OpenAI::Internal::Type::Boolean

              # @!attribute truncated_observation_error
              #
              #   @return [Boolean]
              required :truncated_observation_error, OpenAI::Internal::Type::Boolean

              # @!attribute unresponsive_reward_error
              #
              #   @return [Boolean]
              required :unresponsive_reward_error, OpenAI::Internal::Type::Boolean

              # @!method initialize(formula_parse_error:, invalid_variable_error:, model_grader_parse_error:, model_grader_refusal_error:, model_grader_server_error:, model_grader_server_error_details:, other_error:, python_grader_runtime_error:, python_grader_runtime_error_details:, python_grader_server_error:, python_grader_server_error_type:, sample_parse_error:, truncated_observation_error:, unresponsive_reward_error:)
              #   @param formula_parse_error [Boolean]
              #   @param invalid_variable_error [Boolean]
              #   @param model_grader_parse_error [Boolean]
              #   @param model_grader_refusal_error [Boolean]
              #   @param model_grader_server_error [Boolean]
              #   @param model_grader_server_error_details [String, nil]
              #   @param other_error [Boolean]
              #   @param python_grader_runtime_error [Boolean]
              #   @param python_grader_runtime_error_details [String, nil]
              #   @param python_grader_server_error [Boolean]
              #   @param python_grader_server_error_type [String, nil]
              #   @param sample_parse_error [Boolean]
              #   @param truncated_observation_error [Boolean]
              #   @param unresponsive_reward_error [Boolean]
            end
          end
        end
      end
    end
  end
end
