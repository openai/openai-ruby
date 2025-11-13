# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseFunctionShellCallOutputContent < OpenAI::Internal::Type::BaseModel
        # @!attribute outcome
        #   The exit or timeout outcome associated with this chunk.
        #
        #   @return [OpenAI::Models::Responses::ResponseFunctionShellCallOutputContent::Outcome::Timeout, OpenAI::Models::Responses::ResponseFunctionShellCallOutputContent::Outcome::Exit]
        required :outcome, union: -> { OpenAI::Responses::ResponseFunctionShellCallOutputContent::Outcome }

        # @!attribute stderr
        #   Captured stderr output for this chunk of the shell call.
        #
        #   @return [String]
        required :stderr, String

        # @!attribute stdout
        #   Captured stdout output for this chunk of the shell call.
        #
        #   @return [String]
        required :stdout, String

        # @!method initialize(outcome:, stderr:, stdout:)
        #   Captured stdout and stderr for a portion of a function shell tool call output.
        #
        #   @param outcome [OpenAI::Models::Responses::ResponseFunctionShellCallOutputContent::Outcome::Timeout, OpenAI::Models::Responses::ResponseFunctionShellCallOutputContent::Outcome::Exit] The exit or timeout outcome associated with this chunk.
        #
        #   @param stderr [String] Captured stderr output for this chunk of the shell call.
        #
        #   @param stdout [String] Captured stdout output for this chunk of the shell call.

        # The exit or timeout outcome associated with this chunk.
        #
        # @see OpenAI::Models::Responses::ResponseFunctionShellCallOutputContent#outcome
        module Outcome
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # Indicates that the function shell call exceeded its configured time limit.
          variant :timeout, -> { OpenAI::Responses::ResponseFunctionShellCallOutputContent::Outcome::Timeout }

          # Indicates that the shell commands finished and returned an exit code.
          variant :exit, -> { OpenAI::Responses::ResponseFunctionShellCallOutputContent::Outcome::Exit }

          class Timeout < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   The outcome type. Always `timeout`.
            #
            #   @return [Symbol, :timeout]
            required :type, const: :timeout

            # @!method initialize(type: :timeout)
            #   Indicates that the function shell call exceeded its configured time limit.
            #
            #   @param type [Symbol, :timeout] The outcome type. Always `timeout`.
          end

          class Exit < OpenAI::Internal::Type::BaseModel
            # @!attribute exit_code
            #   The exit code returned by the shell process.
            #
            #   @return [Integer]
            required :exit_code, Integer

            # @!attribute type
            #   The outcome type. Always `exit`.
            #
            #   @return [Symbol, :exit]
            required :type, const: :exit

            # @!method initialize(exit_code:, type: :exit)
            #   Indicates that the shell commands finished and returned an exit code.
            #
            #   @param exit_code [Integer] The exit code returned by the shell process.
            #
            #   @param type [Symbol, :exit] The outcome type. Always `exit`.
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Responses::ResponseFunctionShellCallOutputContent::Outcome::Timeout, OpenAI::Models::Responses::ResponseFunctionShellCallOutputContent::Outcome::Exit)]
        end
      end
    end
  end
end
