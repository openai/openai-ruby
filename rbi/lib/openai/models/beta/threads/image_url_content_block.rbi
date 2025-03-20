# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageURLContentBlock < OpenAI::BaseModel
          sig { returns(OpenAI::Models::Beta::Threads::ImageURL) }
          def image_url
          end

          sig do
            params(_: T.any(OpenAI::Models::Beta::Threads::ImageURL, OpenAI::Util::AnyHash))
              .returns(T.any(OpenAI::Models::Beta::Threads::ImageURL, OpenAI::Util::AnyHash))
          end
          def image_url=(_)
          end

          # The type of the content part.
          sig { returns(Symbol) }
          def type
          end

          sig { params(_: Symbol).returns(Symbol) }
          def type=(_)
          end

          # References an image URL in the content of a message.
          sig { params(image_url: OpenAI::Models::Beta::Threads::ImageURL, type: Symbol).returns(T.attached_class) }
          def self.new(image_url:, type: :image_url)
          end

          sig { override.returns({image_url: OpenAI::Models::Beta::Threads::ImageURL, type: Symbol}) }
          def to_hash
          end
        end
      end
    end
  end
end
