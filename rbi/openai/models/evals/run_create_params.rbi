# typed: strong

module OpenAI
  module Models
    module Evals
      class RunCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(OpenAI::Evals::RunCreateParams, OpenAI::Internal::AnyHash)
          end

        # Details about the run's data source.
        sig do
          returns(
            T.any(
              OpenAI::Evals::CreateEvalJSONLRunDataSource,
              OpenAI::Evals::CreateEvalCompletionsRunDataSource,
              OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource
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
            data_source:
              T.any(
                OpenAI::Evals::CreateEvalJSONLRunDataSource::OrHash,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource::OrHash,
                OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::OrHash
              ),
            metadata: T.nilable(T::Hash[Symbol, String]),
            name: String,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # Details about the run's data source.
          data_source:,
          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard.
          #
          # Keys are strings with a maximum length of 64 characters. Values are strings with
          # a maximum length of 512 characters.
          metadata: nil,
          # The name of the run.
          name: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              data_source:
                T.any(
                  OpenAI::Evals::CreateEvalJSONLRunDataSource,
                  OpenAI::Evals::CreateEvalCompletionsRunDataSource,
                  OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource
                ),
              metadata: T.nilable(T::Hash[Symbol, String]),
              name: String,
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        # Details about the run's data source.
        module DataSource
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Evals::CreateEvalJSONLRunDataSource,
                OpenAI::Evals::CreateEvalCompletionsRunDataSource,
                OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource
              )
            end

          class CreateEvalResponsesRunDataSource < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource,
                  OpenAI::Internal::AnyHash
                )
              end

            # Determines what populates the `item` namespace in this run's data source.
            sig do
              returns(
                T.any(
                  OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent,
                  OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileID,
                  OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::Responses
                )
              )
            end
            attr_accessor :source

            # The type of run data source. Always `responses`.
            sig do
              returns(
                OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Type::OrSymbol
              )
            end
            attr_accessor :type

            # Used when sampling from a model. Dictates the structure of the messages passed
            # into the model. Can either be a reference to a prebuilt trajectory (ie,
            # `item.input_trajectory`), or a template with variable references to the `item`
            # namespace.
            sig do
              returns(
                T.nilable(
                  T.any(
                    OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template,
                    OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::ItemReference
                  )
                )
              )
            end
            attr_reader :input_messages

            sig do
              params(
                input_messages:
                  T.any(
                    OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::OrHash,
                    OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::ItemReference::OrHash
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
                  OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::SamplingParams
                )
              )
            end
            attr_reader :sampling_params

            sig do
              params(
                sampling_params:
                  OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::SamplingParams::OrHash
              ).void
            end
            attr_writer :sampling_params

            # A ResponsesRunDataSource object describing a model sampling configuration.
            sig do
              params(
                source:
                  T.any(
                    OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent::OrHash,
                    OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileID::OrHash,
                    OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::Responses::OrHash
                  ),
                type:
                  OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Type::OrSymbol,
                input_messages:
                  T.any(
                    OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::OrHash,
                    OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::ItemReference::OrHash
                  ),
                model: String,
                sampling_params:
                  OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::SamplingParams::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              # Determines what populates the `item` namespace in this run's data source.
              source:,
              # The type of run data source. Always `responses`.
              type:,
              # Used when sampling from a model. Dictates the structure of the messages passed
              # into the model. Can either be a reference to a prebuilt trajectory (ie,
              # `item.input_trajectory`), or a template with variable references to the `item`
              # namespace.
              input_messages: nil,
              # The name of the model to use for generating completions (e.g. "o3-mini").
              model: nil,
              sampling_params: nil
            )
            end

            sig do
              override.returns(
                {
                  source:
                    T.any(
                      OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent,
                      OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileID,
                      OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::Responses
                    ),
                  type:
                    OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Type::OrSymbol,
                  input_messages:
                    T.any(
                      OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template,
                      OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::ItemReference
                    ),
                  model: String,
                  sampling_params:
                    OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::SamplingParams
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
                    OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent,
                    OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileID,
                    OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::Responses
                  )
                end

              class FileContent < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # The content of the jsonl file.
                sig do
                  returns(
                    T::Array[
                      OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent::Content
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
                        OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent::Content::OrHash
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
                          OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent::Content
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
                        OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileContent::Content,
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
                      OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::FileID,
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
                      OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::Responses,
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

                # Constrains effort on reasoning for
                # [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
                # supported values are `none`, `minimal`, `low`, `medium`, `high`, and `xhigh`.
                # Reducing reasoning effort can result in faster responses and fewer tokens used
                # on reasoning in a response.
                #
                # - `gpt-5.1` defaults to `none`, which does not perform reasoning. The supported
                #   reasoning values for `gpt-5.1` are `none`, `low`, `medium`, and `high`. Tool
                #   calls are supported for all reasoning values in gpt-5.1.
                # - All models before `gpt-5.1` default to `medium` reasoning effort, and do not
                #   support `none`.
                # - The `gpt-5-pro` model defaults to (and only supports) `high` reasoning effort.
                # - `xhigh` is currently only supported for `gpt-5.1-codex-max`.
                sig { returns(T.nilable(OpenAI::ReasoningEffort::OrSymbol)) }
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
                  # Constrains effort on reasoning for
                  # [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
                  # supported values are `none`, `minimal`, `low`, `medium`, `high`, and `xhigh`.
                  # Reducing reasoning effort can result in faster responses and fewer tokens used
                  # on reasoning in a response.
                  #
                  # - `gpt-5.1` defaults to `none`, which does not perform reasoning. The supported
                  #   reasoning values for `gpt-5.1` are `none`, `low`, `medium`, and `high`. Tool
                  #   calls are supported for all reasoning values in gpt-5.1.
                  # - All models before `gpt-5.1` default to `medium` reasoning effort, and do not
                  #   support `none`.
                  # - The `gpt-5-pro` model defaults to (and only supports) `high` reasoning effort.
                  # - `xhigh` is currently only supported for `gpt-5.1-codex-max`.
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
                        T.nilable(OpenAI::ReasoningEffort::OrSymbol),
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
                    OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Source::Variants
                  ]
                )
              end
              def self.variants
              end
            end

            # The type of run data source. Always `responses`.
            module Type
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Type
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              RESPONSES =
                T.let(
                  :responses,
                  OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Type::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::Type::TaggedSymbol
                  ]
                )
              end
              def self.values
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
                    OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template,
                    OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::ItemReference
                  )
                end

              class Template < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # A list of chat messages forming the prompt or context. May include variable
                # references to the `item` namespace, ie {{item.name}}.
                sig do
                  returns(
                    T::Array[
                      T.any(
                        OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::ChatMessage,
                        OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem
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
                    template:
                      T::Array[
                        T.any(
                          OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::ChatMessage::OrHash,
                          OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::OrHash
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
                          T.any(
                            OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::ChatMessage,
                            OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem
                          )
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
                        OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::ChatMessage,
                        OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem
                      )
                    end

                  class ChatMessage < OpenAI::Internal::Type::BaseModel
                    OrHash =
                      T.type_alias do
                        T.any(
                          OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::ChatMessage,
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
                          OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem,
                          OpenAI::Internal::AnyHash
                        )
                      end

                    # Inputs to the model - can contain template strings.
                    sig do
                      returns(
                        T.any(
                          String,
                          OpenAI::Responses::ResponseInputText,
                          OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText,
                          OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::InputImage,
                          OpenAI::Responses::ResponseInputAudio,
                          T::Array[T.anything]
                        )
                      )
                    end
                    attr_accessor :content

                    # The role of the message input. One of `user`, `assistant`, `system`, or
                    # `developer`.
                    sig do
                      returns(
                        OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Role::OrSymbol
                      )
                    end
                    attr_accessor :role

                    # The type of the message input. Always `message`.
                    sig do
                      returns(
                        T.nilable(
                          OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Type::OrSymbol
                        )
                      )
                    end
                    attr_reader :type

                    sig do
                      params(
                        type:
                          OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Type::OrSymbol
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
                            OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText::OrHash,
                            OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::InputImage::OrHash,
                            OpenAI::Responses::ResponseInputAudio::OrHash,
                            T::Array[T.anything]
                          ),
                        role:
                          OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Role::OrSymbol,
                        type:
                          OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Type::OrSymbol
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
                            T.any(
                              String,
                              OpenAI::Responses::ResponseInputText,
                              OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText,
                              OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::InputImage,
                              OpenAI::Responses::ResponseInputAudio,
                              T::Array[T.anything]
                            ),
                          role:
                            OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Role::OrSymbol,
                          type:
                            OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Type::OrSymbol
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
                            OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText,
                            OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::InputImage,
                            OpenAI::Responses::ResponseInputAudio,
                            T::Array[T.anything]
                          )
                        end

                      class OutputText < OpenAI::Internal::Type::BaseModel
                        OrHash =
                          T.type_alias do
                            T.any(
                              OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::OutputText,
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
                              OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::InputImage,
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
                            OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Content::Variants
                          ]
                        )
                      end
                      def self.variants
                      end

                      AnArrayOfInputTextInputImageAndInputAudioArray =
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
                            OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Role
                          )
                        end
                      OrSymbol = T.type_alias { T.any(Symbol, String) }

                      USER =
                        T.let(
                          :user,
                          OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
                        )
                      ASSISTANT =
                        T.let(
                          :assistant,
                          OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
                        )
                      SYSTEM =
                        T.let(
                          :system,
                          OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
                        )
                      DEVELOPER =
                        T.let(
                          :developer,
                          OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
                        )

                      sig do
                        override.returns(
                          T::Array[
                            OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Role::TaggedSymbol
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
                            OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Type
                          )
                        end
                      OrSymbol = T.type_alias { T.any(Symbol, String) }

                      MESSAGE =
                        T.let(
                          :message,
                          OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Type::TaggedSymbol
                        )

                      sig do
                        override.returns(
                          T::Array[
                            OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::EvalItem::Type::TaggedSymbol
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
                        OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Template::Template::Variants
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
                      OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::ItemReference,
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
                    OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::InputMessages::Variants
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
                    OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::SamplingParams,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The maximum number of tokens in the generated output.
              sig { returns(T.nilable(Integer)) }
              attr_reader :max_completion_tokens

              sig { params(max_completion_tokens: Integer).void }
              attr_writer :max_completion_tokens

              # Constrains effort on reasoning for
              # [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
              # supported values are `none`, `minimal`, `low`, `medium`, `high`, and `xhigh`.
              # Reducing reasoning effort can result in faster responses and fewer tokens used
              # on reasoning in a response.
              #
              # - `gpt-5.1` defaults to `none`, which does not perform reasoning. The supported
              #   reasoning values for `gpt-5.1` are `none`, `low`, `medium`, and `high`. Tool
              #   calls are supported for all reasoning values in gpt-5.1.
              # - All models before `gpt-5.1` default to `medium` reasoning effort, and do not
              #   support `none`.
              # - The `gpt-5-pro` model defaults to (and only supports) `high` reasoning effort.
              # - `xhigh` is currently only supported for `gpt-5.1-codex-max`.
              sig { returns(T.nilable(OpenAI::ReasoningEffort::OrSymbol)) }
              attr_accessor :reasoning_effort

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
                    OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::SamplingParams::Text
                  )
                )
              end
              attr_reader :text

              sig do
                params(
                  text:
                    OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::SamplingParams::Text::OrHash
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
                returns(
                  T.nilable(
                    T::Array[
                      T.any(
                        OpenAI::Responses::FunctionTool,
                        OpenAI::Responses::FileSearchTool,
                        OpenAI::Responses::ComputerTool,
                        OpenAI::Responses::Tool::Mcp,
                        OpenAI::Responses::Tool::CodeInterpreter,
                        OpenAI::Responses::Tool::ImageGeneration,
                        OpenAI::Responses::Tool::LocalShell,
                        OpenAI::Responses::FunctionShellTool,
                        OpenAI::Responses::CustomTool,
                        OpenAI::Responses::ApplyPatchTool,
                        OpenAI::Responses::WebSearchTool,
                        OpenAI::Responses::WebSearchPreviewTool
                      )
                    ]
                  )
                )
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
                        OpenAI::Responses::FunctionShellTool::OrHash,
                        OpenAI::Responses::CustomTool::OrHash,
                        OpenAI::Responses::ApplyPatchTool::OrHash,
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
                  reasoning_effort:
                    T.nilable(OpenAI::ReasoningEffort::OrSymbol),
                  seed: Integer,
                  temperature: Float,
                  text:
                    OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::SamplingParams::Text::OrHash,
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
                        OpenAI::Responses::FunctionShellTool::OrHash,
                        OpenAI::Responses::CustomTool::OrHash,
                        OpenAI::Responses::ApplyPatchTool::OrHash,
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
                # Constrains effort on reasoning for
                # [reasoning models](https://platform.openai.com/docs/guides/reasoning). Currently
                # supported values are `none`, `minimal`, `low`, `medium`, `high`, and `xhigh`.
                # Reducing reasoning effort can result in faster responses and fewer tokens used
                # on reasoning in a response.
                #
                # - `gpt-5.1` defaults to `none`, which does not perform reasoning. The supported
                #   reasoning values for `gpt-5.1` are `none`, `low`, `medium`, and `high`. Tool
                #   calls are supported for all reasoning values in gpt-5.1.
                # - All models before `gpt-5.1` default to `medium` reasoning effort, and do not
                #   support `none`.
                # - The `gpt-5-pro` model defaults to (and only supports) `high` reasoning effort.
                # - `xhigh` is currently only supported for `gpt-5.1-codex-max`.
                reasoning_effort: nil,
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
                    reasoning_effort:
                      T.nilable(OpenAI::ReasoningEffort::OrSymbol),
                    seed: Integer,
                    temperature: Float,
                    text:
                      OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::SamplingParams::Text,
                    tools:
                      T::Array[
                        T.any(
                          OpenAI::Responses::FunctionTool,
                          OpenAI::Responses::FileSearchTool,
                          OpenAI::Responses::ComputerTool,
                          OpenAI::Responses::Tool::Mcp,
                          OpenAI::Responses::Tool::CodeInterpreter,
                          OpenAI::Responses::Tool::ImageGeneration,
                          OpenAI::Responses::Tool::LocalShell,
                          OpenAI::Responses::FunctionShellTool,
                          OpenAI::Responses::CustomTool,
                          OpenAI::Responses::ApplyPatchTool,
                          OpenAI::Responses::WebSearchTool,
                          OpenAI::Responses::WebSearchPreviewTool
                        )
                      ],
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
                      OpenAI::Evals::RunCreateParams::DataSource::CreateEvalResponsesRunDataSource::SamplingParams::Text,
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
                      T.any(
                        OpenAI::ResponseFormatText,
                        OpenAI::Responses::ResponseFormatTextJSONSchemaConfig,
                        OpenAI::ResponseFormatJSONObject
                      )
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
                        T.any(
                          OpenAI::ResponseFormatText,
                          OpenAI::Responses::ResponseFormatTextJSONSchemaConfig,
                          OpenAI::ResponseFormatJSONObject
                        )
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
              T::Array[OpenAI::Evals::RunCreateParams::DataSource::Variants]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end
