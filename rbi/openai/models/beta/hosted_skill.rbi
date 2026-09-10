# typed: strong

module OpenAI
  module Models

    module Beta

      # A skill installed in an OpenAI-hosted environment.
      module HostedSkill
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::HostedSkillReference,
            OpenAI::Beta::HostedSkill::Inline
          )
        end

        class Inline < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::HostedSkill::Inline,
              OpenAI::Internal::AnyHash
            )
          end

          # The installed skill description.
          sig { returns(String) }
          attr_accessor :description

          # The installed skill name.
          sig { returns(String) }
          attr_accessor :name

          # The type of the object. Always `inline`.
          sig { returns(Symbol) }
          attr_accessor :type

          # A skill installed from an inline ZIP archive.
          sig do
            params(

              description: String,

              name: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The installed skill description.
            description:,

            # The installed skill name.
            name:,

            # The type of the object. Always `inline`.

            type: :inline
          )
          end

          sig do
            override.returns(
              {description: String, name: String, type: Symbol}
            )
          end
          def to_hash
          end

        end

        sig { override.returns(T::Array[OpenAI::Beta::HostedSkill::Variants]) }
        def self.variants
        end

      end

    end

  end
end
