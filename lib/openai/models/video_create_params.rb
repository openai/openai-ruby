# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Videos#create
    class VideoCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute prompt
      #   Text prompt that describes the video to generate.
      #
      #   @return [String]
      required :prompt, String

      # @!attribute input_reference
      #   Optional reference asset upload or reference object that guides generation.
      #
      #   @return [Pathname, StringIO, IO, String, OpenAI::FilePart, OpenAI::Models::VideoCreateParams::InputReference::ImageRefParam2, nil]
      optional :input_reference, union: -> { OpenAI::VideoCreateParams::InputReference }

      # @!attribute model
      #   The video generation model to use (allowed values: sora-2, sora-2-pro). Defaults
      #   to `sora-2`.
      #
      #   @return [String, Symbol, OpenAI::Models::VideoModel, nil]
      optional :model, union: -> { OpenAI::VideoModel }

      # @!attribute seconds
      #   Clip duration in seconds (allowed values: 4, 8, 12). Defaults to 4 seconds.
      #
      #   @return [Symbol, OpenAI::Models::VideoSeconds, nil]
      optional :seconds, enum: -> { OpenAI::VideoSeconds }

      # @!attribute size
      #   Output resolution formatted as width x height (allowed values: 720x1280,
      #   1280x720, 1024x1792, 1792x1024). Defaults to 720x1280.
      #
      #   @return [Symbol, OpenAI::Models::VideoSize, nil]
      optional :size, enum: -> { OpenAI::VideoSize }

      # @!method initialize(prompt:, input_reference: nil, model: nil, seconds: nil, size: nil, request_options: {})
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::VideoCreateParams} for more details.
      #
      #   @param prompt [String] Text prompt that describes the video to generate.
      #
      #   @param input_reference [Pathname, StringIO, IO, String, OpenAI::FilePart, OpenAI::Models::VideoCreateParams::InputReference::ImageRefParam2] Optional reference asset upload or reference object that guides generation.
      #
      #   @param model [String, Symbol, OpenAI::Models::VideoModel] The video generation model to use (allowed values: sora-2, sora-2-pro). Defaults
      #
      #   @param seconds [Symbol, OpenAI::Models::VideoSeconds] Clip duration in seconds (allowed values: 4, 8, 12). Defaults to 4 seconds.
      #
      #   @param size [Symbol, OpenAI::Models::VideoSize] Output resolution formatted as width x height (allowed values: 720x1280, 1280x72
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

      # Optional reference asset upload or reference object that guides generation.
      module InputReference
        extend OpenAI::Internal::Type::Union

        # Optional reference asset upload or reference object that guides generation.
        variant OpenAI::Internal::Type::FileInput

        variant -> { OpenAI::VideoCreateParams::InputReference::ImageRefParam2 }

        class ImageRefParam2 < OpenAI::Internal::Type::BaseModel
          # @!attribute file_id
          #
          #   @return [String, nil]
          optional :file_id, String

          # @!attribute image_url
          #   A fully qualified URL or base64-encoded data URL.
          #
          #   @return [String, nil]
          optional :image_url, String

          # @!method initialize(file_id: nil, image_url: nil)
          #   @param file_id [String]
          #
          #   @param image_url [String] A fully qualified URL or base64-encoded data URL.
        end

        # @!method self.variants
        #   @return [Array(StringIO, OpenAI::Models::VideoCreateParams::InputReference::ImageRefParam2)]
      end
    end
  end
end
