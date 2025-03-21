# typed: strong

module OpenAI
  module Models
    module VectorStores
      class VectorStoreFileDeleted < OpenAI::BaseModel
        sig { returns(String) }
        attr_accessor :id

        sig { returns(T::Boolean) }
        attr_accessor :deleted

        sig { returns(Symbol) }
        attr_accessor :object

        sig { params(id: String, deleted: T::Boolean, object: Symbol).returns(T.attached_class) }
        def self.new(id:, deleted:, object: :"vector_store.file.deleted")
        end

        sig { override.returns({id: String, deleted: T::Boolean, object: Symbol}) }
        def to_hash
        end
      end
    end

    VectorStoreFileDeleted = VectorStores::VectorStoreFileDeleted
  end
end
