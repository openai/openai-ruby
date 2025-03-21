# typed: strong

module OpenAI
  module Models
    module Uploads
      class PartCreateParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        # The chunk of bytes for this Part.
        sig { returns(T.any(IO, StringIO)) }
        attr_accessor :data

        sig do
          params(
            data: T.any(IO, StringIO),
            request_options: T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash)
          )
            .returns(T.attached_class)
        end
        def self.new(data:, request_options: {})
        end

        sig { override.returns({data: T.any(IO, StringIO), request_options: OpenAI::RequestOptions}) }
        def to_hash
        end
      end
    end
  end
end
