# typed: strong

module OpenAI
  module Models
    module Chat
      class CompletionUpdateParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        sig { returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata
        end

        sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
        def metadata=(_)
        end

        sig do
          params(
            metadata: T.nilable(OpenAI::Models::Metadata),
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(metadata:, request_options: {})
        end

        sig { override.returns({metadata: T.nilable(OpenAI::Models::Metadata), request_options: OpenAI::RequestOptions}) }
        def to_hash
        end
      end
    end
  end
end
