# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageFileContentBlock < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Beta::Threads::ImageFile) }
          def image_file
          end

          sig do
            params(_: T.any(OpenAI::Models::Beta::Threads::ImageFile, OpenAI::Util::AnyHash))
              .returns(T.any(OpenAI::Models::Beta::Threads::ImageFile, OpenAI::Util::AnyHash))
          end
          def image_file=(_)
          end

          # Always `image_file`.
          sig { returns(Symbol) }
          def type
          end

          sig { params(_: Symbol).returns(Symbol) }
          def type=(_)
          end

          # References an image [File](https://platform.openai.com/docs/api-reference/files)
          #   in the content of a message.
          sig { params(image_file: OpenAI::Models::Beta::Threads::ImageFile, type: Symbol).returns(T.attached_class) }
          def self.new(image_file:, type: :image_file)
          end

          sig { override.returns({image_file: OpenAI::Models::Beta::Threads::ImageFile, type: Symbol}) }
          def to_hash
          end
        end
      end
    end
  end
end
