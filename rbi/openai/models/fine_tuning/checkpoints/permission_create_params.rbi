# typed: strong

module OpenAI
  module Models
    module FineTuning
      module Checkpoints
        class PermissionCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::FineTuning::Checkpoints::PermissionCreateParams,
                OpenAI::Internal::AnyHash
              )
            end

          # The project identifiers to grant access to.
          sig { returns(T::Array[String]) }
          attr_accessor :project_ids

          sig do
            params(
              project_ids: T::Array[String],
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # The project identifiers to grant access to.
            project_ids:,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                project_ids: T::Array[String],
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
