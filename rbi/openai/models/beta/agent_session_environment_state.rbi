# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentSessionEnvironmentState < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentSessionEnvironmentState,
            OpenAI::Internal::AnyHash
          )
        end

        # The public ID of the environment.
        sig { returns(String) }
        attr_accessor :id

        # An error reported while preparing a session environment.
        sig { returns(T.nilable(OpenAI::Beta::AgentSessionEnvironmentState::Error)) }
        attr_reader :error

        sig { params(error: T.nilable(OpenAI::Beta::AgentSessionEnvironmentState::Error::OrHash)).void }
        attr_writer :error

        # The environment's connection status.
        sig { returns(OpenAI::Beta::AgentSessionEnvironmentState::Status::TaggedSymbol) }
        attr_accessor :status

        # The environment type.
        sig { returns(String) }
        attr_accessor :type

        # The current state of a session environment.
        sig do
          params(

            id: String,

            error: T.nilable(OpenAI::Beta::AgentSessionEnvironmentState::Error::OrHash),

            status: OpenAI::Beta::AgentSessionEnvironmentState::Status::OrSymbol,

            type: String
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The public ID of the environment.
          id:,

          # An error reported while preparing a session environment.
          error:,

          # The environment's connection status.
          status:,

          # The environment type.

          type:
        )
        end

        sig do
          override.returns(
            {
              id: String,
              error: T.nilable(OpenAI::Beta::AgentSessionEnvironmentState::Error),
              status: OpenAI::Beta::AgentSessionEnvironmentState::Status::TaggedSymbol,
              type: String
            }
          )
        end
        def to_hash
        end

        class Error < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::AgentSessionEnvironmentState::Error,
              OpenAI::Internal::AnyHash
            )
          end

          # A machine-readable error code.
          sig { returns(String) }
          attr_accessor :code

          # A human-readable error message.
          sig { returns(String) }
          attr_accessor :message

          # The error type.
          sig { returns(String) }
          attr_accessor :type

          # An error reported while preparing a session environment.
          sig do
            params(

              code: String,

              message: String,

              type: String
            )
              .returns(T.attached_class)
          end
          def self.new(

            # A machine-readable error code.
            code:,

            # A human-readable error message.
            message:,

            # The error type.

            type:
          )
          end

          sig do
            override.returns(
              {code: String, message: String, type: String}
            )
          end
          def to_hash
          end

        end

        # The environment's connection status.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::AgentSessionEnvironmentState::Status) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          # The environment is being prepared.
          PENDING = T.let(:pending, OpenAI::Beta::AgentSessionEnvironmentState::Status::TaggedSymbol)

          # The environment is ready to connect.
          READY = T.let(:ready, OpenAI::Beta::AgentSessionEnvironmentState::Status::TaggedSymbol)

          # The environment is connected.
          CONNECTED = T.let(:connected, OpenAI::Beta::AgentSessionEnvironmentState::Status::TaggedSymbol)

          # The environment is disconnected.
          DISCONNECTED = T.let(:disconnected, OpenAI::Beta::AgentSessionEnvironmentState::Status::TaggedSymbol)

          # The environment failed to connect.
          FAILED = T.let(:failed, OpenAI::Beta::AgentSessionEnvironmentState::Status::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Beta::AgentSessionEnvironmentState::Status::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
