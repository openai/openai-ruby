# typed: strong

module OpenAI
  module Models

    class Model < OpenAI::Internal::Type::BaseModel

      OrHash = T.type_alias do
        T.any(
          OpenAI::Model,
          OpenAI::Internal::AnyHash
        )
      end

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

      # The date when the model will shut down, or null if not announced.
      sig { returns(T.nilable(Date)) }
      attr_accessor :shutdown_date

      # Describes an OpenAI model offering that can be used with the API.
      sig do
        params(

          id: String,

          created: Integer,

          owned_by: String,

          shutdown_date: T.nilable(Date),

          object: Symbol
        )
          .returns(T.attached_class)
      end
      def self.new(

        # The model identifier, which can be referenced in the API endpoints.
        id:,

        # The Unix timestamp (in seconds) when the model was created.
        created:,

        # The organization that owns the model.
        owned_by:,

        # The date when the model will shut down, or null if not announced.
        shutdown_date: nil,

        # The object type, which is always "model".

        object: :model
      )
      end

      sig do
        override.returns(
          {id: String, created: Integer, object: Symbol, owned_by: String, shutdown_date: T.nilable(Date)}
        )
      end
      def to_hash
      end

    end

  end
end
