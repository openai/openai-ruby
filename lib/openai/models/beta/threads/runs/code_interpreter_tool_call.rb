# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class CodeInterpreterToolCall < OpenAI::BaseModel
            # @!attribute id
            #   The ID of the tool call.
            #
            #   @return [String]
            required :id, String

            # @!attribute code_interpreter
            #   The Code Interpreter tool call definition.
            #
            #   @return [OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter]
            required :code_interpreter,
                     -> { OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter }

            # @!attribute type
            #   The type of tool call. This is always going to be `code_interpreter` for this
            #     type of tool call.
            #
            #   @return [Symbol, :code_interpreter]
            required :type, const: :code_interpreter

            # @!parse
            #   # Details of the Code Interpreter tool call the run step was involved in.
            #   #
            #   # @param id [String]
            #   # @param code_interpreter [OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter]
            #   # @param type [Symbol, :code_interpreter]
            #   #
            #   def initialize(id:, code_interpreter:, type: :code_interpreter, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void

            class CodeInterpreter < OpenAI::BaseModel
              # @!attribute input
              #   The input to the Code Interpreter tool call.
              #
              #   @return [String]
              required :input, String

              # @!attribute outputs
              #   The outputs from the Code Interpreter tool call. Code Interpreter can output one
              #     or more items, including text (`logs`) or images (`image`). Each of these are
              #     represented by a different object type.
              #
              #   @return [Array<OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Logs, OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image>]
              required :outputs,
                       -> { OpenAI::ArrayOf[union: OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output] }

              # @!parse
              #   # The Code Interpreter tool call definition.
              #   #
              #   # @param input [String]
              #   # @param outputs [Array<OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Logs, OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image>]
              #   #
              #   def initialize(input:, outputs:, **) = super

              # def initialize: (Hash | OpenAI::BaseModel) -> void

              # Text output from the Code Interpreter tool call as part of a run step.
              module Output
                extend OpenAI::Union

                discriminator :type

                # Text output from the Code Interpreter tool call as part of a run step.
                variant :logs,
                        -> { OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Logs }

                variant :image,
                        -> { OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image }

                class Logs < OpenAI::BaseModel
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

                  # @!parse
                  #   # Text output from the Code Interpreter tool call as part of a run step.
                  #   #
                  #   # @param logs [String]
                  #   # @param type [Symbol, :logs]
                  #   #
                  #   def initialize(logs:, type: :logs, **) = super

                  # def initialize: (Hash | OpenAI::BaseModel) -> void
                end

                class Image < OpenAI::BaseModel
                  # @!attribute image
                  #
                  #   @return [OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image::Image]
                  required :image,
                           -> { OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image::Image }

                  # @!attribute type
                  #   Always `image`.
                  #
                  #   @return [Symbol, :image]
                  required :type, const: :image

                  # @!parse
                  #   # @param image [OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image::Image]
                  #   # @param type [Symbol, :image]
                  #   #
                  #   def initialize(image:, type: :image, **) = super

                  # def initialize: (Hash | OpenAI::BaseModel) -> void

                  class Image < OpenAI::BaseModel
                    # @!attribute file_id
                    #   The [file](https://platform.openai.com/docs/api-reference/files) ID of the
                    #     image.
                    #
                    #   @return [String]
                    required :file_id, String

                    # @!parse
                    #   # @param file_id [String]
                    #   #
                    #   def initialize(file_id:, **) = super

                    # def initialize: (Hash | OpenAI::BaseModel) -> void
                  end
                end

                # @!parse
                #   # @return [Array(OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Logs, OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall::CodeInterpreter::Output::Image)]
                #   def self.variants; end
              end
            end
          end
        end
      end
    end
  end
end
