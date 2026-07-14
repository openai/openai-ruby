# typed: strong

module OpenAI
  module Models
    BetaResponseOutputItem = Beta::BetaResponseOutputItem

    module Beta
      # An output message from the model.
      module BetaResponseOutputItem
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseOutputMessage,
              OpenAI::Beta::BetaResponseFileSearchToolCall,
              OpenAI::Beta::BetaResponseFunctionToolCall,
              OpenAI::Beta::BetaResponseFunctionToolCallOutputItem,
              OpenAI::Beta::BetaResponseOutputItem::AgentMessage,
              OpenAI::Beta::BetaResponseOutputItem::MultiAgentCall,
              OpenAI::Beta::BetaResponseOutputItem::MultiAgentCallOutput,
              OpenAI::Beta::BetaResponseFunctionWebSearch,
              OpenAI::Beta::BetaResponseComputerToolCall,
              OpenAI::Beta::BetaResponseComputerToolCallOutputItem,
              OpenAI::Beta::BetaResponseReasoningItem,
              OpenAI::Beta::BetaResponseOutputItem::Program,
              OpenAI::Beta::BetaResponseOutputItem::ProgramOutput,
              OpenAI::Beta::BetaResponseToolSearchCall,
              OpenAI::Beta::BetaResponseToolSearchOutputItem,
              OpenAI::Beta::BetaResponseOutputItem::AdditionalTools,
              OpenAI::Beta::BetaResponseCompactionItem,
              OpenAI::Beta::BetaResponseOutputItem::ImageGenerationCall,
              OpenAI::Beta::BetaResponseCodeInterpreterToolCall,
              OpenAI::Beta::BetaResponseOutputItem::LocalShellCall,
              OpenAI::Beta::BetaResponseOutputItem::LocalShellCallOutput,
              OpenAI::Beta::BetaResponseFunctionShellToolCall,
              OpenAI::Beta::BetaResponseFunctionShellToolCallOutput,
              OpenAI::Beta::BetaResponseApplyPatchToolCall,
              OpenAI::Beta::BetaResponseApplyPatchToolCallOutput,
              OpenAI::Beta::BetaResponseOutputItem::McpCall,
              OpenAI::Beta::BetaResponseOutputItem::McpListTools,
              OpenAI::Beta::BetaResponseOutputItem::McpApprovalRequest,
              OpenAI::Beta::BetaResponseOutputItem::McpApprovalResponse,
              OpenAI::Beta::BetaResponseCustomToolCall,
              OpenAI::Beta::BetaResponseCustomToolCallOutputItem
            )
          end

        class AgentMessage < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseOutputItem::AgentMessage,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the agent message.
          sig { returns(String) }
          attr_accessor :id

          # The sending agent identity.
          sig { returns(String) }
          attr_accessor :author

          # Encrypted content sent between agents.
          sig do
            returns(
              T::Array[
                OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::Variants
              ]
            )
          end
          attr_accessor :content

          # The destination agent identity.
          sig { returns(String) }
          attr_accessor :recipient

          # The type of the item. Always `agent_message`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The agent that produced this item.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Agent
              )
            )
          end
          attr_reader :agent

          sig do
            params(
              agent:
                OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Agent::OrHash
            ).void
          end
          attr_writer :agent

          sig do
            params(
              id: String,
              author: String,
              content:
                T::Array[
                  T.any(
                    OpenAI::Beta::BetaResponseInputText::OrHash,
                    OpenAI::Beta::BetaResponseOutputText::OrHash,
                    OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::Text::OrHash,
                    OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::SummaryText::OrHash,
                    OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::ReasoningText::OrHash,
                    OpenAI::Beta::BetaResponseOutputRefusal::OrHash,
                    OpenAI::Beta::BetaResponseInputImage::OrHash,
                    OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::ComputerScreenshot::OrHash,
                    OpenAI::Beta::BetaResponseInputFile::OrHash,
                    OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::EncryptedContent::OrHash
                  )
                ],
              recipient: String,
              agent:
                OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Agent::OrHash,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique ID of the agent message.
            id:,
            # The sending agent identity.
            author:,
            # Encrypted content sent between agents.
            content:,
            # The destination agent identity.
            recipient:,
            # The agent that produced this item.
            agent: nil,
            # The type of the item. Always `agent_message`.
            type: :agent_message
          )
          end

          sig do
            override.returns(
              {
                id: String,
                author: String,
                content:
                  T::Array[
                    OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::Variants
                  ],
                recipient: String,
                type: Symbol,
                agent: OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Agent
              }
            )
          end
          def to_hash
          end

          # A content part that makes up an input or output item.
          module Content
            extend OpenAI::Internal::Type::Union

            Variants =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaResponseInputText,
                  OpenAI::Beta::BetaResponseOutputText,
                  OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::Text,
                  OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::SummaryText,
                  OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::ReasoningText,
                  OpenAI::Beta::BetaResponseOutputRefusal,
                  OpenAI::Beta::BetaResponseInputImage,
                  OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::ComputerScreenshot,
                  OpenAI::Beta::BetaResponseInputFile,
                  OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::EncryptedContent
                )
              end

            class Text < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::Text,
                    OpenAI::Internal::AnyHash
                  )
                end

              sig { returns(String) }
              attr_accessor :text

              sig { returns(Symbol) }
              attr_accessor :type

              # A text content.
              sig do
                params(text: String, type: Symbol).returns(T.attached_class)
              end
              def self.new(text:, type: :text)
              end

              sig { override.returns({ text: String, type: Symbol }) }
              def to_hash
              end
            end

            class SummaryText < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::SummaryText,
                    OpenAI::Internal::AnyHash
                  )
                end

              # A summary of the reasoning output from the model so far.
              sig { returns(String) }
              attr_accessor :text

              # The type of the object. Always `summary_text`.
              sig { returns(Symbol) }
              attr_accessor :type

              # A summary text from the model.
              sig do
                params(text: String, type: Symbol).returns(T.attached_class)
              end
              def self.new(
                # A summary of the reasoning output from the model so far.
                text:,
                # The type of the object. Always `summary_text`.
                type: :summary_text
              )
              end

              sig { override.returns({ text: String, type: Symbol }) }
              def to_hash
              end
            end

            class ReasoningText < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::ReasoningText,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The reasoning text from the model.
              sig { returns(String) }
              attr_accessor :text

              # The type of the reasoning text. Always `reasoning_text`.
              sig { returns(Symbol) }
              attr_accessor :type

              # Reasoning text from the model.
              sig do
                params(text: String, type: Symbol).returns(T.attached_class)
              end
              def self.new(
                # The reasoning text from the model.
                text:,
                # The type of the reasoning text. Always `reasoning_text`.
                type: :reasoning_text
              )
              end

              sig { override.returns({ text: String, type: Symbol }) }
              def to_hash
              end
            end

            class ComputerScreenshot < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::ComputerScreenshot,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The detail level of the screenshot image to be sent to the model. One of `high`,
              # `low`, `auto`, or `original`. Defaults to `auto`.
              sig do
                returns(
                  OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::ComputerScreenshot::Detail::TaggedSymbol
                )
              end
              attr_accessor :detail

              # The identifier of an uploaded file that contains the screenshot.
              sig { returns(T.nilable(String)) }
              attr_accessor :file_id

              # The URL of the screenshot image.
              sig { returns(T.nilable(String)) }
              attr_accessor :image_url

              # Specifies the event type. For a computer screenshot, this property is always set
              # to `computer_screenshot`.
              sig { returns(Symbol) }
              attr_accessor :type

              # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
              # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
              # token block.
              sig do
                returns(
                  T.nilable(
                    OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::ComputerScreenshot::PromptCacheBreakpoint
                  )
                )
              end
              attr_reader :prompt_cache_breakpoint

              sig do
                params(
                  prompt_cache_breakpoint:
                    OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::ComputerScreenshot::PromptCacheBreakpoint::OrHash
                ).void
              end
              attr_writer :prompt_cache_breakpoint

              # A screenshot of a computer.
              sig do
                params(
                  detail:
                    OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::ComputerScreenshot::Detail::OrSymbol,
                  file_id: T.nilable(String),
                  image_url: T.nilable(String),
                  prompt_cache_breakpoint:
                    OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::ComputerScreenshot::PromptCacheBreakpoint::OrHash,
                  type: Symbol
                ).returns(T.attached_class)
              end
              def self.new(
                # The detail level of the screenshot image to be sent to the model. One of `high`,
                # `low`, `auto`, or `original`. Defaults to `auto`.
                detail:,
                # The identifier of an uploaded file that contains the screenshot.
                file_id:,
                # The URL of the screenshot image.
                image_url:,
                # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
                # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
                # token block.
                prompt_cache_breakpoint: nil,
                # Specifies the event type. For a computer screenshot, this property is always set
                # to `computer_screenshot`.
                type: :computer_screenshot
              )
              end

              sig do
                override.returns(
                  {
                    detail:
                      OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::ComputerScreenshot::Detail::TaggedSymbol,
                    file_id: T.nilable(String),
                    image_url: T.nilable(String),
                    type: Symbol,
                    prompt_cache_breakpoint:
                      OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::ComputerScreenshot::PromptCacheBreakpoint
                  }
                )
              end
              def to_hash
              end

              # The detail level of the screenshot image to be sent to the model. One of `high`,
              # `low`, `auto`, or `original`. Defaults to `auto`.
              module Detail
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol =
                  T.type_alias do
                    T.all(
                      Symbol,
                      OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::ComputerScreenshot::Detail
                    )
                  end
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                LOW =
                  T.let(
                    :low,
                    OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::ComputerScreenshot::Detail::TaggedSymbol
                  )
                HIGH =
                  T.let(
                    :high,
                    OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::ComputerScreenshot::Detail::TaggedSymbol
                  )
                AUTO =
                  T.let(
                    :auto,
                    OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::ComputerScreenshot::Detail::TaggedSymbol
                  )
                ORIGINAL =
                  T.let(
                    :original,
                    OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::ComputerScreenshot::Detail::TaggedSymbol
                  )

                sig do
                  override.returns(
                    T::Array[
                      OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::ComputerScreenshot::Detail::TaggedSymbol
                    ]
                  )
                end
                def self.values
                end
              end

              class PromptCacheBreakpoint < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::ComputerScreenshot::PromptCacheBreakpoint,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # The breakpoint mode. Always `explicit`.
                sig { returns(Symbol) }
                attr_accessor :mode

                # Marks the exact end of a reusable prompt prefix. The breakpoint inherits its TTL
                # from the request's `prompt_cache_options.ttl`; the boundary is not rounded to a
                # token block.
                sig { params(mode: Symbol).returns(T.attached_class) }
                def self.new(
                  # The breakpoint mode. Always `explicit`.
                  mode: :explicit
                )
                end

                sig { override.returns({ mode: Symbol }) }
                def to_hash
                end
              end
            end

            class EncryptedContent < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::EncryptedContent,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Opaque encrypted content.
              sig { returns(String) }
              attr_accessor :encrypted_content

              # The type of the input item. Always `encrypted_content`.
              sig { returns(Symbol) }
              attr_accessor :type

              # Opaque encrypted content that Responses API decrypts inside trusted model
              # execution.
              sig do
                params(encrypted_content: String, type: Symbol).returns(
                  T.attached_class
                )
              end
              def self.new(
                # Opaque encrypted content.
                encrypted_content:,
                # The type of the input item. Always `encrypted_content`.
                type: :encrypted_content
              )
              end

              sig do
                override.returns({ encrypted_content: String, type: Symbol })
              end
              def to_hash
              end
            end

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Content::Variants
                ]
              )
            end
            def self.variants
            end
          end

          class Agent < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaResponseOutputItem::AgentMessage::Agent,
                  OpenAI::Internal::AnyHash
                )
              end

            # The canonical name of the agent that produced this item.
            sig { returns(String) }
            attr_accessor :agent_name

            # The agent that produced this item.
            sig { params(agent_name: String).returns(T.attached_class) }
            def self.new(
              # The canonical name of the agent that produced this item.
              agent_name:
            )
            end

            sig { override.returns({ agent_name: String }) }
            def to_hash
            end
          end
        end

        class MultiAgentCall < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseOutputItem::MultiAgentCall,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the multi-agent call item.
          sig { returns(String) }
          attr_accessor :id

          # The multi-agent action to execute.
          sig do
            returns(
              OpenAI::Beta::BetaResponseOutputItem::MultiAgentCall::Action::TaggedSymbol
            )
          end
          attr_accessor :action

          # The JSON string of arguments generated for the action.
          sig { returns(String) }
          attr_accessor :arguments

          # The unique ID linking this call to its output.
          sig { returns(String) }
          attr_accessor :call_id

          # The type of the multi-agent call. Always `multi_agent_call`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The agent that produced this item.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::BetaResponseOutputItem::MultiAgentCall::Agent
              )
            )
          end
          attr_reader :agent

          sig do
            params(
              agent:
                OpenAI::Beta::BetaResponseOutputItem::MultiAgentCall::Agent::OrHash
            ).void
          end
          attr_writer :agent

          sig do
            params(
              id: String,
              action:
                OpenAI::Beta::BetaResponseOutputItem::MultiAgentCall::Action::OrSymbol,
              arguments: String,
              call_id: String,
              agent:
                OpenAI::Beta::BetaResponseOutputItem::MultiAgentCall::Agent::OrHash,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique ID of the multi-agent call item.
            id:,
            # The multi-agent action to execute.
            action:,
            # The JSON string of arguments generated for the action.
            arguments:,
            # The unique ID linking this call to its output.
            call_id:,
            # The agent that produced this item.
            agent: nil,
            # The type of the multi-agent call. Always `multi_agent_call`.
            type: :multi_agent_call
          )
          end

          sig do
            override.returns(
              {
                id: String,
                action:
                  OpenAI::Beta::BetaResponseOutputItem::MultiAgentCall::Action::TaggedSymbol,
                arguments: String,
                call_id: String,
                type: Symbol,
                agent:
                  OpenAI::Beta::BetaResponseOutputItem::MultiAgentCall::Agent
              }
            )
          end
          def to_hash
          end

          # The multi-agent action to execute.
          module Action
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Beta::BetaResponseOutputItem::MultiAgentCall::Action
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            SPAWN_AGENT =
              T.let(
                :spawn_agent,
                OpenAI::Beta::BetaResponseOutputItem::MultiAgentCall::Action::TaggedSymbol
              )
            INTERRUPT_AGENT =
              T.let(
                :interrupt_agent,
                OpenAI::Beta::BetaResponseOutputItem::MultiAgentCall::Action::TaggedSymbol
              )
            LIST_AGENTS =
              T.let(
                :list_agents,
                OpenAI::Beta::BetaResponseOutputItem::MultiAgentCall::Action::TaggedSymbol
              )
            SEND_MESSAGE =
              T.let(
                :send_message,
                OpenAI::Beta::BetaResponseOutputItem::MultiAgentCall::Action::TaggedSymbol
              )
            FOLLOWUP_TASK =
              T.let(
                :followup_task,
                OpenAI::Beta::BetaResponseOutputItem::MultiAgentCall::Action::TaggedSymbol
              )
            WAIT_AGENT =
              T.let(
                :wait_agent,
                OpenAI::Beta::BetaResponseOutputItem::MultiAgentCall::Action::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::BetaResponseOutputItem::MultiAgentCall::Action::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          class Agent < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaResponseOutputItem::MultiAgentCall::Agent,
                  OpenAI::Internal::AnyHash
                )
              end

            # The canonical name of the agent that produced this item.
            sig { returns(String) }
            attr_accessor :agent_name

            # The agent that produced this item.
            sig { params(agent_name: String).returns(T.attached_class) }
            def self.new(
              # The canonical name of the agent that produced this item.
              agent_name:
            )
            end

            sig { override.returns({ agent_name: String }) }
            def to_hash
            end
          end
        end

        class MultiAgentCallOutput < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseOutputItem::MultiAgentCallOutput,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the multi-agent call output item.
          sig { returns(String) }
          attr_accessor :id

          # The multi-agent action that produced this result.
          sig do
            returns(
              OpenAI::Beta::BetaResponseOutputItem::MultiAgentCallOutput::Action::TaggedSymbol
            )
          end
          attr_accessor :action

          # The unique ID of the multi-agent call.
          sig { returns(String) }
          attr_accessor :call_id

          # Text output returned by the multi-agent action.
          sig { returns(T::Array[OpenAI::Beta::BetaResponseOutputText]) }
          attr_accessor :output

          # The type of the multi-agent result. Always `multi_agent_call_output`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The agent that produced this item.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::BetaResponseOutputItem::MultiAgentCallOutput::Agent
              )
            )
          end
          attr_reader :agent

          sig do
            params(
              agent:
                OpenAI::Beta::BetaResponseOutputItem::MultiAgentCallOutput::Agent::OrHash
            ).void
          end
          attr_writer :agent

          sig do
            params(
              id: String,
              action:
                OpenAI::Beta::BetaResponseOutputItem::MultiAgentCallOutput::Action::OrSymbol,
              call_id: String,
              output: T::Array[OpenAI::Beta::BetaResponseOutputText::OrHash],
              agent:
                OpenAI::Beta::BetaResponseOutputItem::MultiAgentCallOutput::Agent::OrHash,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique ID of the multi-agent call output item.
            id:,
            # The multi-agent action that produced this result.
            action:,
            # The unique ID of the multi-agent call.
            call_id:,
            # Text output returned by the multi-agent action.
            output:,
            # The agent that produced this item.
            agent: nil,
            # The type of the multi-agent result. Always `multi_agent_call_output`.
            type: :multi_agent_call_output
          )
          end

          sig do
            override.returns(
              {
                id: String,
                action:
                  OpenAI::Beta::BetaResponseOutputItem::MultiAgentCallOutput::Action::TaggedSymbol,
                call_id: String,
                output: T::Array[OpenAI::Beta::BetaResponseOutputText],
                type: Symbol,
                agent:
                  OpenAI::Beta::BetaResponseOutputItem::MultiAgentCallOutput::Agent
              }
            )
          end
          def to_hash
          end

          # The multi-agent action that produced this result.
          module Action
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Beta::BetaResponseOutputItem::MultiAgentCallOutput::Action
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            SPAWN_AGENT =
              T.let(
                :spawn_agent,
                OpenAI::Beta::BetaResponseOutputItem::MultiAgentCallOutput::Action::TaggedSymbol
              )
            INTERRUPT_AGENT =
              T.let(
                :interrupt_agent,
                OpenAI::Beta::BetaResponseOutputItem::MultiAgentCallOutput::Action::TaggedSymbol
              )
            LIST_AGENTS =
              T.let(
                :list_agents,
                OpenAI::Beta::BetaResponseOutputItem::MultiAgentCallOutput::Action::TaggedSymbol
              )
            SEND_MESSAGE =
              T.let(
                :send_message,
                OpenAI::Beta::BetaResponseOutputItem::MultiAgentCallOutput::Action::TaggedSymbol
              )
            FOLLOWUP_TASK =
              T.let(
                :followup_task,
                OpenAI::Beta::BetaResponseOutputItem::MultiAgentCallOutput::Action::TaggedSymbol
              )
            WAIT_AGENT =
              T.let(
                :wait_agent,
                OpenAI::Beta::BetaResponseOutputItem::MultiAgentCallOutput::Action::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::BetaResponseOutputItem::MultiAgentCallOutput::Action::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          class Agent < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaResponseOutputItem::MultiAgentCallOutput::Agent,
                  OpenAI::Internal::AnyHash
                )
              end

            # The canonical name of the agent that produced this item.
            sig { returns(String) }
            attr_accessor :agent_name

            # The agent that produced this item.
            sig { params(agent_name: String).returns(T.attached_class) }
            def self.new(
              # The canonical name of the agent that produced this item.
              agent_name:
            )
            end

            sig { override.returns({ agent_name: String }) }
            def to_hash
            end
          end
        end

        class Program < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseOutputItem::Program,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the program item.
          sig { returns(String) }
          attr_accessor :id

          # The stable call ID of the program item.
          sig { returns(String) }
          attr_accessor :call_id

          # The JavaScript source executed by programmatic tool calling.
          sig { returns(String) }
          attr_accessor :code

          # Opaque program replay fingerprint that must be round-tripped.
          sig { returns(String) }
          attr_accessor :fingerprint

          # The type of the item. Always `program`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The agent that produced this item.
          sig do
            returns(
              T.nilable(OpenAI::Beta::BetaResponseOutputItem::Program::Agent)
            )
          end
          attr_reader :agent

          sig do
            params(
              agent:
                OpenAI::Beta::BetaResponseOutputItem::Program::Agent::OrHash
            ).void
          end
          attr_writer :agent

          sig do
            params(
              id: String,
              call_id: String,
              code: String,
              fingerprint: String,
              agent:
                OpenAI::Beta::BetaResponseOutputItem::Program::Agent::OrHash,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique ID of the program item.
            id:,
            # The stable call ID of the program item.
            call_id:,
            # The JavaScript source executed by programmatic tool calling.
            code:,
            # Opaque program replay fingerprint that must be round-tripped.
            fingerprint:,
            # The agent that produced this item.
            agent: nil,
            # The type of the item. Always `program`.
            type: :program
          )
          end

          sig do
            override.returns(
              {
                id: String,
                call_id: String,
                code: String,
                fingerprint: String,
                type: Symbol,
                agent: OpenAI::Beta::BetaResponseOutputItem::Program::Agent
              }
            )
          end
          def to_hash
          end

          class Agent < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaResponseOutputItem::Program::Agent,
                  OpenAI::Internal::AnyHash
                )
              end

            # The canonical name of the agent that produced this item.
            sig { returns(String) }
            attr_accessor :agent_name

            # The agent that produced this item.
            sig { params(agent_name: String).returns(T.attached_class) }
            def self.new(
              # The canonical name of the agent that produced this item.
              agent_name:
            )
            end

            sig { override.returns({ agent_name: String }) }
            def to_hash
            end
          end
        end

        class ProgramOutput < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseOutputItem::ProgramOutput,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the program output item.
          sig { returns(String) }
          attr_accessor :id

          # The call ID of the program item.
          sig { returns(String) }
          attr_accessor :call_id

          # The result produced by the program item.
          sig { returns(String) }
          attr_accessor :result

          # The terminal status of the program output item.
          sig do
            returns(
              OpenAI::Beta::BetaResponseOutputItem::ProgramOutput::Status::TaggedSymbol
            )
          end
          attr_accessor :status

          # The type of the item. Always `program_output`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The agent that produced this item.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::BetaResponseOutputItem::ProgramOutput::Agent
              )
            )
          end
          attr_reader :agent

          sig do
            params(
              agent:
                OpenAI::Beta::BetaResponseOutputItem::ProgramOutput::Agent::OrHash
            ).void
          end
          attr_writer :agent

          sig do
            params(
              id: String,
              call_id: String,
              result: String,
              status:
                OpenAI::Beta::BetaResponseOutputItem::ProgramOutput::Status::OrSymbol,
              agent:
                OpenAI::Beta::BetaResponseOutputItem::ProgramOutput::Agent::OrHash,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique ID of the program output item.
            id:,
            # The call ID of the program item.
            call_id:,
            # The result produced by the program item.
            result:,
            # The terminal status of the program output item.
            status:,
            # The agent that produced this item.
            agent: nil,
            # The type of the item. Always `program_output`.
            type: :program_output
          )
          end

          sig do
            override.returns(
              {
                id: String,
                call_id: String,
                result: String,
                status:
                  OpenAI::Beta::BetaResponseOutputItem::ProgramOutput::Status::TaggedSymbol,
                type: Symbol,
                agent:
                  OpenAI::Beta::BetaResponseOutputItem::ProgramOutput::Agent
              }
            )
          end
          def to_hash
          end

          # The terminal status of the program output item.
          module Status
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Beta::BetaResponseOutputItem::ProgramOutput::Status
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            COMPLETED =
              T.let(
                :completed,
                OpenAI::Beta::BetaResponseOutputItem::ProgramOutput::Status::TaggedSymbol
              )
            INCOMPLETE =
              T.let(
                :incomplete,
                OpenAI::Beta::BetaResponseOutputItem::ProgramOutput::Status::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::BetaResponseOutputItem::ProgramOutput::Status::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          class Agent < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaResponseOutputItem::ProgramOutput::Agent,
                  OpenAI::Internal::AnyHash
                )
              end

            # The canonical name of the agent that produced this item.
            sig { returns(String) }
            attr_accessor :agent_name

            # The agent that produced this item.
            sig { params(agent_name: String).returns(T.attached_class) }
            def self.new(
              # The canonical name of the agent that produced this item.
              agent_name:
            )
            end

            sig { override.returns({ agent_name: String }) }
            def to_hash
            end
          end
        end

        class AdditionalTools < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseOutputItem::AdditionalTools,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the additional tools item.
          sig { returns(String) }
          attr_accessor :id

          # The role that provided the additional tools.
          sig do
            returns(
              OpenAI::Beta::BetaResponseOutputItem::AdditionalTools::Role::TaggedSymbol
            )
          end
          attr_accessor :role

          # The additional tool definitions made available at this item.
          sig { returns(T::Array[OpenAI::Beta::BetaTool::Variants]) }
          attr_accessor :tools

          # The type of the item. Always `additional_tools`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The agent that produced this item.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::BetaResponseOutputItem::AdditionalTools::Agent
              )
            )
          end
          attr_reader :agent

          sig do
            params(
              agent:
                OpenAI::Beta::BetaResponseOutputItem::AdditionalTools::Agent::OrHash
            ).void
          end
          attr_writer :agent

          sig do
            params(
              id: String,
              role:
                OpenAI::Beta::BetaResponseOutputItem::AdditionalTools::Role::OrSymbol,
              tools:
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
                ],
              agent:
                OpenAI::Beta::BetaResponseOutputItem::AdditionalTools::Agent::OrHash,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique ID of the additional tools item.
            id:,
            # The role that provided the additional tools.
            role:,
            # The additional tool definitions made available at this item.
            tools:,
            # The agent that produced this item.
            agent: nil,
            # The type of the item. Always `additional_tools`.
            type: :additional_tools
          )
          end

          sig do
            override.returns(
              {
                id: String,
                role:
                  OpenAI::Beta::BetaResponseOutputItem::AdditionalTools::Role::TaggedSymbol,
                tools: T::Array[OpenAI::Beta::BetaTool::Variants],
                type: Symbol,
                agent:
                  OpenAI::Beta::BetaResponseOutputItem::AdditionalTools::Agent
              }
            )
          end
          def to_hash
          end

          # The role that provided the additional tools.
          module Role
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Beta::BetaResponseOutputItem::AdditionalTools::Role
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            UNKNOWN =
              T.let(
                :unknown,
                OpenAI::Beta::BetaResponseOutputItem::AdditionalTools::Role::TaggedSymbol
              )
            USER =
              T.let(
                :user,
                OpenAI::Beta::BetaResponseOutputItem::AdditionalTools::Role::TaggedSymbol
              )
            ASSISTANT =
              T.let(
                :assistant,
                OpenAI::Beta::BetaResponseOutputItem::AdditionalTools::Role::TaggedSymbol
              )
            SYSTEM =
              T.let(
                :system,
                OpenAI::Beta::BetaResponseOutputItem::AdditionalTools::Role::TaggedSymbol
              )
            CRITIC =
              T.let(
                :critic,
                OpenAI::Beta::BetaResponseOutputItem::AdditionalTools::Role::TaggedSymbol
              )
            DISCRIMINATOR =
              T.let(
                :discriminator,
                OpenAI::Beta::BetaResponseOutputItem::AdditionalTools::Role::TaggedSymbol
              )
            DEVELOPER =
              T.let(
                :developer,
                OpenAI::Beta::BetaResponseOutputItem::AdditionalTools::Role::TaggedSymbol
              )
            TOOL =
              T.let(
                :tool,
                OpenAI::Beta::BetaResponseOutputItem::AdditionalTools::Role::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::BetaResponseOutputItem::AdditionalTools::Role::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          class Agent < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaResponseOutputItem::AdditionalTools::Agent,
                  OpenAI::Internal::AnyHash
                )
              end

            # The canonical name of the agent that produced this item.
            sig { returns(String) }
            attr_accessor :agent_name

            # The agent that produced this item.
            sig { params(agent_name: String).returns(T.attached_class) }
            def self.new(
              # The canonical name of the agent that produced this item.
              agent_name:
            )
            end

            sig { override.returns({ agent_name: String }) }
            def to_hash
            end
          end
        end

        class ImageGenerationCall < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseOutputItem::ImageGenerationCall,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the image generation call.
          sig { returns(String) }
          attr_accessor :id

          # The generated image encoded in base64.
          sig { returns(T.nilable(String)) }
          attr_accessor :result

          # The status of the image generation call.
          sig do
            returns(
              OpenAI::Beta::BetaResponseOutputItem::ImageGenerationCall::Status::TaggedSymbol
            )
          end
          attr_accessor :status

          # The type of the image generation call. Always `image_generation_call`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The agent that produced this item.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::BetaResponseOutputItem::ImageGenerationCall::Agent
              )
            )
          end
          attr_reader :agent

          sig do
            params(
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseOutputItem::ImageGenerationCall::Agent::OrHash
                )
            ).void
          end
          attr_writer :agent

          # An image generation request made by the model.
          sig do
            params(
              id: String,
              result: T.nilable(String),
              status:
                OpenAI::Beta::BetaResponseOutputItem::ImageGenerationCall::Status::OrSymbol,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseOutputItem::ImageGenerationCall::Agent::OrHash
                ),
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique ID of the image generation call.
            id:,
            # The generated image encoded in base64.
            result:,
            # The status of the image generation call.
            status:,
            # The agent that produced this item.
            agent: nil,
            # The type of the image generation call. Always `image_generation_call`.
            type: :image_generation_call
          )
          end

          sig do
            override.returns(
              {
                id: String,
                result: T.nilable(String),
                status:
                  OpenAI::Beta::BetaResponseOutputItem::ImageGenerationCall::Status::TaggedSymbol,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseOutputItem::ImageGenerationCall::Agent
                  )
              }
            )
          end
          def to_hash
          end

          # The status of the image generation call.
          module Status
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Beta::BetaResponseOutputItem::ImageGenerationCall::Status
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            IN_PROGRESS =
              T.let(
                :in_progress,
                OpenAI::Beta::BetaResponseOutputItem::ImageGenerationCall::Status::TaggedSymbol
              )
            COMPLETED =
              T.let(
                :completed,
                OpenAI::Beta::BetaResponseOutputItem::ImageGenerationCall::Status::TaggedSymbol
              )
            GENERATING =
              T.let(
                :generating,
                OpenAI::Beta::BetaResponseOutputItem::ImageGenerationCall::Status::TaggedSymbol
              )
            FAILED =
              T.let(
                :failed,
                OpenAI::Beta::BetaResponseOutputItem::ImageGenerationCall::Status::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::BetaResponseOutputItem::ImageGenerationCall::Status::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          class Agent < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaResponseOutputItem::ImageGenerationCall::Agent,
                  OpenAI::Internal::AnyHash
                )
              end

            # The canonical name of the agent that produced this item.
            sig { returns(String) }
            attr_accessor :agent_name

            # The agent that produced this item.
            sig { params(agent_name: String).returns(T.attached_class) }
            def self.new(
              # The canonical name of the agent that produced this item.
              agent_name:
            )
            end

            sig { override.returns({ agent_name: String }) }
            def to_hash
            end
          end
        end

        class LocalShellCall < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseOutputItem::LocalShellCall,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the local shell call.
          sig { returns(String) }
          attr_accessor :id

          # Execute a shell command on the server.
          sig do
            returns(
              OpenAI::Beta::BetaResponseOutputItem::LocalShellCall::Action
            )
          end
          attr_reader :action

          sig do
            params(
              action:
                OpenAI::Beta::BetaResponseOutputItem::LocalShellCall::Action::OrHash
            ).void
          end
          attr_writer :action

          # The unique ID of the local shell tool call generated by the model.
          sig { returns(String) }
          attr_accessor :call_id

          # The status of the local shell call.
          sig do
            returns(
              OpenAI::Beta::BetaResponseOutputItem::LocalShellCall::Status::TaggedSymbol
            )
          end
          attr_accessor :status

          # The type of the local shell call. Always `local_shell_call`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The agent that produced this item.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::BetaResponseOutputItem::LocalShellCall::Agent
              )
            )
          end
          attr_reader :agent

          sig do
            params(
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseOutputItem::LocalShellCall::Agent::OrHash
                )
            ).void
          end
          attr_writer :agent

          # A tool call to run a command on the local shell.
          sig do
            params(
              id: String,
              action:
                OpenAI::Beta::BetaResponseOutputItem::LocalShellCall::Action::OrHash,
              call_id: String,
              status:
                OpenAI::Beta::BetaResponseOutputItem::LocalShellCall::Status::OrSymbol,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseOutputItem::LocalShellCall::Agent::OrHash
                ),
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique ID of the local shell call.
            id:,
            # Execute a shell command on the server.
            action:,
            # The unique ID of the local shell tool call generated by the model.
            call_id:,
            # The status of the local shell call.
            status:,
            # The agent that produced this item.
            agent: nil,
            # The type of the local shell call. Always `local_shell_call`.
            type: :local_shell_call
          )
          end

          sig do
            override.returns(
              {
                id: String,
                action:
                  OpenAI::Beta::BetaResponseOutputItem::LocalShellCall::Action,
                call_id: String,
                status:
                  OpenAI::Beta::BetaResponseOutputItem::LocalShellCall::Status::TaggedSymbol,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseOutputItem::LocalShellCall::Agent
                  )
              }
            )
          end
          def to_hash
          end

          class Action < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaResponseOutputItem::LocalShellCall::Action,
                  OpenAI::Internal::AnyHash
                )
              end

            # The command to run.
            sig { returns(T::Array[String]) }
            attr_accessor :command

            # Environment variables to set for the command.
            sig { returns(T::Hash[Symbol, String]) }
            attr_accessor :env

            # The type of the local shell action. Always `exec`.
            sig { returns(Symbol) }
            attr_accessor :type

            # Optional timeout in milliseconds for the command.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :timeout_ms

            # Optional user to run the command as.
            sig { returns(T.nilable(String)) }
            attr_accessor :user

            # Optional working directory to run the command in.
            sig { returns(T.nilable(String)) }
            attr_accessor :working_directory

            # Execute a shell command on the server.
            sig do
              params(
                command: T::Array[String],
                env: T::Hash[Symbol, String],
                timeout_ms: T.nilable(Integer),
                user: T.nilable(String),
                working_directory: T.nilable(String),
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The command to run.
              command:,
              # Environment variables to set for the command.
              env:,
              # Optional timeout in milliseconds for the command.
              timeout_ms: nil,
              # Optional user to run the command as.
              user: nil,
              # Optional working directory to run the command in.
              working_directory: nil,
              # The type of the local shell action. Always `exec`.
              type: :exec
            )
            end

            sig do
              override.returns(
                {
                  command: T::Array[String],
                  env: T::Hash[Symbol, String],
                  type: Symbol,
                  timeout_ms: T.nilable(Integer),
                  user: T.nilable(String),
                  working_directory: T.nilable(String)
                }
              )
            end
            def to_hash
            end
          end

          # The status of the local shell call.
          module Status
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Beta::BetaResponseOutputItem::LocalShellCall::Status
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            IN_PROGRESS =
              T.let(
                :in_progress,
                OpenAI::Beta::BetaResponseOutputItem::LocalShellCall::Status::TaggedSymbol
              )
            COMPLETED =
              T.let(
                :completed,
                OpenAI::Beta::BetaResponseOutputItem::LocalShellCall::Status::TaggedSymbol
              )
            INCOMPLETE =
              T.let(
                :incomplete,
                OpenAI::Beta::BetaResponseOutputItem::LocalShellCall::Status::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::BetaResponseOutputItem::LocalShellCall::Status::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          class Agent < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaResponseOutputItem::LocalShellCall::Agent,
                  OpenAI::Internal::AnyHash
                )
              end

            # The canonical name of the agent that produced this item.
            sig { returns(String) }
            attr_accessor :agent_name

            # The agent that produced this item.
            sig { params(agent_name: String).returns(T.attached_class) }
            def self.new(
              # The canonical name of the agent that produced this item.
              agent_name:
            )
            end

            sig { override.returns({ agent_name: String }) }
            def to_hash
            end
          end
        end

        class LocalShellCallOutput < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseOutputItem::LocalShellCallOutput,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the local shell tool call generated by the model.
          sig { returns(String) }
          attr_accessor :id

          # A JSON string of the output of the local shell tool call.
          sig { returns(String) }
          attr_accessor :output

          # The type of the local shell tool call output. Always `local_shell_call_output`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The agent that produced this item.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::BetaResponseOutputItem::LocalShellCallOutput::Agent
              )
            )
          end
          attr_reader :agent

          sig do
            params(
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseOutputItem::LocalShellCallOutput::Agent::OrHash
                )
            ).void
          end
          attr_writer :agent

          # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::BetaResponseOutputItem::LocalShellCallOutput::Status::TaggedSymbol
              )
            )
          end
          attr_accessor :status

          # The output of a local shell tool call.
          sig do
            params(
              id: String,
              output: String,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseOutputItem::LocalShellCallOutput::Agent::OrHash
                ),
              status:
                T.nilable(
                  OpenAI::Beta::BetaResponseOutputItem::LocalShellCallOutput::Status::OrSymbol
                ),
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique ID of the local shell tool call generated by the model.
            id:,
            # A JSON string of the output of the local shell tool call.
            output:,
            # The agent that produced this item.
            agent: nil,
            # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
            status: nil,
            # The type of the local shell tool call output. Always `local_shell_call_output`.
            type: :local_shell_call_output
          )
          end

          sig do
            override.returns(
              {
                id: String,
                output: String,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseOutputItem::LocalShellCallOutput::Agent
                  ),
                status:
                  T.nilable(
                    OpenAI::Beta::BetaResponseOutputItem::LocalShellCallOutput::Status::TaggedSymbol
                  )
              }
            )
          end
          def to_hash
          end

          class Agent < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaResponseOutputItem::LocalShellCallOutput::Agent,
                  OpenAI::Internal::AnyHash
                )
              end

            # The canonical name of the agent that produced this item.
            sig { returns(String) }
            attr_accessor :agent_name

            # The agent that produced this item.
            sig { params(agent_name: String).returns(T.attached_class) }
            def self.new(
              # The canonical name of the agent that produced this item.
              agent_name:
            )
            end

            sig { override.returns({ agent_name: String }) }
            def to_hash
            end
          end

          # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
          module Status
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Beta::BetaResponseOutputItem::LocalShellCallOutput::Status
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            IN_PROGRESS =
              T.let(
                :in_progress,
                OpenAI::Beta::BetaResponseOutputItem::LocalShellCallOutput::Status::TaggedSymbol
              )
            COMPLETED =
              T.let(
                :completed,
                OpenAI::Beta::BetaResponseOutputItem::LocalShellCallOutput::Status::TaggedSymbol
              )
            INCOMPLETE =
              T.let(
                :incomplete,
                OpenAI::Beta::BetaResponseOutputItem::LocalShellCallOutput::Status::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::BetaResponseOutputItem::LocalShellCallOutput::Status::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

        class McpCall < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseOutputItem::McpCall,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the tool call.
          sig { returns(String) }
          attr_accessor :id

          # A JSON string of the arguments passed to the tool.
          sig { returns(String) }
          attr_accessor :arguments

          # The name of the tool that was run.
          sig { returns(String) }
          attr_accessor :name

          # The label of the MCP server running the tool.
          sig { returns(String) }
          attr_accessor :server_label

          # The type of the item. Always `mcp_call`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The agent that produced this item.
          sig do
            returns(
              T.nilable(OpenAI::Beta::BetaResponseOutputItem::McpCall::Agent)
            )
          end
          attr_reader :agent

          sig do
            params(
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseOutputItem::McpCall::Agent::OrHash
                )
            ).void
          end
          attr_writer :agent

          # Unique identifier for the MCP tool call approval request. Include this value in
          # a subsequent `mcp_approval_response` input to approve or reject the
          # corresponding tool call.
          sig { returns(T.nilable(String)) }
          attr_accessor :approval_request_id

          # The error from the tool call, if any.
          sig { returns(T.nilable(String)) }
          attr_accessor :error

          # The output from the tool call.
          sig { returns(T.nilable(String)) }
          attr_accessor :output

          # The status of the tool call. One of `in_progress`, `completed`, `incomplete`,
          # `calling`, or `failed`.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::BetaResponseOutputItem::McpCall::Status::TaggedSymbol
              )
            )
          end
          attr_reader :status

          sig do
            params(
              status:
                OpenAI::Beta::BetaResponseOutputItem::McpCall::Status::OrSymbol
            ).void
          end
          attr_writer :status

          # An invocation of a tool on an MCP server.
          sig do
            params(
              id: String,
              arguments: String,
              name: String,
              server_label: String,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseOutputItem::McpCall::Agent::OrHash
                ),
              approval_request_id: T.nilable(String),
              error: T.nilable(String),
              output: T.nilable(String),
              status:
                OpenAI::Beta::BetaResponseOutputItem::McpCall::Status::OrSymbol,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique ID of the tool call.
            id:,
            # A JSON string of the arguments passed to the tool.
            arguments:,
            # The name of the tool that was run.
            name:,
            # The label of the MCP server running the tool.
            server_label:,
            # The agent that produced this item.
            agent: nil,
            # Unique identifier for the MCP tool call approval request. Include this value in
            # a subsequent `mcp_approval_response` input to approve or reject the
            # corresponding tool call.
            approval_request_id: nil,
            # The error from the tool call, if any.
            error: nil,
            # The output from the tool call.
            output: nil,
            # The status of the tool call. One of `in_progress`, `completed`, `incomplete`,
            # `calling`, or `failed`.
            status: nil,
            # The type of the item. Always `mcp_call`.
            type: :mcp_call
          )
          end

          sig do
            override.returns(
              {
                id: String,
                arguments: String,
                name: String,
                server_label: String,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseOutputItem::McpCall::Agent
                  ),
                approval_request_id: T.nilable(String),
                error: T.nilable(String),
                output: T.nilable(String),
                status:
                  OpenAI::Beta::BetaResponseOutputItem::McpCall::Status::TaggedSymbol
              }
            )
          end
          def to_hash
          end

          class Agent < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaResponseOutputItem::McpCall::Agent,
                  OpenAI::Internal::AnyHash
                )
              end

            # The canonical name of the agent that produced this item.
            sig { returns(String) }
            attr_accessor :agent_name

            # The agent that produced this item.
            sig { params(agent_name: String).returns(T.attached_class) }
            def self.new(
              # The canonical name of the agent that produced this item.
              agent_name:
            )
            end

            sig { override.returns({ agent_name: String }) }
            def to_hash
            end
          end

          # The status of the tool call. One of `in_progress`, `completed`, `incomplete`,
          # `calling`, or `failed`.
          module Status
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Beta::BetaResponseOutputItem::McpCall::Status
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            IN_PROGRESS =
              T.let(
                :in_progress,
                OpenAI::Beta::BetaResponseOutputItem::McpCall::Status::TaggedSymbol
              )
            COMPLETED =
              T.let(
                :completed,
                OpenAI::Beta::BetaResponseOutputItem::McpCall::Status::TaggedSymbol
              )
            INCOMPLETE =
              T.let(
                :incomplete,
                OpenAI::Beta::BetaResponseOutputItem::McpCall::Status::TaggedSymbol
              )
            CALLING =
              T.let(
                :calling,
                OpenAI::Beta::BetaResponseOutputItem::McpCall::Status::TaggedSymbol
              )
            FAILED =
              T.let(
                :failed,
                OpenAI::Beta::BetaResponseOutputItem::McpCall::Status::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::BetaResponseOutputItem::McpCall::Status::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end

        class McpListTools < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseOutputItem::McpListTools,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the list.
          sig { returns(String) }
          attr_accessor :id

          # The label of the MCP server.
          sig { returns(String) }
          attr_accessor :server_label

          # The tools available on the server.
          sig do
            returns(
              T::Array[OpenAI::Beta::BetaResponseOutputItem::McpListTools::Tool]
            )
          end
          attr_accessor :tools

          # The type of the item. Always `mcp_list_tools`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The agent that produced this item.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::BetaResponseOutputItem::McpListTools::Agent
              )
            )
          end
          attr_reader :agent

          sig do
            params(
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseOutputItem::McpListTools::Agent::OrHash
                )
            ).void
          end
          attr_writer :agent

          # Error message if the server could not list tools.
          sig { returns(T.nilable(String)) }
          attr_accessor :error

          # A list of tools available on an MCP server.
          sig do
            params(
              id: String,
              server_label: String,
              tools:
                T::Array[
                  OpenAI::Beta::BetaResponseOutputItem::McpListTools::Tool::OrHash
                ],
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseOutputItem::McpListTools::Agent::OrHash
                ),
              error: T.nilable(String),
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique ID of the list.
            id:,
            # The label of the MCP server.
            server_label:,
            # The tools available on the server.
            tools:,
            # The agent that produced this item.
            agent: nil,
            # Error message if the server could not list tools.
            error: nil,
            # The type of the item. Always `mcp_list_tools`.
            type: :mcp_list_tools
          )
          end

          sig do
            override.returns(
              {
                id: String,
                server_label: String,
                tools:
                  T::Array[
                    OpenAI::Beta::BetaResponseOutputItem::McpListTools::Tool
                  ],
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseOutputItem::McpListTools::Agent
                  ),
                error: T.nilable(String)
              }
            )
          end
          def to_hash
          end

          class Tool < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaResponseOutputItem::McpListTools::Tool,
                  OpenAI::Internal::AnyHash
                )
              end

            # The JSON schema describing the tool's input.
            sig { returns(T.anything) }
            attr_accessor :input_schema

            # The name of the tool.
            sig { returns(String) }
            attr_accessor :name

            # Additional annotations about the tool.
            sig { returns(T.nilable(T.anything)) }
            attr_accessor :annotations

            # The description of the tool.
            sig { returns(T.nilable(String)) }
            attr_accessor :description

            # A tool available on an MCP server.
            sig do
              params(
                input_schema: T.anything,
                name: String,
                annotations: T.nilable(T.anything),
                description: T.nilable(String)
              ).returns(T.attached_class)
            end
            def self.new(
              # The JSON schema describing the tool's input.
              input_schema:,
              # The name of the tool.
              name:,
              # Additional annotations about the tool.
              annotations: nil,
              # The description of the tool.
              description: nil
            )
            end

            sig do
              override.returns(
                {
                  input_schema: T.anything,
                  name: String,
                  annotations: T.nilable(T.anything),
                  description: T.nilable(String)
                }
              )
            end
            def to_hash
            end
          end

          class Agent < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaResponseOutputItem::McpListTools::Agent,
                  OpenAI::Internal::AnyHash
                )
              end

            # The canonical name of the agent that produced this item.
            sig { returns(String) }
            attr_accessor :agent_name

            # The agent that produced this item.
            sig { params(agent_name: String).returns(T.attached_class) }
            def self.new(
              # The canonical name of the agent that produced this item.
              agent_name:
            )
            end

            sig { override.returns({ agent_name: String }) }
            def to_hash
            end
          end
        end

        class McpApprovalRequest < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseOutputItem::McpApprovalRequest,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the approval request.
          sig { returns(String) }
          attr_accessor :id

          # A JSON string of arguments for the tool.
          sig { returns(String) }
          attr_accessor :arguments

          # The name of the tool to run.
          sig { returns(String) }
          attr_accessor :name

          # The label of the MCP server making the request.
          sig { returns(String) }
          attr_accessor :server_label

          # The type of the item. Always `mcp_approval_request`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The agent that produced this item.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::BetaResponseOutputItem::McpApprovalRequest::Agent
              )
            )
          end
          attr_reader :agent

          sig do
            params(
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseOutputItem::McpApprovalRequest::Agent::OrHash
                )
            ).void
          end
          attr_writer :agent

          # A request for human approval of a tool invocation.
          sig do
            params(
              id: String,
              arguments: String,
              name: String,
              server_label: String,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseOutputItem::McpApprovalRequest::Agent::OrHash
                ),
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique ID of the approval request.
            id:,
            # A JSON string of arguments for the tool.
            arguments:,
            # The name of the tool to run.
            name:,
            # The label of the MCP server making the request.
            server_label:,
            # The agent that produced this item.
            agent: nil,
            # The type of the item. Always `mcp_approval_request`.
            type: :mcp_approval_request
          )
          end

          sig do
            override.returns(
              {
                id: String,
                arguments: String,
                name: String,
                server_label: String,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseOutputItem::McpApprovalRequest::Agent
                  )
              }
            )
          end
          def to_hash
          end

          class Agent < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaResponseOutputItem::McpApprovalRequest::Agent,
                  OpenAI::Internal::AnyHash
                )
              end

            # The canonical name of the agent that produced this item.
            sig { returns(String) }
            attr_accessor :agent_name

            # The agent that produced this item.
            sig { params(agent_name: String).returns(T.attached_class) }
            def self.new(
              # The canonical name of the agent that produced this item.
              agent_name:
            )
            end

            sig { override.returns({ agent_name: String }) }
            def to_hash
            end
          end
        end

        class McpApprovalResponse < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseOutputItem::McpApprovalResponse,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the approval response
          sig { returns(String) }
          attr_accessor :id

          # The ID of the approval request being answered.
          sig { returns(String) }
          attr_accessor :approval_request_id

          # Whether the request was approved.
          sig { returns(T::Boolean) }
          attr_accessor :approve

          # The type of the item. Always `mcp_approval_response`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The agent that produced this item.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::BetaResponseOutputItem::McpApprovalResponse::Agent
              )
            )
          end
          attr_reader :agent

          sig do
            params(
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseOutputItem::McpApprovalResponse::Agent::OrHash
                )
            ).void
          end
          attr_writer :agent

          # Optional reason for the decision.
          sig { returns(T.nilable(String)) }
          attr_accessor :reason

          # A response to an MCP approval request.
          sig do
            params(
              id: String,
              approval_request_id: String,
              approve: T::Boolean,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseOutputItem::McpApprovalResponse::Agent::OrHash
                ),
              reason: T.nilable(String),
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique ID of the approval response
            id:,
            # The ID of the approval request being answered.
            approval_request_id:,
            # Whether the request was approved.
            approve:,
            # The agent that produced this item.
            agent: nil,
            # Optional reason for the decision.
            reason: nil,
            # The type of the item. Always `mcp_approval_response`.
            type: :mcp_approval_response
          )
          end

          sig do
            override.returns(
              {
                id: String,
                approval_request_id: String,
                approve: T::Boolean,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseOutputItem::McpApprovalResponse::Agent
                  ),
                reason: T.nilable(String)
              }
            )
          end
          def to_hash
          end

          class Agent < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaResponseOutputItem::McpApprovalResponse::Agent,
                  OpenAI::Internal::AnyHash
                )
              end

            # The canonical name of the agent that produced this item.
            sig { returns(String) }
            attr_accessor :agent_name

            # The agent that produced this item.
            sig { params(agent_name: String).returns(T.attached_class) }
            def self.new(
              # The canonical name of the agent that produced this item.
              agent_name:
            )
            end

            sig { override.returns({ agent_name: String }) }
            def to_hash
            end
          end
        end

        sig do
          override.returns(
            T::Array[OpenAI::Beta::BetaResponseOutputItem::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
