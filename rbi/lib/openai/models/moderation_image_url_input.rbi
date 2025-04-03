# typed: strong

module OpenAI
  module Models
    class ModerationImageURLInput < OpenAI::Internal::Type::BaseModel
      # Contains either an image URL or a data URL for a base64 encoded image.
      sig { returns(OpenAI::Models::ModerationImageURLInput::ImageURL) }
      attr_reader :image_url

      sig { params(image_url: T.any(OpenAI::Models::ModerationImageURLInput::ImageURL, OpenAI::Internal::AnyHash)).void }
      attr_writer :image_url

      # Always `image_url`.
      sig { returns(Symbol) }
      attr_accessor :type

      # An object describing an image to classify.
      sig do
        params(
          image_url: T.any(OpenAI::Models::ModerationImageURLInput::ImageURL, OpenAI::Internal::AnyHash),
          type: Symbol
        )
          .returns(T.attached_class)
      end
      def self.new(image_url:, type: :image_url)
      end

      sig { override.returns({image_url: OpenAI::Models::ModerationImageURLInput::ImageURL, type: Symbol}) }
      def to_hash
      end

      class ImageURL < OpenAI::Internal::Type::BaseModel
        # Either a URL of the image or the base64 encoded image data.
        sig { returns(String) }
        attr_accessor :url

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
