# typed: strong

module OpenAI
  module Models
    class ModelDeleted < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias { T.any(OpenAI::ModelDeleted, OpenAI::Internal::AnyHash) }

      sig { returns(String) }
      attr_accessor :id

      sig { returns(T::Boolean) }
      attr_accessor :deleted

      sig { returns(String) }
      attr_accessor :object

      sig do
        params(id: String, deleted: T::Boolean, object: String).returns(
          T.attached_class
        )
      end
      def self.new(id:, deleted:, object:)
      end

      sig do
        override.returns({ id: String, deleted: T::Boolean, object: String })
      end
      def to_hash
      end
    end
  end
end
