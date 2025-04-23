# typed: strong

module OpenAI
  module Models
    module Evals
      class RunCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # Details about the run's data source.
        sig do
          returns(
            T.any(
              OpenAI::Models::Evals::CreateEvalJSONLRunDataSource,
              OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource,
              OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource
            )
          )
        end
        attr_accessor :data_source

        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard.
        #
        # Keys are strings with a maximum length of 64 characters. Values are strings with
        # a maximum length of 512 characters.
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        attr_accessor :metadata

        # The name of the run.
        sig { returns(T.nilable(String)) }
        attr_reader :name

        sig { params(name: String).void }
        attr_writer :name

        sig do
          params(
            data_source: T.any(
              OpenAI::Models::Evals::CreateEvalJSONLRunDataSource,
              OpenAI::Internal::AnyHash,
              OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource,
              OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource
            ),
            metadata: T.nilable(T::Hash[Symbol, String]),
            name: String,
            request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash)
          )
            .returns(T.attached_class)
        end
        def self.new(data_source:, metadata: nil, name: nil, request_options: {}); end

        sig do
          override
            .returns(
              {
                data_source: T.any(
                  OpenAI::Models::Evals::CreateEvalJSONLRunDataSource,
                  OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource,
                  OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource
                ),
                metadata: T.nilable(T::Hash[Symbol, String]),
                name: String,
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash; end

        # Details about the run's data source.
        module DataSource
          extend OpenAI::Internal::Type::Union

          class CreateEvalResponsesRunDataSource < OpenAI::Internal::Type::BaseModel
            # A EvalResponsesSource object describing a run data source configuration.
            sig do
              returns(
                T.any(
                  OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent,
                  OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileID,
                  OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::Responses
                )
              )
            end
            attr_accessor :source

            # The type of run data source. Always `completions`.
            sig do
              returns(
                OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Type::OrSymbol
              )
            end
            attr_accessor :type

            sig do
              returns(
                T.nilable(
                  T.any(
                    OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template,
                    OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::ItemReference
                  )
                )
              )
            end
            attr_reader :input_messages

            sig do
              params(
                input_messages: T.any(
                  OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template,
                  OpenAI::Internal::AnyHash,
                  OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::ItemReference
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

            sig do
              returns(
                T.nilable(
                  OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::SamplingParams
                )
              )
            end
            attr_reader :sampling_params

            sig do
              params(
                sampling_params: T.any(
                  OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::SamplingParams,
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
                  OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent,
                  OpenAI::Internal::AnyHash,
                  OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileID,
                  OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::Responses
                ),
                type: OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Type::OrSymbol,
                input_messages: T.any(
                  OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template,
                  OpenAI::Internal::AnyHash,
                  OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::ItemReference
                ),
                model: String,
                sampling_params: T.any(
                  OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::SamplingParams,
                  OpenAI::Internal::AnyHash
                )
              )
                .returns(T.attached_class)
            end
            def self.new(source:, type:, input_messages: nil, model: nil, sampling_params: nil); end

            sig do
              override
                .returns(
                  {
                    source: T.any(
                      OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent,
                      OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileID,
                      OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::Responses
                    ),
                    type: OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Type::OrSymbol,
                    input_messages: T.any(
                      OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template,
                      OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::ItemReference
                    ),
                    model: String,
                    sampling_params: OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::SamplingParams
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
                    T::Array[
                      OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent::Content
                    ]
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
                        OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent::Content,
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
                        content: T::Array[
                          OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent::Content
                        ],
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
                sig { returns(T.nilable(OpenAI::Models::ReasoningEffort::OrSymbol)) }
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
                        reasoning_effort: T.nilable(OpenAI::Models::ReasoningEffort::OrSymbol),
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
                    [OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileID, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::Responses]
                  )
              end
              def self.variants; end
            end

            # The type of run data source. Always `completions`.
            module Type
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias { T.all(Symbol, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Type) }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              COMPLETIONS =
                T.let(
                  :completions,
                  OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Type::TaggedSymbol
                )

              sig do
                override
                  .returns(
                    T::Array[OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Type::TaggedSymbol]
                  )
              end
              def self.values; end
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
                        OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::ChatMessage,
                        OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem
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
                        OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::ChatMessage,
                        OpenAI::Internal::AnyHash,
                        OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem
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
                            OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::ChatMessage,
                            OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem
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
                          OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText
                        )
                      )
                    end
                    attr_accessor :content

                    # The role of the message input. One of `user`, `assistant`, `system`, or
                    # `developer`.
                    sig do
                      returns(
                        OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Role::OrSymbol
                      )
                    end
                    attr_accessor :role

                    # The type of the message input. Always `message`.
                    sig do
                      returns(
                        T.nilable(
                          OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Type::OrSymbol
                        )
                      )
                    end
                    attr_reader :type

                    sig do
                      params(
                        type: OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Type::OrSymbol
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
                          OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText
                        ),
                        role: OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Role::OrSymbol,
                        type: OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Type::OrSymbol
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
                              OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText
                            ),
                            role: OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Role::OrSymbol,
                            type: OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Type::OrSymbol
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
                            [String, OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText]
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
                          T.all(Symbol, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Role)
                        end
                      OrSymbol = T.type_alias { T.any(Symbol, String) }

                      USER =
                        T.let(
                          :user,
                          OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
                        )
                      ASSISTANT =
                        T.let(
                          :assistant,
                          OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
                        )
                      SYSTEM =
                        T.let(
                          :system,
                          OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
                        )
                      DEVELOPER =
                        T.let(
                          :developer,
                          OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
                        )

                      sig do
                        override
                          .returns(
                            T::Array[
                              OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
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
                          T.all(Symbol, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Type)
                        end
                      OrSymbol = T.type_alias { T.any(Symbol, String) }

                      MESSAGE =
                        T.let(
                          :message,
                          OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Type::TaggedSymbol
                        )

                      sig do
                        override
                          .returns(
                            T::Array[
                              OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Type::TaggedSymbol
                            ]
                          )
                      end
                      def self.values; end
                    end
                  end

                  sig do
                    override
                      .returns(
                        [OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::ChatMessage, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem]
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
                    [OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::ItemReference]
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
                [OpenAI::Models::Evals::CreateEvalJSONLRunDataSource, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource, OpenAI::Models::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource]
              )
          end
          def self.variants; end
        end
      end
    end
  end
end
