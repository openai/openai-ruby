# typed: strong

module OpenAI
  module Models
    class ModerationImageURLInput < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias do
          T.any(OpenAI::ModerationImageURLInput, OpenAI::Internal::AnyHash)
        end

      # Contains either an image URL or a data URL for a base64 encoded image.
      sig { returns(OpenAI::ModerationImageURLInput::ImageURL) }
      attr_reader :image_url

      sig do
        params(
          image_url: OpenAI::ModerationImageURLInput::ImageURL::OrHash
        ).void
      end
      attr_writer :image_url

      # Always `image_url`.
      sig { returns(Symbol) }
      attr_accessor :type

      # An object describing an image to classify.
      sig do
        params(
          image_url: OpenAI::ModerationImageURLInput::ImageURL::OrHash,
          type: Symbol
        ).returns(T.attached_class)
      end
      def self.new(
        # Contains either an image URL or a data URL for a base64 encoded image.
        image_url:,
        # Always `image_url`.
        type: :image_url
      )
      end

      sig do
        override.returns(
          { image_url: OpenAI::ModerationImageURLInput::ImageURL, type: Symbol }
        )
      end
      def to_hash
      end

      class ImageURL < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::ModerationImageURLInput::ImageURL,
              OpenAI::Internal::AnyHash
            )
          end

        # Either a URL of the image or the base64 encoded image data.
        sig { returns(String) }
        attr_accessor :url

        # Contains either an image URL or a data URL for a base64 encoded image.
        sig { params(url: String).returns(T.attached_class) }
        def self.new(
          # Either a URL of the image or the base64 encoded image data.
          url:
        )
        end

        sig { override.returns({ url: String }) }
        def to_hash
        end
      end
    end
  end
end
