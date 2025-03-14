# typed: strong

module OpenAI
  module Resources
    class Images
      # Creates a variation of a given image.
      sig do
        params(
          image: T.any(IO, StringIO),
          model: T.nilable(T.any(String, Symbol)),
          n: T.nilable(Integer),
          response_format: T.nilable(Symbol),
          size: T.nilable(Symbol),
          user: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::ImagesResponse)
      end
      def create_variation(
        image:,
        model: nil,
        n: nil,
        response_format: nil,
        size: nil,
        user: nil,
        request_options: {}
      )
      end

      # Creates an edited or extended image given an original image and a prompt.
      sig do
        params(
          image: T.any(IO, StringIO),
          prompt: String,
          mask: T.any(IO, StringIO),
          model: T.nilable(T.any(String, Symbol)),
          n: T.nilable(Integer),
          response_format: T.nilable(Symbol),
          size: T.nilable(Symbol),
          user: String,
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::ImagesResponse)
      end
      def edit(
        image:,
        prompt:,
        mask: nil,
        model: nil,
        n: nil,
        response_format: nil,
        size: nil,
        user: nil,
        request_options: {}
      )
      end

      # Creates an image given a prompt.
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
          request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        )
          .returns(OpenAI::Models::ImagesResponse)
      end
      def generate(
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

      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
