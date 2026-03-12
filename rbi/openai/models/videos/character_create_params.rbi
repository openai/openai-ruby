# typed: strong

module OpenAI
  module Models
    module Videos
      class CharacterCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Videos::CharacterCreateParams,
              OpenAI::Internal::AnyHash
            )
          end

        # Display name for this API character.
        sig { returns(String) }
        attr_accessor :name

        # Video file used to create a character.
        sig { returns(OpenAI::Internal::FileInput) }
        attr_accessor :video

        sig do
          params(
            name: String,
            video: OpenAI::Internal::FileInput,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # Display name for this API character.
          name:,
          # Video file used to create a character.
          video:,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              name: String,
              video: OpenAI::Internal::FileInput,
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
