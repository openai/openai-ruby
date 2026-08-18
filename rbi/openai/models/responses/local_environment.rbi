# typed: strong

module OpenAI
  module Models
    module Responses
      class LocalEnvironment < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::LocalEnvironment,
              OpenAI::Internal::AnyHash
            )
          end

        # Use a local computer environment.
        sig { returns(Symbol) }
        attr_accessor :type

        # An optional list of skills.
        sig { returns(T.nilable(T::Array[OpenAI::Responses::LocalSkill])) }
        attr_reader :skills

        sig do
          params(skills: T::Array[OpenAI::Responses::LocalSkill::OrHash]).void
        end
        attr_writer :skills

        sig do
          params(
            skills: T::Array[OpenAI::Responses::LocalSkill::OrHash],
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # An optional list of skills.
          skills: nil,
          # Use a local computer environment.
          type: :local
        )
        end

        sig do
          override.returns(
            { type: Symbol, skills: T::Array[OpenAI::Responses::LocalSkill] }
          )
        end
        def to_hash
        end
      end
    end
  end
end
