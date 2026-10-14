# typed: strong

module OpenAI
  module Models
    module Beta
      module Responses
        class InputTokenCountParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::Responses::InputTokenCountParams,
                OpenAI::Internal::AnyHash
              )
            end

          # The conversation that this response belongs to. Items from this conversation are
          # prepended to `input_items` for this response request. Input items and output
          # items from this response are automatically added to this conversation after this
          # response completes.
          sig do
            returns(
              T.nilable(
                T.any(String, OpenAI::Beta::BetaResponseConversationParam)
              )
            )
          end
          attr_accessor :conversation

          # Text, image, or file inputs to the model, used to generate a response
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::Responses::InputTokenCountParams::Input::Variants
              )
            )
          end
          attr_accessor :input

          # A system (or developer) message inserted into the model's context. When used
          # along with `previous_response_id`, the instructions from a previous response
          # will not be carried over to the next response. This makes it simple to swap out
          # system (or developer) messages in new responses.
          sig { returns(T.nilable(String)) }
          attr_accessor :instructions

          # Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI offers a
          # wide range of models with different capabilities, performance characteristics,
          # and price points. Refer to the
          # [model guide](https://platform.openai.com/docs/models) to browse and compare
          # available models.
          sig { returns(T.nilable(String)) }
          attr_accessor :model

          # Whether to allow the model to run tool calls in parallel.
          sig { returns(T.nilable(T::Boolean)) }
          attr_accessor :parallel_tool_calls

          # A model-owned style preset to apply to this request. Omit this parameter to use
          # the model's default style. Supported values may expand over time. Values must be
          # at most 64 characters.
          sig do
            returns(
              T.nilable(
                T.any(
                  String,
                  OpenAI::Beta::Responses::InputTokenCountParams::Personality::OrSymbol
                )
              )
            )
          end
          attr_reader :personality

          sig do
            params(
              personality:
                T.any(
                  String,
                  OpenAI::Beta::Responses::InputTokenCountParams::Personality::OrSymbol
                )
            ).void
          end
          attr_writer :personality

          # The unique ID of the previous response to the model. Use this to create
          # multi-turn conversations. Learn more about
          # [conversation state](https://platform.openai.com/docs/guides/conversation-state).
          # Cannot be used in conjunction with `conversation`.
          sig { returns(T.nilable(String)) }
          attr_accessor :previous_response_id

          # **gpt-5 and o-series models only** Configuration options for
          # [reasoning models](https://platform.openai.com/docs/guides/reasoning).
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::Responses::InputTokenCountParams::Reasoning
              )
            )
          end
          attr_reader :reasoning

          sig do
            params(
              reasoning:
                T.nilable(
                  OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::OrHash
                )
            ).void
          end
          attr_writer :reasoning

          # Configuration options for a text response from the model. Can be plain text or
          # structured JSON data. Learn more:
          #
          # - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
          # - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
          sig do
            returns(
              T.nilable(OpenAI::Beta::Responses::InputTokenCountParams::Text)
            )
          end
          attr_reader :text

          sig do
            params(
              text:
                T.nilable(
                  OpenAI::Beta::Responses::InputTokenCountParams::Text::OrHash
                )
            ).void
          end
          attr_writer :text

          # Controls which tool the model should use, if any.
          sig do
            returns(
              T.nilable(
                T.any(
                  OpenAI::Beta::BetaToolChoiceOptions::OrSymbol,
                  OpenAI::Beta::BetaToolChoiceAllowed,
                  OpenAI::Beta::BetaToolChoiceTypes,
                  OpenAI::Beta::BetaToolChoiceFunction,
                  OpenAI::Beta::BetaToolChoiceMcp,
                  OpenAI::Beta::BetaToolChoiceCustom,
                  OpenAI::Beta::Responses::InputTokenCountParams::ToolChoice::BetaSpecificProgrammaticToolCallingParam,
                  OpenAI::Beta::BetaToolChoiceApplyPatch,
                  OpenAI::Beta::BetaToolChoiceShell
                )
              )
            )
          end
          attr_accessor :tool_choice

          # An array of tools the model may call while generating a response. You can
          # specify which tool to use by setting the `tool_choice` parameter.
          sig do
            returns(
              T.nilable(
                T::Array[
                  T.any(
                    OpenAI::Beta::BetaFunctionTool,
                    OpenAI::Beta::BetaFileSearchTool,
                    OpenAI::Beta::BetaComputerTool,
                    OpenAI::Beta::BetaComputerUsePreviewTool,
                    OpenAI::Beta::BetaTool::Mcp,
                    OpenAI::Beta::BetaTool::CodeInterpreter,
                    OpenAI::Beta::BetaTool::ProgrammaticToolCalling,
                    OpenAI::Beta::BetaTool::ImageGeneration,
                    OpenAI::Beta::BetaTool::LocalShell,
                    OpenAI::Beta::BetaFunctionShellTool,
                    OpenAI::Beta::BetaCustomTool,
                    OpenAI::Beta::BetaNamespaceTool,
                    OpenAI::Beta::BetaToolSearchTool,
                    OpenAI::Beta::BetaApplyPatchTool,
                    OpenAI::Beta::BetaWebSearchTool,
                    OpenAI::Beta::BetaWebSearchPreviewTool
                  )
                ]
              )
            )
          end
          attr_accessor :tools

          # The truncation strategy to use for the model response. - `auto`: If the input to
          # this Response exceeds the model's context window size, the model will truncate
          # the response to fit the context window by dropping items from the beginning of
          # the conversation. - `disabled` (default): If the input size will exceed the
          # context window size for a model, the request will fail with a 400 error.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::Responses::InputTokenCountParams::Truncation::OrSymbol
              )
            )
          end
          attr_reader :truncation

          sig do
            params(
              truncation:
                OpenAI::Beta::Responses::InputTokenCountParams::Truncation::OrSymbol
            ).void
          end
          attr_writer :truncation

          sig do
            returns(
              T.nilable(
                T::Array[
                  OpenAI::Beta::Responses::InputTokenCountParams::Beta::OrSymbol
                ]
              )
            )
          end
          attr_reader :betas

          sig do
            params(
              betas:
                T::Array[
                  OpenAI::Beta::Responses::InputTokenCountParams::Beta::OrSymbol
                ]
            ).void
          end
          attr_writer :betas

          sig do
            params(
              conversation:
                T.nilable(
                  T.any(
                    String,
                    OpenAI::Beta::BetaResponseConversationParam::OrHash
                  )
                ),
              input:
                T.nilable(
                  OpenAI::Beta::Responses::InputTokenCountParams::Input::Variants
                ),
              instructions: T.nilable(String),
              model: T.nilable(String),
              parallel_tool_calls: T.nilable(T::Boolean),
              personality:
                T.any(
                  String,
                  OpenAI::Beta::Responses::InputTokenCountParams::Personality::OrSymbol
                ),
              previous_response_id: T.nilable(String),
              reasoning:
                T.nilable(
                  OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::OrHash
                ),
              text:
                T.nilable(
                  OpenAI::Beta::Responses::InputTokenCountParams::Text::OrHash
                ),
              tool_choice:
                T.nilable(
                  T.any(
                    OpenAI::Beta::BetaToolChoiceOptions::OrSymbol,
                    OpenAI::Beta::BetaToolChoiceAllowed::OrHash,
                    OpenAI::Beta::BetaToolChoiceTypes::OrHash,
                    OpenAI::Beta::BetaToolChoiceFunction::OrHash,
                    OpenAI::Beta::BetaToolChoiceMcp::OrHash,
                    OpenAI::Beta::BetaToolChoiceCustom::OrHash,
                    OpenAI::Beta::Responses::InputTokenCountParams::ToolChoice::BetaSpecificProgrammaticToolCallingParam::OrHash,
                    OpenAI::Beta::BetaToolChoiceApplyPatch::OrHash,
                    OpenAI::Beta::BetaToolChoiceShell::OrHash
                  )
                ),
              tools:
                T.nilable(
                  T::Array[
                    T.any(
                      OpenAI::Beta::BetaFunctionTool::OrHash,
                      OpenAI::Beta::BetaFileSearchTool::OrHash,
                      OpenAI::Beta::BetaComputerTool::OrHash,
                      OpenAI::Beta::BetaComputerUsePreviewTool::OrHash,
                      OpenAI::Beta::BetaTool::Mcp::OrHash,
                      OpenAI::Beta::BetaTool::CodeInterpreter::OrHash,
                      OpenAI::Beta::BetaTool::ProgrammaticToolCalling::OrHash,
                      OpenAI::Beta::BetaTool::ImageGeneration::OrHash,
                      OpenAI::Beta::BetaTool::LocalShell::OrHash,
                      OpenAI::Beta::BetaFunctionShellTool::OrHash,
                      OpenAI::Beta::BetaCustomTool::OrHash,
                      OpenAI::Beta::BetaNamespaceTool::OrHash,
                      OpenAI::Beta::BetaToolSearchTool::OrHash,
                      OpenAI::Beta::BetaApplyPatchTool::OrHash,
                      OpenAI::Beta::BetaWebSearchTool::OrHash,
                      OpenAI::Beta::BetaWebSearchPreviewTool::OrHash
                    )
                  ]
                ),
              truncation:
                OpenAI::Beta::Responses::InputTokenCountParams::Truncation::OrSymbol,
              betas:
                T::Array[
                  OpenAI::Beta::Responses::InputTokenCountParams::Beta::OrSymbol
                ],
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # The conversation that this response belongs to. Items from this conversation are
            # prepended to `input_items` for this response request. Input items and output
            # items from this response are automatically added to this conversation after this
            # response completes.
            conversation: nil,
            # Text, image, or file inputs to the model, used to generate a response
            input: nil,
            # A system (or developer) message inserted into the model's context. When used
            # along with `previous_response_id`, the instructions from a previous response
            # will not be carried over to the next response. This makes it simple to swap out
            # system (or developer) messages in new responses.
            instructions: nil,
            # Model ID used to generate the response, like `gpt-4o` or `o3`. OpenAI offers a
            # wide range of models with different capabilities, performance characteristics,
            # and price points. Refer to the
            # [model guide](https://platform.openai.com/docs/models) to browse and compare
            # available models.
            model: nil,
            # Whether to allow the model to run tool calls in parallel.
            parallel_tool_calls: nil,
            # A model-owned style preset to apply to this request. Omit this parameter to use
            # the model's default style. Supported values may expand over time. Values must be
            # at most 64 characters.
            personality: nil,
            # The unique ID of the previous response to the model. Use this to create
            # multi-turn conversations. Learn more about
            # [conversation state](https://platform.openai.com/docs/guides/conversation-state).
            # Cannot be used in conjunction with `conversation`.
            previous_response_id: nil,
            # **gpt-5 and o-series models only** Configuration options for
            # [reasoning models](https://platform.openai.com/docs/guides/reasoning).
            reasoning: nil,
            # Configuration options for a text response from the model. Can be plain text or
            # structured JSON data. Learn more:
            #
            # - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
            # - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
            text: nil,
            # Controls which tool the model should use, if any.
            tool_choice: nil,
            # An array of tools the model may call while generating a response. You can
            # specify which tool to use by setting the `tool_choice` parameter.
            tools: nil,
            # The truncation strategy to use for the model response. - `auto`: If the input to
            # this Response exceeds the model's context window size, the model will truncate
            # the response to fit the context window by dropping items from the beginning of
            # the conversation. - `disabled` (default): If the input size will exceed the
            # context window size for a model, the request will fail with a 400 error.
            truncation: nil,
            betas: nil,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                conversation:
                  T.nilable(
                    T.any(String, OpenAI::Beta::BetaResponseConversationParam)
                  ),
                input:
                  T.nilable(
                    OpenAI::Beta::Responses::InputTokenCountParams::Input::Variants
                  ),
                instructions: T.nilable(String),
                model: T.nilable(String),
                parallel_tool_calls: T.nilable(T::Boolean),
                personality:
                  T.any(
                    String,
                    OpenAI::Beta::Responses::InputTokenCountParams::Personality::OrSymbol
                  ),
                previous_response_id: T.nilable(String),
                reasoning:
                  T.nilable(
                    OpenAI::Beta::Responses::InputTokenCountParams::Reasoning
                  ),
                text:
                  T.nilable(
                    OpenAI::Beta::Responses::InputTokenCountParams::Text
                  ),
                tool_choice:
                  T.nilable(
                    T.any(
                      OpenAI::Beta::BetaToolChoiceOptions::OrSymbol,
                      OpenAI::Beta::BetaToolChoiceAllowed,
                      OpenAI::Beta::BetaToolChoiceTypes,
                      OpenAI::Beta::BetaToolChoiceFunction,
                      OpenAI::Beta::BetaToolChoiceMcp,
                      OpenAI::Beta::BetaToolChoiceCustom,
                      OpenAI::Beta::Responses::InputTokenCountParams::ToolChoice::BetaSpecificProgrammaticToolCallingParam,
                      OpenAI::Beta::BetaToolChoiceApplyPatch,
                      OpenAI::Beta::BetaToolChoiceShell
                    )
                  ),
                tools:
                  T.nilable(
                    T::Array[
                      T.any(
                        OpenAI::Beta::BetaFunctionTool,
                        OpenAI::Beta::BetaFileSearchTool,
                        OpenAI::Beta::BetaComputerTool,
                        OpenAI::Beta::BetaComputerUsePreviewTool,
                        OpenAI::Beta::BetaTool::Mcp,
                        OpenAI::Beta::BetaTool::CodeInterpreter,
                        OpenAI::Beta::BetaTool::ProgrammaticToolCalling,
                        OpenAI::Beta::BetaTool::ImageGeneration,
                        OpenAI::Beta::BetaTool::LocalShell,
                        OpenAI::Beta::BetaFunctionShellTool,
                        OpenAI::Beta::BetaCustomTool,
                        OpenAI::Beta::BetaNamespaceTool,
                        OpenAI::Beta::BetaToolSearchTool,
                        OpenAI::Beta::BetaApplyPatchTool,
                        OpenAI::Beta::BetaWebSearchTool,
                        OpenAI::Beta::BetaWebSearchPreviewTool
                      )
                    ]
                  ),
                truncation:
                  OpenAI::Beta::Responses::InputTokenCountParams::Truncation::OrSymbol,
                betas:
                  T::Array[
                    OpenAI::Beta::Responses::InputTokenCountParams::Beta::OrSymbol
                  ],
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          # The conversation that this response belongs to. Items from this conversation are
          # prepended to `input_items` for this response request. Input items and output
          # items from this response are automatically added to this conversation after this
          # response completes.
          module Conversation
            extend OpenAI::Internal::Type::Union

            Variants =
              T.type_alias do
                T.any(String, OpenAI::Beta::BetaResponseConversationParam)
              end

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::Responses::InputTokenCountParams::Conversation::Variants
                ]
              )
            end
            def self.variants
            end
          end

          # Text, image, or file inputs to the model, used to generate a response
          module Input
            extend OpenAI::Internal::Type::Union

            Variants =
              T.type_alias do
                T.any(
                  String,
                  T::Array[OpenAI::Beta::BetaResponseInputItem::Variants]
                )
              end

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::Responses::InputTokenCountParams::Input::Variants
                ]
              )
            end
            def self.variants
            end

            BetaResponseInputItemArray =
              T.let(
                OpenAI::Internal::Type::ArrayOf[
                  union: OpenAI::Beta::BetaResponseInputItem
                ],
                OpenAI::Internal::Type::Converter
              )
          end

          # A model-owned style preset to apply to this request. Omit this parameter to use
          # the model's default style. Supported values may expand over time. Values must be
          # at most 64 characters.
          module Personality
            extend OpenAI::Internal::Type::Union

            Variants =
              T.type_alias do
                T.any(
                  String,
                  OpenAI::Beta::Responses::InputTokenCountParams::Personality::TaggedSymbol
                )
              end

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::Responses::InputTokenCountParams::Personality::Variants
                ]
              )
            end
            def self.variants
            end

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Beta::Responses::InputTokenCountParams::Personality
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            FRIENDLY =
              T.let(
                :friendly,
                OpenAI::Beta::Responses::InputTokenCountParams::Personality::TaggedSymbol
              )
            PRAGMATIC =
              T.let(
                :pragmatic,
                OpenAI::Beta::Responses::InputTokenCountParams::Personality::TaggedSymbol
              )
          end

          class Reasoning < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::Responses::InputTokenCountParams::Reasoning,
                  OpenAI::Internal::AnyHash
                )
              end

            # Controls which reasoning items are rendered back to the model on later turns. If
            # omitted or set to `auto`, the model determines the context mode. The `gpt-5.6`
            # model family defaults to `all_turns`; earlier models default to `current_turn`.
            #
            # When returned on a response, this is the effective reasoning context mode used
            # for the response.
            sig do
              returns(
                T.nilable(
                  OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Context::OrSymbol
                )
              )
            end
            attr_accessor :context

            # Constrains effort on reasoning for reasoning models. Currently supported values
            # are `none`, `minimal`, `low`, `medium`, `high`, `xhigh`, and `max`. Reducing
            # reasoning effort can result in faster responses and fewer tokens used on
            # reasoning in a response. Not all reasoning models support every value. See the
            # [reasoning guide](https://platform.openai.com/docs/guides/reasoning) for
            # model-specific support.
            sig do
              returns(
                T.nilable(
                  OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Effort::OrSymbol
                )
              )
            end
            attr_accessor :effort

            # **Deprecated:** use `summary` instead.
            #
            # A summary of the reasoning performed by the model. This can be useful for
            # debugging and understanding the model's reasoning process. One of `auto`,
            # `concise`, or `detailed`.
            sig do
              returns(
                T.nilable(
                  OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::GenerateSummary::OrSymbol
                )
              )
            end
            attr_accessor :generate_summary

            # Controls the reasoning execution mode for the request.
            #
            # When returned on a response, this is the effective execution mode.
            sig do
              returns(
                T.nilable(
                  T.any(
                    String,
                    OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Mode::OrSymbol
                  )
                )
              )
            end
            attr_reader :mode

            sig do
              params(
                mode:
                  T.any(
                    String,
                    OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Mode::OrSymbol
                  )
              ).void
            end
            attr_writer :mode

            # A summary of the reasoning performed by the model. This can be useful for
            # debugging and understanding the model's reasoning process. One of `auto`,
            # `concise`, or `detailed`.
            #
            # `concise` is supported for `computer-use-preview` models and all reasoning
            # models after `gpt-5`.
            sig do
              returns(
                T.nilable(
                  OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Summary::OrSymbol
                )
              )
            end
            attr_accessor :summary

            # **gpt-5 and o-series models only** Configuration options for
            # [reasoning models](https://platform.openai.com/docs/guides/reasoning).
            sig do
              params(
                context:
                  T.nilable(
                    OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Context::OrSymbol
                  ),
                effort:
                  T.nilable(
                    OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Effort::OrSymbol
                  ),
                generate_summary:
                  T.nilable(
                    OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::GenerateSummary::OrSymbol
                  ),
                mode:
                  T.any(
                    String,
                    OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Mode::OrSymbol
                  ),
                summary:
                  T.nilable(
                    OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Summary::OrSymbol
                  )
              ).returns(T.attached_class)
            end
            def self.new(
              # Controls which reasoning items are rendered back to the model on later turns. If
              # omitted or set to `auto`, the model determines the context mode. The `gpt-5.6`
              # model family defaults to `all_turns`; earlier models default to `current_turn`.
              #
              # When returned on a response, this is the effective reasoning context mode used
              # for the response.
              context: nil,
              # Constrains effort on reasoning for reasoning models. Currently supported values
              # are `none`, `minimal`, `low`, `medium`, `high`, `xhigh`, and `max`. Reducing
              # reasoning effort can result in faster responses and fewer tokens used on
              # reasoning in a response. Not all reasoning models support every value. See the
              # [reasoning guide](https://platform.openai.com/docs/guides/reasoning) for
              # model-specific support.
              effort: nil,
              # **Deprecated:** use `summary` instead.
              #
              # A summary of the reasoning performed by the model. This can be useful for
              # debugging and understanding the model's reasoning process. One of `auto`,
              # `concise`, or `detailed`.
              generate_summary: nil,
              # Controls the reasoning execution mode for the request.
              #
              # When returned on a response, this is the effective execution mode.
              mode: nil,
              # A summary of the reasoning performed by the model. This can be useful for
              # debugging and understanding the model's reasoning process. One of `auto`,
              # `concise`, or `detailed`.
              #
              # `concise` is supported for `computer-use-preview` models and all reasoning
              # models after `gpt-5`.
              summary: nil
            )
            end

            sig do
              override.returns(
                {
                  context:
                    T.nilable(
                      OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Context::OrSymbol
                    ),
                  effort:
                    T.nilable(
                      OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Effort::OrSymbol
                    ),
                  generate_summary:
                    T.nilable(
                      OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::GenerateSummary::OrSymbol
                    ),
                  mode:
                    T.any(
                      String,
                      OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Mode::OrSymbol
                    ),
                  summary:
                    T.nilable(
                      OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Summary::OrSymbol
                    )
                }
              )
            end
            def to_hash
            end

            # Controls which reasoning items are rendered back to the model on later turns. If
            # omitted or set to `auto`, the model determines the context mode. The `gpt-5.6`
            # model family defaults to `all_turns`; earlier models default to `current_turn`.
            #
            # When returned on a response, this is the effective reasoning context mode used
            # for the response.
            module Context
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Context
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              AUTO =
                T.let(
                  :auto,
                  OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Context::TaggedSymbol
                )
              CURRENT_TURN =
                T.let(
                  :current_turn,
                  OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Context::TaggedSymbol
                )
              ALL_TURNS =
                T.let(
                  :all_turns,
                  OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Context::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Context::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end

            # Constrains effort on reasoning for reasoning models. Currently supported values
            # are `none`, `minimal`, `low`, `medium`, `high`, `xhigh`, and `max`. Reducing
            # reasoning effort can result in faster responses and fewer tokens used on
            # reasoning in a response. Not all reasoning models support every value. See the
            # [reasoning guide](https://platform.openai.com/docs/guides/reasoning) for
            # model-specific support.
            module Effort
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Effort
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              NONE =
                T.let(
                  :none,
                  OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Effort::TaggedSymbol
                )
              MINIMAL =
                T.let(
                  :minimal,
                  OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Effort::TaggedSymbol
                )
              LOW =
                T.let(
                  :low,
                  OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Effort::TaggedSymbol
                )
              MEDIUM =
                T.let(
                  :medium,
                  OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Effort::TaggedSymbol
                )
              HIGH =
                T.let(
                  :high,
                  OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Effort::TaggedSymbol
                )
              XHIGH =
                T.let(
                  :xhigh,
                  OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Effort::TaggedSymbol
                )
              MAX =
                T.let(
                  :max,
                  OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Effort::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Effort::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end

            # **Deprecated:** use `summary` instead.
            #
            # A summary of the reasoning performed by the model. This can be useful for
            # debugging and understanding the model's reasoning process. One of `auto`,
            # `concise`, or `detailed`.
            module GenerateSummary
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::GenerateSummary
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              AUTO =
                T.let(
                  :auto,
                  OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::GenerateSummary::TaggedSymbol
                )
              CONCISE =
                T.let(
                  :concise,
                  OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::GenerateSummary::TaggedSymbol
                )
              DETAILED =
                T.let(
                  :detailed,
                  OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::GenerateSummary::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::GenerateSummary::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end

            # Controls the reasoning execution mode for the request.
            #
            # When returned on a response, this is the effective execution mode.
            module Mode
              extend OpenAI::Internal::Type::Union

              Variants =
                T.type_alias do
                  T.any(
                    String,
                    OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Mode::TaggedSymbol
                  )
                end

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Mode::Variants
                  ]
                )
              end
              def self.variants
              end

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Mode
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              STANDARD =
                T.let(
                  :standard,
                  OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Mode::TaggedSymbol
                )
              PRO =
                T.let(
                  :pro,
                  OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Mode::TaggedSymbol
                )
            end

            # A summary of the reasoning performed by the model. This can be useful for
            # debugging and understanding the model's reasoning process. One of `auto`,
            # `concise`, or `detailed`.
            #
            # `concise` is supported for `computer-use-preview` models and all reasoning
            # models after `gpt-5`.
            module Summary
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Summary
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              AUTO =
                T.let(
                  :auto,
                  OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Summary::TaggedSymbol
                )
              CONCISE =
                T.let(
                  :concise,
                  OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Summary::TaggedSymbol
                )
              DETAILED =
                T.let(
                  :detailed,
                  OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Summary::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Beta::Responses::InputTokenCountParams::Reasoning::Summary::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end
          end

          class Text < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::Responses::InputTokenCountParams::Text,
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
                    OpenAI::Beta::BetaResponseFormatTextConfig::Text,
                    OpenAI::Beta::BetaResponseFormatTextJSONSchemaConfig,
                    OpenAI::Beta::BetaResponseFormatTextConfig::JSONObject
                  )
                )
              )
            end
            attr_reader :format_

            sig do
              params(
                format_:
                  T.any(
                    OpenAI::Beta::BetaResponseFormatTextConfig::Text::OrHash,
                    OpenAI::Beta::BetaResponseFormatTextJSONSchemaConfig::OrHash,
                    OpenAI::Beta::BetaResponseFormatTextConfig::JSONObject::OrHash
                  )
              ).void
            end
            attr_writer :format_

            # Constrains the verbosity of the model's response. Lower values will result in
            # more concise responses, while higher values will result in more verbose
            # responses. Currently supported values are `low`, `medium`, and `high`. The
            # default is `medium`.
            sig do
              returns(
                T.nilable(
                  OpenAI::Beta::Responses::InputTokenCountParams::Text::Verbosity::OrSymbol
                )
              )
            end
            attr_accessor :verbosity

            # Configuration options for a text response from the model. Can be plain text or
            # structured JSON data. Learn more:
            #
            # - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
            # - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
            sig do
              params(
                format_:
                  T.any(
                    OpenAI::Beta::BetaResponseFormatTextConfig::Text::OrHash,
                    OpenAI::Beta::BetaResponseFormatTextJSONSchemaConfig::OrHash,
                    OpenAI::Beta::BetaResponseFormatTextConfig::JSONObject::OrHash
                  ),
                verbosity:
                  T.nilable(
                    OpenAI::Beta::Responses::InputTokenCountParams::Text::Verbosity::OrSymbol
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
              format_: nil,
              # Constrains the verbosity of the model's response. Lower values will result in
              # more concise responses, while higher values will result in more verbose
              # responses. Currently supported values are `low`, `medium`, and `high`. The
              # default is `medium`.
              verbosity: nil
            )
            end

            sig do
              override.returns(
                {
                  format_:
                    T.any(
                      OpenAI::Beta::BetaResponseFormatTextConfig::Text,
                      OpenAI::Beta::BetaResponseFormatTextJSONSchemaConfig,
                      OpenAI::Beta::BetaResponseFormatTextConfig::JSONObject
                    ),
                  verbosity:
                    T.nilable(
                      OpenAI::Beta::Responses::InputTokenCountParams::Text::Verbosity::OrSymbol
                    )
                }
              )
            end
            def to_hash
            end

            # Constrains the verbosity of the model's response. Lower values will result in
            # more concise responses, while higher values will result in more verbose
            # responses. Currently supported values are `low`, `medium`, and `high`. The
            # default is `medium`.
            module Verbosity
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Beta::Responses::InputTokenCountParams::Text::Verbosity
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              LOW =
                T.let(
                  :low,
                  OpenAI::Beta::Responses::InputTokenCountParams::Text::Verbosity::TaggedSymbol
                )
              MEDIUM =
                T.let(
                  :medium,
                  OpenAI::Beta::Responses::InputTokenCountParams::Text::Verbosity::TaggedSymbol
                )
              HIGH =
                T.let(
                  :high,
                  OpenAI::Beta::Responses::InputTokenCountParams::Text::Verbosity::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Beta::Responses::InputTokenCountParams::Text::Verbosity::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end
          end

          # Controls which tool the model should use, if any.
          module ToolChoice
            extend OpenAI::Internal::Type::Union

            Variants =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaToolChoiceOptions::TaggedSymbol,
                  OpenAI::Beta::BetaToolChoiceAllowed,
                  OpenAI::Beta::BetaToolChoiceTypes,
                  OpenAI::Beta::BetaToolChoiceFunction,
                  OpenAI::Beta::BetaToolChoiceMcp,
                  OpenAI::Beta::BetaToolChoiceCustom,
                  OpenAI::Beta::Responses::InputTokenCountParams::ToolChoice::BetaSpecificProgrammaticToolCallingParam,
                  OpenAI::Beta::BetaToolChoiceApplyPatch,
                  OpenAI::Beta::BetaToolChoiceShell
                )
              end

            class BetaSpecificProgrammaticToolCallingParam < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::Responses::InputTokenCountParams::ToolChoice::BetaSpecificProgrammaticToolCallingParam,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The tool to call. Always `programmatic_tool_calling`.
              sig { returns(Symbol) }
              attr_accessor :type

              sig { params(type: Symbol).returns(T.attached_class) }
              def self.new(
                # The tool to call. Always `programmatic_tool_calling`.
                type: :programmatic_tool_calling
              )
              end

              sig { override.returns({ type: Symbol }) }
              def to_hash
              end
            end

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::Responses::InputTokenCountParams::ToolChoice::Variants
                ]
              )
            end
            def self.variants
            end
          end

          # The truncation strategy to use for the model response. - `auto`: If the input to
          # this Response exceeds the model's context window size, the model will truncate
          # the response to fit the context window by dropping items from the beginning of
          # the conversation. - `disabled` (default): If the input size will exceed the
          # context window size for a model, the request will fail with a 400 error.
          module Truncation
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Beta::Responses::InputTokenCountParams::Truncation
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            AUTO =
              T.let(
                :auto,
                OpenAI::Beta::Responses::InputTokenCountParams::Truncation::TaggedSymbol
              )
            DISABLED =
              T.let(
                :disabled,
                OpenAI::Beta::Responses::InputTokenCountParams::Truncation::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::Responses::InputTokenCountParams::Truncation::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          module Beta
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Beta::Responses::InputTokenCountParams::Beta
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            RESPONSES_MULTI_AGENT_V1 =
              T.let(
                :"responses_multi_agent=v1",
                OpenAI::Beta::Responses::InputTokenCountParams::Beta::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::Responses::InputTokenCountParams::Beta::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end
      end
    end
  end
end
