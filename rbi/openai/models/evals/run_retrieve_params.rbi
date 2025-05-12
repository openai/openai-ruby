# typed: strong

module OpenAI
  module Models
    module Evals
      class RunRetrieveParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(OpenAI::Evals::RunRetrieveParams, OpenAI::Internal::AnyHash)
          end

        sig { returns(String) }
        attr_accessor :eval_id

        sig do
          params(
            eval_id: String,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(eval_id:, request_options: {})
        end

        sig do
          override.returns(
            { eval_id: String, request_options: OpenAI::RequestOptions }
          )
        end
        def to_hash
        end
      end
    end
  end
end
