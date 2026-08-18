# typed: strong

module OpenAI
  module Models
    module Responses
      class LocalSkill < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Responses::LocalSkill, OpenAI::Internal::AnyHash)
          end

        # The description of the skill.
        sig { returns(String) }
        attr_accessor :description

        # The name of the skill.
        sig { returns(String) }
        attr_accessor :name

        # The path to the directory containing the skill.
        sig { returns(String) }
        attr_accessor :path

        sig do
          params(description: String, name: String, path: String).returns(
            T.attached_class
          )
        end
        def self.new(
          # The description of the skill.
          description:,
          # The name of the skill.
          name:,
          # The path to the directory containing the skill.
          path:
        )
        end

        sig do
          override.returns({ description: String, name: String, path: String })
        end
        def to_hash
        end
      end
    end
  end
end
