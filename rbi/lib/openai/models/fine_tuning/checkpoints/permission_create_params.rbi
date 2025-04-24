# typed: strong

module OpenAI
  module Models
    module FineTuning
      module Checkpoints
        class PermissionCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # The project identifiers to grant access to.
          sig { returns(T::Array[String]) }
          attr_accessor :project_ids

          sig do
            params(
              project_ids: T::Array[String],
              request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash)
            )
              .returns(T.attached_class)
          end
          def self.new(
            # The project identifiers to grant access to.
            project_ids:,
            request_options: {}
          ); end
          sig { override.returns({project_ids: T::Array[String], request_options: OpenAI::RequestOptions}) }
          def to_hash; end
        end
      end
    end
  end
end
