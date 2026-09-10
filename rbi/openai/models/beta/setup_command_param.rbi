# typed: strong

module OpenAI
  module Models

    module Beta

      class SetupCommandParam < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::SetupCommandParam,
            OpenAI::Internal::AnyHash
          )
        end

        # The shell command to execute.
        sig { returns(String) }
        attr_accessor :command

        # The absolute working directory. Defaults to `/workspace`.
        sig { returns(T.nilable(String)) }
        attr_accessor :cwd

        # A confidential setup command executed before the hosted agent starts.
        sig do
          params(

            command: String,

            cwd: T.nilable(String)
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The shell command to execute.
          command:,

          # The absolute working directory. Defaults to `/workspace`.

          cwd: nil
        )
        end

        sig do
          override.returns(
            {command: String, cwd: T.nilable(String)}
          )
        end
        def to_hash
        end

      end

    end

  end
end
