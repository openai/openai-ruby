# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaFunctionShellTool < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of the shell tool. Always `shell`.
        #
        #   @return [Symbol, :shell]
        required :type, const: :shell

        # @!attribute allowed_callers
        #   The tool invocation context(s).
        #
        #   @return [Array<Symbol, OpenAI::Models::Beta::BetaFunctionShellTool::AllowedCaller>, nil]
        optional :allowed_callers,
                 -> {
                   OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Beta::BetaFunctionShellTool::AllowedCaller]
                 },
                 nil?: true

        # @!attribute environment
        #
        #   @return [OpenAI::Models::Beta::BetaContainerAuto, OpenAI::Models::Beta::BetaLocalEnvironment, OpenAI::Models::Beta::BetaContainerReference, nil]
        optional :environment, union: -> { OpenAI::Beta::BetaFunctionShellTool::Environment }, nil?: true

        # @!method initialize(allowed_callers: nil, environment: nil, type: :shell)
        #   A tool that allows the model to execute shell commands.
        #
        #   @param allowed_callers [Array<Symbol, OpenAI::Models::Beta::BetaFunctionShellTool::AllowedCaller>, nil] The tool invocation context(s).
        #
        #   @param environment [OpenAI::Models::Beta::BetaContainerAuto, OpenAI::Models::Beta::BetaLocalEnvironment, OpenAI::Models::Beta::BetaContainerReference, nil]
        #
        #   @param type [Symbol, :shell] The type of the shell tool. Always `shell`.

        module AllowedCaller
          extend OpenAI::Internal::Type::Enum

          DIRECT = :direct
          PROGRAMMATIC = :programmatic

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @see OpenAI::Models::Beta::BetaFunctionShellTool#environment
        module Environment
          extend OpenAI::Internal::Type::Union

          discriminator :type

          variant :container_auto, -> { OpenAI::Beta::BetaContainerAuto }

          variant :local, -> { OpenAI::Beta::BetaLocalEnvironment }

          variant :container_reference, -> { OpenAI::Beta::BetaContainerReference }

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Beta::BetaContainerAuto, OpenAI::Models::Beta::BetaLocalEnvironment, OpenAI::Models::Beta::BetaContainerReference)]
        end
      end
    end

    BetaFunctionShellTool = Beta::BetaFunctionShellTool
  end
end
