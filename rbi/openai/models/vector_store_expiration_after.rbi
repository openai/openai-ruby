# typed: strong

module OpenAI
  module Models
    class VectorStoreExpirationAfter < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias do
          T.any(OpenAI::VectorStoreExpirationAfter, OpenAI::Internal::AnyHash)
        end

      # Anchor timestamp after which the expiration policy applies. Supported anchors:
      # `last_active_at`.
      sig { returns(Symbol) }
      attr_accessor :anchor

      # The number of days after the anchor time that the vector store will expire.
      sig { returns(Integer) }
      attr_accessor :days

      # The expiration policy for a vector store.
      sig { params(days: Integer, anchor: Symbol).returns(T.attached_class) }
      def self.new(
        # The number of days after the anchor time that the vector store will expire.
        days:,
        # Anchor timestamp after which the expiration policy applies. Supported anchors:
        # `last_active_at`.
        anchor: :last_active_at
      )
      end

      sig { override.returns({ anchor: Symbol, days: Integer }) }
      def to_hash
      end
    end
  end
end
