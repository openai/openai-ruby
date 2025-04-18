# typed: strong

module OpenAI
  module Models
    module Uploads
      class PartCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # The chunk of bytes for this Part.
        sig { returns(T.any(Pathname, StringIO)) }
        attr_accessor :data

        sig do
          params(
            data: T.any(Pathname, StringIO),
            request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash)
          )
            .returns(T.attached_class)
        end
        def self.new(data:, request_options: {}); end

        sig { override.returns({data: T.any(Pathname, StringIO), request_options: OpenAI::RequestOptions}) }
        def to_hash; end
      end
    end
  end
end
