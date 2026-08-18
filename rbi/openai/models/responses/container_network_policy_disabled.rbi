# typed: strong

module OpenAI
  module Models
    module Responses
      class ContainerNetworkPolicyDisabled < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ContainerNetworkPolicyDisabled,
              OpenAI::Internal::AnyHash
            )
          end

        # Disable outbound network access. Always `disabled`.
        sig { returns(Symbol) }
        attr_accessor :type

        sig { params(type: Symbol).returns(T.attached_class) }
        def self.new(
          # Disable outbound network access. Always `disabled`.
          type: :disabled
        )
        end

        sig { override.returns({ type: Symbol }) }
        def to_hash
        end
      end
    end
  end
end
