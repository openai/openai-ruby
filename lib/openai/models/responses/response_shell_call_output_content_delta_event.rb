# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseShellCallOutputContentDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute command_index
        #   The index of the shell command that produced output.
        #
        #   @return [Integer]
        required :command_index, Integer

        # @!attribute delta
        #   The stdout/stderr delta that was emitted.
        #
        #   @return [OpenAI::Models::Responses::ResponseShellCallOutputContentDeltaEvent::Delta]
        required :delta, -> { OpenAI::Responses::ResponseShellCallOutputContentDeltaEvent::Delta }

        # @!attribute item_id
        #   The ID of the output item that was updated.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item that was updated.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of the event that was emitted.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event, always `response.shell_call_output_content.delta`.
        #
        #   @return [Symbol, :"response.shell_call_output_content.delta"]
        required :type, const: :"response.shell_call_output_content.delta"

        # @!method initialize(command_index:, delta:, item_id:, output_index:, sequence_number:, type: :"response.shell_call_output_content.delta")
        #   A streaming event that indicated shell call output was incrementally added.
        #
        #   @param command_index [Integer] The index of the shell command that produced output.
        #
        #   @param delta [OpenAI::Models::Responses::ResponseShellCallOutputContentDeltaEvent::Delta] The stdout/stderr delta that was emitted.
        #
        #   @param item_id [String] The ID of the output item that was updated.
        #
        #   @param output_index [Integer] The index of the output item that was updated.
        #
        #   @param sequence_number [Integer] The sequence number of the event that was emitted.
        #
        #   @param type [Symbol, :"response.shell_call_output_content.delta"] The type of the event, always `response.shell_call_output_content.delta`.

        # @see OpenAI::Models::Responses::ResponseShellCallOutputContentDeltaEvent#delta
        class Delta < OpenAI::Internal::Type::BaseModel
          # @!attribute stderr
          #   The stderr delta that was emitted.
          #
          #   @return [String, nil]
          optional :stderr, String

          # @!attribute stdout
          #   The stdout delta that was emitted.
          #
          #   @return [String, nil]
          optional :stdout, String

          # @!method initialize(stderr: nil, stdout: nil)
          #   The stdout/stderr delta that was emitted.
          #
          #   @param stderr [String] The stderr delta that was emitted.
          #
          #   @param stdout [String] The stdout delta that was emitted.
        end
      end
    end
  end
end
