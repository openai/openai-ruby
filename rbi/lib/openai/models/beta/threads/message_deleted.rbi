# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class MessageDeleted < OpenAI::BaseModel
          sig { returns(String) }
          def id
          end

          sig { params(_: String).returns(String) }
          def id=(_)
          end

          sig { returns(T::Boolean) }
          def deleted
          end

          sig { params(_: T::Boolean).returns(T::Boolean) }
          def deleted=(_)
          end

          sig { returns(Symbol) }
          def object
          end

          sig { params(_: Symbol).returns(Symbol) }
          def object=(_)
          end

          sig { params(id: String, deleted: T::Boolean, object: Symbol).returns(T.attached_class) }
          def self.new(id:, deleted:, object: :"thread.message.deleted")
          end

          sig { override.returns({id: String, deleted: T::Boolean, object: Symbol}) }
          def to_hash
          end
        end
      end
    end
  end
end
