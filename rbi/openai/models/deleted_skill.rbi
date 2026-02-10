# typed: strong

module OpenAI
  module Models
    class DeletedSkill < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias { T.any(OpenAI::DeletedSkill, OpenAI::Internal::AnyHash) }

      sig { returns(String) }
      attr_accessor :id

      sig { returns(T::Boolean) }
      attr_accessor :deleted

      sig { returns(Symbol) }
      attr_accessor :object

      sig do
        params(id: String, deleted: T::Boolean, object: Symbol).returns(
          T.attached_class
        )
      end
      def self.new(id:, deleted:, object: :"skill.deleted")
      end

      sig do
        override.returns({ id: String, deleted: T::Boolean, object: Symbol })
      end
      def to_hash
      end
    end
  end
end
