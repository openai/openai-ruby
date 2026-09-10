# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AgentSessionEnvironmentState < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The public ID of the environment.
        #
        #   @return [String]
        required :id, String

        # @!attribute error
        #   An error reported while preparing a session environment.
        #
        #   @return [OpenAI::Models::Beta::AgentSessionEnvironmentState::Error, nil]
        required :error, -> { OpenAI::Beta::AgentSessionEnvironmentState::Error }, nil?: true

        # @!attribute status
        #   The environment's connection status.
        #
        #   @return [Symbol, OpenAI::Models::Beta::AgentSessionEnvironmentState::Status]
        required :status, enum: -> { OpenAI::Beta::AgentSessionEnvironmentState::Status }

        # @!attribute type
        #   The environment type.
        #
        #   @return [String]
        required :type, String

        # @!method initialize(id:, error:, status:, type:)
        #   The current state of a session environment.
        #
        #   @param id [String]
        #     The public ID of the environment.
        #
        #   @param error [OpenAI::Models::Beta::AgentSessionEnvironmentState::Error, nil]
        #     An error reported while preparing a session environment.
        #
        #   @param status [Symbol, OpenAI::Models::Beta::AgentSessionEnvironmentState::Status]
        #     The environment's connection status.
        #
        #   @param type [String]
        #     The environment type.

        # @see OpenAI::Models::Beta::AgentSessionEnvironmentState#error
        class Error < OpenAI::Internal::Type::BaseModel
          # @!attribute code
          #   A machine-readable error code.
          #
          #   @return [String]
          required :code, String

          # @!attribute message
          #   A human-readable error message.
          #
          #   @return [String]
          required :message, String

          # @!attribute type
          #   The error type.
          #
          #   @return [String]
          required :type, String

          # @!method initialize(code:, message:, type:)
          #   An error reported while preparing a session environment.
          #
          #   @param code [String]
          #     A machine-readable error code.
          #
          #   @param message [String]
          #     A human-readable error message.
          #
          #   @param type [String]
          #     The error type.
        end

        # The environment's connection status.
        #
        # @see OpenAI::Models::Beta::AgentSessionEnvironmentState#status
        module Status
          extend OpenAI::Internal::Type::Enum

          # The environment is being prepared.
          PENDING = :pending

          # The environment is ready to connect.
          READY = :ready

          # The environment is connected.
          CONNECTED = :connected

          # The environment is disconnected.
          DISCONNECTED = :disconnected

          # The environment failed to connect.
          FAILED = :failed

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
