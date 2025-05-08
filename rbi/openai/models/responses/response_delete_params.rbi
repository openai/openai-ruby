# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseDeleteParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        sig do
          params(request_options: OpenAI::RequestOptions::OrHash).returns(
            T.attached_class
          )
        end
        def self.new(request_options: {})
        end

        sig { override.returns({ request_options: OpenAI::RequestOptions }) }
        def to_hash
        end
      end
    end
  end
end
