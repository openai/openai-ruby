# typed: strong

module OpenAI
  module Models
    module FineTuning
      module Checkpoints
        class PermissionCreateResponse < OpenAI::Internal::Type::BaseModel
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
          def self.new(id:, created_at:, project_id:, object: :"checkpoint.permission"); end

          sig { override.returns({id: String, created_at: Integer, object: Symbol, project_id: String}) }
          def to_hash; end
        end
      end
    end
  end
end
