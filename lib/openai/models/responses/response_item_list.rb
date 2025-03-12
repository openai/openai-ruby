# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseItemList < OpenAI::BaseModel
        # @!attribute data
        #   A list of items used to generate this response.
        #
        #   @return [Array<OpenAI::Models::Responses::ResponseItemList::Data::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseItemList::Data::FunctionCallOutput>]
        required :data, -> { OpenAI::ArrayOf[union: OpenAI::Models::Responses::ResponseItemList::Data] }

        # @!attribute first_id
        #   The ID of the first item in the list.
        #
        #   @return [String]
        required :first_id, String

        # @!attribute has_more
        #   Whether there are more items available.
        #
        #   @return [Boolean]
        required :has_more, OpenAI::BooleanModel

        # @!attribute last_id
        #   The ID of the last item in the list.
        #
        #   @return [String]
        required :last_id, String

        # @!attribute object
        #   The type of object returned, must be `list`.
        #
        #   @return [Symbol, :list]
        required :object, const: :list

        # @!parse
        #   # A list of Response items.
        #   #
        #   # @param data [Array<OpenAI::Models::Responses::ResponseItemList::Data::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseItemList::Data::FunctionCallOutput>]
        #   # @param first_id [String]
        #   # @param has_more [Boolean]
        #   # @param last_id [String]
        #   # @param object [Symbol, :list]
        #   #
        #   def initialize(data:, first_id:, has_more:, last_id:, object: :list, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # @abstract
        #
        # Content item used to generate a response.
        class Data < OpenAI::Union
          discriminator :type

          variant :message, -> { OpenAI::Models::Responses::ResponseItemList::Data::Message }

          # An output message from the model.
          variant :message, -> { OpenAI::Models::Responses::ResponseOutputMessage }

          # The results of a file search tool call. See the
          # [file search guide](https://platform.openai.com/docs/guides/tools-file-search) for more information.
          variant :file_search_call, -> { OpenAI::Models::Responses::ResponseFileSearchToolCall }

          # A tool call to a computer use tool. See the
          # [computer use guide](https://platform.openai.com/docs/guides/tools-computer-use) for more information.
          variant :computer_call, -> { OpenAI::Models::Responses::ResponseComputerToolCall }

          variant :computer_call_output,
                  -> { OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput }

          # The results of a web search tool call. See the
          # [web search guide](https://platform.openai.com/docs/guides/tools-web-search) for more information.
          variant :web_search_call, -> { OpenAI::Models::Responses::ResponseFunctionWebSearch }

          # A tool call to run a function. See the
          # [function calling guide](https://platform.openai.com/docs/guides/function-calling) for more information.
          variant :function_call, -> { OpenAI::Models::Responses::ResponseFunctionToolCall }

          variant :function_call_output,
                  -> { OpenAI::Models::Responses::ResponseItemList::Data::FunctionCallOutput }

          class Message < OpenAI::BaseModel
            # @!attribute id
            #   The unique ID of the message input.
            #
            #   @return [String]
            required :id, String

            # @!attribute content
            #   A list of one or many input items to the model, containing different content
            #     types.
            #
            #   @return [Array<OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Responses::ResponseInputImage, OpenAI::Models::Responses::ResponseInputFile>]
            required :content, -> { OpenAI::ArrayOf[union: OpenAI::Models::Responses::ResponseInputContent] }

            # @!attribute role
            #   The role of the message input. One of `user`, `system`, or `developer`.
            #
            #   @return [Symbol, OpenAI::Models::Responses::ResponseItemList::Data::Message::Role]
            required :role, enum: -> { OpenAI::Models::Responses::ResponseItemList::Data::Message::Role }

            # @!attribute [r] status
            #   The status of item. One of `in_progress`, `completed`, or `incomplete`.
            #     Populated when items are returned via API.
            #
            #   @return [Symbol, OpenAI::Models::Responses::ResponseItemList::Data::Message::Status, nil]
            optional :status, enum: -> { OpenAI::Models::Responses::ResponseItemList::Data::Message::Status }

            # @!parse
            #   # @return [Symbol, OpenAI::Models::Responses::ResponseItemList::Data::Message::Status]
            #   attr_writer :status

            # @!attribute [r] type
            #   The type of the message input. Always set to `message`.
            #
            #   @return [Symbol, OpenAI::Models::Responses::ResponseItemList::Data::Message::Type, nil]
            optional :type, enum: -> { OpenAI::Models::Responses::ResponseItemList::Data::Message::Type }

            # @!parse
            #   # @return [Symbol, OpenAI::Models::Responses::ResponseItemList::Data::Message::Type]
            #   attr_writer :type

            # @!parse
            #   # @param id [String]
            #   # @param content [Array<OpenAI::Models::Responses::ResponseInputText, OpenAI::Models::Responses::ResponseInputImage, OpenAI::Models::Responses::ResponseInputFile>]
            #   # @param role [Symbol, OpenAI::Models::Responses::ResponseItemList::Data::Message::Role]
            #   # @param status [Symbol, OpenAI::Models::Responses::ResponseItemList::Data::Message::Status]
            #   # @param type [Symbol, OpenAI::Models::Responses::ResponseItemList::Data::Message::Type]
            #   #
            #   def initialize(id:, content:, role:, status: nil, type: nil, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void

            # @abstract
            #
            # The role of the message input. One of `user`, `system`, or `developer`.
            class Role < OpenAI::Enum
              USER = :user
              SYSTEM = :system
              DEVELOPER = :developer

              finalize!
            end

            # @abstract
            #
            # The status of item. One of `in_progress`, `completed`, or `incomplete`.
            #   Populated when items are returned via API.
            class Status < OpenAI::Enum
              IN_PROGRESS = :in_progress
              COMPLETED = :completed
              INCOMPLETE = :incomplete

              finalize!
            end

            # @abstract
            #
            # The type of the message input. Always set to `message`.
            class Type < OpenAI::Enum
              MESSAGE = :message

              finalize!
            end
          end

          class ComputerCallOutput < OpenAI::BaseModel
            # @!attribute id
            #   The unique ID of the computer call tool output.
            #
            #   @return [String]
            required :id, String

            # @!attribute call_id
            #   The ID of the computer tool call that produced the output.
            #
            #   @return [String]
            required :call_id, String

            # @!attribute output
            #   A computer screenshot image used with the computer use tool.
            #
            #   @return [OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::Output]
            required :output, -> { OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::Output }

            # @!attribute type
            #   The type of the computer tool call output. Always `computer_call_output`.
            #
            #   @return [Symbol, :computer_call_output]
            required :type, const: :computer_call_output

            # @!attribute [r] acknowledged_safety_checks
            #   The safety checks reported by the API that have been acknowledged by the
            #     developer.
            #
            #   @return [Array<OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::AcknowledgedSafetyCheck>, nil]
            optional :acknowledged_safety_checks,
                     -> { OpenAI::ArrayOf[OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::AcknowledgedSafetyCheck] }

            # @!parse
            #   # @return [Array<OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::AcknowledgedSafetyCheck>]
            #   attr_writer :acknowledged_safety_checks

            # @!attribute [r] status
            #   The status of the message input. One of `in_progress`, `completed`, or
            #     `incomplete`. Populated when input items are returned via API.
            #
            #   @return [Symbol, OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::Status, nil]
            optional :status,
                     enum: -> { OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::Status }

            # @!parse
            #   # @return [Symbol, OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::Status]
            #   attr_writer :status

            # @!parse
            #   # @param id [String]
            #   # @param call_id [String]
            #   # @param output [OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::Output]
            #   # @param acknowledged_safety_checks [Array<OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::AcknowledgedSafetyCheck>]
            #   # @param status [Symbol, OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::Status]
            #   # @param type [Symbol, :computer_call_output]
            #   #
            #   def initialize(id:, call_id:, output:, acknowledged_safety_checks: nil, status: nil, type: :computer_call_output, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void

            class Output < OpenAI::BaseModel
              # @!attribute type
              #   Specifies the event type. For a computer screenshot, this property is always set
              #     to `computer_screenshot`.
              #
              #   @return [Symbol, :computer_screenshot]
              required :type, const: :computer_screenshot

              # @!attribute [r] file_id
              #   The identifier of an uploaded file that contains the screenshot.
              #
              #   @return [String, nil]
              optional :file_id, String

              # @!parse
              #   # @return [String]
              #   attr_writer :file_id

              # @!attribute [r] image_url
              #   The URL of the screenshot image.
              #
              #   @return [String, nil]
              optional :image_url, String

              # @!parse
              #   # @return [String]
              #   attr_writer :image_url

              # @!parse
              #   # A computer screenshot image used with the computer use tool.
              #   #
              #   # @param file_id [String]
              #   # @param image_url [String]
              #   # @param type [Symbol, :computer_screenshot]
              #   #
              #   def initialize(file_id: nil, image_url: nil, type: :computer_screenshot, **) = super

              # def initialize: (Hash | OpenAI::BaseModel) -> void
            end

            class AcknowledgedSafetyCheck < OpenAI::BaseModel
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

              # @!parse
              #   # A pending safety check for the computer call.
              #   #
              #   # @param id [String]
              #   # @param code [String]
              #   # @param message [String]
              #   #
              #   def initialize(id:, code:, message:, **) = super

              # def initialize: (Hash | OpenAI::BaseModel) -> void
            end

            # @abstract
            #
            # The status of the message input. One of `in_progress`, `completed`, or
            #   `incomplete`. Populated when input items are returned via API.
            class Status < OpenAI::Enum
              IN_PROGRESS = :in_progress
              COMPLETED = :completed
              INCOMPLETE = :incomplete

              finalize!
            end
          end

          class FunctionCallOutput < OpenAI::BaseModel
            # @!attribute id
            #   The unique ID of the function call tool output.
            #
            #   @return [String]
            required :id, String

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

            # @!attribute [r] status
            #   The status of the item. One of `in_progress`, `completed`, or `incomplete`.
            #     Populated when items are returned via API.
            #
            #   @return [Symbol, OpenAI::Models::Responses::ResponseItemList::Data::FunctionCallOutput::Status, nil]
            optional :status,
                     enum: -> { OpenAI::Models::Responses::ResponseItemList::Data::FunctionCallOutput::Status }

            # @!parse
            #   # @return [Symbol, OpenAI::Models::Responses::ResponseItemList::Data::FunctionCallOutput::Status]
            #   attr_writer :status

            # @!parse
            #   # @param id [String]
            #   # @param call_id [String]
            #   # @param output [String]
            #   # @param status [Symbol, OpenAI::Models::Responses::ResponseItemList::Data::FunctionCallOutput::Status]
            #   # @param type [Symbol, :function_call_output]
            #   #
            #   def initialize(id:, call_id:, output:, status: nil, type: :function_call_output, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void

            # @abstract
            #
            # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
            #   Populated when items are returned via API.
            class Status < OpenAI::Enum
              IN_PROGRESS = :in_progress
              COMPLETED = :completed
              INCOMPLETE = :incomplete

              finalize!
            end
          end
        end
      end
    end

    ResponseItemList = Responses::ResponseItemList
  end
end
