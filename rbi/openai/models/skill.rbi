# typed: strong

module OpenAI
  module Models
    class Skill < OpenAI::Internal::Type::BaseModel
      OrHash = T.type_alias { T.any(OpenAI::Skill, OpenAI::Internal::AnyHash) }

      # Unique identifier for the skill.
      sig { returns(String) }
      attr_accessor :id

      # Unix timestamp (seconds) for when the skill was created.
      sig { returns(Integer) }
      attr_accessor :created_at

      # Default version for the skill.
      sig { returns(String) }
      attr_accessor :default_version

      # Description of the skill.
      sig { returns(String) }
      attr_accessor :description

      # Latest version for the skill.
      sig { returns(String) }
      attr_accessor :latest_version

      # Name of the skill.
      sig { returns(String) }
      attr_accessor :name

      # The object type, which is `skill`.
      sig { returns(Symbol) }
      attr_accessor :object

      sig do
        params(
          id: String,
          created_at: Integer,
          default_version: String,
          description: String,
          latest_version: String,
          name: String,
          object: Symbol
        ).returns(T.attached_class)
      end
      def self.new(
        # Unique identifier for the skill.
        id:,
        # Unix timestamp (seconds) for when the skill was created.
        created_at:,
        # Default version for the skill.
        default_version:,
        # Description of the skill.
        description:,
        # Latest version for the skill.
        latest_version:,
        # Name of the skill.
        name:,
        # The object type, which is `skill`.
        object: :skill
      )
      end

      sig do
        override.returns(
          {
            id: String,
            created_at: Integer,
            default_version: String,
            description: String,
            latest_version: String,
            name: String,
            object: Symbol
          }
        )
      end
      def to_hash
      end
    end
  end
end
