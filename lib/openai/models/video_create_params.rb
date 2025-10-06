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
      #   Optional image reference that guides generation.
      #
      #   @return [Pathname, StringIO, IO, String, OpenAI::FilePart, nil]
      optional :input_reference, OpenAI::Internal::Type::FileInput

      # @!attribute model
      #   The video generation model to use. Defaults to `sora-2`.
      #
      #   @return [Symbol, OpenAI::Models::VideoModel, nil]
      optional :model, enum: -> { OpenAI::VideoModel }

      # @!attribute seconds
      #   Clip duration in seconds. Defaults to 4 seconds.
      #
      #   @return [Symbol, OpenAI::Models::VideoSeconds, nil]
      optional :seconds, enum: -> { OpenAI::VideoSeconds }

      # @!attribute size
      #   Output resolution formatted as width x height. Defaults to 720x1280.
      #
      #   @return [Symbol, OpenAI::Models::VideoSize, nil]
      optional :size, enum: -> { OpenAI::VideoSize }

      # @!method initialize(prompt:, input_reference: nil, model: nil, seconds: nil, size: nil, request_options: {})
      #   @param prompt [String] Text prompt that describes the video to generate.
      #
      #   @param input_reference [Pathname, StringIO, IO, String, OpenAI::FilePart] Optional image reference that guides generation.
      #
      #   @param model [Symbol, OpenAI::Models::VideoModel] The video generation model to use. Defaults to `sora-2`.
      #
      #   @param seconds [Symbol, OpenAI::Models::VideoSeconds] Clip duration in seconds. Defaults to 4 seconds.
      #
      #   @param size [Symbol, OpenAI::Models::VideoSize] Output resolution formatted as width x height. Defaults to 720x1280.
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
    end
  end
end
