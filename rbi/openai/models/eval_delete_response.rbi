# typed: strong

module OpenAI
  module Models
    class EvalDeleteResponse < OpenAI::Internal::Type::BaseModel
      sig { returns(T::Boolean) }
      attr_accessor :deleted

      sig { returns(String) }
      attr_accessor :eval_id

      sig { returns(String) }
      attr_accessor :object

      sig { params(deleted: T::Boolean, eval_id: String, object: String).returns(T.attached_class) }
      def self.new(deleted:, eval_id:, object:); end

      sig { override.returns({deleted: T::Boolean, eval_id: String, object: String}) }
      def to_hash; end
    end
  end
end
