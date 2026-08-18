# typed: strong

module OpenAI
  module Models
    module FineTuning
      module Checkpoints
        class PermissionDeleteResponse < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Models::FineTuning::Checkpoints::PermissionDeleteResponse,
                OpenAI::Internal::AnyHash
              )
            end

          # The ID of the fine-tuned model checkpoint permission that was deleted.
          sig { returns(String) }
          attr_accessor :id

          # Whether the fine-tuned model checkpoint permission was successfully deleted.
          sig { returns(T::Boolean) }
          attr_accessor :deleted

          # The object type, which is always "checkpoint.permission".
          sig { returns(Symbol) }
          attr_accessor :object

          sig do
            params(id: String, deleted: T::Boolean, object: Symbol).returns(
              T.attached_class
            )
          end
          def self.new(
            # The ID of the fine-tuned model checkpoint permission that was deleted.
            id:,
            # Whether the fine-tuned model checkpoint permission was successfully deleted.
            deleted:,
            # The object type, which is always "checkpoint.permission".
            object: :"checkpoint.permission"
          )
          end

          sig do
            override.returns(
              { id: String, deleted: T::Boolean, object: Symbol }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
