# typed: strong

module OpenAI
  module Models
    class Model < OpenAI::BaseModel
      # The model identifier, which can be referenced in the API endpoints.
      sig { returns(String) }
      attr_accessor :id

      # The Unix timestamp (in seconds) when the model was created.
      sig { returns(Integer) }
      attr_accessor :created

      # The object type, which is always "model".
      sig { returns(Symbol) }
      attr_accessor :object

      # The organization that owns the model.
      sig { returns(String) }
      attr_accessor :owned_by

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
