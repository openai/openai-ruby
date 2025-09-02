# typed: strong

module OpenAI
  module Models
    module Evals
      class RunRetrieveResponse < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Models::Evals::RunRetrieveResponse,
              OpenAI::Internal::AnyHash
            )
          end

        # Unique identifier for the evaluation run.
        sig { returns(String) }
        attr_accessor :id

        # Unix timestamp (in seconds) when the evaluation run was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        # Information about the run's data source.
        sig do
          returns(
            OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Variants
          )
        end
        attr_accessor :data_source

        # An object representing an error response from the Eval API.
        sig { returns(OpenAI::Evals::EvalAPIError) }
        attr_reader :error

        sig { params(error: OpenAI::Evals::EvalAPIError::OrHash).void }
        attr_writer :error

        # The identifier of the associated evaluation.
        sig { returns(String) }
        attr_accessor :eval_id

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard.
        #
        # Keys are strings with a maximum length of 64 characters. Values are strings with
        # a maximum length of 512 characters.
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        attr_accessor :metadata

        # The model that is evaluated, if applicable.
        sig { returns(String) }
        attr_accessor :model

        # The name of the evaluation run.
        sig { returns(String) }
        attr_accessor :name

        # The type of the object. Always "eval.run".
        sig { returns(Symbol) }
        attr_accessor :object

        # Usage statistics for each model during the evaluation run.
        sig do
          returns(
            T::Array[OpenAI::Models::Evals::RunRetrieveResponse::PerModelUsage]
          )
        end
        attr_accessor :per_model_usage

        # Results per testing criteria applied during the evaluation run.
        sig do
          returns(
            T::Array[
              OpenAI::Models::Evals::RunRetrieveResponse::PerTestingCriteriaResult
            ]
          )
        end
        attr_accessor :per_testing_criteria_results

        # The URL to the rendered evaluation run report on the UI dashboard.
        sig { returns(String) }
        attr_accessor :report_url

        # Counters summarizing the outcomes of the evaluation run.
        sig do
          returns(OpenAI::Models::Evals::RunRetrieveResponse::ResultCounts)
        end
        attr_reader :result_counts

        sig do
          params(
            result_counts:
              OpenAI::Models::Evals::RunRetrieveResponse::ResultCounts::OrHash
          ).void
        end
        attr_writer :result_counts

        # The status of the evaluation run.
        sig { returns(String) }
        attr_accessor :status

        # A schema representing an evaluation run.
        sig do
          params(
            id: String,
            created_at: Integer,
            data_source:
              T.any(
                OpenAI::Evals::CreateEvalJSONLRunDataSource::OrHash,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::OrHash,
                OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::OrHash
              ),
            error: OpenAI::Evals::EvalAPIError::OrHash,
            eval_id: String,
            metadata: T.nilable(T::Hash[Symbol, String]),
            model: String,
            name: String,
            per_model_usage:
              T::Array[
                OpenAI::Models::Evals::RunRetrieveResponse::PerModelUsage::OrHash
              ],
            per_testing_criteria_results:
              T::Array[
                OpenAI::Models::Evals::RunRetrieveResponse::PerTestingCriteriaResult::OrHash
              ],
            report_url: String,
            result_counts:
              OpenAI::Models::Evals::RunRetrieveResponse::ResultCounts::OrHash,
            status: String,
            object: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Unique identifier for the evaluation run.
          id:,
          # Unix timestamp (in seconds) when the evaluation run was created.
          created_at:,
          # Information about the run's data source.
          data_source:,
          # An object representing an error response from the Eval API.
          error:,
          # The identifier of the associated evaluation.
          eval_id:,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard.
          #
          # Keys are strings with a maximum length of 64 characters. Values are strings with
          # a maximum length of 512 characters.
          metadata:,
          # The model that is evaluated, if applicable.
          model:,
          # The name of the evaluation run.
          name:,
          # Usage statistics for each model during the evaluation run.
          per_model_usage:,
          # Results per testing criteria applied during the evaluation run.
          per_testing_criteria_results:,
          # The URL to the rendered evaluation run report on the UI dashboard.
          report_url:,
          # Counters summarizing the outcomes of the evaluation run.
          result_counts:,
          # The status of the evaluation run.
          status:,
          # The type of the object. Always "eval.run".
          object: :"eval.run"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              data_source:
                OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Variants,
              error: OpenAI::Evals::EvalAPIError,
              eval_id: String,
              metadata: T.nilable(T::Hash[Symbol, String]),
              model: String,
              name: String,
              object: Symbol,
              per_model_usage:
                T::Array[
                  OpenAI::Models::Evals::RunRetrieveResponse::PerModelUsage
                ],
              per_testing_criteria_results:
                T::Array[
                  OpenAI::Models::Evals::RunRetrieveResponse::PerTestingCriteriaResult
                ],
              report_url: String,
              result_counts:
                OpenAI::Models::Evals::RunRetrieveResponse::ResultCounts,
              status: String
            }
          )
        end
        def to_hash
        end

        # Information about the run's data source.
        module DataSource
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Evals::CreateEvalJSONLRunDataSource,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource,
                OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses
              )
            end

          class Responses < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses,
                  OpenAI::Internal::AnyHash
                )
              end

            # Determines what populates the `item` namespace in this run's data source.
            sig do
              returns(
                OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::Source::Variants
              )
            end
            attr_accessor :source

            # The type of run data source. Always `responses`.
            sig { returns(Symbol) }
            attr_accessor :type

            # Used when sampling from a model. Dictates the structure of the messages passed
            # into the model. Can either be a reference to a prebuilt trajectory (ie,
            # `item.input_trajectory`), or a template with variable references to the `item`
            # namespace.
            sig do
              returns(
                T.nilable(
                  OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Variants
                )
              )
            end
            attr_reader :input_messages

            sig do
              params(
                input_messages:
                  T.any(
                    OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::OrHash,
                    OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::ItemReference::OrHash
                  )
              ).void
            end
            attr_writer :input_messages

            # The name of the model to use for generating completions (e.g. "o3-mini").
            sig { returns(T.nilable(String)) }
            attr_reader :model

            sig { params(model: String).void }
            attr_writer :model

            sig do
              returns(
                T.nilable(
                  OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::SamplingParams
                )
              )
            end
            attr_reader :sampling_params

            sig do
              params(
                sampling_params:
                  OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::SamplingParams::OrHash
              ).void
            end
            attr_writer :sampling_params

            # A ResponsesRunDataSource object describing a model sampling configuration.
            sig do
              params(
                source:
                  T.any(
                    OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::Source::FileContent::OrHash,
                    OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::Source::FileID::OrHash,
                    OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::Source::Responses::OrHash
                  ),
                input_messages:
                  T.any(
                    OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::OrHash,
                    OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::ItemReference::OrHash
                  ),
                model: String,
                sampling_params:
                  OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::SamplingParams::OrHash,
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # Determines what populates the `item` namespace in this run's data source.
              source:,
              # Used when sampling from a model. Dictates the structure of the messages passed
              # into the model. Can either be a reference to a prebuilt trajectory (ie,
              # `item.input_trajectory`), or a template with variable references to the `item`
              # namespace.
              input_messages: nil,
              # The name of the model to use for generating completions (e.g. "o3-mini").
              model: nil,
              sampling_params: nil,
              # The type of run data source. Always `responses`.
              type: :responses
            )
            end

            sig do
              override.returns(
                {
                  source:
                    OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::Source::Variants,
                  type: Symbol,
                  input_messages:
                    OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Variants,
                  model: String,
                  sampling_params:
                    OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::SamplingParams
                }
              )
            end
            def to_hash
            end

            # Determines what populates the `item` namespace in this run's data source.
            module Source
              extend OpenAI::Internal::Type::Union

              Variants =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::Source::FileContent,
                    OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::Source::FileID,
                    OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::Source::Responses
                  )
                end

              class FileContent < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::Source::FileContent,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # The content of the jsonl file.
                sig do
                  returns(
                    T::Array[
                      OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::Source::FileContent::Content
                    ]
                  )
                end
                attr_accessor :content

                # The type of jsonl source. Always `file_content`.
                sig { returns(Symbol) }
                attr_accessor :type

                sig do
                  params(
                    content:
                      T::Array[
                        OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::Source::FileContent::Content::OrHash
                      ],
                    type: Symbol
                  ).returns(T.attached_class)
                end
                def self.new(
                  # The content of the jsonl file.
                  content:,
                  # The type of jsonl source. Always `file_content`.
                  type: :file_content
                )
                end

                sig do
                  override.returns(
                    {
                      content:
                        T::Array[
                          OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::Source::FileContent::Content
                        ],
                      type: Symbol
                    }
                  )
                end
                def to_hash
                end

                class Content < OpenAI::Internal::Type::BaseModel
                  OrHash =
                    T.type_alias do
                      T.any(
                        OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::Source::FileContent::Content,
                        OpenAI::Internal::AnyHash
                      )
                    end

                  sig { returns(T::Hash[Symbol, T.anything]) }
                  attr_accessor :item

                  sig { returns(T.nilable(T::Hash[Symbol, T.anything])) }
                  attr_reader :sample

                  sig { params(sample: T::Hash[Symbol, T.anything]).void }
                  attr_writer :sample

                  sig do
                    params(
                      item: T::Hash[Symbol, T.anything],
                      sample: T::Hash[Symbol, T.anything]
                    ).returns(T.attached_class)
                  end
                  def self.new(item:, sample: nil)
                  end

                  sig do
                    override.returns(
                      {
                        item: T::Hash[Symbol, T.anything],
                        sample: T::Hash[Symbol, T.anything]
                      }
                    )
                  end
                  def to_hash
                  end
                end
              end

              class FileID < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::Source::FileID,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # The identifier of the file.
                sig { returns(String) }
                attr_accessor :id

                # The type of jsonl source. Always `file_id`.
                sig { returns(Symbol) }
                attr_accessor :type

                sig do
                  params(id: String, type: Symbol).returns(T.attached_class)
                end
                def self.new(
                  # The identifier of the file.
                  id:,
                  # The type of jsonl source. Always `file_id`.
                  type: :file_id
                )
                end

                sig { override.returns({ id: String, type: Symbol }) }
                def to_hash
                end
              end

              class Responses < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::Source::Responses,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # The type of run data source. Always `responses`.
                sig { returns(Symbol) }
                attr_accessor :type

                # Only include items created after this timestamp (inclusive). This is a query
                # parameter used to select responses.
                sig { returns(T.nilable(Integer)) }
                attr_accessor :created_after

                # Only include items created before this timestamp (inclusive). This is a query
                # parameter used to select responses.
                sig { returns(T.nilable(Integer)) }
                attr_accessor :created_before

                # Optional string to search the 'instructions' field. This is a query parameter
                # used to select responses.
                sig { returns(T.nilable(String)) }
                attr_accessor :instructions_search

                # Metadata filter for the responses. This is a query parameter used to select
                # responses.
                sig { returns(T.nilable(T.anything)) }
                attr_accessor :metadata

                # The name of the model to find responses for. This is a query parameter used to
                # select responses.
                sig { returns(T.nilable(String)) }
                attr_accessor :model

                # Optional reasoning effort parameter. This is a query parameter used to select
                # responses.
                sig do
                  returns(T.nilable(OpenAI::ReasoningEffort::TaggedSymbol))
                end
                attr_accessor :reasoning_effort

                # Sampling temperature. This is a query parameter used to select responses.
                sig { returns(T.nilable(Float)) }
                attr_accessor :temperature

                # List of tool names. This is a query parameter used to select responses.
                sig { returns(T.nilable(T::Array[String])) }
                attr_accessor :tools

                # Nucleus sampling parameter. This is a query parameter used to select responses.
                sig { returns(T.nilable(Float)) }
                attr_accessor :top_p

                # List of user identifiers. This is a query parameter used to select responses.
                sig { returns(T.nilable(T::Array[String])) }
                attr_accessor :users

                # A EvalResponsesSource object describing a run data source configuration.
                sig do
                  params(
                    created_after: T.nilable(Integer),
                    created_before: T.nilable(Integer),
                    instructions_search: T.nilable(String),
                    metadata: T.nilable(T.anything),
                    model: T.nilable(String),
                    reasoning_effort:
                      T.nilable(OpenAI::ReasoningEffort::OrSymbol),
                    temperature: T.nilable(Float),
                    tools: T.nilable(T::Array[String]),
                    top_p: T.nilable(Float),
                    users: T.nilable(T::Array[String]),
                    type: Symbol
                  ).returns(T.attached_class)
                end
                def self.new(
                  # Only include items created after this timestamp (inclusive). This is a query
                  # parameter used to select responses.
                  created_after: nil,
                  # Only include items created before this timestamp (inclusive). This is a query
                  # parameter used to select responses.
                  created_before: nil,
                  # Optional string to search the 'instructions' field. This is a query parameter
                  # used to select responses.
                  instructions_search: nil,
                  # Metadata filter for the responses. This is a query parameter used to select
                  # responses.
                  metadata: nil,
                  # The name of the model to find responses for. This is a query parameter used to
                  # select responses.
                  model: nil,
                  # Optional reasoning effort parameter. This is a query parameter used to select
                  # responses.
                  reasoning_effort: nil,
                  # Sampling temperature. This is a query parameter used to select responses.
                  temperature: nil,
                  # List of tool names. This is a query parameter used to select responses.
                  tools: nil,
                  # Nucleus sampling parameter. This is a query parameter used to select responses.
                  top_p: nil,
                  # List of user identifiers. This is a query parameter used to select responses.
                  users: nil,
                  # The type of run data source. Always `responses`.
                  type: :responses
                )
                end

                sig do
                  override.returns(
                    {
                      type: Symbol,
                      created_after: T.nilable(Integer),
                      created_before: T.nilable(Integer),
                      instructions_search: T.nilable(String),
                      metadata: T.nilable(T.anything),
                      model: T.nilable(String),
                      reasoning_effort:
                        T.nilable(OpenAI::ReasoningEffort::TaggedSymbol),
                      temperature: T.nilable(Float),
                      tools: T.nilable(T::Array[String]),
                      top_p: T.nilable(Float),
                      users: T.nilable(T::Array[String])
                    }
                  )
                end
                def to_hash
                end
              end

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::Source::Variants
                  ]
                )
              end
              def self.variants
              end
            end

            # Used when sampling from a model. Dictates the structure of the messages passed
            # into the model. Can either be a reference to a prebuilt trajectory (ie,
            # `item.input_trajectory`), or a template with variable references to the `item`
            # namespace.
            module InputMessages
              extend OpenAI::Internal::Type::Union

              Variants =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template,
                    OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::ItemReference
                  )
                end

              class Template < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # A list of chat messages forming the prompt or context. May include variable
                # references to the `item` namespace, ie {{item.name}}.
                sig do
                  returns(
                    T::Array[
                      OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::Variants
                    ]
                  )
                end
                attr_accessor :template

                # The type of input messages. Always `template`.
                sig { returns(Symbol) }
                attr_accessor :type

                sig do
                  params(
                    template:
                      T::Array[
                        T.any(
                          OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::ChatMessage::OrHash,
                          OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem::OrHash
                        )
                      ],
                    type: Symbol
                  ).returns(T.attached_class)
                end
                def self.new(
                  # A list of chat messages forming the prompt or context. May include variable
                  # references to the `item` namespace, ie {{item.name}}.
                  template:,
                  # The type of input messages. Always `template`.
                  type: :template
                )
                end

                sig do
                  override.returns(
                    {
                      template:
                        T::Array[
                          OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::Variants
                        ],
                      type: Symbol
                    }
                  )
                end
                def to_hash
                end

                # A message input to the model with a role indicating instruction following
                # hierarchy. Instructions given with the `developer` or `system` role take
                # precedence over instructions given with the `user` role. Messages with the
                # `assistant` role are presumed to have been generated by the model in previous
                # interactions.
                module Template
                  extend OpenAI::Internal::Type::Union

                  Variants =
                    T.type_alias do
                      T.any(
                        OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::ChatMessage,
                        OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem
                      )
                    end

                  class ChatMessage < OpenAI::Internal::Type::BaseModel
                    OrHash =
                      T.type_alias do
                        T.any(
                          OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::ChatMessage,
                          OpenAI::Internal::AnyHash
                        )
                      end

                    # The content of the message.
                    sig { returns(String) }
                    attr_accessor :content

                    # The role of the message (e.g. "system", "assistant", "user").
                    sig { returns(String) }
                    attr_accessor :role

                    sig do
                      params(content: String, role: String).returns(
                        T.attached_class
                      )
                    end
                    def self.new(
                      # The content of the message.
                      content:,
                      # The role of the message (e.g. "system", "assistant", "user").
                      role:
                    )
                    end

                    sig { override.returns({ content: String, role: String }) }
                    def to_hash
                    end
                  end

                  class EvalItem < OpenAI::Internal::Type::BaseModel
                    OrHash =
                      T.type_alias do
                        T.any(
                          OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem,
                          OpenAI::Internal::AnyHash
                        )
                      end

                    # Inputs to the model - can contain template strings.
                    sig do
                      returns(
                        OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem::Content::Variants
                      )
                    end
                    attr_accessor :content

                    # The role of the message input. One of `user`, `assistant`, `system`, or
                    # `developer`.
                    sig do
                      returns(
                        OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
                      )
                    end
                    attr_accessor :role

                    # The type of the message input. Always `message`.
                    sig do
                      returns(
                        T.nilable(
                          OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem::Type::TaggedSymbol
                        )
                      )
                    end
                    attr_reader :type

                    sig do
                      params(
                        type:
                          OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem::Type::OrSymbol
                      ).void
                    end
                    attr_writer :type

                    # A message input to the model with a role indicating instruction following
                    # hierarchy. Instructions given with the `developer` or `system` role take
                    # precedence over instructions given with the `user` role. Messages with the
                    # `assistant` role are presumed to have been generated by the model in previous
                    # interactions.
                    sig do
                      params(
                        content:
                          T.any(
                            String,
                            OpenAI::Responses::ResponseInputText::OrHash,
                            OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem::Content::OutputText::OrHash,
                            OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem::Content::InputImage::OrHash,
                            T::Array[T.anything]
                          ),
                        role:
                          OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem::Role::OrSymbol,
                        type:
                          OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem::Type::OrSymbol
                      ).returns(T.attached_class)
                    end
                    def self.new(
                      # Inputs to the model - can contain template strings.
                      content:,
                      # The role of the message input. One of `user`, `assistant`, `system`, or
                      # `developer`.
                      role:,
                      # The type of the message input. Always `message`.
                      type: nil
                    )
                    end

                    sig do
                      override.returns(
                        {
                          content:
                            OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem::Content::Variants,
                          role:
                            OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol,
                          type:
                            OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem::Type::TaggedSymbol
                        }
                      )
                    end
                    def to_hash
                    end

                    # Inputs to the model - can contain template strings.
                    module Content
                      extend OpenAI::Internal::Type::Union

                      Variants =
                        T.type_alias do
                          T.any(
                            String,
                            OpenAI::Responses::ResponseInputText,
                            OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem::Content::OutputText,
                            OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem::Content::InputImage,
                            T::Array[T.anything]
                          )
                        end

                      class OutputText < OpenAI::Internal::Type::BaseModel
                        OrHash =
                          T.type_alias do
                            T.any(
                              OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem::Content::OutputText,
                              OpenAI::Internal::AnyHash
                            )
                          end

                        # The text output from the model.
                        sig { returns(String) }
                        attr_accessor :text

                        # The type of the output text. Always `output_text`.
                        sig { returns(Symbol) }
                        attr_accessor :type

                        # A text output from the model.
                        sig do
                          params(text: String, type: Symbol).returns(
                            T.attached_class
                          )
                        end
                        def self.new(
                          # The text output from the model.
                          text:,
                          # The type of the output text. Always `output_text`.
                          type: :output_text
                        )
                        end

                        sig { override.returns({ text: String, type: Symbol }) }
                        def to_hash
                        end
                      end

                      class InputImage < OpenAI::Internal::Type::BaseModel
                        OrHash =
                          T.type_alias do
                            T.any(
                              OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem::Content::InputImage,
                              OpenAI::Internal::AnyHash
                            )
                          end

                        # The URL of the image input.
                        sig { returns(String) }
                        attr_accessor :image_url

                        # The type of the image input. Always `input_image`.
                        sig { returns(Symbol) }
                        attr_accessor :type

                        # The detail level of the image to be sent to the model. One of `high`, `low`, or
                        # `auto`. Defaults to `auto`.
                        sig { returns(T.nilable(String)) }
                        attr_reader :detail

                        sig { params(detail: String).void }
                        attr_writer :detail

                        # An image input to the model.
                        sig do
                          params(
                            image_url: String,
                            detail: String,
                            type: Symbol
                          ).returns(T.attached_class)
                        end
                        def self.new(
                          # The URL of the image input.
                          image_url:,
                          # The detail level of the image to be sent to the model. One of `high`, `low`, or
                          # `auto`. Defaults to `auto`.
                          detail: nil,
                          # The type of the image input. Always `input_image`.
                          type: :input_image
                        )
                        end

                        sig do
                          override.returns(
                            { image_url: String, type: Symbol, detail: String }
                          )
                        end
                        def to_hash
                        end
                      end

                      sig do
                        override.returns(
                          T::Array[
                            OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem::Content::Variants
                          ]
                        )
                      end
                      def self.variants
                      end

                      AnArrayOfInputTextAndInputImageArray =
                        T.let(
                          OpenAI::Internal::Type::ArrayOf[
                            OpenAI::Internal::Type::Unknown
                          ],
                          OpenAI::Internal::Type::Converter
                        )
                    end

                    # The role of the message input. One of `user`, `assistant`, `system`, or
                    # `developer`.
                    module Role
                      extend OpenAI::Internal::Type::Enum

                      TaggedSymbol =
                        T.type_alias do
                          T.all(
                            Symbol,
                            OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem::Role
                          )
                        end
                      OrSymbol = T.type_alias { T.any(Symbol, String) }

                      USER =
                        T.let(
                          :user,
                          OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
                        )
                      ASSISTANT =
                        T.let(
                          :assistant,
                          OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
                        )
                      SYSTEM =
                        T.let(
                          :system,
                          OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
                        )
                      DEVELOPER =
                        T.let(
                          :developer,
                          OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
                        )

                      sig do
                        override.returns(
                          T::Array[
                            OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
                          ]
                        )
                      end
                      def self.values
                      end
                    end

                    # The type of the message input. Always `message`.
                    module Type
                      extend OpenAI::Internal::Type::Enum

                      TaggedSymbol =
                        T.type_alias do
                          T.all(
                            Symbol,
                            OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem::Type
                          )
                        end
                      OrSymbol = T.type_alias { T.any(Symbol, String) }

                      MESSAGE =
                        T.let(
                          :message,
                          OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem::Type::TaggedSymbol
                        )

                      sig do
                        override.returns(
                          T::Array[
                            OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::EvalItem::Type::TaggedSymbol
                          ]
                        )
                      end
                      def self.values
                      end
                    end
                  end

                  sig do
                    override.returns(
                      T::Array[
                        OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Template::Template::Variants
                      ]
                    )
                  end
                  def self.variants
                  end
                end
              end

              class ItemReference < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::ItemReference,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # A reference to a variable in the `item` namespace. Ie, "item.name"
                sig { returns(String) }
                attr_accessor :item_reference

                # The type of input messages. Always `item_reference`.
                sig { returns(Symbol) }
                attr_accessor :type

                sig do
                  params(item_reference: String, type: Symbol).returns(
                    T.attached_class
                  )
                end
                def self.new(
                  # A reference to a variable in the `item` namespace. Ie, "item.name"
                  item_reference:,
                  # The type of input messages. Always `item_reference`.
                  type: :item_reference
                )
                end

                sig do
                  override.returns({ item_reference: String, type: Symbol })
                end
                def to_hash
                end
              end

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::InputMessages::Variants
                  ]
                )
              end
              def self.variants
              end
            end

            class SamplingParams < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::SamplingParams,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The maximum number of tokens in the generated output.
              sig { returns(T.nilable(Integer)) }
              attr_reader :max_completion_tokens

              sig { params(max_completion_tokens: Integer).void }
              attr_writer :max_completion_tokens

              # A seed value to initialize the randomness, during sampling.
              sig { returns(T.nilable(Integer)) }
              attr_reader :seed

              sig { params(seed: Integer).void }
              attr_writer :seed

              # A higher temperature increases randomness in the outputs.
              sig { returns(T.nilable(Float)) }
              attr_reader :temperature

              sig { params(temperature: Float).void }
              attr_writer :temperature

              # Configuration options for a text response from the model. Can be plain text or
              # structured JSON data. Learn more:
              #
              # - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
              # - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
              sig do
                returns(
                  T.nilable(
                    OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::SamplingParams::Text
                  )
                )
              end
              attr_reader :text

              sig do
                params(
                  text:
                    OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::SamplingParams::Text::OrHash
                ).void
              end
              attr_writer :text

              # An array of tools the model may call while generating a response. You can
              # specify which tool to use by setting the `tool_choice` parameter.
              #
              # The two categories of tools you can provide the model are:
              #
              # - **Built-in tools**: Tools that are provided by OpenAI that extend the model's
              #   capabilities, like
              #   [web search](https://platform.openai.com/docs/guides/tools-web-search) or
              #   [file search](https://platform.openai.com/docs/guides/tools-file-search).
              #   Learn more about
              #   [built-in tools](https://platform.openai.com/docs/guides/tools).
              # - **Function calls (custom tools)**: Functions that are defined by you, enabling
              #   the model to call your own code. Learn more about
              #   [function calling](https://platform.openai.com/docs/guides/function-calling).
              sig do
                returns(T.nilable(T::Array[OpenAI::Responses::Tool::Variants]))
              end
              attr_reader :tools

              sig do
                params(
                  tools:
                    T::Array[
                      T.any(
                        OpenAI::Responses::FunctionTool::OrHash,
                        OpenAI::Responses::FileSearchTool::OrHash,
                        OpenAI::Responses::ComputerTool::OrHash,
                        OpenAI::Responses::Tool::Mcp::OrHash,
                        OpenAI::Responses::Tool::CodeInterpreter::OrHash,
                        OpenAI::Responses::Tool::ImageGeneration::OrHash,
                        OpenAI::Responses::Tool::LocalShell::OrHash,
                        OpenAI::Responses::CustomTool::OrHash,
                        OpenAI::Responses::WebSearchTool::OrHash,
                        OpenAI::Responses::WebSearchPreviewTool::OrHash
                      )
                    ]
                ).void
              end
              attr_writer :tools

              # An alternative to temperature for nucleus sampling; 1.0 includes all tokens.
              sig { returns(T.nilable(Float)) }
              attr_reader :top_p

              sig { params(top_p: Float).void }
              attr_writer :top_p

              sig do
                params(
                  max_completion_tokens: Integer,
                  seed: Integer,
                  temperature: Float,
                  text:
                    OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::SamplingParams::Text::OrHash,
                  tools:
                    T::Array[
                      T.any(
                        OpenAI::Responses::FunctionTool::OrHash,
                        OpenAI::Responses::FileSearchTool::OrHash,
                        OpenAI::Responses::ComputerTool::OrHash,
                        OpenAI::Responses::Tool::Mcp::OrHash,
                        OpenAI::Responses::Tool::CodeInterpreter::OrHash,
                        OpenAI::Responses::Tool::ImageGeneration::OrHash,
                        OpenAI::Responses::Tool::LocalShell::OrHash,
                        OpenAI::Responses::CustomTool::OrHash,
                        OpenAI::Responses::WebSearchTool::OrHash,
                        OpenAI::Responses::WebSearchPreviewTool::OrHash
                      )
                    ],
                  top_p: Float
                ).returns(T.attached_class)
              end
              def self.new(
                # The maximum number of tokens in the generated output.
                max_completion_tokens: nil,
                # A seed value to initialize the randomness, during sampling.
                seed: nil,
                # A higher temperature increases randomness in the outputs.
                temperature: nil,
                # Configuration options for a text response from the model. Can be plain text or
                # structured JSON data. Learn more:
                #
                # - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
                # - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
                text: nil,
                # An array of tools the model may call while generating a response. You can
                # specify which tool to use by setting the `tool_choice` parameter.
                #
                # The two categories of tools you can provide the model are:
                #
                # - **Built-in tools**: Tools that are provided by OpenAI that extend the model's
                #   capabilities, like
                #   [web search](https://platform.openai.com/docs/guides/tools-web-search) or
                #   [file search](https://platform.openai.com/docs/guides/tools-file-search).
                #   Learn more about
                #   [built-in tools](https://platform.openai.com/docs/guides/tools).
                # - **Function calls (custom tools)**: Functions that are defined by you, enabling
                #   the model to call your own code. Learn more about
                #   [function calling](https://platform.openai.com/docs/guides/function-calling).
                tools: nil,
                # An alternative to temperature for nucleus sampling; 1.0 includes all tokens.
                top_p: nil
              )
              end

              sig do
                override.returns(
                  {
                    max_completion_tokens: Integer,
                    seed: Integer,
                    temperature: Float,
                    text:
                      OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::SamplingParams::Text,
                    tools: T::Array[OpenAI::Responses::Tool::Variants],
                    top_p: Float
                  }
                )
              end
              def to_hash
              end

              class Text < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Responses::SamplingParams::Text,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # An object specifying the format that the model must output.
                #
                # Configuring `{ "type": "json_schema" }` enables Structured Outputs, which
                # ensures the model will match your supplied JSON schema. Learn more in the
                # [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
                #
                # The default format is `{ "type": "text" }` with no additional options.
                #
                # **Not recommended for gpt-4o and newer models:**
                #
                # Setting to `{ "type": "json_object" }` enables the older JSON mode, which
                # ensures the message the model generates is valid JSON. Using `json_schema` is
                # preferred for models that support it.
                sig do
                  returns(
                    T.nilable(
                      OpenAI::Responses::ResponseFormatTextConfig::Variants
                    )
                  )
                end
                attr_reader :format_

                sig do
                  params(
                    format_:
                      T.any(
                        OpenAI::ResponseFormatText::OrHash,
                        OpenAI::Responses::ResponseFormatTextJSONSchemaConfig::OrHash,
                        OpenAI::ResponseFormatJSONObject::OrHash
                      )
                  ).void
                end
                attr_writer :format_

                # Configuration options for a text response from the model. Can be plain text or
                # structured JSON data. Learn more:
                #
                # - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
                # - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
                sig do
                  params(
                    format_:
                      T.any(
                        OpenAI::ResponseFormatText::OrHash,
                        OpenAI::Responses::ResponseFormatTextJSONSchemaConfig::OrHash,
                        OpenAI::ResponseFormatJSONObject::OrHash
                      )
                  ).returns(T.attached_class)
                end
                def self.new(
                  # An object specifying the format that the model must output.
                  #
                  # Configuring `{ "type": "json_schema" }` enables Structured Outputs, which
                  # ensures the model will match your supplied JSON schema. Learn more in the
                  # [Structured Outputs guide](https://platform.openai.com/docs/guides/structured-outputs).
                  #
                  # The default format is `{ "type": "text" }` with no additional options.
                  #
                  # **Not recommended for gpt-4o and newer models:**
                  #
                  # Setting to `{ "type": "json_object" }` enables the older JSON mode, which
                  # ensures the message the model generates is valid JSON. Using `json_schema` is
                  # preferred for models that support it.
                  format_: nil
                )
                end

                sig do
                  override.returns(
                    {
                      format_:
                        OpenAI::Responses::ResponseFormatTextConfig::Variants
                    }
                  )
                end
                def to_hash
                end
              end
            end
          end

          sig do
            override.returns(
              T::Array[
                OpenAI::Models::Evals::RunRetrieveResponse::DataSource::Variants
              ]
            )
          end
          def self.variants
          end
        end

        class PerModelUsage < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Models::Evals::RunRetrieveResponse::PerModelUsage,
                OpenAI::Internal::AnyHash
              )
            end

          # The number of tokens retrieved from cache.
          sig { returns(Integer) }
          attr_accessor :cached_tokens

          # The number of completion tokens generated.
          sig { returns(Integer) }
          attr_accessor :completion_tokens

          # The number of invocations.
          sig { returns(Integer) }
          attr_accessor :invocation_count

          # The name of the model.
          sig { returns(String) }
          attr_accessor :model_name

          # The number of prompt tokens used.
          sig { returns(Integer) }
          attr_accessor :prompt_tokens

          # The total number of tokens used.
          sig { returns(Integer) }
          attr_accessor :total_tokens

          sig do
            params(
              cached_tokens: Integer,
              completion_tokens: Integer,
              invocation_count: Integer,
              model_name: String,
              prompt_tokens: Integer,
              total_tokens: Integer
            ).returns(T.attached_class)
          end
          def self.new(
            # The number of tokens retrieved from cache.
            cached_tokens:,
            # The number of completion tokens generated.
            completion_tokens:,
            # The number of invocations.
            invocation_count:,
            # The name of the model.
            model_name:,
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
                invocation_count: Integer,
                model_name: String,
                prompt_tokens: Integer,
                total_tokens: Integer
              }
            )
          end
          def to_hash
          end
        end

        class PerTestingCriteriaResult < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Models::Evals::RunRetrieveResponse::PerTestingCriteriaResult,
                OpenAI::Internal::AnyHash
              )
            end

          # Number of tests failed for this criteria.
          sig { returns(Integer) }
          attr_accessor :failed

          # Number of tests passed for this criteria.
          sig { returns(Integer) }
          attr_accessor :passed

          # A description of the testing criteria.
          sig { returns(String) }
          attr_accessor :testing_criteria

          sig do
            params(
              failed: Integer,
              passed: Integer,
              testing_criteria: String
            ).returns(T.attached_class)
          end
          def self.new(
            # Number of tests failed for this criteria.
            failed:,
            # Number of tests passed for this criteria.
            passed:,
            # A description of the testing criteria.
            testing_criteria:
          )
          end

          sig do
            override.returns(
              { failed: Integer, passed: Integer, testing_criteria: String }
            )
          end
          def to_hash
          end
        end

        class ResultCounts < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Models::Evals::RunRetrieveResponse::ResultCounts,
                OpenAI::Internal::AnyHash
              )
            end

          # Number of output items that resulted in an error.
          sig { returns(Integer) }
          attr_accessor :errored

          # Number of output items that failed to pass the evaluation.
          sig { returns(Integer) }
          attr_accessor :failed

          # Number of output items that passed the evaluation.
          sig { returns(Integer) }
          attr_accessor :passed

          # Total number of executed output items.
          sig { returns(Integer) }
          attr_accessor :total

          # Counters summarizing the outcomes of the evaluation run.
          sig do
            params(
              errored: Integer,
              failed: Integer,
              passed: Integer,
              total: Integer
            ).returns(T.attached_class)
          end
          def self.new(
            # Number of output items that resulted in an error.
            errored:,
            # Number of output items that failed to pass the evaluation.
            failed:,
            # Number of output items that passed the evaluation.
            passed:,
            # Total number of executed output items.
            total:
          )
          end

          sig do
            override.returns(
              {
                errored: Integer,
                failed: Integer,
                passed: Integer,
                total: Integer
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
