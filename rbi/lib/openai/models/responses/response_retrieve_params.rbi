# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseRetrieveParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        # Additional fields to include in the response. See the `include` parameter for
        #   Response creation above for more information.
        sig { returns(T.nilable(T::Array[OpenAI::Models::Responses::ResponseIncludable::OrSymbol])) }
        def include
        end

        sig do
          params(_: T::Array[OpenAI::Models::Responses::ResponseIncludable::OrSymbol])
            .returns(T::Array[OpenAI::Models::Responses::ResponseIncludable::OrSymbol])
        end
        def include=(_)
        end

        sig do
          params(
            include: T::Array[OpenAI::Models::Responses::ResponseIncludable::OrSymbol],
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(include: nil, request_options: {})
        end

        sig do
          override
            .returns(
              {
                include: T::Array[OpenAI::Models::Responses::ResponseIncludable::OrSymbol],
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
