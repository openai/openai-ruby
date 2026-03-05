# typed: strong

module OpenAI
  module Models
    class SkillUpdateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash =
        T.type_alias do
          T.any(OpenAI::SkillUpdateParams, OpenAI::Internal::AnyHash)
        end

      sig { returns(String) }
      attr_accessor :skill_id

      # The skill version number to set as default.
      sig { returns(String) }
      attr_accessor :default_version

      sig do
        params(
          skill_id: String,
          default_version: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(
        skill_id:,
        # The skill version number to set as default.
        default_version:,
        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            skill_id: String,
            default_version: String,
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end
    end
  end
end
