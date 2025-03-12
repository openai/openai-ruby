# typed: strong

module OpenAI
  module Models
    class ModerationImageURLInput < OpenAI::BaseModel
      sig { returns(OpenAI::Models::ModerationImageURLInput::ImageURL) }
      def image_url
      end

      sig do
        params(_: OpenAI::Models::ModerationImageURLInput::ImageURL)
          .returns(OpenAI::Models::ModerationImageURLInput::ImageURL)
      end
      def image_url=(_)
      end

      sig { returns(Symbol) }
      def type
      end

      sig { params(_: Symbol).returns(Symbol) }
      def type=(_)
      end

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
        sig { returns(String) }
        def url
        end

        sig { params(_: String).returns(String) }
        def url=(_)
        end

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
