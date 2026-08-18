# typed: strong

module OpenAI
  module Resources
    class Beta
      class Responses
        class InputTokens
          # Returns input token counts of the request.
          #
          # Returns an object with `object` set to `response.input_tokens` and an
          # `input_tokens` count.
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
            ).returns(OpenAI::Models::Beta::Responses::InputTokenCountResponse)
          end
          def count(
            # Body param: The conversation that this response belongs to. Items from this
            # conversation are prepended to `input_items` for this response request. Input
            # items and output items from this response are automatically added to this
            # conversation after this response completes.
            conversation: nil,
            # Body param: Text, image, or file inputs to the model, used to generate a
            # response
            input: nil,
            # Body param: A system (or developer) message inserted into the model's context.
            # When used along with `previous_response_id`, the instructions from a previous
            # response will not be carried over to the next response. This makes it simple to
            # swap out system (or developer) messages in new responses.
            instructions: nil,
            # Body param: Model ID used to generate the response, like `gpt-4o` or `o3`.
            # OpenAI offers a wide range of models with different capabilities, performance
            # characteristics, and price points. Refer to the
            # [model guide](https://platform.openai.com/docs/models) to browse and compare
            # available models.
            model: nil,
            # Body param: Whether to allow the model to run tool calls in parallel.
            parallel_tool_calls: nil,
            # Body param: A model-owned style preset to apply to this request. Omit this
            # parameter to use the model's default style. Supported values may expand over
            # time. Values must be at most 64 characters.
            personality: nil,
            # Body param: The unique ID of the previous response to the model. Use this to
            # create multi-turn conversations. Learn more about
            # [conversation state](https://platform.openai.com/docs/guides/conversation-state).
            # Cannot be used in conjunction with `conversation`.
            previous_response_id: nil,
            # Body param: **gpt-5 and o-series models only** Configuration options for
            # [reasoning models](https://platform.openai.com/docs/guides/reasoning).
            reasoning: nil,
            # Body param: Configuration options for a text response from the model. Can be
            # plain text or structured JSON data. Learn more:
            #
            # - [Text inputs and outputs](https://platform.openai.com/docs/guides/text)
            # - [Structured Outputs](https://platform.openai.com/docs/guides/structured-outputs)
            text: nil,
            # Body param: Controls which tool the model should use, if any.
            tool_choice: nil,
            # Body param: An array of tools the model may call while generating a response.
            # You can specify which tool to use by setting the `tool_choice` parameter.
            tools: nil,
            # Body param: The truncation strategy to use for the model response. - `auto`: If
            # the input to this Response exceeds the model's context window size, the model
            # will truncate the response to fit the context window by dropping items from the
            # beginning of the conversation. - `disabled` (default): If the input size will
            # exceed the context window size for a model, the request will fail with a 400
            # error.
            truncation: nil,
            # Header param: Optional beta features to enable for this request.
            betas: nil,
            request_options: {}
          )
          end

          # @api private
          sig { params(client: OpenAI::Client).returns(T.attached_class) }
          def self.new(client:)
          end
        end
      end
    end
  end
end
