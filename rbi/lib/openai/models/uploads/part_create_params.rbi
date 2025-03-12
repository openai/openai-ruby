# typed: strong

module OpenAI
  module Models
    module Uploads
      class PartCreateParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        sig { returns(T.any(IO, StringIO)) }
        def data
        end

        sig { params(_: T.any(IO, StringIO)).returns(T.any(IO, StringIO)) }
        def data=(_)
        end

        sig do
          params(
            data: T.any(IO, StringIO),
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
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
