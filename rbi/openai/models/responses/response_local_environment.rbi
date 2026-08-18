# typed: strong

module OpenAI
  module Models

    module Responses

      class ResponseLocalEnvironment < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Responses::ResponseLocalEnvironment,
            OpenAI::Internal::AnyHash
          )
        end

        # The environment type. Always `local`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Represents the use of a local environment to perform shell actions.
        sig do
          params(

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The environment type. Always `local`.

          type: :local
        )
        end

        sig do
          override.returns(
            {type: Symbol}
          )
        end
        def to_hash
        end

      end

    end

  end
end
