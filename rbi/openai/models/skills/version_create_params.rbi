# typed: strong

module OpenAI
  module Models
    module Skills
      class VersionCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Skills::VersionCreateParams,
              OpenAI::Internal::AnyHash
            )
          end

        # Whether to set this version as the default.
        sig { returns(T.nilable(T::Boolean)) }
        attr_reader :default

        sig { params(default: T::Boolean).void }
        attr_writer :default

        # Skill files to upload (directory upload) or a single zip file.
        sig do
          returns(
            T.nilable(OpenAI::Skills::VersionCreateParams::Files::Variants)
          )
        end
        attr_reader :files

        sig do
          params(
            files: OpenAI::Skills::VersionCreateParams::Files::Variants
          ).void
        end
        attr_writer :files

        sig do
          params(
            default: T::Boolean,
            files: OpenAI::Skills::VersionCreateParams::Files::Variants,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # Whether to set this version as the default.
          default: nil,
          # Skill files to upload (directory upload) or a single zip file.
          files: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              default: T::Boolean,
              files: OpenAI::Skills::VersionCreateParams::Files::Variants,
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
            override.returns(
              T::Array[OpenAI::Skills::VersionCreateParams::Files::Variants]
            )
          end
          def self.variants
          end

          StringArray =
            T.let(
              OpenAI::Internal::Type::ArrayOf[
                OpenAI::Internal::Type::FileInput
              ],
              OpenAI::Internal::Type::Converter
            )
        end
      end
    end
  end
end
