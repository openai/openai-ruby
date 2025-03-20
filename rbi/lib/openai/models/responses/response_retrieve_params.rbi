# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseRetrieveParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        # Additional fields to include in the response. See the `include` parameter for
        #   Response creation above for more information.
        sig { returns(T.nilable(T::Array[Symbol])) }
        def include
        end

        sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
        def include=(_)
        end

        sig do
          params(
            include: T::Array[Symbol],
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(include: nil, request_options: {})
        end

        sig { override.returns({include: T::Array[Symbol], request_options: OpenAI::RequestOptions}) }
        def to_hash
        end
      end
    end
  end
end
