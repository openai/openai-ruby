# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseRetrieveParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # Additional fields to include in the response. See the `include` parameter for
        # Response creation above for more information.
        sig { returns(T.nilable(T::Array[OpenAI::Models::Responses::ResponseIncludable::OrSymbol])) }
        attr_reader :include

        sig { params(include: T::Array[OpenAI::Models::Responses::ResponseIncludable::OrSymbol]).void }
        attr_writer :include

        sig do
          params(
            include: T::Array[OpenAI::Models::Responses::ResponseIncludable::OrSymbol],
            request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash)
          )
            .returns(T.attached_class)
        end
        def self.new(include: nil, request_options: {}); end

        sig do
          override
            .returns(
              {
                include: T::Array[OpenAI::Models::Responses::ResponseIncludable::OrSymbol],
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash; end
      end
    end
  end
end
