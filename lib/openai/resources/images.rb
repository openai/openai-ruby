# frozen_string_literal: true

module OpenAI
  module Resources
    class Images
      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::ImageCreateVariationParams} for more details.
      #
      # Creates a variation of a given image. This endpoint only supports `dall-e-2`.
      #
      # @overload create_variation(image:, model: nil, n: nil, response_format: nil, size: nil, user: nil, request_options: {})
      #
      # @param image [Pathname, StringIO, IO, String, OpenAI::FilePart] The image to use as the basis for the variation(s). Must be a valid PNG file, le
      #
      # @param model [String, Symbol, OpenAI::Models::ImageModel, nil] The model to use for image generation. Only `dall-e-2` is supported at this time
      #
      # @param n [Integer, nil] The number of images to generate. Must be between 1 and 10.
      #
      # @param response_format [Symbol, OpenAI::Models::ImageCreateVariationParams::ResponseFormat, nil] The format in which the generated images are returned. Must be one of `url` or `
      #
      # @param size [Symbol, OpenAI::Models::ImageCreateVariationParams::Size, nil] The size of the generated images. Must be one of `256x256`, `512x512`, or `1024x
      #
      # @param user [String] A unique identifier representing your end-user, which can help OpenAI to monitor
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::ImagesResponse]
      #
      # @see OpenAI::Models::ImageCreateVariationParams
      def create_variation(params)
        parsed, options = OpenAI::ImageCreateVariationParams.dump_request(params)
        @client.request(
          method: :post,
          path: "images/variations",
          headers: {"content-type" => "multipart/form-data"},
          body: parsed,
          model: OpenAI::ImagesResponse,
          options: options
        )
      end

      # See {OpenAI::Resources::Images#edit_stream_raw} for streaming counterpart.
      #
      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::ImageEditParams} for more details.
      #
      # Creates an edited or extended image given one or more source images and a
      # prompt. This endpoint only supports `gpt-image-1` and `dall-e-2`.
      #
      # @overload edit(image:, prompt:, background: nil, input_fidelity: nil, mask: nil, model: nil, n: nil, output_compression: nil, output_format: nil, partial_images: nil, quality: nil, response_format: nil, size: nil, user: nil, request_options: {})
      #
      # @param image [Pathname, StringIO, IO, String, OpenAI::FilePart, Array<Pathname, StringIO, IO, String, OpenAI::FilePart>] The image(s) to edit. Must be a supported image file or an array of images.
      #
      # @param prompt [String] A text description of the desired image(s). The maximum length is 1000 character
      #
      # @param background [Symbol, OpenAI::Models::ImageEditParams::Background, nil] Allows to set transparency for the background of the generated image(s).
      #
      # @param input_fidelity [Symbol, OpenAI::Models::ImageEditParams::InputFidelity, nil] Control how much effort the model will exert to match the style and features,
      #
      # @param mask [Pathname, StringIO, IO, String, OpenAI::FilePart] An additional image whose fully transparent areas (e.g. where alpha is zero) ind
      #
      # @param model [String, Symbol, OpenAI::Models::ImageModel, nil] The model to use for image generation. Only `dall-e-2` and `gpt-image-1` are sup
      #
      # @param n [Integer, nil] The number of images to generate. Must be between 1 and 10.
      #
      # @param output_compression [Integer, nil] The compression level (0-100%) for the generated images. This parameter
      #
      # @param output_format [Symbol, OpenAI::Models::ImageEditParams::OutputFormat, nil] The format in which the generated images are returned. This parameter is
      #
      # @param partial_images [Integer, nil] The number of partial images to generate. This parameter is used for
      #
      # @param quality [Symbol, OpenAI::Models::ImageEditParams::Quality, nil] The quality of the image that will be generated. `high`, `medium` and `low` are
      #
      # @param response_format [Symbol, OpenAI::Models::ImageEditParams::ResponseFormat, nil] The format in which the generated images are returned. Must be one of `url` or `
      #
      # @param size [Symbol, OpenAI::Models::ImageEditParams::Size, nil] The size of the generated images. Must be one of `1024x1024`, `1536x1024` (lands
      #
      # @param user [String] A unique identifier representing your end-user, which can help OpenAI to monitor
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::ImagesResponse]
      #
      # @see OpenAI::Models::ImageEditParams
      def edit(params)
        parsed, options = OpenAI::ImageEditParams.dump_request(params)
        if parsed[:stream]
          message = "Please use `#edit_stream_raw` for the streaming use case."
          raise ArgumentError.new(message)
        end
        @client.request(
          method: :post,
          path: "images/edits",
          headers: {"content-type" => "multipart/form-data"},
          body: parsed,
          model: OpenAI::ImagesResponse,
          options: options
        )
      end

      # See {OpenAI::Resources::Images#edit} for non-streaming counterpart.
      #
      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::ImageEditParams} for more details.
      #
      # Creates an edited or extended image given one or more source images and a
      # prompt. This endpoint only supports `gpt-image-1` and `dall-e-2`.
      #
      # @overload edit_stream_raw(image:, prompt:, background: nil, input_fidelity: nil, mask: nil, model: nil, n: nil, output_compression: nil, output_format: nil, partial_images: nil, quality: nil, response_format: nil, size: nil, user: nil, request_options: {})
      #
      # @param image [Pathname, StringIO, IO, String, OpenAI::FilePart, Array<Pathname, StringIO, IO, String, OpenAI::FilePart>] The image(s) to edit. Must be a supported image file or an array of images.
      #
      # @param prompt [String] A text description of the desired image(s). The maximum length is 1000 character
      #
      # @param background [Symbol, OpenAI::Models::ImageEditParams::Background, nil] Allows to set transparency for the background of the generated image(s).
      #
      # @param input_fidelity [Symbol, OpenAI::Models::ImageEditParams::InputFidelity, nil] Control how much effort the model will exert to match the style and features,
      #
      # @param mask [Pathname, StringIO, IO, String, OpenAI::FilePart] An additional image whose fully transparent areas (e.g. where alpha is zero) ind
      #
      # @param model [String, Symbol, OpenAI::Models::ImageModel, nil] The model to use for image generation. Only `dall-e-2` and `gpt-image-1` are sup
      #
      # @param n [Integer, nil] The number of images to generate. Must be between 1 and 10.
      #
      # @param output_compression [Integer, nil] The compression level (0-100%) for the generated images. This parameter
      #
      # @param output_format [Symbol, OpenAI::Models::ImageEditParams::OutputFormat, nil] The format in which the generated images are returned. This parameter is
      #
      # @param partial_images [Integer, nil] The number of partial images to generate. This parameter is used for
      #
      # @param quality [Symbol, OpenAI::Models::ImageEditParams::Quality, nil] The quality of the image that will be generated. `high`, `medium` and `low` are
      #
      # @param response_format [Symbol, OpenAI::Models::ImageEditParams::ResponseFormat, nil] The format in which the generated images are returned. Must be one of `url` or `
      #
      # @param size [Symbol, OpenAI::Models::ImageEditParams::Size, nil] The size of the generated images. Must be one of `1024x1024`, `1536x1024` (lands
      #
      # @param user [String] A unique identifier representing your end-user, which can help OpenAI to monitor
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Internal::Stream<OpenAI::Models::ImageEditPartialImageEvent, OpenAI::Models::ImageEditCompletedEvent>]
      #
      # @see OpenAI::Models::ImageEditParams
      def edit_stream_raw(params)
        parsed, options = OpenAI::ImageEditParams.dump_request(params)
        unless parsed.fetch(:stream, true)
          message = "Please use `#edit` for the non-streaming use case."
          raise ArgumentError.new(message)
        end
        parsed.store(:stream, true)
        @client.request(
          method: :post,
          path: "images/edits",
          headers: {"content-type" => "multipart/form-data", "accept" => "text/event-stream"},
          body: parsed,
          stream: OpenAI::Internal::Stream,
          model: OpenAI::ImageEditStreamEvent,
          options: options
        )
      end

      # See {OpenAI::Resources::Images#generate_stream_raw} for streaming counterpart.
      #
      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::ImageGenerateParams} for more details.
      #
      # Creates an image given a prompt.
      # [Learn more](https://platform.openai.com/docs/guides/images).
      #
      # @overload generate(prompt:, background: nil, model: nil, moderation: nil, n: nil, output_compression: nil, output_format: nil, partial_images: nil, quality: nil, response_format: nil, size: nil, style: nil, user: nil, request_options: {})
      #
      # @param prompt [String] A text description of the desired image(s). The maximum length is 32000 characte
      #
      # @param background [Symbol, OpenAI::Models::ImageGenerateParams::Background, nil] Allows to set transparency for the background of the generated image(s).
      #
      # @param model [String, Symbol, OpenAI::Models::ImageModel, nil] The model to use for image generation. One of `dall-e-2`, `dall-e-3`, or `gpt-im
      #
      # @param moderation [Symbol, OpenAI::Models::ImageGenerateParams::Moderation, nil] Control the content-moderation level for images generated by `gpt-image-1`. Must
      #
      # @param n [Integer, nil] The number of images to generate. Must be between 1 and 10. For `dall-e-3`, only
      #
      # @param output_compression [Integer, nil] The compression level (0-100%) for the generated images. This parameter is only
      #
      # @param output_format [Symbol, OpenAI::Models::ImageGenerateParams::OutputFormat, nil] The format in which the generated images are returned. This parameter is only su
      #
      # @param partial_images [Integer, nil] The number of partial images to generate. This parameter is used for
      #
      # @param quality [Symbol, OpenAI::Models::ImageGenerateParams::Quality, nil] The quality of the image that will be generated.
      #
      # @param response_format [Symbol, OpenAI::Models::ImageGenerateParams::ResponseFormat, nil] The format in which generated images with `dall-e-2` and `dall-e-3` are returned
      #
      # @param size [Symbol, OpenAI::Models::ImageGenerateParams::Size, nil] The size of the generated images. Must be one of `1024x1024`, `1536x1024` (lands
      #
      # @param style [Symbol, OpenAI::Models::ImageGenerateParams::Style, nil] The style of the generated images. This parameter is only supported for `dall-e-
      #
      # @param user [String] A unique identifier representing your end-user, which can help OpenAI to monitor
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::ImagesResponse]
      #
      # @see OpenAI::Models::ImageGenerateParams
      def generate(params)
        parsed, options = OpenAI::ImageGenerateParams.dump_request(params)
        if parsed[:stream]
          message = "Please use `#generate_stream_raw` for the streaming use case."
          raise ArgumentError.new(message)
        end
        @client.request(
          method: :post,
          path: "images/generations",
          body: parsed,
          model: OpenAI::ImagesResponse,
          options: options
        )
      end

      # See {OpenAI::Resources::Images#generate} for non-streaming counterpart.
      #
      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::ImageGenerateParams} for more details.
      #
      # Creates an image given a prompt.
      # [Learn more](https://platform.openai.com/docs/guides/images).
      #
      # @overload generate_stream_raw(prompt:, background: nil, model: nil, moderation: nil, n: nil, output_compression: nil, output_format: nil, partial_images: nil, quality: nil, response_format: nil, size: nil, style: nil, user: nil, request_options: {})
      #
      # @param prompt [String] A text description of the desired image(s). The maximum length is 32000 characte
      #
      # @param background [Symbol, OpenAI::Models::ImageGenerateParams::Background, nil] Allows to set transparency for the background of the generated image(s).
      #
      # @param model [String, Symbol, OpenAI::Models::ImageModel, nil] The model to use for image generation. One of `dall-e-2`, `dall-e-3`, or `gpt-im
      #
      # @param moderation [Symbol, OpenAI::Models::ImageGenerateParams::Moderation, nil] Control the content-moderation level for images generated by `gpt-image-1`. Must
      #
      # @param n [Integer, nil] The number of images to generate. Must be between 1 and 10. For `dall-e-3`, only
      #
      # @param output_compression [Integer, nil] The compression level (0-100%) for the generated images. This parameter is only
      #
      # @param output_format [Symbol, OpenAI::Models::ImageGenerateParams::OutputFormat, nil] The format in which the generated images are returned. This parameter is only su
      #
      # @param partial_images [Integer, nil] The number of partial images to generate. This parameter is used for
      #
      # @param quality [Symbol, OpenAI::Models::ImageGenerateParams::Quality, nil] The quality of the image that will be generated.
      #
      # @param response_format [Symbol, OpenAI::Models::ImageGenerateParams::ResponseFormat, nil] The format in which generated images with `dall-e-2` and `dall-e-3` are returned
      #
      # @param size [Symbol, OpenAI::Models::ImageGenerateParams::Size, nil] The size of the generated images. Must be one of `1024x1024`, `1536x1024` (lands
      #
      # @param style [Symbol, OpenAI::Models::ImageGenerateParams::Style, nil] The style of the generated images. This parameter is only supported for `dall-e-
      #
      # @param user [String] A unique identifier representing your end-user, which can help OpenAI to monitor
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Internal::Stream<OpenAI::Models::ImageGenPartialImageEvent, OpenAI::Models::ImageGenCompletedEvent>]
      #
      # @see OpenAI::Models::ImageGenerateParams
      def generate_stream_raw(params)
        parsed, options = OpenAI::ImageGenerateParams.dump_request(params)
        unless parsed.fetch(:stream, true)
          message = "Please use `#generate` for the non-streaming use case."
          raise ArgumentError.new(message)
        end
        parsed.store(:stream, true)
        @client.request(
          method: :post,
          path: "images/generations",
          headers: {"accept" => "text/event-stream"},
          body: parsed,
          stream: OpenAI::Internal::Stream,
          model: OpenAI::ImageGenStreamEvent,
          options: options
        )
      end

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
      end
    end
  end
end
