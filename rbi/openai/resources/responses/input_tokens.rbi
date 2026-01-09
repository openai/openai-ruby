# typed: strong

module OpenAI
  module Resources
    class Responses
      class InputTokens
        # Get input token counts
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
          ).returns(OpenAI::Models::Responses::InputTokenCountResponse)
        end
        def count(
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
