# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class CodeInterpreterLogs < OpenAI::BaseModel
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

            # @!attribute [r] logs
            #   The text output from the Code Interpreter tool call.
            #
            #   @return [String, nil]
            optional :logs, String

            # @!parse
            #   # @return [String]
            #   attr_writer :logs

            # @!parse
            #   # Text output from the Code Interpreter tool call as part of a run step.
            #   #
            #   # @param index [Integer]
            #   # @param logs [String]
            #   # @param type [Symbol, :logs]
            #   #
            #   def initialize(index:, logs: nil, type: :logs, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void
          end
        end
      end
    end
  end
end
