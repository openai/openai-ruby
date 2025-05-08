# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class CodeInterpreterToolCall < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The ID of the tool call.
            #
            #   @return [String]
            required :id, String

            # @!attribute code_interpreter
            #   The Code Interpreter tool call definition.
            #
            #   @return [OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter]
            required :code_interpreter,
                     -> {
                       OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter
                     }

            # @!attribute type
            #   The type of tool call. This is always going to be `code_interpreter` for this
            #   type of tool call.
            #
            #   @return [Symbol, :code_interpreter]
            required :type, const: :code_interpreter

            # @!method initialize(id:, code_interpreter:, type: :code_interpreter)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall} for more details.
            #
            #   Details of the Code Interpreter tool call the run step was involved in.
            #
            #   @param id [String] The ID of the tool call.
            #
            #   @param code_interpreter [OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter] The Code Interpreter tool call definition.
            #
            #   @param type [Symbol, :code_interpreter] The type of tool call. This is always going to be `code_interpreter` for this ty

            # @see OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall#code_interpreter
            class CodeInterpreter < OpenAI::Internal::Type::BaseModel
              # @!attribute input
              #   The input to the Code Interpreter tool call.
              #
              #   @return [String]
              required :input, String

              # @!attribute outputs
              #   The outputs from the Code Interpreter tool call. Code Interpreter can output one
              #   or more items, including text (`logs`) or images (`image`). Each of these are
              #   represented by a different object type.
              #
              #   @return [Array<OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Logs, OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image>]
              required :outputs,
                       -> {
                         OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output]
                       }

              # @!method initialize(input:, outputs:)
              #   Some parameter documentations has been truncated, see
              #   {OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter} for more
              #   details.
              #
              #   The Code Interpreter tool call definition.
              #
              #   @param input [String] The input to the Code Interpreter tool call.
              #
              #   @param outputs [Array<OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Logs, OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image>] The outputs from the Code Interpreter tool call. Code Interpreter can output one

              # Text output from the Code Interpreter tool call as part of a run step.
              module Output
                extend OpenAI::Internal::Type::Union

                discriminator :type

                # Text output from the Code Interpreter tool call as part of a run step.
                variant :logs,
                        -> {
                          OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Logs
                        }

                variant :image,
                        -> {
                          OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image
                        }

                class Logs < OpenAI::Internal::Type::BaseModel
                  # @!attribute logs
                  #   The text output from the Code Interpreter tool call.
                  #
                  #   @return [String]
                  required :logs, String

                  # @!attribute type
                  #   Always `logs`.
                  #
                  #   @return [Symbol, :logs]
                  required :type, const: :logs

                  # @!method initialize(logs:, type: :logs)
                  #   Text output from the Code Interpreter tool call as part of a run step.
                  #
                  #   @param logs [String] The text output from the Code Interpreter tool call.
                  #
                  #   @param type [Symbol, :logs] Always `logs`.
                end

                class Image < OpenAI::Internal::Type::BaseModel
                  # @!attribute image
                  #
                  #   @return [OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image::Image]
                  required :image,
                           -> {
                             OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image::Image
                           }

                  # @!attribute type
                  #   Always `image`.
                  #
                  #   @return [Symbol, :image]
                  required :type, const: :image

                  # @!method initialize(image:, type: :image)
                  #   @param image [OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image::Image]
                  #
                  #   @param type [Symbol, :image] Always `image`.

                  # @see OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image#image
                  class Image < OpenAI::Internal::Type::BaseModel
                    # @!attribute file_id
                    #   The [file](https://platform.openai.com/docs/api-reference/files) ID of the
                    #   image.
                    #
                    #   @return [String]
                    required :file_id, String

                    # @!method initialize(file_id:)
                    #   Some parameter documentations has been truncated, see
                    #   {OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image::Image}
                    #   for more details.
                    #
                    #   @param file_id [String] The [file](https://platform.openai.com/docs/api-reference/files) ID of the image
                  end
                end

                # @!method self.variants
                #   @return [Array(OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Logs, OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image)]
              end
            end
          end
        end
      end
    end
  end
end
