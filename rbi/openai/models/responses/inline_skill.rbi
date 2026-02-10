# typed: strong

module OpenAI
  module Models
    module Responses
      class InlineSkill < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Responses::InlineSkill, OpenAI::Internal::AnyHash)
          end

        # The description of the skill.
        sig { returns(String) }
        attr_accessor :description

        # The name of the skill.
        sig { returns(String) }
        attr_accessor :name

        # Inline skill payload
        sig { returns(OpenAI::Responses::InlineSkillSource) }
        attr_reader :source

        sig do
          params(source: OpenAI::Responses::InlineSkillSource::OrHash).void
        end
        attr_writer :source

        # Defines an inline skill for this request.
        sig { returns(Symbol) }
        attr_accessor :type

        sig do
          params(
            description: String,
            name: String,
            source: OpenAI::Responses::InlineSkillSource::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The description of the skill.
          description:,
          # The name of the skill.
          name:,
          # Inline skill payload
          source:,
          # Defines an inline skill for this request.
          type: :inline
        )
        end

        sig do
          override.returns(
            {
              description: String,
              name: String,
              source: OpenAI::Responses::InlineSkillSource,
              type: Symbol
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
