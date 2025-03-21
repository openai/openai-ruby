# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageFileContentBlock < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Beta::Threads::ImageFile) }
          attr_reader :image_file

          sig { params(image_file: T.any(OpenAI::Models::Beta::Threads::ImageFile, OpenAI::Util::AnyHash)).void }
          attr_writer :image_file

          # Always `image_file`.
          sig { returns(Symbol) }
          attr_accessor :type

          # References an image [File](https://platform.openai.com/docs/api-reference/files)
          #   in the content of a message.
          sig do
            params(image_file: T.any(OpenAI::Models::Beta::Threads::ImageFile, OpenAI::Util::AnyHash), type: Symbol)
              .returns(T.attached_class)
          end
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
