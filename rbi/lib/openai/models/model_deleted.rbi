# typed: strong

module OpenAI
  module Models
    class ModelDeleted < OpenAI::Internal::Type::BaseModel
      sig { returns(String) }
      attr_accessor :id

      sig { returns(T::Boolean) }
      attr_accessor :deleted

      sig { returns(String) }
      attr_accessor :object

      sig { params(id: String, deleted: T::Boolean, object: String).returns(T.attached_class) }
      def self.new(id:, deleted:, object:); end

      sig { override.returns({id: String, deleted: T::Boolean, object: String}) }
      def to_hash; end
    end
  end
end
