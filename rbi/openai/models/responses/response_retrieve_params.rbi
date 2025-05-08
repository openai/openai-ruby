# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseRetrieveParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # Additional fields to include in the response. See the `include` parameter for
        # Response creation above for more information.
        sig do
          returns(
            T.nilable(T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol])
          )
        end
        attr_reader :include

        sig do
          params(
            include: T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol]
          ).void
        end
        attr_writer :include

        sig do
          params(
            include: T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol],
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # Additional fields to include in the response. See the `include` parameter for
          # Response creation above for more information.
          include: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              include:
                T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol],
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
