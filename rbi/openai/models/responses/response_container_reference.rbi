# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseContainerReference < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseContainerReference,
              OpenAI::Internal::AnyHash
            )
          end

        sig { returns(String) }
        attr_accessor :container_id

        # The environment type. Always `container_reference`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Represents a container created with /v1/containers.
        sig do
          params(container_id: String, type: Symbol).returns(T.attached_class)
        end
        def self.new(
          container_id:,
          # The environment type. Always `container_reference`.
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
