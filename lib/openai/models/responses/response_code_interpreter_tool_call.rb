# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseCodeInterpreterToolCall < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the code interpreter tool call.
        #
        #   @return [String]
        required :id, String

        # @!attribute code
        #   The code to run, or null if not available.
        #
        #   @return [String, nil]
        required :code, String, nil?: true

        # @!attribute container_id
        #   The ID of the container used to run the code.
        #
        #   @return [String]
        required :container_id, String

        # @!attribute outputs
        #   The outputs generated by the code interpreter, such as logs or images. Can be
        #   null if no outputs are available.
        #
        #   @return [Array<OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Output::Logs, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Output::Image>, nil]
        required :outputs,
                 -> {
                   OpenAI::Internal::Type::ArrayOf[union: OpenAI::Responses::ResponseCodeInterpreterToolCall::Output]
                 },
                 nil?: true

        # @!attribute status
        #   The status of the code interpreter tool call. Valid values are `in_progress`,
        #   `completed`, `incomplete`, `interpreting`, and `failed`.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Status]
        required :status, enum: -> { OpenAI::Responses::ResponseCodeInterpreterToolCall::Status }

        # @!attribute type
        #   The type of the code interpreter tool call. Always `code_interpreter_call`.
        #
        #   @return [Symbol, :code_interpreter_call]
        required :type, const: :code_interpreter_call

        # @!method initialize(id:, code:, container_id:, outputs:, status:, type: :code_interpreter_call)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseCodeInterpreterToolCall} for more details.
        #
        #   A tool call to run code.
        #
        #   @param id [String] The unique ID of the code interpreter tool call.
        #
        #   @param code [String, nil] The code to run, or null if not available.
        #
        #   @param container_id [String] The ID of the container used to run the code.
        #
        #   @param outputs [Array<OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Output::Logs, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Output::Image>, nil] The outputs generated by the code interpreter, such as logs or images.
        #
        #   @param status [Symbol, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Status] The status of the code interpreter tool call. Valid values are `in_progress`, `c
        #
        #   @param type [Symbol, :code_interpreter_call] The type of the code interpreter tool call. Always `code_interpreter_call`.

        # The logs output from the code interpreter.
        module Output
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # The logs output from the code interpreter.
          variant :logs, -> { OpenAI::Responses::ResponseCodeInterpreterToolCall::Output::Logs }

          # The image output from the code interpreter.
          variant :image, -> { OpenAI::Responses::ResponseCodeInterpreterToolCall::Output::Image }

          class Logs < OpenAI::Internal::Type::BaseModel
            # @!attribute logs
            #   The logs output from the code interpreter.
            #
            #   @return [String]
            required :logs, String

            # @!attribute type
            #   The type of the output. Always 'logs'.
            #
            #   @return [Symbol, :logs]
            required :type, const: :logs

            # @!method initialize(logs:, type: :logs)
            #   The logs output from the code interpreter.
            #
            #   @param logs [String] The logs output from the code interpreter.
            #
            #   @param type [Symbol, :logs] The type of the output. Always 'logs'.
          end

          class Image < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   The type of the output. Always 'image'.
            #
            #   @return [Symbol, :image]
            required :type, const: :image

            # @!attribute url
            #   The URL of the image output from the code interpreter.
            #
            #   @return [String]
            required :url, String

            # @!method initialize(url:, type: :image)
            #   The image output from the code interpreter.
            #
            #   @param url [String] The URL of the image output from the code interpreter.
            #
            #   @param type [Symbol, :image] The type of the output. Always 'image'.
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Output::Logs, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall::Output::Image)]
        end

        # The status of the code interpreter tool call. Valid values are `in_progress`,
        # `completed`, `incomplete`, `interpreting`, and `failed`.
        #
        # @see OpenAI::Models::Responses::ResponseCodeInterpreterToolCall#status
        module Status
          extend OpenAI::Internal::Type::Enum

          IN_PROGRESS = :in_progress
          COMPLETED = :completed
          INCOMPLETE = :incomplete
          INTERPRETING = :interpreting
          FAILED = :failed

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
