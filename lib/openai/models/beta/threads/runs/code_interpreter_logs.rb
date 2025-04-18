# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class CodeInterpreterLogs < OpenAI::Internal::Type::BaseModel
            # @!attribute index
            #   The index of the output in the outputs array.
            #
            #   @return [Integer]
            required :index, Integer

            # @!attribute type
            #   Always `logs`.
            #
            #   @return [Symbol, :logs]
            required :type, const: :logs

            # @!attribute logs
            #   The text output from the Code Interpreter tool call.
            #
            #   @return [String, nil]
            optional :logs, String

            # @!method initialize(index:, logs: nil, type: :logs)
            #   Text output from the Code Interpreter tool call as part of a run step.
            #
            #   @param index [Integer]
            #   @param logs [String]
            #   @param type [Symbol, :logs]
          end
        end
      end
    end
  end
end
