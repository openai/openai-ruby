# typed: strong

module OpenAI
  module Models
    module Evals
      class RunListResponse < OpenAI::Internal::Type::BaseModel
        # Unique identifier for the evaluation run.
        sig { returns(String) }
        attr_accessor :id

        # Unix timestamp (in seconds) when the evaluation run was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        # Information about the run's data source.
        sig do
          returns(
            T.any(
              OpenAI::Models::Evals::CreateEvalJSONLRunDataSource,
              OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource,
              OpenAI::Models::Evals::RunListResponse::DataSource::Completions
            )
          )
        end
        attr_accessor :data_source

        # An object representing an error response from the Eval API.
        sig { returns(OpenAI::Models::Evals::EvalAPIError) }
        attr_reader :error

        sig { params(error: T.any(OpenAI::Models::Evals::EvalAPIError, OpenAI::Internal::AnyHash)).void }
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
        sig { returns(T::Array[OpenAI::Models::Evals::RunListResponse::PerModelUsage]) }
        attr_accessor :per_model_usage

        # Results per testing criteria applied during the evaluation run.
        sig { returns(T::Array[OpenAI::Models::Evals::RunListResponse::PerTestingCriteriaResult]) }
        attr_accessor :per_testing_criteria_results

        # The URL to the rendered evaluation run report on the UI dashboard.
        sig { returns(String) }
        attr_accessor :report_url

        # Counters summarizing the outcomes of the evaluation run.
        sig { returns(OpenAI::Models::Evals::RunListResponse::ResultCounts) }
        attr_reader :result_counts

        sig do
          params(
            result_counts: T.any(OpenAI::Models::Evals::RunListResponse::ResultCounts, OpenAI::Internal::AnyHash)
          )
            .void
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
            data_source: T.any(
              OpenAI::Models::Evals::CreateEvalJSONLRunDataSource,
              OpenAI::Internal::AnyHash,
              OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource,
              OpenAI::Models::Evals::RunListResponse::DataSource::Completions
            ),
            error: T.any(OpenAI::Models::Evals::EvalAPIError, OpenAI::Internal::AnyHash),
            eval_id: String,
            metadata: T.nilable(T::Hash[Symbol, String]),
            model: String,
            name: String,
            per_model_usage: T::Array[T.any(OpenAI::Models::Evals::RunListResponse::PerModelUsage, OpenAI::Internal::AnyHash)],
            per_testing_criteria_results: T::Array[T.any(OpenAI::Models::Evals::RunListResponse::PerTestingCriteriaResult, OpenAI::Internal::AnyHash)],
            report_url: String,
            result_counts: T.any(OpenAI::Models::Evals::RunListResponse::ResultCounts, OpenAI::Internal::AnyHash),
            status: String,
            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(
          id:,
          created_at:,
          data_source:,
          error:,
          eval_id:,
          metadata:,
          model:,
          name:,
          per_model_usage:,
          per_testing_criteria_results:,
          report_url:,
          result_counts:,
          status:,
          object: :"eval.run"
        ); end
        sig do
          override
            .returns(
              {
                id: String,
                created_at: Integer,
                data_source: T.any(
                  OpenAI::Models::Evals::CreateEvalJSONLRunDataSource,
                  OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource,
                  OpenAI::Models::Evals::RunListResponse::DataSource::Completions
                ),
                error: OpenAI::Models::Evals::EvalAPIError,
                eval_id: String,
                metadata: T.nilable(T::Hash[Symbol, String]),
                model: String,
                name: String,
                object: Symbol,
                per_model_usage: T::Array[OpenAI::Models::Evals::RunListResponse::PerModelUsage],
                per_testing_criteria_results: T::Array[OpenAI::Models::Evals::RunListResponse::PerTestingCriteriaResult],
                report_url: String,
                result_counts: OpenAI::Models::Evals::RunListResponse::ResultCounts,
                status: String
              }
            )
        end
        def to_hash; end

        # Information about the run's data source.
        module DataSource
          extend OpenAI::Internal::Type::Union

          class Completions < OpenAI::Internal::Type::BaseModel
            # A EvalResponsesSource object describing a run data source configuration.
            sig do
              returns(
                T.any(
                  OpenAI::Models::Evals::RunListResponse::DataSource::Completions::Source::FileContent,
                  OpenAI::Models::Evals::RunListResponse::DataSource::Completions::Source::FileID,
                  OpenAI::Models::Evals::RunListResponse::DataSource::Completions::Source::Responses
                )
              )
            end
            attr_accessor :source

            # The type of run data source. Always `completions`.
            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              returns(
                T.nilable(
                  T.any(
                    OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template,
                    OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::ItemReference
                  )
                )
              )
            end
            attr_reader :input_messages

            sig do
              params(
                input_messages: T.any(
                  OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template,
                  OpenAI::Internal::AnyHash,
                  OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::ItemReference
                )
              )
                .void
            end
            attr_writer :input_messages

            # The name of the model to use for generating completions (e.g. "o3-mini").
            sig { returns(T.nilable(String)) }
            attr_reader :model

            sig { params(model: String).void }
            attr_writer :model

            sig { returns(T.nilable(OpenAI::Models::Evals::RunListResponse::DataSource::Completions::SamplingParams)) }
            attr_reader :sampling_params

            sig do
              params(
                sampling_params: T.any(
                  OpenAI::Models::Evals::RunListResponse::DataSource::Completions::SamplingParams,
                  OpenAI::Internal::AnyHash
                )
              )
                .void
            end
            attr_writer :sampling_params

            # A ResponsesRunDataSource object describing a model sampling configuration.
            sig do
              params(
                source: T.any(
                  OpenAI::Models::Evals::RunListResponse::DataSource::Completions::Source::FileContent,
                  OpenAI::Internal::AnyHash,
                  OpenAI::Models::Evals::RunListResponse::DataSource::Completions::Source::FileID,
                  OpenAI::Models::Evals::RunListResponse::DataSource::Completions::Source::Responses
                ),
                input_messages: T.any(
                  OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template,
                  OpenAI::Internal::AnyHash,
                  OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::ItemReference
                ),
                model: String,
                sampling_params: T.any(
                  OpenAI::Models::Evals::RunListResponse::DataSource::Completions::SamplingParams,
                  OpenAI::Internal::AnyHash
                ),
                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(source:, input_messages: nil, model: nil, sampling_params: nil, type: :completions)
            end

            sig do
              override
                .returns(
                  {
                    source: T.any(
                      OpenAI::Models::Evals::RunListResponse::DataSource::Completions::Source::FileContent,
                      OpenAI::Models::Evals::RunListResponse::DataSource::Completions::Source::FileID,
                      OpenAI::Models::Evals::RunListResponse::DataSource::Completions::Source::Responses
                    ),
                    type: Symbol,
                    input_messages: T.any(
                      OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template,
                      OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::ItemReference
                    ),
                    model: String,
                    sampling_params: OpenAI::Models::Evals::RunListResponse::DataSource::Completions::SamplingParams
                  }
                )
            end
            def to_hash; end

            # A EvalResponsesSource object describing a run data source configuration.
            module Source
              extend OpenAI::Internal::Type::Union

              class FileContent < OpenAI::Internal::Type::BaseModel
                # The content of the jsonl file.
                sig do
                  returns(
                    T::Array[OpenAI::Models::Evals::RunListResponse::DataSource::Completions::Source::FileContent::Content]
                  )
                end
                attr_accessor :content

                # The type of jsonl source. Always `file_content`.
                sig { returns(Symbol) }
                attr_accessor :type

                sig do
                  params(
                    content: T::Array[
                      T.any(
                        OpenAI::Models::Evals::RunListResponse::DataSource::Completions::Source::FileContent::Content,
                        OpenAI::Internal::AnyHash
                      )
                    ],
                    type: Symbol
                  )
                    .returns(T.attached_class)
                end
                def self.new(content:, type: :file_content); end

                sig do
                  override
                    .returns(
                      {
                        content: T::Array[OpenAI::Models::Evals::RunListResponse::DataSource::Completions::Source::FileContent::Content],
                        type: Symbol
                      }
                    )
                end
                def to_hash; end

                class Content < OpenAI::Internal::Type::BaseModel
                  sig { returns(T::Hash[Symbol, T.anything]) }
                  attr_accessor :item

                  sig { returns(T.nilable(T::Hash[Symbol, T.anything])) }
                  attr_reader :sample

                  sig { params(sample: T::Hash[Symbol, T.anything]).void }
                  attr_writer :sample

                  sig do
                    params(
                      item: T::Hash[Symbol, T.anything],
                      sample: T::Hash[Symbol,
                                      T.anything]
                    ).returns(T.attached_class)
                  end
                  def self.new(item:, sample: nil); end

                  sig do
                    override.returns({item: T::Hash[Symbol, T.anything], sample: T::Hash[Symbol, T.anything]})
                  end
                  def to_hash; end
                end
              end

              class FileID < OpenAI::Internal::Type::BaseModel
                # The identifier of the file.
                sig { returns(String) }
                attr_accessor :id

                # The type of jsonl source. Always `file_id`.
                sig { returns(Symbol) }
                attr_accessor :type

                sig { params(id: String, type: Symbol).returns(T.attached_class) }
                def self.new(id:, type: :file_id); end

                sig { override.returns({id: String, type: Symbol}) }
                def to_hash; end
              end

              class Responses < OpenAI::Internal::Type::BaseModel
                # The type of run data source. Always `responses`.
                sig { returns(Symbol) }
                attr_accessor :type

                # Whether to allow parallel tool calls. This is a query parameter used to select
                # responses.
                sig { returns(T.nilable(T::Boolean)) }
                attr_accessor :allow_parallel_tool_calls

                # Only include items created after this timestamp (inclusive). This is a query
                # parameter used to select responses.
                sig { returns(T.nilable(Integer)) }
                attr_accessor :created_after

                # Only include items created before this timestamp (inclusive). This is a query
                # parameter used to select responses.
                sig { returns(T.nilable(Integer)) }
                attr_accessor :created_before

                # Whether the response has tool calls. This is a query parameter used to select
                # responses.
                sig { returns(T.nilable(T::Boolean)) }
                attr_accessor :has_tool_calls

                # Optional search string for instructions. This is a query parameter used to
                # select responses.
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
                sig { returns(T.nilable(OpenAI::Models::ReasoningEffort::TaggedSymbol)) }
                attr_accessor :reasoning_effort

                # Sampling temperature. This is a query parameter used to select responses.
                sig { returns(T.nilable(Float)) }
                attr_accessor :temperature

                # Nucleus sampling parameter. This is a query parameter used to select responses.
                sig { returns(T.nilable(Float)) }
                attr_accessor :top_p

                # List of user identifiers. This is a query parameter used to select responses.
                sig { returns(T.nilable(T::Array[String])) }
                attr_accessor :users

                # A EvalResponsesSource object describing a run data source configuration.
                sig do
                  params(
                    allow_parallel_tool_calls: T.nilable(T::Boolean),
                    created_after: T.nilable(Integer),
                    created_before: T.nilable(Integer),
                    has_tool_calls: T.nilable(T::Boolean),
                    instructions_search: T.nilable(String),
                    metadata: T.nilable(T.anything),
                    model: T.nilable(String),
                    reasoning_effort: T.nilable(OpenAI::Models::ReasoningEffort::OrSymbol),
                    temperature: T.nilable(Float),
                    top_p: T.nilable(Float),
                    users: T.nilable(T::Array[String]),
                    type: Symbol
                  )
                    .returns(T.attached_class)
                end
                def self.new(
                  allow_parallel_tool_calls: nil,
                  created_after: nil,
                  created_before: nil,
                  has_tool_calls: nil,
                  instructions_search: nil,
                  metadata: nil,
                  model: nil,
                  reasoning_effort: nil,
                  temperature: nil,
                  top_p: nil,
                  users: nil,
                  type: :responses
                ); end
                sig do
                  override
                    .returns(
                      {
                        type: Symbol,
                        allow_parallel_tool_calls: T.nilable(T::Boolean),
                        created_after: T.nilable(Integer),
                        created_before: T.nilable(Integer),
                        has_tool_calls: T.nilable(T::Boolean),
                        instructions_search: T.nilable(String),
                        metadata: T.nilable(T.anything),
                        model: T.nilable(String),
                        reasoning_effort: T.nilable(OpenAI::Models::ReasoningEffort::TaggedSymbol),
                        temperature: T.nilable(Float),
                        top_p: T.nilable(Float),
                        users: T.nilable(T::Array[String])
                      }
                    )
                end
                def to_hash; end
              end

              sig do
                override
                  .returns(
                    [OpenAI::Models::Evals::RunListResponse::DataSource::Completions::Source::FileContent, OpenAI::Models::Evals::RunListResponse::DataSource::Completions::Source::FileID, OpenAI::Models::Evals::RunListResponse::DataSource::Completions::Source::Responses]
                  )
              end
              def self.variants; end
            end

            module InputMessages
              extend OpenAI::Internal::Type::Union

              class Template < OpenAI::Internal::Type::BaseModel
                # A list of chat messages forming the prompt or context. May include variable
                # references to the "item" namespace, ie {{item.name}}.
                sig do
                  returns(
                    T::Array[
                      T.any(
                        OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::ChatMessage,
                        OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem
                      )
                    ]
                  )
                end
                attr_accessor :template

                # The type of input messages. Always `template`.
                sig { returns(Symbol) }
                attr_accessor :type

                sig do
                  params(
                    template: T::Array[
                      T.any(
                        OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::ChatMessage,
                        OpenAI::Internal::AnyHash,
                        OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem
                      )
                    ],
                    type: Symbol
                  )
                    .returns(T.attached_class)
                end
                def self.new(template:, type: :template); end

                sig do
                  override
                    .returns(
                      {
                        template: T::Array[
                          T.any(
                            OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::ChatMessage,
                            OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem
                          )
                        ],
                        type: Symbol
                      }
                    )
                end
                def to_hash; end

                # A message input to the model with a role indicating instruction following
                # hierarchy. Instructions given with the `developer` or `system` role take
                # precedence over instructions given with the `user` role. Messages with the
                # `assistant` role are presumed to have been generated by the model in previous
                # interactions.
                module Template
                  extend OpenAI::Internal::Type::Union

                  class ChatMessage < OpenAI::Internal::Type::BaseModel
                    # The content of the message.
                    sig { returns(String) }
                    attr_accessor :content

                    # The role of the message (e.g. "system", "assistant", "user").
                    sig { returns(String) }
                    attr_accessor :role

                    sig { params(content: String, role: String).returns(T.attached_class) }
                    def self.new(content:, role:); end

                    sig { override.returns({content: String, role: String}) }
                    def to_hash; end
                  end

                  class EvalItem < OpenAI::Internal::Type::BaseModel
                    # Text inputs to the model - can contain template strings.
                    sig do
                      returns(
                        T.any(
                          String,
                          OpenAI::Models::Responses::ResponseInputText,
                          OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Content::OutputText
                        )
                      )
                    end
                    attr_accessor :content

                    # The role of the message input. One of `user`, `assistant`, `system`, or
                    # `developer`.
                    sig do
                      returns(
                        OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
                      )
                    end
                    attr_accessor :role

                    # The type of the message input. Always `message`.
                    sig do
                      returns(
                        T.nilable(
                          OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Type::TaggedSymbol
                        )
                      )
                    end
                    attr_reader :type

                    sig do
                      params(
                        type: OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Type::OrSymbol
                      )
                        .void
                    end
                    attr_writer :type

                    # A message input to the model with a role indicating instruction following
                    # hierarchy. Instructions given with the `developer` or `system` role take
                    # precedence over instructions given with the `user` role. Messages with the
                    # `assistant` role are presumed to have been generated by the model in previous
                    # interactions.
                    sig do
                      params(
                        content: T.any(
                          String,
                          OpenAI::Models::Responses::ResponseInputText,
                          OpenAI::Internal::AnyHash,
                          OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Content::OutputText
                        ),
                        role: OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Role::OrSymbol,
                        type: OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Type::OrSymbol
                      )
                        .returns(T.attached_class)
                    end
                    def self.new(content:, role:, type: nil); end

                    sig do
                      override
                        .returns(
                          {
                            content: T.any(
                              String,
                              OpenAI::Models::Responses::ResponseInputText,
                              OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Content::OutputText
                            ),
                            role: OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol,
                            type: OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Type::TaggedSymbol
                          }
                        )
                    end
                    def to_hash; end

                    # Text inputs to the model - can contain template strings.
                    module Content
                      extend OpenAI::Internal::Type::Union

                      class OutputText < OpenAI::Internal::Type::BaseModel
                        # The text output from the model.
                        sig { returns(String) }
                        attr_accessor :text

                        # The type of the output text. Always `output_text`.
                        sig { returns(Symbol) }
                        attr_accessor :type

                        # A text output from the model.
                        sig { params(text: String, type: Symbol).returns(T.attached_class) }
                        def self.new(text:, type: :output_text); end

                        sig { override.returns({text: String, type: Symbol}) }
                        def to_hash; end
                      end

                      sig do
                        override
                          .returns(
                            [String, OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Content::OutputText]
                          )
                      end
                      def self.variants; end
                    end

                    # The role of the message input. One of `user`, `assistant`, `system`, or
                    # `developer`.
                    module Role
                      extend OpenAI::Internal::Type::Enum

                      TaggedSymbol =
                        T.type_alias do
                          T.all(Symbol, OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Role)
                        end
                      OrSymbol = T.type_alias { T.any(Symbol, String) }

                      USER =
                        T.let(
                          :user,
                          OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
                        )
                      ASSISTANT =
                        T.let(
                          :assistant,
                          OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
                        )
                      SYSTEM =
                        T.let(
                          :system,
                          OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
                        )
                      DEVELOPER =
                        T.let(
                          :developer,
                          OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
                        )

                      sig do
                        override
                          .returns(
                            T::Array[
                              OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
                            ]
                          )
                      end
                      def self.values; end
                    end

                    # The type of the message input. Always `message`.
                    module Type
                      extend OpenAI::Internal::Type::Enum

                      TaggedSymbol =
                        T.type_alias do
                          T.all(Symbol, OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Type)
                        end
                      OrSymbol = T.type_alias { T.any(Symbol, String) }

                      MESSAGE =
                        T.let(
                          :message,
                          OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Type::TaggedSymbol
                        )

                      sig do
                        override
                          .returns(
                            T::Array[
                              OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem::Type::TaggedSymbol
                            ]
                          )
                      end
                      def self.values; end
                    end
                  end

                  sig do
                    override
                      .returns(
                        [OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::ChatMessage, OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template::Template::EvalItem]
                      )
                  end
                  def self.variants; end
                end
              end

              class ItemReference < OpenAI::Internal::Type::BaseModel
                # A reference to a variable in the "item" namespace. Ie, "item.name"
                sig { returns(String) }
                attr_accessor :item_reference

                # The type of input messages. Always `item_reference`.
                sig { returns(Symbol) }
                attr_accessor :type

                sig { params(item_reference: String, type: Symbol).returns(T.attached_class) }
                def self.new(item_reference:, type: :item_reference); end

                sig { override.returns({item_reference: String, type: Symbol}) }
                def to_hash; end
              end

              sig do
                override
                  .returns(
                    [OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::Template, OpenAI::Models::Evals::RunListResponse::DataSource::Completions::InputMessages::ItemReference]
                  )
              end
              def self.variants; end
            end

            class SamplingParams < OpenAI::Internal::Type::BaseModel
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

              # An alternative to temperature for nucleus sampling; 1.0 includes all tokens.
              sig { returns(T.nilable(Float)) }
              attr_reader :top_p

              sig { params(top_p: Float).void }
              attr_writer :top_p

              sig do
                params(max_completion_tokens: Integer, seed: Integer, temperature: Float, top_p: Float)
                  .returns(T.attached_class)
              end
              def self.new(max_completion_tokens: nil, seed: nil, temperature: nil, top_p: nil); end

              sig do
                override.returns(
                  {
                    max_completion_tokens: Integer,
                    seed: Integer,
                    temperature: Float,
                    top_p: Float
                  }
                )
              end
              def to_hash; end
            end
          end

          sig do
            override
              .returns(
                [OpenAI::Models::Evals::CreateEvalJSONLRunDataSource, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource, OpenAI::Models::Evals::RunListResponse::DataSource::Completions]
              )
          end
          def self.variants; end
        end

        class PerModelUsage < OpenAI::Internal::Type::BaseModel
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
            )
              .returns(T.attached_class)
          end
          def self.new(
            cached_tokens:,
            completion_tokens:,
            invocation_count:,
            model_name:,
            prompt_tokens:,
            total_tokens:
          )
          end

          sig do
            override
              .returns(
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
          def to_hash; end
        end

        class PerTestingCriteriaResult < OpenAI::Internal::Type::BaseModel
          # Number of tests failed for this criteria.
          sig { returns(Integer) }
          attr_accessor :failed

          # Number of tests passed for this criteria.
          sig { returns(Integer) }
          attr_accessor :passed

          # A description of the testing criteria.
          sig { returns(String) }
          attr_accessor :testing_criteria

          sig { params(failed: Integer, passed: Integer, testing_criteria: String).returns(T.attached_class) }
          def self.new(failed:, passed:, testing_criteria:); end

          sig { override.returns({failed: Integer, passed: Integer, testing_criteria: String}) }
          def to_hash; end
        end

        class ResultCounts < OpenAI::Internal::Type::BaseModel
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
          def self.new(errored:, failed:, passed:, total:); end

          sig { override.returns({errored: Integer, failed: Integer, passed: Integer, total: Integer}) }
          def to_hash; end
        end
      end
    end
  end
end
