# typed: strong

module OpenAI
  module Models
    class VideoCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash =
        T.type_alias do
          T.any(OpenAI::VideoCreateParams, OpenAI::Internal::AnyHash)
        end

      # Text prompt that describes the video to generate.
      sig { returns(String) }
      attr_accessor :prompt

      # Optional image reference that guides generation.
      sig { returns(T.nilable(OpenAI::Internal::FileInput)) }
      attr_reader :input_reference

      sig { params(input_reference: OpenAI::Internal::FileInput).void }
      attr_writer :input_reference

      # The video generation model to use (allowed values: sora-2, sora-2-pro). Defaults
      # to `sora-2`.
      sig { returns(T.nilable(T.any(String, OpenAI::VideoModel::OrSymbol))) }
      attr_reader :model

      sig { params(model: T.any(String, OpenAI::VideoModel::OrSymbol)).void }
      attr_writer :model

      # Clip duration in seconds (allowed values: 4, 8, 12). Defaults to 4 seconds.
      sig { returns(T.nilable(OpenAI::VideoSeconds::OrSymbol)) }
      attr_reader :seconds

      sig { params(seconds: OpenAI::VideoSeconds::OrSymbol).void }
      attr_writer :seconds

      # Output resolution formatted as width x height (allowed values: 720x1280,
      # 1280x720, 1024x1792, 1792x1024). Defaults to 720x1280.
      sig { returns(T.nilable(OpenAI::VideoSize::OrSymbol)) }
      attr_reader :size

      sig { params(size: OpenAI::VideoSize::OrSymbol).void }
      attr_writer :size

      sig do
        params(
          prompt: String,
          input_reference: OpenAI::Internal::FileInput,
          model: T.any(String, OpenAI::VideoModel::OrSymbol),
          seconds: OpenAI::VideoSeconds::OrSymbol,
          size: OpenAI::VideoSize::OrSymbol,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(
        # Text prompt that describes the video to generate.
        prompt:,
        # Optional image reference that guides generation.
        input_reference: nil,
        # The video generation model to use (allowed values: sora-2, sora-2-pro). Defaults
        # to `sora-2`.
        model: nil,
        # Clip duration in seconds (allowed values: 4, 8, 12). Defaults to 4 seconds.
        seconds: nil,
        # Output resolution formatted as width x height (allowed values: 720x1280,
        # 1280x720, 1024x1792, 1792x1024). Defaults to 720x1280.
        size: nil,
        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            prompt: String,
            input_reference: OpenAI::Internal::FileInput,
            model: T.any(String, OpenAI::VideoModel::OrSymbol),
            seconds: OpenAI::VideoSeconds::OrSymbol,
            size: OpenAI::VideoSize::OrSymbol,
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end
    end
  end
end
