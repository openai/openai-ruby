# typed: strong

module OpenAI
  module Models
    module Responses
      class ContainerReference < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ContainerReference,
              OpenAI::Internal::AnyHash
            )
          end

        # The ID of the referenced container.
        sig { returns(String) }
        attr_accessor :container_id

        # References a container created with the /v1/containers endpoint
        sig { returns(Symbol) }
        attr_accessor :type

        sig do
          params(container_id: String, type: Symbol).returns(T.attached_class)
        end
        def self.new(
          # The ID of the referenced container.
          container_id:,
          # References a container created with the /v1/containers endpoint
          type: :container_reference
        )
        end

        sig { override.returns({ container_id: String, type: Symbol }) }
        def to_hash
        end
      end
    end
  end
end
