# typed: strong

module OpenAI
  module Models
    class Model < OpenAI::BaseModel
      sig { returns(String) }
      def id
      end

      sig { params(_: String).returns(String) }
      def id=(_)
      end

      sig { returns(Integer) }
      def created
      end

      sig { params(_: Integer).returns(Integer) }
      def created=(_)
      end

      sig { returns(Symbol) }
      def object
      end

      sig { params(_: Symbol).returns(Symbol) }
      def object=(_)
      end

      sig { returns(String) }
      def owned_by
      end

      sig { params(_: String).returns(String) }
      def owned_by=(_)
      end

      sig { params(id: String, created: Integer, owned_by: String, object: Symbol).returns(T.attached_class) }
      def self.new(id:, created:, owned_by:, object: :model)
      end

      sig { override.returns({id: String, created: Integer, object: Symbol, owned_by: String}) }
      def to_hash
      end
    end
  end
end
