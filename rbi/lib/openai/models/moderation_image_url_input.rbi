# typed: strong

module OpenAI
  module Models
    class ModerationImageURLInput < OpenAI::BaseModel
      # Contains either an image URL or a data URL for a base64 encoded image.
      sig { returns(OpenAI::Models::ModerationImageURLInput::ImageURL) }
      def image_url
      end

      sig do
        params(_: T.any(OpenAI::Models::ModerationImageURLInput::ImageURL, OpenAI::Util::AnyHash))
          .returns(T.any(OpenAI::Models::ModerationImageURLInput::ImageURL, OpenAI::Util::AnyHash))
      end
      def image_url=(_)
      end

      # Always `image_url`.
      sig { returns(Symbol) }
      def type
      end

      sig { params(_: Symbol).returns(Symbol) }
      def type=(_)
      end

      # An object describing an image to classify.
      sig do
        params(image_url: OpenAI::Models::ModerationImageURLInput::ImageURL, type: Symbol)
          .returns(T.attached_class)
      end
      def self.new(image_url:, type: :image_url)
      end

      sig { override.returns({image_url: OpenAI::Models::ModerationImageURLInput::ImageURL, type: Symbol}) }
      def to_hash
      end

      class ImageURL < OpenAI::BaseModel
        # Either a URL of the image or the base64 encoded image data.
        sig { returns(String) }
        def url
        end

        sig { params(_: String).returns(String) }
        def url=(_)
        end

        # Contains either an image URL or a data URL for a base64 encoded image.
        sig { params(url: String).returns(T.attached_class) }
        def self.new(url:)
        end

        sig { override.returns({url: String}) }
        def to_hash
        end
      end
    end
  end
end
