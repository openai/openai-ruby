# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageFileContentBlock < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          sig { returns(OpenAI::Beta::Threads::ImageFile) }
          attr_reader :image_file

          sig do
            params(image_file: OpenAI::Beta::Threads::ImageFile::OrHash).void
          end
          attr_writer :image_file

          # Always `image_file`.
          sig { returns(Symbol) }
          attr_accessor :type

          # References an image [File](https://platform.openai.com/docs/api-reference/files)
          # in the content of a message.
          sig do
            params(
              image_file: OpenAI::Beta::Threads::ImageFile::OrHash,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            image_file:,
            # Always `image_file`.
            type: :image_file
          )
          end

          sig do
            override.returns(
              { image_file: OpenAI::Beta::Threads::ImageFile, type: Symbol }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
