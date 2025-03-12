# typed: strong

module OpenAI
  module Models
    class ModelDeleted < OpenAI::BaseModel
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

      sig { returns(String) }
      def object
      end

      sig { params(_: String).returns(String) }
      def object=(_)
      end

      sig { params(id: String, deleted: T::Boolean, object: String).returns(T.attached_class) }
      def self.new(id:, deleted:, object:)
      end

      sig { override.returns({id: String, deleted: T::Boolean, object: String}) }
      def to_hash
      end
    end
  end
end
