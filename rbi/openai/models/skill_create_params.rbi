# typed: strong

module OpenAI
  module Models
    class SkillCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash =
        T.type_alias do
          T.any(OpenAI::SkillCreateParams, OpenAI::Internal::AnyHash)
        end

      # Skill files to upload (directory upload) or a single zip file.
      sig { returns(T.nilable(OpenAI::SkillCreateParams::Files::Variants)) }
      attr_reader :files

      sig { params(files: OpenAI::SkillCreateParams::Files::Variants).void }
      attr_writer :files

      sig do
        params(
          files: OpenAI::SkillCreateParams::Files::Variants,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(
        # Skill files to upload (directory upload) or a single zip file.
        files: nil,
        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            files: OpenAI::SkillCreateParams::Files::Variants,
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end

      # Skill files to upload (directory upload) or a single zip file.
      module Files
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias { T.any(T::Array[StringIO], StringIO) }

        sig do
          override.returns(T::Array[OpenAI::SkillCreateParams::Files::Variants])
        end
        def self.variants
        end

        StringArray =
          T.let(
            OpenAI::Internal::Type::ArrayOf[OpenAI::Internal::Type::FileInput],
            OpenAI::Internal::Type::Converter
          )
      end
    end
  end
end
