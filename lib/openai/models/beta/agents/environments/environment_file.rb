# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Agents
        module Environments
          # @see OpenAI::Resources::Beta::Agents::Environments::Files#create
          class EnvironmentFile < OpenAI::Internal::Type::BaseModel
            # @!attribute environment_id
            #   The ID of the environment containing this file.
            #
            #   @return [String]
            required :environment_id, String

            # @!attribute object
            #   The object type. Always `agent.environment.file`.
            #
            #   @return [Symbol, :"agent.environment.file"]
            required :object, const: :"agent.environment.file"

            # @!attribute path
            #   The absolute file path inside the environment's workspace.
            #
            #   @return [String]
            required :path, String

            # @!attribute size_bytes
            #   The file size in bytes.
            #
            #   @return [Integer]
            required :size_bytes, Integer

            # @!method initialize(environment_id:, path:, size_bytes:, object: :"agent.environment.file")
            #   A live file in an execution environment.
            #
            #   @param environment_id [String]
            #     The ID of the environment containing this file.
            #
            #   @param path [String]
            #     The absolute file path inside the environment's workspace.
            #
            #   @param size_bytes [Integer]
            #     The file size in bytes.
            #
            #   @param object [Symbol, :"agent.environment.file"]
            #     The object type. Always `agent.environment.file`.
          end
        end

        EnvironmentFile = Environments::EnvironmentFile
      end
    end
  end
end
