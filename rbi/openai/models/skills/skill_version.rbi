# typed: strong

module OpenAI
  module Models
    SkillVersion = Skills::SkillVersion

    module Skills
      class SkillVersion < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Skills::SkillVersion, OpenAI::Internal::AnyHash)
          end

        # Unique identifier for the skill version.
        sig { returns(String) }
        attr_accessor :id

        # Unix timestamp (seconds) for when the version was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        # Description of the skill version.
        sig { returns(String) }
        attr_accessor :description

        # Name of the skill version.
        sig { returns(String) }
        attr_accessor :name

        # The object type, which is `skill.version`.
        sig { returns(Symbol) }
        attr_accessor :object

        # Identifier of the skill for this version.
        sig { returns(String) }
        attr_accessor :skill_id

        # Version number for this skill.
        sig { returns(String) }
        attr_accessor :version

        sig do
          params(
            id: String,
            created_at: Integer,
            description: String,
            name: String,
            skill_id: String,
            version: String,
            object: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Unique identifier for the skill version.
          id:,
          # Unix timestamp (seconds) for when the version was created.
          created_at:,
          # Description of the skill version.
          description:,
          # Name of the skill version.
          name:,
          # Identifier of the skill for this version.
          skill_id:,
          # Version number for this skill.
          version:,
          # The object type, which is `skill.version`.
          object: :"skill.version"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              description: String,
              name: String,
              object: Symbol,
              skill_id: String,
              version: String
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
