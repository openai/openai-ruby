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

        # @!attribute environment
        #
        #   @return [OpenAI::Models::Responses::ContainerAuto, OpenAI::Models::Responses::LocalEnvironment, OpenAI::Models::Responses::ContainerReference, nil]
        optional :environment, union: -> { OpenAI::Responses::FunctionShellTool::Environment }, nil?: true

        # @!method initialize(environment: nil, type: :shell)
        #   A tool that allows the model to execute shell commands.
        #
        #   @param environment [OpenAI::Models::Responses::ContainerAuto, OpenAI::Models::Responses::LocalEnvironment, OpenAI::Models::Responses::ContainerReference, nil]
        #
        #   @param type [Symbol, :shell] The type of the shell tool. Always `shell`.

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
