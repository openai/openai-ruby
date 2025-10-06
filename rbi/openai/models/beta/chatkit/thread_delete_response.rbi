# typed: strong

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ThreadDeleteResponse < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Models::Beta::ChatKit::ThreadDeleteResponse,
                OpenAI::Internal::AnyHash
              )
            end

          # Identifier of the deleted thread.
          sig { returns(String) }
          attr_accessor :id

          # Indicates that the thread has been deleted.
          sig { returns(T::Boolean) }
          attr_accessor :deleted

          # Type discriminator that is always `chatkit.thread.deleted`.
          sig { returns(Symbol) }
          attr_accessor :object

          # Confirmation payload returned after deleting a thread.
          sig do
            params(id: String, deleted: T::Boolean, object: Symbol).returns(
              T.attached_class
            )
          end
          def self.new(
            # Identifier of the deleted thread.
            id:,
            # Indicates that the thread has been deleted.
            deleted:,
            # Type discriminator that is always `chatkit.thread.deleted`.
            object: :"chatkit.thread.deleted"
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
