# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class CodeInterpreterToolCallDelta < OpenAI::BaseModel
            # @!attribute index
            #   The index of the tool call in the tool calls array.
            #
            #   @return [Integer]
            required :index, Integer

            # @!attribute type
            #   The type of tool call. This is always going to be `code_interpreter` for this
            #     type of tool call.
            #
            #   @return [Symbol, :code_interpreter]
            required :type, const: :code_interpreter

            # @!attribute [r] id
            #   The ID of the tool call.
            #
            #   @return [String, nil]
            optional :id, String

            # @!parse
            #   # @return [String]
            #   attr_writer :id

            # @!attribute [r] code_interpreter
            #   The Code Interpreter tool call definition.
            #
            #   @return [OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta::CodeInterpreter, nil]
            optional :code_interpreter,
                     -> { OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta::CodeInterpreter }

            # @!parse
            #   # @return [OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta::CodeInterpreter]
            #   attr_writer :code_interpreter

            # @!parse
            #   # Details of the Code Interpreter tool call the run step was involved in.
            #   #
            #   # @param index [Integer]
            #   # @param id [String]
            #   # @param code_interpreter [OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta::CodeInterpreter]
            #   # @param type [Symbol, :code_interpreter]
            #   #
            #   def initialize(index:, id: nil, code_interpreter: nil, type: :code_interpreter, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void

            class CodeInterpreter < OpenAI::BaseModel
              # @!attribute [r] input
              #   The input to the Code Interpreter tool call.
              #
              #   @return [String, nil]
              optional :input, String

              # @!parse
              #   # @return [String]
              #   attr_writer :input

              # @!attribute [r] outputs
              #   The outputs from the Code Interpreter tool call. Code Interpreter can output one
              #     or more items, including text (`logs`) or images (`image`). Each of these are
              #     represented by a different object type.
              #
              #   @return [Array<OpenAI::Models::Beta::Threads::Runs::CodeInterpreterLogs, OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage>, nil]
              optional :outputs,
                       -> { OpenAI::ArrayOf[union: OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta::CodeInterpreter::Output] }

              # @!parse
              #   # @return [Array<OpenAI::Models::Beta::Threads::Runs::CodeInterpreterLogs, OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage>]
              #   attr_writer :outputs

              # @!parse
              #   # The Code Interpreter tool call definition.
              #   #
              #   # @param input [String]
              #   # @param outputs [Array<OpenAI::Models::Beta::Threads::Runs::CodeInterpreterLogs, OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage>]
              #   #
              #   def initialize(input: nil, outputs: nil, **) = super

              # def initialize: (Hash | OpenAI::BaseModel) -> void

              # Text output from the Code Interpreter tool call as part of a run step.
              module Output
                extend OpenAI::Union

                discriminator :type

                # Text output from the Code Interpreter tool call as part of a run step.
                variant :logs, -> { OpenAI::Models::Beta::Threads::Runs::CodeInterpreterLogs }

                variant :image, -> { OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage }

                # @!parse
                #   class << self
                #     # @return [Array(OpenAI::Models::Beta::Threads::Runs::CodeInterpreterLogs, OpenAI::Models::Beta::Threads::Runs::CodeInterpreterOutputImage)]
                #     def variants; end
                #   end
              end
            end
          end
        end
      end
    end
  end
end
