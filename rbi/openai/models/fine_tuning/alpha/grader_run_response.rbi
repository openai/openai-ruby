# typed: strong

module OpenAI
  module Models
    module FineTuning
      module Alpha
        class GraderRunResponse < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          sig do
            returns(
              OpenAI::Models::FineTuning::Alpha::GraderRunResponse::Metadata
            )
          end
          attr_reader :metadata

          sig do
            params(
              metadata:
                OpenAI::Models::FineTuning::Alpha::GraderRunResponse::Metadata::OrHash
            ).void
          end
          attr_writer :metadata

          sig { returns(T::Hash[Symbol, T.anything]) }
          attr_accessor :model_grader_token_usage_per_model

          sig { returns(Float) }
          attr_accessor :reward

          sig { returns(T::Hash[Symbol, T.anything]) }
          attr_accessor :sub_rewards

          sig do
            params(
              metadata:
                OpenAI::Models::FineTuning::Alpha::GraderRunResponse::Metadata::OrHash,
              model_grader_token_usage_per_model: T::Hash[Symbol, T.anything],
              reward: Float,
              sub_rewards: T::Hash[Symbol, T.anything]
            ).returns(T.attached_class)
          end
          def self.new(
            metadata:,
            model_grader_token_usage_per_model:,
            reward:,
            sub_rewards:
          )
          end

          sig do
            override.returns(
              {
                metadata:
                  OpenAI::Models::FineTuning::Alpha::GraderRunResponse::Metadata,
                model_grader_token_usage_per_model: T::Hash[Symbol, T.anything],
                reward: Float,
                sub_rewards: T::Hash[Symbol, T.anything]
              }
            )
          end
          def to_hash
          end

          class Metadata < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

            sig do
              returns(
                OpenAI::Models::FineTuning::Alpha::GraderRunResponse::Metadata::Errors
              )
            end
            attr_reader :errors

            sig do
              params(
                errors:
                  OpenAI::Models::FineTuning::Alpha::GraderRunResponse::Metadata::Errors::OrHash
              ).void
            end
            attr_writer :errors

            sig { returns(Float) }
            attr_accessor :execution_time

            sig { returns(String) }
            attr_accessor :name

            sig { returns(T.nilable(String)) }
            attr_accessor :sampled_model_name

            sig { returns(T::Hash[Symbol, T.anything]) }
            attr_accessor :scores

            sig { returns(T.nilable(Integer)) }
            attr_accessor :token_usage

            sig { returns(String) }
            attr_accessor :type

            sig do
              params(
                errors:
                  OpenAI::Models::FineTuning::Alpha::GraderRunResponse::Metadata::Errors::OrHash,
                execution_time: Float,
                name: String,
                sampled_model_name: T.nilable(String),
                scores: T::Hash[Symbol, T.anything],
                token_usage: T.nilable(Integer),
                type: String
              ).returns(T.attached_class)
            end
            def self.new(
              errors:,
              execution_time:,
              name:,
              sampled_model_name:,
              scores:,
              token_usage:,
              type:
            )
            end

            sig do
              override.returns(
                {
                  errors:
                    OpenAI::Models::FineTuning::Alpha::GraderRunResponse::Metadata::Errors,
                  execution_time: Float,
                  name: String,
                  sampled_model_name: T.nilable(String),
                  scores: T::Hash[Symbol, T.anything],
                  token_usage: T.nilable(Integer),
                  type: String
                }
              )
            end
            def to_hash
            end

            class Errors < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

              sig { returns(T::Boolean) }
              attr_accessor :formula_parse_error

              sig { returns(T::Boolean) }
              attr_accessor :invalid_variable_error

              sig { returns(T::Boolean) }
              attr_accessor :model_grader_parse_error

              sig { returns(T::Boolean) }
              attr_accessor :model_grader_refusal_error

              sig { returns(T::Boolean) }
              attr_accessor :model_grader_server_error

              sig { returns(T.nilable(String)) }
              attr_accessor :model_grader_server_error_details

              sig { returns(T::Boolean) }
              attr_accessor :other_error

              sig { returns(T::Boolean) }
              attr_accessor :python_grader_runtime_error

              sig { returns(T.nilable(String)) }
              attr_accessor :python_grader_runtime_error_details

              sig { returns(T::Boolean) }
              attr_accessor :python_grader_server_error

              sig { returns(T.nilable(String)) }
              attr_accessor :python_grader_server_error_type

              sig { returns(T::Boolean) }
              attr_accessor :sample_parse_error

              sig { returns(T::Boolean) }
              attr_accessor :truncated_observation_error

              sig { returns(T::Boolean) }
              attr_accessor :unresponsive_reward_error

              sig do
                params(
                  formula_parse_error: T::Boolean,
                  invalid_variable_error: T::Boolean,
                  model_grader_parse_error: T::Boolean,
                  model_grader_refusal_error: T::Boolean,
                  model_grader_server_error: T::Boolean,
                  model_grader_server_error_details: T.nilable(String),
                  other_error: T::Boolean,
                  python_grader_runtime_error: T::Boolean,
                  python_grader_runtime_error_details: T.nilable(String),
                  python_grader_server_error: T::Boolean,
                  python_grader_server_error_type: T.nilable(String),
                  sample_parse_error: T::Boolean,
                  truncated_observation_error: T::Boolean,
                  unresponsive_reward_error: T::Boolean
                ).returns(T.attached_class)
              end
              def self.new(
                formula_parse_error:,
                invalid_variable_error:,
                model_grader_parse_error:,
                model_grader_refusal_error:,
                model_grader_server_error:,
                model_grader_server_error_details:,
                other_error:,
                python_grader_runtime_error:,
                python_grader_runtime_error_details:,
                python_grader_server_error:,
                python_grader_server_error_type:,
                sample_parse_error:,
                truncated_observation_error:,
                unresponsive_reward_error:
              )
              end

              sig do
                override.returns(
                  {
                    formula_parse_error: T::Boolean,
                    invalid_variable_error: T::Boolean,
                    model_grader_parse_error: T::Boolean,
                    model_grader_refusal_error: T::Boolean,
                    model_grader_server_error: T::Boolean,
                    model_grader_server_error_details: T.nilable(String),
                    other_error: T::Boolean,
                    python_grader_runtime_error: T::Boolean,
                    python_grader_runtime_error_details: T.nilable(String),
                    python_grader_server_error: T::Boolean,
                    python_grader_server_error_type: T.nilable(String),
                    sample_parse_error: T::Boolean,
                    truncated_observation_error: T::Boolean,
                    unresponsive_reward_error: T::Boolean
                  }
                )
              end
              def to_hash
              end
            end
          end
        end
      end
    end
  end
end
