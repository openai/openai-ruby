# typed: strong

module OpenAI
  module Models
    module FineTuning
      module Checkpoints
        class PermissionDeleteResponse < OpenAI::Internal::Type::BaseModel
          # The ID of the fine-tuned model checkpoint permission that was deleted.
          sig { returns(String) }
          attr_accessor :id

          # Whether the fine-tuned model checkpoint permission was successfully deleted.
          sig { returns(T::Boolean) }
          attr_accessor :deleted

          # The object type, which is always "checkpoint.permission".
          sig { returns(Symbol) }
          attr_accessor :object

          sig { params(id: String, deleted: T::Boolean, object: Symbol).returns(T.attached_class) }
          def self.new(id:, deleted:, object: :"checkpoint.permission"); end

          sig { override.returns({id: String, deleted: T::Boolean, object: Symbol}) }
          def to_hash; end
        end
      end
    end
  end
end
