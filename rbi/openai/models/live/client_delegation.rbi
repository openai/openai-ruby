# typed: strong

module OpenAI
  module Models

    module Live

      class ClientDelegation < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::ClientDelegation,
            OpenAI::Internal::AnyHash
          )
        end

        # The delegation owner. Always `client` for tasks handled by your application.
        sig { returns(Symbol) }
        attr_accessor :type

        # Delegate tasks to your application. The Live session emits delegation events
        # that your backend handles.
        sig do
          params(

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The delegation owner. Always `client` for tasks handled by your application.

          type: :client
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
