# typed: strong

module OpenAI
  module Models
    module FineTuning
      module Checkpoints
        class PermissionRetrieveResponse < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveResponse,
                OpenAI::Internal::AnyHash
              )
            end

          # The permission identifier, which can be referenced in the API endpoints.
          sig { returns(String) }
          attr_accessor :id

          # The Unix timestamp (in seconds) for when the permission was created.
          sig { returns(Integer) }
          attr_accessor :created_at

          # The object type, which is always "checkpoint.permission".
          sig { returns(Symbol) }
          attr_accessor :object

          # The project identifier that the permission is for.
          sig { returns(String) }
          attr_accessor :project_id

          # The `checkpoint.permission` object represents a permission for a fine-tuned
          # model checkpoint.
          sig do
            params(
              id: String,
              created_at: Integer,
              project_id: String,
              object: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The permission identifier, which can be referenced in the API endpoints.
            id:,
            # The Unix timestamp (in seconds) for when the permission was created.
            created_at:,
            # The project identifier that the permission is for.
            project_id:,
            # The object type, which is always "checkpoint.permission".
            object: :"checkpoint.permission"
          )
          end

          sig do
            override.returns(
              {
                id: String,
                created_at: Integer,
                object: Symbol,
                project_id: String
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
