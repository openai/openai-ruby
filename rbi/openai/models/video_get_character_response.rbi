# typed: strong

module OpenAI
  module Models
    class VideoGetCharacterResponse < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias do
          T.any(
            OpenAI::Models::VideoGetCharacterResponse,
            OpenAI::Internal::AnyHash
          )
        end

      # Identifier for the character creation cameo.
      sig { returns(T.nilable(String)) }
      attr_accessor :id

      # Unix timestamp (in seconds) when the character was created.
      sig { returns(Integer) }
      attr_accessor :created_at

      # Display name for the character.
      sig { returns(T.nilable(String)) }
      attr_accessor :name

      sig do
        params(
          id: T.nilable(String),
          created_at: Integer,
          name: T.nilable(String)
        ).returns(T.attached_class)
      end
      def self.new(
        # Identifier for the character creation cameo.
        id:,
        # Unix timestamp (in seconds) when the character was created.
        created_at:,
        # Display name for the character.
        name:
      )
      end

      sig do
        override.returns(
          {
            id: T.nilable(String),
            created_at: Integer,
            name: T.nilable(String)
          }
        )
      end
      def to_hash
      end
    end
  end
end
