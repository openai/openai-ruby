# typed: strong

module OpenAI
  module Models

    module Beta

      # An item associated with a session turn.
      module AgentSessionItem
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::AgentSessionMessage,
            OpenAI::Beta::AgentReasoningItem,
            OpenAI::Beta::AgentFunctionCallItem,
            OpenAI::Beta::AgentSessionItem::FunctionCallOutput,
            OpenAI::Beta::AgentSessionItem::AgentMessage,
            OpenAI::Beta::AgentMcpCallItem,
            OpenAI::Beta::AgentWebSearchCallItem,
            OpenAI::Beta::AgentCommandExecutionItem,
            OpenAI::Beta::AgentCreateSubagentCallItem,
            OpenAI::Beta::AgentSendSubagentInputCallItem,
            OpenAI::Beta::AgentResumeSubagentCallItem,
            OpenAI::Beta::AgentWaitForSubagentsCallItem,
            OpenAI::Beta::AgentInterruptSubagentCallItem,
            OpenAI::Beta::AgentCloseSubagentCallItem
          )
        end

        class FunctionCallOutput < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::AgentSessionItem::FunctionCallOutput,
              OpenAI::Internal::AnyHash
            )
          end

          # The ID of the function call output item.
          sig { returns(String) }
          attr_accessor :id

          # The ID of the function call that produced this output.
          sig { returns(String) }
          attr_accessor :call_id

          # The error message, if the call failed.
          sig { returns(T.nilable(String)) }
          attr_accessor :error

          # The text or model-input content supplied as a function result.
          sig { returns(T.nilable(OpenAI::Beta::AgentFunctionCallOutput::Variants)) }
          attr_accessor :output

          # The status of the function call.
          sig { returns(OpenAI::Beta::AgentFunctionCallStatus::TaggedSymbol) }
          attr_accessor :status

          # The ID of the turn that contains this item.
          sig { returns(String) }
          attr_accessor :turn_id

          # The item type. Always `function_call_output`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The result supplied for a function call.
          sig do
            params(

              id: String,

              call_id: String,

              error: T.nilable(String),

              output: T.nilable(
                T.any(
                  String,
                  T::Array[
                    T.any(OpenAI::Beta::InputContent::InputText::OrHash, OpenAI::Beta::InputContent::InputImage::OrHash)
                  ]
                )
              ),

              status: OpenAI::Beta::AgentFunctionCallStatus::OrSymbol,

              turn_id: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The ID of the function call output item.
            id:,

            # The ID of the function call that produced this output.
            call_id:,

            # The error message, if the call failed.
            error:,

            # The text or model-input content supplied as a function result.
            output:,

            # The status of the function call.
            status:,

            # The ID of the turn that contains this item.
            turn_id:,

            # The item type. Always `function_call_output`.

            type: :function_call_output
          )
          end

          sig do
            override.returns(
              {
                id: String,
                call_id: String,
                error: T.nilable(String),
                output: T.nilable(OpenAI::Beta::AgentFunctionCallOutput::Variants),
                status: OpenAI::Beta::AgentFunctionCallStatus::TaggedSymbol,
                turn_id: String,
                type: Symbol
              }
            )
          end
          def to_hash
          end

        end

        class AgentMessage < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::AgentSessionItem::AgentMessage,
              OpenAI::Internal::AnyHash
            )
          end

          # The ID of the message.
          sig { returns(String) }
          attr_accessor :id

          # The content exchanged between the agents.
          sig { returns(T::Array[OpenAI::Beta::AgentContent::Variants]) }
          attr_accessor :content

          # The ID or name of the receiving agent.
          sig { returns(String) }
          attr_accessor :recipient_agent_id

          # The ID or name of the sending agent.
          sig { returns(String) }
          attr_accessor :sender_agent_id

          # The ID of the turn that contains this item.
          sig { returns(String) }
          attr_accessor :turn_id

          # The item type. Always `agent_message`.
          sig { returns(Symbol) }
          attr_accessor :type

          # A message exchanged between agent threads.
          sig do
            params(

              id: String,

              content: T::Array[
                T.any(OpenAI::Beta::OutputText::OrHash, OpenAI::Beta::AgentContent::EncryptedContent::OrHash)
              ],

              recipient_agent_id: String,

              sender_agent_id: String,

              turn_id: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The ID of the message.
            id:,

            # The content exchanged between the agents.
            content:,

            # The ID or name of the receiving agent.
            recipient_agent_id:,

            # The ID or name of the sending agent.
            sender_agent_id:,

            # The ID of the turn that contains this item.
            turn_id:,

            # The item type. Always `agent_message`.

            type: :agent_message
          )
          end

          sig do
            override.returns(
              {
                id: String,
                content: T::Array[OpenAI::Beta::AgentContent::Variants],
                recipient_agent_id: String,
                sender_agent_id: String,
                turn_id: String,
                type: Symbol
              }
            )
          end
          def to_hash
          end

        end

        sig { override.returns(T::Array[OpenAI::Beta::AgentSessionItem::Variants]) }
        def self.variants
        end

      end

    end

  end
end
