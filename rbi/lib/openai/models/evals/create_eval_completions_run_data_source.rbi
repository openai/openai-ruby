# typed: strong

module OpenAI
  module Models
    module Evals
      class CreateEvalCompletionsRunDataSource < OpenAI::Internal::Type::BaseModel
        sig do
          returns(
            T.any(
              OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template,
              OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference
            )
          )
        end
        attr_accessor :input_messages

        # The name of the model to use for generating completions (e.g. "o3-mini").
        sig { returns(String) }
        attr_accessor :model

        # A StoredCompletionsRunDataSource configuration describing a set of filters
        sig do
          returns(
            T.any(
              OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent,
              OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileID,
              OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions
            )
          )
        end
        attr_accessor :source

        # The type of run data source. Always `completions`.
        sig { returns(OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Type::OrSymbol) }
        attr_accessor :type

        sig { returns(T.nilable(OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::SamplingParams)) }
        attr_reader :sampling_params

        sig do
          params(
            sampling_params: T.any(
              OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::SamplingParams,
              OpenAI::Internal::AnyHash
            )
          )
            .void
        end
        attr_writer :sampling_params

        # A CompletionsRunDataSource object describing a model sampling configuration.
        sig do
          params(
            input_messages: T.any(
              OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template,
              OpenAI::Internal::AnyHash,
              OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference
            ),
            model: String,
            source: T.any(
              OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent,
              OpenAI::Internal::AnyHash,
              OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileID,
              OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions
            ),
            type: OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Type::OrSymbol,
            sampling_params: T.any(
              OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::SamplingParams,
              OpenAI::Internal::AnyHash
            )
          )
            .returns(T.attached_class)
        end
        def self.new(input_messages:, model:, source:, type:, sampling_params: nil); end

        sig do
          override
            .returns(
              {
                input_messages: T.any(
                  OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template,
                  OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference
                ),
                model: String,
                source: T.any(
                  OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent,
                  OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileID,
                  OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions
                ),
                type: OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Type::OrSymbol,
                sampling_params: OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::SamplingParams
              }
            )
        end
        def to_hash; end

        module InputMessages
          extend OpenAI::Internal::Type::Union

          class Template < OpenAI::Internal::Type::BaseModel
            # A list of chat messages forming the prompt or context. May include variable
            # references to the "item" namespace, ie {{item.name}}.
            sig do
              returns(
                T::Array[
                  T.any(
                    OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::ChatMessage,
                    OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage,
                    OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage
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
                    OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::ChatMessage,
                    OpenAI::Internal::AnyHash,
                    OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage,
                    OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage
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
                        OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::ChatMessage,
                        OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage,
                        OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage
                      )
                    ],
                    type: Symbol
                  }
                )
            end
            def to_hash; end

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

              class InputMessage < OpenAI::Internal::Type::BaseModel
                sig do
                  returns(
                    OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Content
                  )
                end
                attr_reader :content

                sig do
                  params(
                    content: T.any(
                      OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Content,
                      OpenAI::Internal::AnyHash
                    )
                  )
                    .void
                end
                attr_writer :content

                # The role of the message. One of `user`, `system`, or `developer`.
                sig do
                  returns(
                    OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Role::OrSymbol
                  )
                end
                attr_accessor :role

                # The type of item, which is always `message`.
                sig do
                  returns(
                    OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Type::OrSymbol
                  )
                end
                attr_accessor :type

                sig do
                  params(
                    content: T.any(
                      OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Content,
                      OpenAI::Internal::AnyHash
                    ),
                    role: OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Role::OrSymbol,
                    type: OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Type::OrSymbol
                  )
                    .returns(T.attached_class)
                end
                def self.new(content:, role:, type:); end

                sig do
                  override
                    .returns(
                      {
                        content: OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Content,
                        role: OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Role::OrSymbol,
                        type: OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Type::OrSymbol
                      }
                    )
                end
                def to_hash; end

                class Content < OpenAI::Internal::Type::BaseModel
                  # The text content.
                  sig { returns(String) }
                  attr_accessor :text

                  # The type of content, which is always `input_text`.
                  sig do
                    returns(
                      OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Content::Type::OrSymbol
                    )
                  end
                  attr_accessor :type

                  sig do
                    params(
                      text: String,
                      type: OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Content::Type::OrSymbol
                    )
                      .returns(T.attached_class)
                  end
                  def self.new(text:, type:); end

                  sig do
                    override
                      .returns(
                        {
                          text: String,
                          type: OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Content::Type::OrSymbol
                        }
                      )
                  end
                  def to_hash; end

                  # The type of content, which is always `input_text`.
                  module Type
                    extend OpenAI::Internal::Type::Enum

                    TaggedSymbol =
                      T.type_alias do
                        T.all(Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Content::Type)
                      end
                    OrSymbol =
                      T.type_alias do
                        T.any(
                          Symbol,
                          String,
                          OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Content::Type::TaggedSymbol
                        )
                      end

                    INPUT_TEXT =
                      T.let(
                        :input_text,
                        OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Content::Type::TaggedSymbol
                      )

                    sig do
                      override
                        .returns(
                          T::Array[
                            OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Content::Type::TaggedSymbol
                          ]
                        )
                    end
                    def self.values; end
                  end
                end

                # The role of the message. One of `user`, `system`, or `developer`.
                module Role
                  extend OpenAI::Internal::Type::Enum

                  TaggedSymbol =
                    T.type_alias do
                      T.all(Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Role)
                    end
                  OrSymbol =
                    T.type_alias do
                      T.any(
                        Symbol,
                        String,
                        OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Role::TaggedSymbol
                      )
                    end

                  USER =
                    T.let(
                      :user,
                      OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Role::TaggedSymbol
                    )
                  SYSTEM =
                    T.let(
                      :system,
                      OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Role::TaggedSymbol
                    )
                  DEVELOPER =
                    T.let(
                      :developer,
                      OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Role::TaggedSymbol
                    )

                  sig do
                    override
                      .returns(
                        T::Array[
                          OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Role::TaggedSymbol
                        ]
                      )
                  end
                  def self.values; end
                end

                # The type of item, which is always `message`.
                module Type
                  extend OpenAI::Internal::Type::Enum

                  TaggedSymbol =
                    T.type_alias do
                      T.all(Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Type)
                    end
                  OrSymbol =
                    T.type_alias do
                      T.any(
                        Symbol,
                        String,
                        OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Type::TaggedSymbol
                      )
                    end

                  MESSAGE =
                    T.let(
                      :message,
                      OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Type::TaggedSymbol
                    )

                  sig do
                    override
                      .returns(
                        T::Array[
                          OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage::Type::TaggedSymbol
                        ]
                      )
                  end
                  def self.values; end
                end
              end

              class OutputMessage < OpenAI::Internal::Type::BaseModel
                sig do
                  returns(
                    OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Content
                  )
                end
                attr_reader :content

                sig do
                  params(
                    content: T.any(
                      OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Content,
                      OpenAI::Internal::AnyHash
                    )
                  )
                    .void
                end
                attr_writer :content

                # The role of the message. Must be `assistant` for output.
                sig do
                  returns(
                    OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Role::OrSymbol
                  )
                end
                attr_accessor :role

                # The type of item, which is always `message`.
                sig do
                  returns(
                    OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Type::OrSymbol
                  )
                end
                attr_accessor :type

                sig do
                  params(
                    content: T.any(
                      OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Content,
                      OpenAI::Internal::AnyHash
                    ),
                    role: OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Role::OrSymbol,
                    type: OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Type::OrSymbol
                  )
                    .returns(T.attached_class)
                end
                def self.new(content:, role:, type:); end

                sig do
                  override
                    .returns(
                      {
                        content: OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Content,
                        role: OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Role::OrSymbol,
                        type: OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Type::OrSymbol
                      }
                    )
                end
                def to_hash; end

                class Content < OpenAI::Internal::Type::BaseModel
                  # The text content.
                  sig { returns(String) }
                  attr_accessor :text

                  # The type of content, which is always `output_text`.
                  sig do
                    returns(
                      OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Content::Type::OrSymbol
                    )
                  end
                  attr_accessor :type

                  sig do
                    params(
                      text: String,
                      type: OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Content::Type::OrSymbol
                    )
                      .returns(T.attached_class)
                  end
                  def self.new(text:, type:); end

                  sig do
                    override
                      .returns(
                        {
                          text: String,
                          type: OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Content::Type::OrSymbol
                        }
                      )
                  end
                  def to_hash; end

                  # The type of content, which is always `output_text`.
                  module Type
                    extend OpenAI::Internal::Type::Enum

                    TaggedSymbol =
                      T.type_alias do
                        T.all(Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Content::Type)
                      end
                    OrSymbol =
                      T.type_alias do
                        T.any(
                          Symbol,
                          String,
                          OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Content::Type::TaggedSymbol
                        )
                      end

                    OUTPUT_TEXT =
                      T.let(
                        :output_text,
                        OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Content::Type::TaggedSymbol
                      )

                    sig do
                      override
                        .returns(
                          T::Array[
                            OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Content::Type::TaggedSymbol
                          ]
                        )
                    end
                    def self.values; end
                  end
                end

                # The role of the message. Must be `assistant` for output.
                module Role
                  extend OpenAI::Internal::Type::Enum

                  TaggedSymbol =
                    T.type_alias do
                      T.all(Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Role)
                    end
                  OrSymbol =
                    T.type_alias do
                      T.any(
                        Symbol,
                        String,
                        OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Role::TaggedSymbol
                      )
                    end

                  ASSISTANT =
                    T.let(
                      :assistant,
                      OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Role::TaggedSymbol
                    )

                  sig do
                    override
                      .returns(
                        T::Array[
                          OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Role::TaggedSymbol
                        ]
                      )
                  end
                  def self.values; end
                end

                # The type of item, which is always `message`.
                module Type
                  extend OpenAI::Internal::Type::Enum

                  TaggedSymbol =
                    T.type_alias do
                      T.all(Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Type)
                    end
                  OrSymbol =
                    T.type_alias do
                      T.any(
                        Symbol,
                        String,
                        OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Type::TaggedSymbol
                      )
                    end

                  MESSAGE =
                    T.let(
                      :message,
                      OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Type::TaggedSymbol
                    )

                  sig do
                    override
                      .returns(
                        T::Array[
                          OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage::Type::TaggedSymbol
                        ]
                      )
                  end
                  def self.values; end
                end
              end

              sig do
                override
                  .returns(
                    [OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::ChatMessage, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::InputMessage, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template::Template::OutputMessage]
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
                [OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::Template, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::InputMessages::ItemReference]
              )
          end
          def self.variants; end
        end

        # A StoredCompletionsRunDataSource configuration describing a set of filters
        module Source
          extend OpenAI::Internal::Type::Union

          class FileContent < OpenAI::Internal::Type::BaseModel
            # The content of the jsonl file.
            sig { returns(T::Array[OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent::Content]) }
            attr_accessor :content

            # The type of jsonl source. Always `file_content`.
            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(
                content: T::Array[
                  T.any(
                    OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent::Content,
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
                    content: T::Array[OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent::Content],
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
                  sample: T::Hash[Symbol, T.anything]
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

          class StoredCompletions < OpenAI::Internal::Type::BaseModel
            # An optional Unix timestamp to filter items created after this time.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :created_after

            # An optional Unix timestamp to filter items created before this time.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :created_before

            # An optional maximum number of items to return.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :limit

            # Set of 16 key-value pairs that can be attached to an object. This can be useful
            # for storing additional information about the object in a structured format, and
            # querying for objects via API or the dashboard.
            #
            # Keys are strings with a maximum length of 64 characters. Values are strings with
            # a maximum length of 512 characters.
            sig { returns(T.nilable(T::Hash[Symbol, String])) }
            attr_accessor :metadata

            # An optional model to filter by (e.g., 'gpt-4o').
            sig { returns(T.nilable(String)) }
            attr_accessor :model

            # The type of source. Always `stored_completions`.
            sig { returns(Symbol) }
            attr_accessor :type

            # A StoredCompletionsRunDataSource configuration describing a set of filters
            sig do
              params(
                created_after: T.nilable(Integer),
                created_before: T.nilable(Integer),
                limit: T.nilable(Integer),
                metadata: T.nilable(T::Hash[Symbol, String]),
                model: T.nilable(String),
                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(
              created_after:,
              created_before:,
              limit:,
              metadata:,
              model:,
              type: :stored_completions
            )
            end

            sig do
              override
                .returns(
                  {
                    created_after: T.nilable(Integer),
                    created_before: T.nilable(Integer),
                    limit: T.nilable(Integer),
                    metadata: T.nilable(T::Hash[Symbol, String]),
                    model: T.nilable(String),
                    type: Symbol
                  }
                )
            end
            def to_hash; end
          end

          sig do
            override
              .returns(
                [OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileContent, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::FileID, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Source::StoredCompletions]
              )
          end
          def self.variants; end
        end

        # The type of run data source. Always `completions`.
        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Type) }
          OrSymbol =
            T.type_alias { T.any(Symbol, String, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Type::TaggedSymbol) }

          COMPLETIONS =
            T.let(:completions, OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Type::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Evals::CreateEvalCompletionsRunDataSource::Type::TaggedSymbol]) }
          def self.values; end
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
    end
  end
end
