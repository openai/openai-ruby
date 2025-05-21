# typed: strong

module OpenAI
  module Models
    module Containers
      class FileDeleteParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Containers::FileDeleteParams,
              OpenAI::Internal::AnyHash
            )
          end

        sig { returns(String) }
        attr_accessor :container_id

        sig do
          params(
            container_id: String,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(container_id:, request_options: {})
        end

        sig do
          override.returns(
            { container_id: String, request_options: OpenAI::RequestOptions }
          )
        end
        def to_hash
        end
      end
    end
  end
end
