# typed: strong

module OpenAI
  module Models

    module Beta

      class HostedSkillReference < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::HostedSkillReference,
            OpenAI::Internal::AnyHash
          )
        end

        # The installed skill description.
        sig { returns(String) }
        attr_accessor :description

        # The installed skill name.
        sig { returns(String) }
        attr_accessor :name

        # The referenced skill ID.
        sig { returns(String) }
        attr_accessor :skill_id

        # The type of the object. Always `skill_reference`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The concrete skill version installed for this session.
        sig { returns(String) }
        attr_accessor :version

        # A skill installed from the Skills API.
        sig do
          params(

            description: String,

            name: String,

            skill_id: String,

            version: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The installed skill description.
          description:,

          # The installed skill name.
          name:,

          # The referenced skill ID.
          skill_id:,

          # The concrete skill version installed for this session.
          version:,

          # The type of the object. Always `skill_reference`.

          type: :skill_reference
        )
        end

        sig do
          override.returns(
            {description: String, name: String, skill_id: String, type: Symbol, version: String}
          )
        end
        def to_hash
        end

      end

    end

  end
end
