# typed: strong

module OpenAI
  module Models

    class DecisionCreateParams < OpenAI::Internal::Type::BaseModel

      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash = T.type_alias do
        T.any(
          OpenAI::DecisionCreateParams,
          OpenAI::Internal::AnyHash
        )
      end

      # The input to evaluate for every question. Provide a text string or an ordered
      # array of messages, function calls and outputs, or custom tool calls and outputs.
      # Each tool output must identify a matching call by call ID.
      sig { returns(OpenAI::DecisionCreateParams::Input::Variants) }
      attr_accessor :input

      # The model to use. Only `gpt-6-luna` is supported.
      sig { returns(String) }
      attr_accessor :model

      # Ask 1–400 questions about the input. Each question can be a predicate, choice,
      # or score. Answers come back in the same order.
      sig {
        returns(
          T::Array[
            T.any(
              OpenAI::DecisionCreateParams::Question::Predicate,
              OpenAI::DecisionCreateParams::Question::Choice,
              OpenAI::DecisionCreateParams::Question::Score
            )
          ]
        )
      }
      attr_accessor :questions

      # Partition prompt cache reuse by caller-provided key.
      sig { returns(T.nilable(String)) }
      attr_accessor :prompt_cache_key

      # Options for prompt caching. Supported for `gpt-5.6` and later models. By
      # default, OpenAI automatically chooses one implicit cache breakpoint. You can add
      # explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
      # request can write up to four breakpoints. For cache matching, OpenAI considers
      # up to the latest 80 breakpoints in the conversation, without a content-block
      # lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
      # `ttl` defaults to `30m`, which is currently the only supported value. See the
      # [prompt caching guide](https://developers.openai.com/api/docs/guides/prompt-caching)
      # for current details.
      sig { returns(T.nilable(OpenAI::DecisionCreateParams::PromptCacheOptions::OrHash)) }
      attr_accessor :prompt_cache_options

      # Opaque caller-provided end-user identifier, scoped by the verified org. Match
      # Responses' limit; this is never the authenticated user identity.
      sig { returns(T.nilable(String)) }
      attr_accessor :safety_identifier

      sig do
        params(

          input: OpenAI::DecisionCreateParams::Input::Variants,

          model: String,

          questions: T::Array[
            T.any(
              OpenAI::DecisionCreateParams::Question::Predicate::OrHash,
              OpenAI::DecisionCreateParams::Question::Choice::OrHash,
              OpenAI::DecisionCreateParams::Question::Score::OrHash
            )
          ],

          prompt_cache_key: T.nilable(String),

          prompt_cache_options: T.nilable(OpenAI::DecisionCreateParams::PromptCacheOptions::OrHash),

          safety_identifier: T.nilable(String),

          request_options: OpenAI::RequestOptions::OrHash
        )
          .returns(T.attached_class)
      end
      def self.new(

        # The input to evaluate for every question. Provide a text string or an ordered
        # array of messages, function calls and outputs, or custom tool calls and outputs.
        # Each tool output must identify a matching call by call ID.
        input:,

        # The model to use. Only `gpt-6-luna` is supported.
        model:,

        # Ask 1–400 questions about the input. Each question can be a predicate, choice,
        # or score. Answers come back in the same order.
        questions:,

        # Partition prompt cache reuse by caller-provided key.
        prompt_cache_key: nil,

        # Options for prompt caching. Supported for `gpt-5.6` and later models. By
        # default, OpenAI automatically chooses one implicit cache breakpoint. You can add
        # explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
        # request can write up to four breakpoints. For cache matching, OpenAI considers
        # up to the latest 80 breakpoints in the conversation, without a content-block
        # lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
        # `ttl` defaults to `30m`, which is currently the only supported value. See the
        # [prompt caching guide](https://developers.openai.com/api/docs/guides/prompt-caching)
        # for current details.
        prompt_cache_options: nil,

        # Opaque caller-provided end-user identifier, scoped by the verified org. Match
        # Responses' limit; this is never the authenticated user identity.
        safety_identifier: nil,

        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            input: OpenAI::DecisionCreateParams::Input::Variants,
            model: String,
            questions: T::Array[
              T.any(
                OpenAI::DecisionCreateParams::Question::Predicate,
                OpenAI::DecisionCreateParams::Question::Choice,
                OpenAI::DecisionCreateParams::Question::Score
              )
            ],
            prompt_cache_key: T.nilable(String),
            prompt_cache_options: T.nilable(OpenAI::DecisionCreateParams::PromptCacheOptions::OrHash),
            safety_identifier: T.nilable(String),
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end

      # The input to evaluate for every question. Provide a text string or an ordered
      # array of messages, function calls and outputs, or custom tool calls and outputs.
      # Each tool output must identify a matching call by call ID.
      module Input
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias {
          T.any(String, T::Array[OpenAI::DecisionCreateParams::Input::UnionMember1::Variants])
        }

        # A user message containing input text, images, or JSON.
        module UnionMember1
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias {
            T.any(
              T.any(
                T.any(OpenAI::DecisionInputMessage, OpenAI::DecisionInputMessageUnion::Variants),
                OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputUserMessage
              ),
              OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputDeveloperMessage,
              OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputSystemMessage,
              OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage,
              OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCall,
              OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput,
              OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCall,
              OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput
            )
          }

          class DecisionInputUserMessage < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputUserMessage,
                OpenAI::Internal::AnyHash
              )
            end

            # A text string or an ordered list of text, image, and JSON parts.
            sig {
              returns(OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputUserMessage::Content::Variants)
            }
            attr_accessor :content

            sig { returns(Symbol) }
            attr_accessor :role

            sig {
              returns(
                T.nilable(OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputUserMessage::Type::OrSymbol)
              )
            }
            attr_reader :type

            sig {
              params(type: OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputUserMessage::Type::OrSymbol)
                .void
            }
            attr_writer :type

            # A user message containing input text, images, or JSON.
            sig do
              params(

                content: OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputUserMessage::Content::Variants,

                type: OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputUserMessage::Type::OrSymbol,

                role: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # A text string or an ordered list of text, image, and JSON parts.
              content:,

              type: nil,

              role: :user
            )
            end

            sig do
              override.returns(
                {
                  content: OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputUserMessage::Content::Variants,
                  role: Symbol,
                  type: OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputUserMessage::Type::OrSymbol
                }
              )
            end
            def to_hash
            end

            # A text string or an ordered list of text, image, and JSON parts.
            module Content
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias { T.any(String, T::Array[OpenAI::DecisionInputPart::Variants]) }

              sig {
                override.returns(
                  T::Array[
                    OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputUserMessage::Content::Variants
                  ]
                )
              }
              def self.variants
              end

              DecisionInputPartArray = T.let(
                OpenAI::Internal::Type::ArrayOf[union: OpenAI::DecisionInputPart],
                OpenAI::Internal::Type::Converter
              )

            end

            module Type
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias {
                T.all(Symbol, OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputUserMessage::Type)
              }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              MESSAGE = T.let(
                :message,
                OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputUserMessage::Type::TaggedSymbol
              )

              sig {
                override.returns(
                  T::Array[
                    OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputUserMessage::Type::TaggedSymbol
                  ]
                )
              }
              def self.values
              end
            end
          end

          class DecisionInputDeveloperMessage < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputDeveloperMessage,
                OpenAI::Internal::AnyHash
              )
            end

            # A text string or an ordered list of input text parts.
            sig {
              returns(
                OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputDeveloperMessage::Content::Variants
              )
            }
            attr_accessor :content

            sig { returns(Symbol) }
            attr_accessor :role

            sig {
              returns(
                T.nilable(
                  OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputDeveloperMessage::Type::OrSymbol
                )
              )
            }
            attr_reader :type

            sig {
              params(
                type: OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputDeveloperMessage::Type::OrSymbol
              )
                .void
            }
            attr_writer :type

            # A developer message containing input text.
            sig do
              params(

                content: OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputDeveloperMessage::Content::Variants,

                type: OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputDeveloperMessage::Type::OrSymbol,

                role: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # A text string or an ordered list of input text parts.
              content:,

              type: nil,

              role: :developer
            )
            end

            sig do
              override.returns(
                {
                  content: OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputDeveloperMessage::Content::Variants,
                  role: Symbol,
                  type: OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputDeveloperMessage::Type::OrSymbol
                }
              )
            end
            def to_hash
            end

            # A text string or an ordered list of input text parts.
            module Content
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias { T.any(String, T::Array[OpenAI::DecisionInputText]) }

              sig {
                override.returns(
                  T::Array[
                    OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputDeveloperMessage::Content::Variants
                  ]
                )
              }
              def self.variants
              end

              DecisionInputTextArray = T.let(
                OpenAI::Internal::Type::ArrayOf[OpenAI::DecisionInputText],
                OpenAI::Internal::Type::Converter
              )

            end

            module Type
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias {
                T.all(Symbol, OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputDeveloperMessage::Type)
              }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              MESSAGE = T.let(
                :message,
                OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputDeveloperMessage::Type::TaggedSymbol
              )

              sig {
                override.returns(
                  T::Array[
                    OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputDeveloperMessage::Type::TaggedSymbol
                  ]
                )
              }
              def self.values
              end
            end
          end

          class DecisionInputSystemMessage < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputSystemMessage,
                OpenAI::Internal::AnyHash
              )
            end

            # A text string or an ordered list of input text parts.
            sig {
              returns(OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputSystemMessage::Content::Variants)
            }
            attr_accessor :content

            sig { returns(Symbol) }
            attr_accessor :role

            sig {
              returns(
                T.nilable(OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputSystemMessage::Type::OrSymbol)
              )
            }
            attr_reader :type

            sig {
              params(
                type: OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputSystemMessage::Type::OrSymbol
              )
                .void
            }
            attr_writer :type

            # A system message containing input text.
            sig do
              params(

                content: OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputSystemMessage::Content::Variants,

                type: OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputSystemMessage::Type::OrSymbol,

                role: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # A text string or an ordered list of input text parts.
              content:,

              type: nil,

              role: :system
            )
            end

            sig do
              override.returns(
                {
                  content: OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputSystemMessage::Content::Variants,
                  role: Symbol,
                  type: OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputSystemMessage::Type::OrSymbol
                }
              )
            end
            def to_hash
            end

            # A text string or an ordered list of input text parts.
            module Content
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias { T.any(String, T::Array[OpenAI::DecisionInputText]) }

              sig {
                override.returns(
                  T::Array[
                    OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputSystemMessage::Content::Variants
                  ]
                )
              }
              def self.variants
              end

              DecisionInputTextArray = T.let(
                OpenAI::Internal::Type::ArrayOf[OpenAI::DecisionInputText],
                OpenAI::Internal::Type::Converter
              )

            end

            module Type
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias {
                T.all(Symbol, OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputSystemMessage::Type)
              }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              MESSAGE = T.let(
                :message,
                OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputSystemMessage::Type::TaggedSymbol
              )

              sig {
                override.returns(
                  T::Array[
                    OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputSystemMessage::Type::TaggedSymbol
                  ]
                )
              }
              def self.values
              end
            end
          end

          class DecisionInputAssistantMessage < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage,
                OpenAI::Internal::AnyHash
              )
            end

            # A text string or an ordered list of output text and refusal parts.
            sig {
              returns(
                OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Content::Variants
              )
            }
            attr_accessor :content

            sig { returns(Symbol) }
            attr_accessor :role

            # The phase of an assistant message.
            sig {
              returns(
                T.nilable(
                  OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Phase::OrSymbol
                )
              )
            }
            attr_accessor :phase

            sig {
              returns(
                T.nilable(
                  OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Type::OrSymbol
                )
              )
            }
            attr_reader :type

            sig {
              params(
                type: OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Type::OrSymbol
              )
                .void
            }
            attr_writer :type

            # An assistant message containing output text or refusals.
            sig do
              params(

                content: OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Content::Variants,

                phase: T.nilable(
                  OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Phase::OrSymbol
                ),

                type: OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Type::OrSymbol,

                role: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              # A text string or an ordered list of output text and refusal parts.
              content:,

              # The phase of an assistant message.
              phase: nil,

              type: nil,

              role: :assistant
            )
            end

            sig do
              override.returns(
                {
                  content: OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Content::Variants,
                  role: Symbol,
                  phase: T.nilable(
                    OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Phase::OrSymbol
                  ),
                  type: OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Type::OrSymbol
                }
              )
            end
            def to_hash
            end

            # A text string or an ordered list of output text and refusal parts.
            module Content
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias {
                T.any(
                  String,
                  T::Array[
                    OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Content::Part::Variants
                  ]
                )
              }

              module Part
                extend OpenAI::Internal::Type::Union

                Variants = T.type_alias {
                  T.any(
                    OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Content::Part::OutputText,
                    OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Content::Part::Refusal
                  )
                }

                class OutputText < OpenAI::Internal::Type::BaseModel
                  OrHash = T.type_alias do
                    T.any(
                      OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Content::Part::OutputText,
                      OpenAI::Internal::AnyHash
                    )
                  end

                  sig { returns(String) }
                  attr_accessor :text

                  sig { returns(Symbol) }
                  attr_accessor :type

                  sig do
                    params(

                      text: String,

                      type: Symbol
                    )
                      .returns(T.attached_class)
                  end
                  def self.new(

                    text:,

                    type: :output_text
                  )
                  end

                  sig do
                    override.returns(
                      {text: String, type: Symbol}
                    )
                  end
                  def to_hash
                  end

                end

                class Refusal < OpenAI::Internal::Type::BaseModel
                  OrHash = T.type_alias do
                    T.any(
                      OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Content::Part::Refusal,
                      OpenAI::Internal::AnyHash
                    )
                  end

                  sig { returns(String) }
                  attr_accessor :refusal

                  sig { returns(Symbol) }
                  attr_accessor :type

                  sig do
                    params(

                      refusal: String,

                      type: Symbol
                    )
                      .returns(T.attached_class)
                  end
                  def self.new(

                    refusal:,

                    type: :refusal
                  )
                  end

                  sig do
                    override.returns(
                      {refusal: String, type: Symbol}
                    )
                  end
                  def to_hash
                  end

                end

                sig {
                  override.returns(
                    T::Array[
                      OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Content::Part::Variants
                    ]
                  )
                }
                def self.variants
                end

              end

              sig {
                override.returns(
                  T::Array[
                    OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Content::Variants
                  ]
                )
              }
              def self.variants
              end

              PartsArray = T.let(
                OpenAI::Internal::Type::ArrayOf[
                  union: OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Content::Part
                ],
                OpenAI::Internal::Type::Converter
              )

            end

            # The phase of an assistant message.
            module Phase
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias {
                T.all(Symbol, OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Phase)
              }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              COMMENTARY = T.let(
                :commentary,
                OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Phase::TaggedSymbol
              )
              FINAL_ANSWER = T.let(
                :final_answer,
                OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Phase::TaggedSymbol
              )

              sig {
                override.returns(
                  T::Array[
                    OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Phase::TaggedSymbol
                  ]
                )
              }
              def self.values
              end
            end

            module Type
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias {
                T.all(Symbol, OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Type)
              }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              MESSAGE = T.let(
                :message,
                OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Type::TaggedSymbol
              )

              sig {
                override.returns(
                  T::Array[
                    OpenAI::DecisionCreateParams::Input::UnionMember1::DecisionInputAssistantMessage::Type::TaggedSymbol
                  ]
                )
              }
              def self.values
              end
            end
          end

          class FunctionCall < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCall,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :arguments

            sig { returns(String) }
            attr_accessor :call_id

            sig { returns(String) }
            attr_accessor :name

            sig { returns(Symbol) }
            attr_accessor :type

            sig { returns(T.nilable(String)) }
            attr_accessor :id

            sig { returns(T.nilable(String)) }
            attr_accessor :namespace

            sig {
              returns(T.nilable(OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCall::Status::OrSymbol))
            }
            attr_accessor :status

            sig do
              params(

                arguments: String,

                call_id: String,

                name: String,

                id: T.nilable(String),

                namespace: T.nilable(String),

                status: T.nilable(OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCall::Status::OrSymbol),

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              arguments:,

              call_id:,

              name:,

              id: nil,

              namespace: nil,

              status: nil,

              type: :function_call
            )
            end

            sig do
              override.returns(
                {
                  arguments: String,
                  call_id: String,
                  name: String,
                  type: Symbol,
                  id: T.nilable(String),
                  namespace: T.nilable(String),
                  status: T.nilable(OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCall::Status::OrSymbol)
                }
              )
            end
            def to_hash
            end

            module Status
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias {
                T.all(Symbol, OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCall::Status)
              }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              IN_PROGRESS = T.let(
                :in_progress,
                OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCall::Status::TaggedSymbol
              )
              COMPLETED = T.let(
                :completed,
                OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCall::Status::TaggedSymbol
              )
              INCOMPLETE = T.let(
                :incomplete,
                OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCall::Status::TaggedSymbol
              )

              sig {
                override.returns(
                  T::Array[OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCall::Status::TaggedSymbol]
                )
              }
              def self.values
              end
            end
          end

          class FunctionCallOutput < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :call_id

            # Text evidence or an ordered list of text and image parts.
            sig { returns(OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput::Output::Variants) }
            attr_accessor :output

            sig { returns(Symbol) }
            attr_accessor :type

            sig { returns(T.nilable(String)) }
            attr_accessor :id

            sig {
              returns(
                T.nilable(OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput::Status::OrSymbol)
              )
            }
            attr_accessor :status

            sig do
              params(

                call_id: String,

                output: OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput::Output::Variants,

                id: T.nilable(String),

                status: T.nilable(
                  OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput::Status::OrSymbol
                ),

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              call_id:,

              # Text evidence or an ordered list of text and image parts.
              output:,

              id: nil,

              status: nil,

              type: :function_call_output
            )
            end

            sig do
              override.returns(
                {
                  call_id: String,
                  output: OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput::Output::Variants,
                  type: Symbol,
                  id: T.nilable(String),
                  status: T.nilable(
                    OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput::Status::OrSymbol
                  )
                }
              )
            end
            def to_hash
            end

            # Text evidence or an ordered list of text and image parts.
            module Output
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias {
                T.any(
                  String,
                  T::Array[
                    OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput::Output::Part::Variants
                  ]
                )
              }

              # An image provided as a base64 data URL or a publicly accessible HTTP(S) URL.
              # File IDs are not supported.
              module Part
                extend OpenAI::Internal::Type::Union

                Variants = T.type_alias { T.any(OpenAI::DecisionInputText, OpenAI::DecisionInputImage) }

                sig {
                  override.returns(
                    T::Array[
                      OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput::Output::Part::Variants
                    ]
                  )
                }
                def self.variants
                end

              end

              sig {
                override.returns(
                  T::Array[OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput::Output::Variants]
                )
              }
              def self.variants
              end

              PartsArray = T.let(
                OpenAI::Internal::Type::ArrayOf[
                  union: OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput::Output::Part
                ],
                OpenAI::Internal::Type::Converter
              )

            end

            module Status
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias {
                T.all(Symbol, OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput::Status)
              }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              IN_PROGRESS = T.let(
                :in_progress,
                OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput::Status::TaggedSymbol
              )
              COMPLETED = T.let(
                :completed,
                OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput::Status::TaggedSymbol
              )
              INCOMPLETE = T.let(
                :incomplete,
                OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput::Status::TaggedSymbol
              )

              sig {
                override.returns(
                  T::Array[OpenAI::DecisionCreateParams::Input::UnionMember1::FunctionCallOutput::Status::TaggedSymbol]
                )
              }
              def self.values
              end
            end
          end

          class CustomToolCall < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCall,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :call_id

            sig { returns(String) }
            attr_accessor :input

            sig { returns(String) }
            attr_accessor :name

            sig { returns(Symbol) }
            attr_accessor :type

            sig { returns(T.nilable(String)) }
            attr_accessor :id

            sig { returns(T.nilable(String)) }
            attr_accessor :namespace

            sig {
              returns(T.nilable(OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCall::Status::OrSymbol))
            }
            attr_accessor :status

            sig do
              params(

                call_id: String,

                input: String,

                name: String,

                id: T.nilable(String),

                namespace: T.nilable(String),

                status: T.nilable(OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCall::Status::OrSymbol),

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              call_id:,

              input:,

              name:,

              id: nil,

              namespace: nil,

              status: nil,

              type: :custom_tool_call
            )
            end

            sig do
              override.returns(
                {
                  call_id: String,
                  input: String,
                  name: String,
                  type: Symbol,
                  id: T.nilable(String),
                  namespace: T.nilable(String),
                  status: T.nilable(OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCall::Status::OrSymbol)
                }
              )
            end
            def to_hash
            end

            module Status
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias {
                T.all(Symbol, OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCall::Status)
              }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              IN_PROGRESS = T.let(
                :in_progress,
                OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCall::Status::TaggedSymbol
              )
              COMPLETED = T.let(
                :completed,
                OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCall::Status::TaggedSymbol
              )
              INCOMPLETE = T.let(
                :incomplete,
                OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCall::Status::TaggedSymbol
              )

              sig {
                override.returns(
                  T::Array[OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCall::Status::TaggedSymbol]
                )
              }
              def self.values
              end
            end
          end

          class CustomToolCallOutput < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :call_id

            # Text evidence or an ordered list of text and image parts.
            sig { returns(OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput::Output::Variants) }
            attr_accessor :output

            sig { returns(Symbol) }
            attr_accessor :type

            sig { returns(T.nilable(String)) }
            attr_accessor :id

            sig {
              returns(
                T.nilable(OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput::Status::OrSymbol)
              )
            }
            attr_accessor :status

            sig do
              params(

                call_id: String,

                output: OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput::Output::Variants,

                id: T.nilable(String),

                status: T.nilable(
                  OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput::Status::OrSymbol
                ),

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              call_id:,

              # Text evidence or an ordered list of text and image parts.
              output:,

              id: nil,

              status: nil,

              type: :custom_tool_call_output
            )
            end

            sig do
              override.returns(
                {
                  call_id: String,
                  output: OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput::Output::Variants,
                  type: Symbol,
                  id: T.nilable(String),
                  status: T.nilable(
                    OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput::Status::OrSymbol
                  )
                }
              )
            end
            def to_hash
            end

            # Text evidence or an ordered list of text and image parts.
            module Output
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias {
                T.any(
                  String,
                  T::Array[
                    OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput::Output::Part::Variants
                  ]
                )
              }

              # An image provided as a base64 data URL or a publicly accessible HTTP(S) URL.
              # File IDs are not supported.
              module Part
                extend OpenAI::Internal::Type::Union

                Variants = T.type_alias { T.any(OpenAI::DecisionInputText, OpenAI::DecisionInputImage) }

                sig {
                  override.returns(
                    T::Array[
                      OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput::Output::Part::Variants
                    ]
                  )
                }
                def self.variants
                end

              end

              sig {
                override.returns(
                  T::Array[OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput::Output::Variants]
                )
              }
              def self.variants
              end

              PartsArray = T.let(
                OpenAI::Internal::Type::ArrayOf[
                  union: OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput::Output::Part
                ],
                OpenAI::Internal::Type::Converter
              )

            end

            module Status
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias {
                T.all(Symbol, OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput::Status)
              }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              IN_PROGRESS = T.let(
                :in_progress,
                OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput::Status::TaggedSymbol
              )
              COMPLETED = T.let(
                :completed,
                OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput::Status::TaggedSymbol
              )
              INCOMPLETE = T.let(
                :incomplete,
                OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput::Status::TaggedSymbol
              )

              sig {
                override.returns(
                  T::Array[
                    OpenAI::DecisionCreateParams::Input::UnionMember1::CustomToolCallOutput::Status::TaggedSymbol
                  ]
                )
              }
              def self.values
              end
            end
          end

          sig { override.returns(T::Array[OpenAI::DecisionCreateParams::Input::UnionMember1::Variants]) }
          def self.variants
          end

        end

        sig { override.returns(T::Array[OpenAI::DecisionCreateParams::Input::Variants]) }
        def self.variants
        end

        UnionMember1Array = T.let(
          OpenAI::Internal::Type::ArrayOf[union: OpenAI::DecisionCreateParams::Input::UnionMember1],
          OpenAI::Internal::Type::Converter
        )

      end

      # A question about the request's input, with an optional correlation name.
      module Question
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias {
          T.any(
            OpenAI::DecisionCreateParams::Question::Predicate,
            OpenAI::DecisionCreateParams::Question::Choice,
            OpenAI::DecisionCreateParams::Question::Score
          )
        }

        class Predicate < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::DecisionCreateParams::Question::Predicate,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(OpenAI::DecisionCreateParams::Question::Predicate::Instructions::Variants) }
          attr_accessor :instructions

          # The type of the object. Always `predicate`.
          sig { returns(Symbol) }
          attr_accessor :type

          sig { returns(T.nilable(String)) }
          attr_reader :name

          sig { params(name: String).void }
          attr_writer :name

          # Estimate how likely it is that a statement about the input is true.
          sig do
            params(

              instructions: OpenAI::DecisionCreateParams::Question::Predicate::Instructions::Variants,

              name: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            instructions:,

            name: nil,

            # The type of the object. Always `predicate`.

            type: :predicate
          )
          end

          sig do
            override.returns(
              {
                instructions: OpenAI::DecisionCreateParams::Question::Predicate::Instructions::Variants,
                type: Symbol,
                name: String
              }
            )
          end
          def to_hash
          end

          module Instructions
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias { T.any(String, T::Array[OpenAI::DecisionQuestionInputPart::Variants]) }

            sig {
              override.returns(T::Array[OpenAI::DecisionCreateParams::Question::Predicate::Instructions::Variants])
            }
            def self.variants
            end

            DecisionQuestionInputPartArray = T.let(
              OpenAI::Internal::Type::ArrayOf[union: OpenAI::DecisionQuestionInputPart],
              OpenAI::Internal::Type::Converter
            )

          end
        end

        class Choice < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::DecisionCreateParams::Question::Choice,
              OpenAI::Internal::AnyHash
            )
          end

          # Provide between 2 and 255 choices. Each choice must be unique.
          sig { returns(T::Array[OpenAI::DecisionCreateParams::Question::Choice::Choice]) }
          attr_accessor :choices

          sig { returns(OpenAI::DecisionCreateParams::Question::Choice::Instructions::Variants) }
          attr_accessor :instructions

          # The type of the object. Always `choice`.
          sig { returns(Symbol) }
          attr_accessor :type

          sig { returns(T.nilable(String)) }
          attr_reader :name

          sig { params(name: String).void }
          attr_writer :name

          # Choose from the supplied options based on the input.
          sig do
            params(

              choices: T::Array[OpenAI::DecisionCreateParams::Question::Choice::Choice::OrHash],

              instructions: OpenAI::DecisionCreateParams::Question::Choice::Instructions::Variants,

              name: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Provide between 2 and 255 choices. Each choice must be unique.
            choices:,

            instructions:,

            name: nil,

            # The type of the object. Always `choice`.

            type: :choice
          )
          end

          sig do
            override.returns(
              {
                choices: T::Array[OpenAI::DecisionCreateParams::Question::Choice::Choice],
                instructions: OpenAI::DecisionCreateParams::Question::Choice::Instructions::Variants,
                type: Symbol,
                name: String
              }
            )
          end
          def to_hash
          end

          class Choice < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::DecisionCreateParams::Question::Choice::Choice,
                OpenAI::Internal::AnyHash
              )
            end

            # Choice values are typed: a string and a boolean with the same text are distinct.
            sig { returns(T.any(String, T::Boolean)) }
            attr_accessor :value

            sig { returns(T.nilable(String)) }
            attr_reader :description

            sig { params(description: String).void }
            attr_writer :description

            sig do
              params(

                value: T.any(String, T::Boolean),

                description: String
              )
                .returns(T.attached_class)
            end
            def self.new(

              # Choice values are typed: a string and a boolean with the same text are distinct.
              value:,

              description: nil
            )
            end

            sig do
              override.returns(
                {value: T.any(String, T::Boolean), description: String}
              )
            end
            def to_hash
            end

            # Choice values are typed: a string and a boolean with the same text are distinct.
            module Value
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias { T.any(String, T::Boolean) }

              sig {
                override.returns(T::Array[OpenAI::DecisionCreateParams::Question::Choice::Choice::Value::Variants])
              }
              def self.variants
              end

            end
          end

          module Instructions
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias { T.any(String, T::Array[OpenAI::DecisionQuestionInputPart::Variants]) }

            sig { override.returns(T::Array[OpenAI::DecisionCreateParams::Question::Choice::Instructions::Variants]) }
            def self.variants
            end

            DecisionQuestionInputPartArray = T.let(
              OpenAI::Internal::Type::ArrayOf[union: OpenAI::DecisionQuestionInputPart],
              OpenAI::Internal::Type::Converter
            )

          end
        end

        class Score < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::DecisionCreateParams::Question::Score,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(OpenAI::DecisionCreateParams::Question::Score::Instructions::Variants) }
          attr_accessor :instructions

          sig { returns(T::Array[OpenAI::DecisionCreateParams::Question::Score::Level]) }
          attr_accessor :levels

          # The type of the object. Always `score`.
          sig { returns(Symbol) }
          attr_accessor :type

          sig { returns(T.nilable(String)) }
          attr_reader :name

          sig { params(name: String).void }
          attr_writer :name

          # Rate the input against the supplied ordered levels.
          sig do
            params(

              instructions: OpenAI::DecisionCreateParams::Question::Score::Instructions::Variants,

              levels: T::Array[OpenAI::DecisionCreateParams::Question::Score::Level::OrHash],

              name: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            instructions:,

            levels:,

            name: nil,

            # The type of the object. Always `score`.

            type: :score
          )
          end

          sig do
            override.returns(
              {
                instructions: OpenAI::DecisionCreateParams::Question::Score::Instructions::Variants,
                levels: T::Array[OpenAI::DecisionCreateParams::Question::Score::Level],
                type: Symbol,
                name: String
              }
            )
          end
          def to_hash
          end

          module Instructions
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias { T.any(String, T::Array[OpenAI::DecisionQuestionInputPart::Variants]) }

            sig { override.returns(T::Array[OpenAI::DecisionCreateParams::Question::Score::Instructions::Variants]) }
            def self.variants
            end

            DecisionQuestionInputPartArray = T.let(
              OpenAI::Internal::Type::ArrayOf[union: OpenAI::DecisionQuestionInputPart],
              OpenAI::Internal::Type::Converter
            )

          end

          class Level < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::DecisionCreateParams::Question::Score::Level,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :label

            sig { returns(T.nilable(String)) }
            attr_reader :description

            sig { params(description: String).void }
            attr_writer :description

            sig do
              params(

                label: String,

                description: String
              )
                .returns(T.attached_class)
            end
            def self.new(

              label:,

              description: nil
            )
            end

            sig do
              override.returns(
                {label: String, description: String}
              )
            end
            def to_hash
            end

          end
        end

        sig { override.returns(T::Array[OpenAI::DecisionCreateParams::Question::Variants]) }
        def self.variants
        end

      end

      class PromptCacheOptions < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias do
          T.any(
            OpenAI::DecisionCreateParams::PromptCacheOptions,
            OpenAI::Internal::AnyHash
          )
        end

        # Controls whether OpenAI automatically creates an implicit cache breakpoint.
        # Defaults to `implicit`. With `implicit`, OpenAI creates one implicit breakpoint
        # and writes up to the latest three explicit breakpoints in the request. With
        # `explicit`, OpenAI does not create an implicit breakpoint and writes up to the
        # latest four explicit breakpoints. If there are no explicit breakpoints, the
        # request does not use prompt caching.
        sig { returns(T.nilable(OpenAI::DecisionCreateParams::PromptCacheOptions::Mode::OrSymbol)) }
        attr_accessor :mode

        # The minimum lifetime applied to every implicit and explicit cache breakpoint
        # written by the request. Defaults to `30m`, which is currently the only supported
        # value. The backend may retain cache entries for longer.
        sig { returns(T.nilable(OpenAI::DecisionCreateParams::PromptCacheOptions::Ttl::OrSymbol)) }
        attr_reader :ttl

        sig { params(ttl: OpenAI::DecisionCreateParams::PromptCacheOptions::Ttl::OrSymbol).void }
        attr_writer :ttl

        # Options for prompt caching. Supported for `gpt-5.6` and later models. By
        # default, OpenAI automatically chooses one implicit cache breakpoint. You can add
        # explicit breakpoints to content blocks with `prompt_cache_breakpoint`. Each
        # request can write up to four breakpoints. For cache matching, OpenAI considers
        # up to the latest 80 breakpoints in the conversation, without a content-block
        # lookback limit. Set `mode` to `explicit` to disable the implicit breakpoint. The
        # `ttl` defaults to `30m`, which is currently the only supported value. See the
        # [prompt caching guide](https://developers.openai.com/api/docs/guides/prompt-caching)
        # for current details.
        sig do
          params(

            mode: T.nilable(OpenAI::DecisionCreateParams::PromptCacheOptions::Mode::OrSymbol),

            ttl: OpenAI::DecisionCreateParams::PromptCacheOptions::Ttl::OrSymbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Controls whether OpenAI automatically creates an implicit cache breakpoint.
          # Defaults to `implicit`. With `implicit`, OpenAI creates one implicit breakpoint
          # and writes up to the latest three explicit breakpoints in the request. With
          # `explicit`, OpenAI does not create an implicit breakpoint and writes up to the
          # latest four explicit breakpoints. If there are no explicit breakpoints, the
          # request does not use prompt caching.
          mode: nil,

          # The minimum lifetime applied to every implicit and explicit cache breakpoint
          # written by the request. Defaults to `30m`, which is currently the only supported
          # value. The backend may retain cache entries for longer.

          ttl: nil
        )
        end

        sig do
          override.returns(
            {
              mode: T.nilable(OpenAI::DecisionCreateParams::PromptCacheOptions::Mode::OrSymbol),
              ttl: OpenAI::DecisionCreateParams::PromptCacheOptions::Ttl::OrSymbol
            }
          )
        end
        def to_hash
        end

        # Controls whether OpenAI automatically creates an implicit cache breakpoint.
        # Defaults to `implicit`. With `implicit`, OpenAI creates one implicit breakpoint
        # and writes up to the latest three explicit breakpoints in the request. With
        # `explicit`, OpenAI does not create an implicit breakpoint and writes up to the
        # latest four explicit breakpoints. If there are no explicit breakpoints, the
        # request does not use prompt caching.
        module Mode
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::DecisionCreateParams::PromptCacheOptions::Mode) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IMPLICIT = T.let(:implicit, OpenAI::DecisionCreateParams::PromptCacheOptions::Mode::TaggedSymbol)
          EXPLICIT = T.let(:explicit, OpenAI::DecisionCreateParams::PromptCacheOptions::Mode::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::DecisionCreateParams::PromptCacheOptions::Mode::TaggedSymbol]) }
          def self.values
          end
        end

        # The minimum lifetime applied to every implicit and explicit cache breakpoint
        # written by the request. Defaults to `30m`, which is currently the only supported
        # value. The backend may retain cache entries for longer.
        module Ttl
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::DecisionCreateParams::PromptCacheOptions::Ttl) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          TTL_30M = T.let(:"30m", OpenAI::DecisionCreateParams::PromptCacheOptions::Ttl::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::DecisionCreateParams::PromptCacheOptions::Ttl::TaggedSymbol]) }
          def self.values
          end
        end
      end

    end

  end
end
