# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class SetupCommandParam < OpenAI::Internal::Type::BaseModel
        # @!attribute command
        #   The shell command to execute.
        #
        #   @return [String]
        required :command, String

        # @!attribute cwd
        #   The absolute working directory. Defaults to `/workspace`.
        #
        #   @return [String, nil]
        optional :cwd, String, nil?: true

        # @!method initialize(command:, cwd: nil)
        #   A confidential setup command executed before the hosted agent starts.
        #
        #   @param command [String]
        #     The shell command to execute.
        #
        #   @param cwd [String, nil]
        #     The absolute working directory. Defaults to `/workspace`.
      end
    end
  end
end
