# typed: strong

module OpenAI
  module Models
    class Model < OpenAI::BaseModel
      # The model identifier, which can be referenced in the API endpoints.
      sig { returns(String) }
      def id
      end

      sig { params(_: String).returns(String) }
      def id=(_)
      end

      # The Unix timestamp (in seconds) when the model was created.
      sig { returns(Integer) }
      def created
      end

      sig { params(_: Integer).returns(Integer) }
      def created=(_)
      end

      # The object type, which is always "model".
      sig { returns(Symbol) }
      def object
      end

      sig { params(_: Symbol).returns(Symbol) }
      def object=(_)
      end

      # The organization that owns the model.
      sig { returns(String) }
      def owned_by
      end

      sig { params(_: String).returns(String) }
      def owned_by=(_)
      end

      # Describes an OpenAI model offering that can be used with the API.
      sig { params(id: String, created: Integer, owned_by: String, object: Symbol).returns(T.attached_class) }
      def self.new(id:, created:, owned_by:, object: :model)
      end

      sig { override.returns({id: String, created: Integer, object: Symbol, owned_by: String}) }
      def to_hash
      end
    end
  end
end
