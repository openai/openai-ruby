# typed: strong

module OpenAI
  module Models
    module Evals
      module Runs
        class OutputItemRetrieveResponse < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse,
                OpenAI::Internal::AnyHash
              )
            end

          # Unique identifier for the evaluation run output item.
          sig { returns(String) }
          attr_accessor :id

          # Unix timestamp (in seconds) when the evaluation run was created.
          sig { returns(Integer) }
          attr_accessor :created_at

          # Details of the input data source item.
          sig { returns(T::Hash[Symbol, T.anything]) }
          attr_accessor :datasource_item

          # The identifier for the data source item.
          sig { returns(Integer) }
          attr_accessor :datasource_item_id

          # The identifier of the evaluation group.
          sig { returns(String) }
          attr_accessor :eval_id

          # The type of the object. Always "eval.run.output_item".
          sig { returns(Symbol) }
          attr_accessor :object

          # A list of grader results for this output item.
          sig do
            returns(
              T::Array[
                OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Result
              ]
            )
          end
          attr_accessor :results

          # The identifier of the evaluation run associated with this output item.
          sig { returns(String) }
          attr_accessor :run_id

          # A sample containing the input and output of the evaluation run.
          sig do
            returns(
              OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample
            )
          end
          attr_reader :sample

          sig do
            params(
              sample:
                OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample::OrHash
            ).void
          end
          attr_writer :sample

          # The status of the evaluation run.
          sig { returns(String) }
          attr_accessor :status

          # A schema representing an evaluation run output item.
          sig do
            params(
              id: String,
              created_at: Integer,
              datasource_item: T::Hash[Symbol, T.anything],
              datasource_item_id: Integer,
              eval_id: String,
              results:
                T::Array[
                  OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Result::OrHash
                ],
              run_id: String,
              sample:
                OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample::OrHash,
              status: String,
              object: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Unique identifier for the evaluation run output item.
            id:,
            # Unix timestamp (in seconds) when the evaluation run was created.
            created_at:,
            # Details of the input data source item.
            datasource_item:,
            # The identifier for the data source item.
            datasource_item_id:,
            # The identifier of the evaluation group.
            eval_id:,
            # A list of grader results for this output item.
            results:,
            # The identifier of the evaluation run associated with this output item.
            run_id:,
            # A sample containing the input and output of the evaluation run.
            sample:,
            # The status of the evaluation run.
            status:,
            # The type of the object. Always "eval.run.output_item".
            object: :"eval.run.output_item"
          )
          end

          sig do
            override.returns(
              {
                id: String,
                created_at: Integer,
                datasource_item: T::Hash[Symbol, T.anything],
                datasource_item_id: Integer,
                eval_id: String,
                object: Symbol,
                results:
                  T::Array[
                    OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Result
                  ],
                run_id: String,
                sample:
                  OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample,
                status: String
              }
            )
          end
          def to_hash
          end

          class Result < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Result,
                  OpenAI::Internal::AnyHash
                )
              end

            # The name of the grader.
            sig { returns(String) }
            attr_accessor :name

            # Whether the grader considered the output a pass.
            sig { returns(T::Boolean) }
            attr_accessor :passed

            # The numeric score produced by the grader.
            sig { returns(Float) }
            attr_accessor :score

            # Optional sample or intermediate data produced by the grader.
            sig { returns(T.nilable(T::Hash[Symbol, T.anything])) }
            attr_accessor :sample

            # The grader type (for example, "string-check-grader").
            sig { returns(T.nilable(String)) }
            attr_reader :type

            sig { params(type: String).void }
            attr_writer :type

            # A single grader result for an evaluation run output item.
            sig do
              params(
                name: String,
                passed: T::Boolean,
                score: Float,
                sample: T.nilable(T::Hash[Symbol, T.anything]),
                type: String
              ).returns(T.attached_class)
            end
            def self.new(
              # The name of the grader.
              name:,
              # Whether the grader considered the output a pass.
              passed:,
              # The numeric score produced by the grader.
              score:,
              # Optional sample or intermediate data produced by the grader.
              sample: nil,
              # The grader type (for example, "string-check-grader").
              type: nil
            )
            end

            sig do
              override.returns(
                {
                  name: String,
                  passed: T::Boolean,
                  score: Float,
                  sample: T.nilable(T::Hash[Symbol, T.anything]),
                  type: String
                }
              )
            end
            def to_hash
            end
          end

          class Sample < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample,
                  OpenAI::Internal::AnyHash
                )
              end

            # An object representing an error response from the Eval API.
            sig { returns(OpenAI::Evals::EvalAPIError) }
            attr_reader :error

            sig { params(error: OpenAI::Evals::EvalAPIError::OrHash).void }
            attr_writer :error

            # The reason why the sample generation was finished.
            sig { returns(String) }
            attr_accessor :finish_reason

            # An array of input messages.
            sig do
              returns(
                T::Array[
                  OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample::Input
                ]
              )
            end
            attr_accessor :input

            # The maximum number of tokens allowed for completion.
            sig { returns(Integer) }
            attr_accessor :max_completion_tokens

            # The model used for generating the sample.
            sig { returns(String) }
            attr_accessor :model

            # An array of output messages.
            sig do
              returns(
                T::Array[
                  OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample::Output
                ]
              )
            end
            attr_accessor :output

            # The seed used for generating the sample.
            sig { returns(Integer) }
            attr_accessor :seed

            # The sampling temperature used.
            sig { returns(Float) }
            attr_accessor :temperature

            # The top_p value used for sampling.
            sig { returns(Float) }
            attr_accessor :top_p

            # Token usage details for the sample.
            sig do
              returns(
                OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample::Usage
              )
            end
            attr_reader :usage

            sig do
              params(
                usage:
                  OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample::Usage::OrHash
              ).void
            end
            attr_writer :usage

            # A sample containing the input and output of the evaluation run.
            sig do
              params(
                error: OpenAI::Evals::EvalAPIError::OrHash,
                finish_reason: String,
                input:
                  T::Array[
                    OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample::Input::OrHash
                  ],
                max_completion_tokens: Integer,
                model: String,
                output:
                  T::Array[
                    OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample::Output::OrHash
                  ],
                seed: Integer,
                temperature: Float,
                top_p: Float,
                usage:
                  OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample::Usage::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              # An object representing an error response from the Eval API.
              error:,
              # The reason why the sample generation was finished.
              finish_reason:,
              # An array of input messages.
              input:,
              # The maximum number of tokens allowed for completion.
              max_completion_tokens:,
              # The model used for generating the sample.
              model:,
              # An array of output messages.
              output:,
              # The seed used for generating the sample.
              seed:,
              # The sampling temperature used.
              temperature:,
              # The top_p value used for sampling.
              top_p:,
              # Token usage details for the sample.
              usage:
            )
            end

            sig do
              override.returns(
                {
                  error: OpenAI::Evals::EvalAPIError,
                  finish_reason: String,
                  input:
                    T::Array[
                      OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample::Input
                    ],
                  max_completion_tokens: Integer,
                  model: String,
                  output:
                    T::Array[
                      OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample::Output
                    ],
                  seed: Integer,
                  temperature: Float,
                  top_p: Float,
                  usage:
                    OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample::Usage
                }
              )
            end
            def to_hash
            end

            class Input < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample::Input,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The content of the message.
              sig { returns(String) }
              attr_accessor :content

              # The role of the message sender (e.g., system, user, developer).
              sig { returns(String) }
              attr_accessor :role

              # An input message.
              sig do
                params(content: String, role: String).returns(T.attached_class)
              end
              def self.new(
                # The content of the message.
                content:,
                # The role of the message sender (e.g., system, user, developer).
                role:
              )
              end

              sig { override.returns({ content: String, role: String }) }
              def to_hash
              end
            end

            class Output < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample::Output,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The content of the message.
              sig { returns(T.nilable(String)) }
              attr_reader :content

              sig { params(content: String).void }
              attr_writer :content

              # The role of the message (e.g. "system", "assistant", "user").
              sig { returns(T.nilable(String)) }
              attr_reader :role

              sig { params(role: String).void }
              attr_writer :role

              sig do
                params(content: String, role: String).returns(T.attached_class)
              end
              def self.new(
                # The content of the message.
                content: nil,
                # The role of the message (e.g. "system", "assistant", "user").
                role: nil
              )
              end

              sig { override.returns({ content: String, role: String }) }
              def to_hash
              end
            end

            class Usage < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Evals::Runs::OutputItemRetrieveResponse::Sample::Usage,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The number of tokens retrieved from cache.
              sig { returns(Integer) }
              attr_accessor :cached_tokens

              # The number of completion tokens generated.
              sig { returns(Integer) }
              attr_accessor :completion_tokens

              # The number of prompt tokens used.
              sig { returns(Integer) }
              attr_accessor :prompt_tokens

              # The total number of tokens used.
              sig { returns(Integer) }
              attr_accessor :total_tokens

              # Token usage details for the sample.
              sig do
                params(
                  cached_tokens: Integer,
                  completion_tokens: Integer,
                  prompt_tokens: Integer,
                  total_tokens: Integer
                ).returns(T.attached_class)
              end
              def self.new(
                # The number of tokens retrieved from cache.
                cached_tokens:,
                # The number of completion tokens generated.
                completion_tokens:,
                # The number of prompt tokens used.
                prompt_tokens:,
                # The total number of tokens used.
                total_tokens:
              )
              end

              sig do
                override.returns(
                  {
                    cached_tokens: Integer,
                    completion_tokens: Integer,
                    prompt_tokens: Integer,
                    total_tokens: Integer
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
