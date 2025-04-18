# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        # @see OpenAI::Resources::Beta::Threads::Runs#submit_tool_outputs
        #
        # @see OpenAI::Resources::Beta::Threads::Runs#submit_tool_outputs_stream_raw
        class RunSubmitToolOutputsParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute thread_id
          #
          #   @return [String]
          required :thread_id, String

          # @!attribute tool_outputs
          #   A list of tools for which the outputs are being submitted.
          #
          #   @return [Array<OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams::ToolOutput>]
          required :tool_outputs,
                   -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams::ToolOutput] }

          # @!method initialize(thread_id:, tool_outputs:, request_options: {})
          #   @param thread_id [String]
          #   @param tool_outputs [Array<OpenAI::Models::Beta::Threads::RunSubmitToolOutputsParams::ToolOutput>]
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          class ToolOutput < OpenAI::Internal::Type::BaseModel
            # @!attribute output
            #   The output of the tool call to be submitted to continue the run.
            #
            #   @return [String, nil]
            optional :output, String

            # @!attribute tool_call_id
            #   The ID of the tool call in the `required_action` object within the run object
            #   the output is being submitted for.
            #
            #   @return [String, nil]
            optional :tool_call_id, String

            # @!method initialize(output: nil, tool_call_id: nil)
            #   @param output [String]
            #   @param tool_call_id [String]
          end
        end
      end
    end
  end
end
