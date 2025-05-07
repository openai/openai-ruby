# typed: strong

module OpenAI
  module Models
    class EvalDeleteResponse < OpenAI::Internal::Type::BaseModel
      OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

      sig { returns(T::Boolean) }
      attr_accessor :deleted

      sig { returns(String) }
      attr_accessor :eval_id

      sig { returns(String) }
      attr_accessor :object

      sig do
        params(deleted: T::Boolean, eval_id: String, object: String).returns(
          T.attached_class
        )
      end
      def self.new(deleted:, eval_id:, object:)
      end

      sig do
        override.returns(
          { deleted: T::Boolean, eval_id: String, object: String }
        )
      end
      def to_hash
      end
    end
  end
end
