# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # A message input to the model with a role indicating instruction following
      # hierarchy. Instructions given with the `developer` or `system` role take
      # precedence over instructions given with the `user` role. Messages with the
      # `assistant` role are presumed to have been generated by the model in previous
      # interactions.
      module ResponseInputItem
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A message input to the model with a role indicating instruction following
        # hierarchy. Instructions given with the `developer` or `system` role take
        # precedence over instructions given with the `user` role. Messages with the
        # `assistant` role are presumed to have been generated by the model in previous
        # interactions.
        variant :message, -> { OpenAI::Models::Responses::EasyInputMessage }

        # A message input to the model with a role indicating instruction following
        # hierarchy. Instructions given with the `developer` or `system` role take
        # precedence over instructions given with the `user` role.
        variant :message, -> { OpenAI::Models::Responses::ResponseInputItem::Message }

        # An output message from the model.
        variant :message, -> { OpenAI::Models::Responses::ResponseOutputMessage }

        # The results of a file search tool call. See the
        # [file search guide](https://platform.openai.com/docs/guides/tools-file-search) for more information.
        variant :file_search_call, -> { OpenAI::Models::Responses::ResponseFileSearchToolCall }

        # A tool call to a computer use tool. See the
        # [computer use guide](https://platform.openai.com/docs/guides/tools-computer-use) for more information.
        variant :computer_call, -> { OpenAI::Models::Responses::ResponseComputerToolCall }

        # The output of a computer tool call.
        variant :computer_call_output, -> { OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput }

        # The results of a web search tool call. See the
        # [web search guide](https://platform.openai.com/docs/guides/tools-web-search) for more information.
        variant :web_search_call, -> { OpenAI::Models::Responses::ResponseFunctionWebSearch }

        # A tool call to run a function. See the
        # [function calling guide](https://platform.openai.com/docs/guides/function-calling) for more information.
        variant :function_call, -> { OpenAI::Models::Responses::ResponseFunctionToolCall }

        # The output of a function tool call.
        variant :function_call_output, -> { OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput }

        # A description of the chain of thought used by a reasoning model while generating
        # a response.
        variant :reasoning, -> { OpenAI::Models::Responses::ResponseReasoningItem }

        # An internal identifier for an item to reference.
        variant :item_reference, -> { OpenAI::Models::Responses::ResponseInputItem::ItemReference }

        class Message < OpenAI::Internal::Type::BaseModel
          # @!attribute content
          #   A list of one or many input items to the model, containing different content
          #   types.
          #
          #   @return [Array<OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Responses::ResponseInputImage, OpenAI::Models::Responses::ResponseInputFile>]
          required :content,
                   -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::Responses::ResponseInputContent] }

          # @!attribute role
          #   The role of the message input. One of `user`, `system`, or `developer`.
          #
          #   @return [Symbol, OpenAI::Models::Responses::ResponseInputItem::Message::Role]
          required :role, enum: -> { OpenAI::Models::Responses::ResponseInputItem::Message::Role }

          # @!attribute status
          #   The status of item. One of `in_progress`, `completed`, or `incomplete`.
          #   Populated when items are returned via API.
          #
          #   @return [Symbol, OpenAI::Models::Responses::ResponseInputItem::Message::Status, nil]
          optional :status, enum: -> { OpenAI::Models::Responses::ResponseInputItem::Message::Status }

          # @!attribute type
          #   The type of the message input. Always set to `message`.
          #
          #   @return [Symbol, OpenAI::Models::Responses::ResponseInputItem::Message::Type, nil]
          optional :type, enum: -> { OpenAI::Models::Responses::ResponseInputItem::Message::Type }

          # @!method initialize(content:, role:, status: nil, type: nil)
          #   A message input to the model with a role indicating instruction following
          #   hierarchy. Instructions given with the `developer` or `system` role take
          #   precedence over instructions given with the `user` role.
          #
          #   @param content [Array<OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Responses::ResponseInputImage, OpenAI::Models::Responses::ResponseInputFile>]
          #   @param role [Symbol, OpenAI::Models::Responses::ResponseInputItem::Message::Role]
          #   @param status [Symbol, OpenAI::Models::Responses::ResponseInputItem::Message::Status]
          #   @param type [Symbol, OpenAI::Models::Responses::ResponseInputItem::Message::Type]

          # The role of the message input. One of `user`, `system`, or `developer`.
          #
          # @see OpenAI::Models::Responses::ResponseInputItem::Message#role
          module Role
            extend OpenAI::Internal::Type::Enum

            USER = :user
            SYSTEM = :system
            DEVELOPER = :developer

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # The status of item. One of `in_progress`, `completed`, or `incomplete`.
          # Populated when items are returned via API.
          #
          # @see OpenAI::Models::Responses::ResponseInputItem::Message#status
          module Status
            extend OpenAI::Internal::Type::Enum

            IN_PROGRESS = :in_progress
            COMPLETED = :completed
            INCOMPLETE = :incomplete

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # The type of the message input. Always set to `message`.
          #
          # @see OpenAI::Models::Responses::ResponseInputItem::Message#type
          module Type
            extend OpenAI::Internal::Type::Enum

            MESSAGE = :message

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        class ComputerCallOutput < OpenAI::Internal::Type::BaseModel
          # @!attribute call_id
          #   The ID of the computer tool call that produced the output.
          #
          #   @return [String]
          required :call_id, String

          # @!attribute output
          #   A computer screenshot image used with the computer use tool.
          #
          #   @return [OpenAI::Models::Responses::ResponseComputerToolCallOutputScreenshot]
          required :output, -> { OpenAI::Models::Responses::ResponseComputerToolCallOutputScreenshot }

          # @!attribute type
          #   The type of the computer tool call output. Always `computer_call_output`.
          #
          #   @return [Symbol, :computer_call_output]
          required :type, const: :computer_call_output

          # @!attribute id
          #   The ID of the computer tool call output.
          #
          #   @return [String, nil]
          optional :id, String

          # @!attribute acknowledged_safety_checks
          #   The safety checks reported by the API that have been acknowledged by the
          #   developer.
          #
          #   @return [Array<OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::AcknowledgedSafetyCheck>, nil]
          optional :acknowledged_safety_checks,
                   -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::AcknowledgedSafetyCheck] }

          # @!attribute status
          #   The status of the message input. One of `in_progress`, `completed`, or
          #   `incomplete`. Populated when input items are returned via API.
          #
          #   @return [Symbol, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::Status, nil]
          optional :status, enum: -> { OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::Status }

          # @!method initialize(call_id:, output:, id: nil, acknowledged_safety_checks: nil, status: nil, type: :computer_call_output)
          #   The output of a computer tool call.
          #
          #   @param call_id [String]
          #   @param output [OpenAI::Models::Responses::ResponseComputerToolCallOutputScreenshot]
          #   @param id [String]
          #   @param acknowledged_safety_checks [Array<OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::AcknowledgedSafetyCheck>]
          #   @param status [Symbol, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::Status]
          #   @param type [Symbol, :computer_call_output]

          class AcknowledgedSafetyCheck < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The ID of the pending safety check.
            #
            #   @return [String]
            required :id, String

            # @!attribute code
            #   The type of the pending safety check.
            #
            #   @return [String]
            required :code, String

            # @!attribute message
            #   Details about the pending safety check.
            #
            #   @return [String]
            required :message, String

            # @!method initialize(id:, code:, message:)
            #   A pending safety check for the computer call.
            #
            #   @param id [String]
            #   @param code [String]
            #   @param message [String]
          end

          # The status of the message input. One of `in_progress`, `completed`, or
          # `incomplete`. Populated when input items are returned via API.
          #
          # @see OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput#status
          module Status
            extend OpenAI::Internal::Type::Enum

            IN_PROGRESS = :in_progress
            COMPLETED = :completed
            INCOMPLETE = :incomplete

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        class FunctionCallOutput < OpenAI::Internal::Type::BaseModel
          # @!attribute call_id
          #   The unique ID of the function tool call generated by the model.
          #
          #   @return [String]
          required :call_id, String

          # @!attribute output
          #   A JSON string of the output of the function tool call.
          #
          #   @return [String]
          required :output, String

          # @!attribute type
          #   The type of the function tool call output. Always `function_call_output`.
          #
          #   @return [Symbol, :function_call_output]
          required :type, const: :function_call_output

          # @!attribute id
          #   The unique ID of the function tool call output. Populated when this item is
          #   returned via API.
          #
          #   @return [String, nil]
          optional :id, String

          # @!attribute status
          #   The status of the item. One of `in_progress`, `completed`, or `incomplete`.
          #   Populated when items are returned via API.
          #
          #   @return [Symbol, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput::Status, nil]
          optional :status, enum: -> { OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput::Status }

          # @!method initialize(call_id:, output:, id: nil, status: nil, type: :function_call_output)
          #   The output of a function tool call.
          #
          #   @param call_id [String]
          #   @param output [String]
          #   @param id [String]
          #   @param status [Symbol, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput::Status]
          #   @param type [Symbol, :function_call_output]

          # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
          # Populated when items are returned via API.
          #
          # @see OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput#status
          module Status
            extend OpenAI::Internal::Type::Enum

            IN_PROGRESS = :in_progress
            COMPLETED = :completed
            INCOMPLETE = :incomplete

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        class ItemReference < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The ID of the item to reference.
          #
          #   @return [String]
          required :id, String

          # @!attribute type
          #   The type of item to reference. Always `item_reference`.
          #
          #   @return [Symbol, :item_reference]
          required :type, const: :item_reference

          # @!method initialize(id:, type: :item_reference)
          #   An internal identifier for an item to reference.
          #
          #   @param id [String]
          #   @param type [Symbol, :item_reference]
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseInputItem::ItemReference)]
      end
    end
  end
end
