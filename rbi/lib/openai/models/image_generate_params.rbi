# typed: strong

module OpenAI
  module Models
    class ImageGenerateParams < OpenAI::BaseModel
      extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      # A text description of the desired image(s). The maximum length is 1000
      #   characters for `dall-e-2` and 4000 characters for `dall-e-3`.
      sig { returns(String) }
      def prompt
      end

      sig { params(_: String).returns(String) }
      def prompt=(_)
      end

      # The model to use for image generation.
      sig { returns(T.nilable(T.any(String, Symbol))) }
      def model
      end

      sig { params(_: T.nilable(T.any(String, Symbol))).returns(T.nilable(T.any(String, Symbol))) }
      def model=(_)
      end

      # The number of images to generate. Must be between 1 and 10. For `dall-e-3`, only
      #   `n=1` is supported.
      sig { returns(T.nilable(Integer)) }
      def n
      end

      sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def n=(_)
      end

      # The quality of the image that will be generated. `hd` creates images with finer
      #   details and greater consistency across the image. This param is only supported
      #   for `dall-e-3`.
      sig { returns(T.nilable(Symbol)) }
      def quality
      end

      sig { params(_: Symbol).returns(Symbol) }
      def quality=(_)
      end

      # The format in which the generated images are returned. Must be one of `url` or
      #   `b64_json`. URLs are only valid for 60 minutes after the image has been
      #   generated.
      sig { returns(T.nilable(Symbol)) }
      def response_format
      end

      sig { params(_: T.nilable(Symbol)).returns(T.nilable(Symbol)) }
      def response_format=(_)
      end

      # The size of the generated images. Must be one of `256x256`, `512x512`, or
      #   `1024x1024` for `dall-e-2`. Must be one of `1024x1024`, `1792x1024`, or
      #   `1024x1792` for `dall-e-3` models.
      sig { returns(T.nilable(Symbol)) }
      def size
      end

      sig { params(_: T.nilable(Symbol)).returns(T.nilable(Symbol)) }
      def size=(_)
      end

      # The style of the generated images. Must be one of `vivid` or `natural`. Vivid
      #   causes the model to lean towards generating hyper-real and dramatic images.
      #   Natural causes the model to produce more natural, less hyper-real looking
      #   images. This param is only supported for `dall-e-3`.
      sig { returns(T.nilable(Symbol)) }
      def style
      end

      sig { params(_: T.nilable(Symbol)).returns(T.nilable(Symbol)) }
      def style=(_)
      end

      # A unique identifier representing your end-user, which can help OpenAI to monitor
      #   and detect abuse.
      #   [Learn more](https://platform.openai.com/docs/guides/safety-best-practices#end-user-ids).
      sig { returns(T.nilable(String)) }
      def user
      end

      sig { params(_: String).returns(String) }
      def user=(_)
      end

      sig do
        params(
          prompt: String,
          model: T.nilable(T.any(String, Symbol)),
          n: T.nilable(Integer),
          quality: Symbol,
          response_format: T.nilable(Symbol),
          size: T.nilable(Symbol),
          style: T.nilable(Symbol),
          user: String,
          request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
        )
          .returns(T.attached_class)
      end
      def self.new(
        prompt:,
        model: nil,
        n: nil,
        quality: nil,
        response_format: nil,
        size: nil,
        style: nil,
        user: nil,
        request_options: {}
      )
      end

      sig do
        override
          .returns(
            {
              prompt: String,
              model: T.nilable(T.any(String, Symbol)),
              n: T.nilable(Integer),
              quality: Symbol,
              response_format: T.nilable(Symbol),
              size: T.nilable(Symbol),
              style: T.nilable(Symbol),
              user: String,
              request_options: OpenAI::RequestOptions
            }
          )
      end
      def to_hash
      end

      # The model to use for image generation.
      class Model < OpenAI::Union
        abstract!

        Variants = type_template(:out) { {fixed: T.any(String, Symbol)} }
      end

      # The quality of the image that will be generated. `hd` creates images with finer
      #   details and greater consistency across the image. This param is only supported
      #   for `dall-e-3`.
      class Quality < OpenAI::Enum
        abstract!

        Value = type_template(:out) { {fixed: Symbol} }

        STANDARD = :standard
        HD = :hd
      end

      # The format in which the generated images are returned. Must be one of `url` or
      #   `b64_json`. URLs are only valid for 60 minutes after the image has been
      #   generated.
      class ResponseFormat < OpenAI::Enum
        abstract!

        Value = type_template(:out) { {fixed: Symbol} }

        URL = :url
        B64_JSON = :b64_json
      end

      # The size of the generated images. Must be one of `256x256`, `512x512`, or
      #   `1024x1024` for `dall-e-2`. Must be one of `1024x1024`, `1792x1024`, or
      #   `1024x1792` for `dall-e-3` models.
      class Size < OpenAI::Enum
        abstract!

        Value = type_template(:out) { {fixed: Symbol} }

        NUMBER_256X256 = :"256x256"
        NUMBER_512X512 = :"512x512"
        NUMBER_1024X1024 = :"1024x1024"
        NUMBER_1792X1024 = :"1792x1024"
        NUMBER_1024X1792 = :"1024x1792"
      end

      # The style of the generated images. Must be one of `vivid` or `natural`. Vivid
      #   causes the model to lean towards generating hyper-real and dramatic images.
      #   Natural causes the model to produce more natural, less hyper-real looking
      #   images. This param is only supported for `dall-e-3`.
      class Style < OpenAI::Enum
        abstract!

        Value = type_template(:out) { {fixed: Symbol} }

        VIVID = :vivid
        NATURAL = :natural
      end
    end
  end
end
