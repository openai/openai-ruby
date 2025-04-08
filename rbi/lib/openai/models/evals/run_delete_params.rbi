# typed: strong

module OpenAI
  module Models
    module Evals
      class RunDeleteParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        sig { returns(String) }
        attr_accessor :eval_id

        sig do
          params(eval_id: String, request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash))
            .returns(T.attached_class)
        end
        def self.new(eval_id:, request_options: {}); end

        sig { override.returns({eval_id: String, request_options: OpenAI::RequestOptions}) }
        def to_hash; end
      end
    end
  end
end
