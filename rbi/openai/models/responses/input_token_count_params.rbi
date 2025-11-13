# typed: strong

module OpenAI
  module Models
    module Responses
      class InputTokenCountParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::InputTokenCountParams,
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
              T.any(String, OpenAI::Responses::ResponseConversationParam)
            )
          )
        end
        attr_accessor :conversation

        # Text, image, or file inputs to the model, used to generate a response
        sig do
          returns(
            T.nilable(OpenAI::Responses::InputTokenCountParams::Input::Variants)
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

        # The unique ID of the previous response to the model. Use this to create
        # multi-turn conversations. Learn more about
        # [conversation state](https://platform.openai.com/docs/guides/conversation-state).
        # Cannot be used in conjunction with `conversation`.
        sig { returns(T.nilable(String)) }
        attr_accessor :previous_response_id

        # **gpt-5 and o-series models only** Configuration options for
        # [reasoning models](https://platform.openai.com/docs/guides/reasoning).
        sig { returns(T.nilable(OpenAI::Reasoning)) }
        attr_reader :reasoning

        sig { params(reasoning: T.nilable(OpenAI::Reasoning::OrHash)).void }
        attr_writer :reasoning

        # Configuration options for a text response from the model. Can be plain text or
        # structured JSON data. Learn more:
        #
        # - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
        # - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
        sig do
          returns(T.nilable(OpenAI::Responses::InputTokenCountParams::Text))
        end
        attr_reader :text

        sig do
          params(
            text:
              T.nilable(OpenAI::Responses::InputTokenCountParams::Text::OrHash)
          ).void
        end
        attr_writer :text

        # How the model should select which tool (or tools) to use when generating a
        # response. See the `tools` parameter to see how to specify which tools the model
        # can call.
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Responses::ToolChoiceOptions::OrSymbol,
                OpenAI::Responses::ToolChoiceAllowed,
                OpenAI::Responses::ToolChoiceTypes,
                OpenAI::Responses::ToolChoiceFunction,
                OpenAI::Responses::ToolChoiceMcp,
                OpenAI::Responses::ToolChoiceCustom,
                OpenAI::Responses::ToolChoiceApplyPatch,
                OpenAI::Responses::ToolChoiceShell
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
        attr_accessor :tools

        # The truncation strategy to use for the model response. - `auto`: If the input to
        # this Response exceeds the model's context window size, the model will truncate
        # the response to fit the context window by dropping items from the beginning of
        # the conversation. - `disabled` (default): If the input size will exceed the
        # context window size for a model, the request will fail with a 400 error.
        sig do
          returns(
            T.nilable(
              OpenAI::Responses::InputTokenCountParams::Truncation::OrSymbol
            )
          )
        end
        attr_reader :truncation

        sig do
          params(
            truncation:
              OpenAI::Responses::InputTokenCountParams::Truncation::OrSymbol
          ).void
        end
        attr_writer :truncation

        sig do
          params(
            conversation:
              T.nilable(
                T.any(
                  String,
                  OpenAI::Responses::ResponseConversationParam::OrHash
                )
              ),
            input:
              T.nilable(
                OpenAI::Responses::InputTokenCountParams::Input::Variants
              ),
            instructions: T.nilable(String),
            model: T.nilable(String),
            parallel_tool_calls: T.nilable(T::Boolean),
            previous_response_id: T.nilable(String),
            reasoning: T.nilable(OpenAI::Reasoning::OrHash),
            text:
              T.nilable(OpenAI::Responses::InputTokenCountParams::Text::OrHash),
            tool_choice:
              T.nilable(
                T.any(
                  OpenAI::Responses::ToolChoiceOptions::OrSymbol,
                  OpenAI::Responses::ToolChoiceAllowed::OrHash,
                  OpenAI::Responses::ToolChoiceTypes::OrHash,
                  OpenAI::Responses::ToolChoiceFunction::OrHash,
                  OpenAI::Responses::ToolChoiceMcp::OrHash,
                  OpenAI::Responses::ToolChoiceCustom::OrHash,
                  OpenAI::Responses::ToolChoiceApplyPatch::OrHash,
                  OpenAI::Responses::ToolChoiceShell::OrHash
                )
              ),
            tools:
              T.nilable(
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
              ),
            truncation:
              OpenAI::Responses::InputTokenCountParams::Truncation::OrSymbol,
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
          # How the model should select which tool (or tools) to use when generating a
          # response. See the `tools` parameter to see how to specify which tools the model
          # can call.
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
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              conversation:
                T.nilable(
                  T.any(String, OpenAI::Responses::ResponseConversationParam)
                ),
              input:
                T.nilable(
                  OpenAI::Responses::InputTokenCountParams::Input::Variants
                ),
              instructions: T.nilable(String),
              model: T.nilable(String),
              parallel_tool_calls: T.nilable(T::Boolean),
              previous_response_id: T.nilable(String),
              reasoning: T.nilable(OpenAI::Reasoning),
              text: T.nilable(OpenAI::Responses::InputTokenCountParams::Text),
              tool_choice:
                T.nilable(
                  T.any(
                    OpenAI::Responses::ToolChoiceOptions::OrSymbol,
                    OpenAI::Responses::ToolChoiceAllowed,
                    OpenAI::Responses::ToolChoiceTypes,
                    OpenAI::Responses::ToolChoiceFunction,
                    OpenAI::Responses::ToolChoiceMcp,
                    OpenAI::Responses::ToolChoiceCustom,
                    OpenAI::Responses::ToolChoiceApplyPatch,
                    OpenAI::Responses::ToolChoiceShell
                  )
                ),
              tools:
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
                ),
              truncation:
                OpenAI::Responses::InputTokenCountParams::Truncation::OrSymbol,
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
              T.any(String, OpenAI::Responses::ResponseConversationParam)
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::InputTokenCountParams::Conversation::Variants
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
                T::Array[OpenAI::Responses::ResponseInputItem::Variants]
              )
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::InputTokenCountParams::Input::Variants
              ]
            )
          end
          def self.variants
          end

          ResponseInputItemArray =
            T.let(
              OpenAI::Internal::Type::ArrayOf[
                union: OpenAI::Responses::ResponseInputItem
              ],
              OpenAI::Internal::Type::Converter
            )
        end

        class Text < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::InputTokenCountParams::Text,
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

          # Constrains the verbosity of the model's response. Lower values will result in
          # more concise responses, while higher values will result in more verbose
          # responses. Currently supported values are `low`, `medium`, and `high`.
          sig do
            returns(
              T.nilable(
                OpenAI::Responses::InputTokenCountParams::Text::Verbosity::OrSymbol
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
                  OpenAI::ResponseFormatText::OrHash,
                  OpenAI::Responses::ResponseFormatTextJSONSchemaConfig::OrHash,
                  OpenAI::ResponseFormatJSONObject::OrHash
                ),
              verbosity:
                T.nilable(
                  OpenAI::Responses::InputTokenCountParams::Text::Verbosity::OrSymbol
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
            # responses. Currently supported values are `low`, `medium`, and `high`.
            verbosity: nil
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
                  ),
                verbosity:
                  T.nilable(
                    OpenAI::Responses::InputTokenCountParams::Text::Verbosity::OrSymbol
                  )
              }
            )
          end
          def to_hash
          end

          # Constrains the verbosity of the model's response. Lower values will result in
          # more concise responses, while higher values will result in more verbose
          # responses. Currently supported values are `low`, `medium`, and `high`.
          module Verbosity
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Responses::InputTokenCountParams::Text::Verbosity
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            LOW =
              T.let(
                :low,
                OpenAI::Responses::InputTokenCountParams::Text::Verbosity::TaggedSymbol
              )
            MEDIUM =
              T.let(
                :medium,
                OpenAI::Responses::InputTokenCountParams::Text::Verbosity::TaggedSymbol
              )
            HIGH =
              T.let(
                :high,
                OpenAI::Responses::InputTokenCountParams::Text::Verbosity::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Responses::InputTokenCountParams::Text::Verbosity::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

        # How the model should select which tool (or tools) to use when generating a
        # response. See the `tools` parameter to see how to specify which tools the model
        # can call.
        module ToolChoice
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Responses::ToolChoiceOptions::TaggedSymbol,
                OpenAI::Responses::ToolChoiceAllowed,
                OpenAI::Responses::ToolChoiceTypes,
                OpenAI::Responses::ToolChoiceFunction,
                OpenAI::Responses::ToolChoiceMcp,
                OpenAI::Responses::ToolChoiceCustom,
                OpenAI::Responses::ToolChoiceApplyPatch,
                OpenAI::Responses::ToolChoiceShell
              )
            end

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::InputTokenCountParams::ToolChoice::Variants
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
                OpenAI::Responses::InputTokenCountParams::Truncation
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          AUTO =
            T.let(
              :auto,
              OpenAI::Responses::InputTokenCountParams::Truncation::TaggedSymbol
            )
          DISABLED =
            T.let(
              :disabled,
              OpenAI::Responses::InputTokenCountParams::Truncation::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::InputTokenCountParams::Truncation::TaggedSymbol
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
