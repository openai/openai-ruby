# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class FunctionShellTool < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of the shell tool. Always `shell`.
        #
        #   @return [Symbol, :shell]
        required :type, const: :shell

        # @!attribute allowed_callers
        #   The tool invocation context(s).
        #
        #   @return [Array<Symbol, OpenAI::Models::Responses::FunctionShellTool::AllowedCaller>, nil]
        optional :allowed_callers,
                 -> {
                   OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Responses::FunctionShellTool::AllowedCaller]
                 },
                 nil?: true

        # @!attribute environment
        #
        #   @return [OpenAI::Models::Responses::ContainerAuto, OpenAI::Models::Responses::LocalEnvironment, OpenAI::Models::Responses::ContainerReference, nil]
        optional :environment, union: -> { OpenAI::Responses::FunctionShellTool::Environment }, nil?: true

        # @!method initialize(allowed_callers: nil, environment: nil, type: :shell)
        #   A tool that allows the model to execute shell commands.
        #
        #   @param allowed_callers [Array<Symbol, OpenAI::Models::Responses::FunctionShellTool::AllowedCaller>, nil] The tool invocation context(s).
        #
        #   @param environment [OpenAI::Models::Responses::ContainerAuto, OpenAI::Models::Responses::LocalEnvironment, OpenAI::Models::Responses::ContainerReference, nil]
        #
        #   @param type [Symbol, :shell] The type of the shell tool. Always `shell`.

        module AllowedCaller
          extend OpenAI::Internal::Type::Enum

          DIRECT = :direct
          PROGRAMMATIC = :programmatic

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @see OpenAI::Models::Responses::FunctionShellTool#environment
        module Environment
          extend OpenAI::Internal::Type::Union

          discriminator :type

          variant :container_auto, -> { OpenAI::Responses::ContainerAuto }

          variant :local, -> { OpenAI::Responses::LocalEnvironment }

          variant :container_reference, -> { OpenAI::Responses::ContainerReference }

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Responses::ContainerAuto, OpenAI::Models::Responses::LocalEnvironment, OpenAI::Models::Responses::ContainerReference)]
        end
      end
    end
  end
end
