# typed: strong

module OpenAI
  module Models
    module Responses
      class SkillReference < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Responses::SkillReference, OpenAI::Internal::AnyHash)
          end

        # The ID of the referenced skill.
        sig { returns(String) }
        attr_accessor :skill_id

        # References a skill created with the /v1/skills endpoint.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional skill version. Use a positive integer or 'latest'. Omit for default.
        sig { returns(T.nilable(String)) }
        attr_reader :version

        sig { params(version: String).void }
        attr_writer :version

        sig do
          params(skill_id: String, version: String, type: Symbol).returns(
            T.attached_class
          )
        end
        def self.new(
          # The ID of the referenced skill.
          skill_id:,
          # Optional skill version. Use a positive integer or 'latest'. Omit for default.
          version: nil,
          # References a skill created with the /v1/skills endpoint.
          type: :skill_reference
        )
        end

        sig do
          override.returns({ skill_id: String, type: Symbol, version: String })
        end
        def to_hash
        end
      end
    end
  end
end
