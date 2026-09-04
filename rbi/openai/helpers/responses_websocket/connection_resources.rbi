# typed: strong

module OpenAI
  module Models
    module Responses
      module ConnectionResources
        class Response
          # @api private
          sig { params(connection: OpenAI::Responses::Connection).returns(T.attached_class) }
          def self.new(connection)
          end

          sig do
            params(
              background: T.nilable(T::Boolean),
              context_management: T.nilable(
                T::Array[OpenAI::Responses::ResponsesClientEvent::ResponseCreate::ContextManagement::OrHash]
              ),
              conversation: T.nilable(T.any(String, OpenAI::Responses::ResponseConversationParam::OrHash)),
              include: T.nilable(T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol]),
              input: OpenAI::Responses::ResponsesClientEvent::ResponseCreate::Input::Variants,
              instructions: T.nilable(String),
              max_output_tokens: T.nilable(Integer),
              max_tool_calls: T.nilable(Integer),
              metadata: T.nilable(T::Hash[Symbol, String]),
              model: T.any(String, OpenAI::ChatModel::OrSymbol, OpenAI::ResponsesModel::ResponsesOnlyModel::OrSymbol),
              moderation: T.nilable(OpenAI::Responses::ResponsesClientEvent::ResponseCreate::Moderation::OrHash),
              parallel_tool_calls: T.nilable(T::Boolean),
              previous_response_id: T.nilable(String),
              prompt: T.nilable(OpenAI::Responses::ResponsePrompt::OrHash),
              prompt_cache_key: T.nilable(String),
              prompt_cache_options: OpenAI::Responses::ResponsesClientEvent::ResponseCreate::PromptCacheOptions::OrHash,
              prompt_cache_retention: T.nilable(
                OpenAI::Responses::ResponsesClientEvent::ResponseCreate::PromptCacheRetention::OrSymbol
              ),
              reasoning: T.nilable(OpenAI::Reasoning::OrHash),
              safety_identifier: T.nilable(String),
              service_tier: T.nilable(OpenAI::Responses::ResponsesClientEvent::ResponseCreate::ServiceTier::OrSymbol),
              store: T.nilable(T::Boolean),
              stream: T.nilable(T::Boolean),
              stream_id: String,
              stream_options: T.nilable(OpenAI::Responses::ResponsesClientEvent::ResponseCreate::StreamOptions::OrHash),
              temperature: T.nilable(Float),
              text: OpenAI::Responses::ResponseTextConfig::OrHash,
              tool_choice: T.any(
                OpenAI::Responses::ToolChoiceOptions::OrSymbol,
                OpenAI::Responses::ToolChoiceAllowed::OrHash,
                OpenAI::Responses::ToolChoiceTypes::OrHash,
                OpenAI::Responses::ToolChoiceFunction::OrHash,
                OpenAI::Responses::ToolChoiceMcp::OrHash,
                OpenAI::Responses::ToolChoiceCustom::OrHash,
                OpenAI::Responses::ResponsesClientEvent::ResponseCreate::ToolChoice::SpecificProgrammaticToolCallingParam::OrHash,
                OpenAI::Responses::ToolChoiceApplyPatch::OrHash,
                OpenAI::Responses::ToolChoiceShell::OrHash
              ),
              tools: T::Array[
                T.any(
                  OpenAI::Responses::FunctionTool::OrHash,
                  OpenAI::Responses::FileSearchTool::OrHash,
                  OpenAI::Responses::ComputerTool::OrHash,
                  OpenAI::Responses::ComputerUsePreviewTool::OrHash,
                  OpenAI::Responses::Tool::Mcp::OrHash,
                  OpenAI::Responses::Tool::CodeInterpreter::OrHash,
                  OpenAI::Responses::Tool::ProgrammaticToolCalling::OrHash,
                  OpenAI::Responses::Tool::ImageGeneration::OrHash,
                  OpenAI::Responses::Tool::LocalShell::OrHash,
                  OpenAI::Responses::FunctionShellTool::OrHash,
                  OpenAI::Responses::CustomTool::OrHash,
                  OpenAI::Responses::NamespaceTool::OrHash,
                  OpenAI::Responses::ToolSearchTool::OrHash,
                  OpenAI::Responses::ApplyPatchTool::OrHash,
                  OpenAI::Responses::WebSearchTool::OrHash,
                  OpenAI::Responses::WebSearchPreviewTool::OrHash
                )
              ],
              top_logprobs: T.nilable(Integer),
              top_p: T.nilable(Float),
              truncation: T.nilable(OpenAI::Responses::ResponsesClientEvent::ResponseCreate::Truncation::OrSymbol),
              user: String,
              params: T::Hash[T.any(String, Symbol), T.anything]
            )
              .void
          end
          def create(
            background: nil,
            context_management: nil,
            conversation: nil,
            include: nil,
            input: nil,
            instructions: nil,
            max_output_tokens: nil,
            max_tool_calls: nil,
            metadata: nil,
            model: nil,
            moderation: nil,
            parallel_tool_calls: nil,
            previous_response_id: nil,
            prompt: nil,
            prompt_cache_key: nil,
            prompt_cache_options: nil,
            prompt_cache_retention: nil,
            reasoning: nil,
            safety_identifier: nil,
            service_tier: nil,
            store: nil,
            stream: nil,
            stream_id: nil,
            stream_options: nil,
            temperature: nil,
            text: nil,
            tool_choice: nil,
            tools: nil,
            top_logprobs: nil,
            top_p: nil,
            truncation: nil,
            user: nil,
            **params
          )
          end
        end
      end
    end
  end
end
