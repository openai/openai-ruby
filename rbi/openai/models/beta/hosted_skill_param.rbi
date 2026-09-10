# typed: strong

module OpenAI
  module Models

    module Beta

      # A skill installed in an OpenAI-hosted environment.
      module HostedSkillParam
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::HostedSkillParam::SkillReference,
            OpenAI::Beta::HostedSkillParam::Inline
          )
        end

        class SkillReference < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::HostedSkillParam::SkillReference,
              OpenAI::Internal::AnyHash
            )
          end

          # The ID of the skill created through `/v1/skills`.
          sig { returns(String) }
          attr_accessor :skill_id

          # The type of the object. Always `skill_reference`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The skill version, a positive integer or `latest`; omission selects the default.
          sig { returns(T.nilable(String)) }
          attr_accessor :version

          # References a skill uploaded through the Skills API.
          sig do
            params(

              skill_id: String,

              version: T.nilable(String),

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The ID of the skill created through `/v1/skills`.
            skill_id:,

            # The skill version, a positive integer or `latest`; omission selects the default.
            version: nil,

            # The type of the object. Always `skill_reference`.

            type: :skill_reference
          )
          end

          sig do
            override.returns(
              {skill_id: String, type: Symbol, version: T.nilable(String)}
            )
          end
          def to_hash
          end

        end

        class Inline < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::HostedSkillParam::Inline,
              OpenAI::Internal::AnyHash
            )
          end

          # The skill description declared in `SKILL.md`.
          sig { returns(String) }
          attr_accessor :description

          # The skill name declared in `SKILL.md`.
          sig { returns(String) }
          attr_accessor :name

          # Provides ZIP bytes encoded with standard base64.
          sig { returns(OpenAI::Beta::InlineCapabilitySourceParam) }
          attr_reader :source

          sig { params(source: OpenAI::Beta::InlineCapabilitySourceParam::OrHash).void }
          attr_writer :source

          # The type of the object. Always `inline`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Supplies a skill ZIP directly in the session request.
          sig do
            params(

              description: String,

              name: String,

              source: OpenAI::Beta::InlineCapabilitySourceParam::OrHash,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The skill description declared in `SKILL.md`.
            description:,

            # The skill name declared in `SKILL.md`.
            name:,

            # Provides ZIP bytes encoded with standard base64.
            source:,

            # The type of the object. Always `inline`.

            type: :inline
          )
          end

          sig do
            override.returns(
              {description: String, name: String, source: OpenAI::Beta::InlineCapabilitySourceParam, type: Symbol}
            )
          end
          def to_hash
          end

        end

        sig { override.returns(T::Array[OpenAI::Beta::HostedSkillParam::Variants]) }
        def self.variants
        end

      end

    end

  end
end
