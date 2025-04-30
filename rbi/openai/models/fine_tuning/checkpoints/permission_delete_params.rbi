# typed: strong

module OpenAI
  module Models
    module FineTuning
      module Checkpoints
        class PermissionDeleteParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          sig { returns(String) }
          attr_accessor :fine_tuned_model_checkpoint

          sig do
            params(
              fine_tuned_model_checkpoint: String,
              request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash)
            )
              .returns(T.attached_class)
          end
          def self.new(fine_tuned_model_checkpoint:, request_options: {}); end

          sig do
            override.returns({fine_tuned_model_checkpoint: String, request_options: OpenAI::RequestOptions})
          end
          def to_hash; end
        end
      end
    end
  end
end
