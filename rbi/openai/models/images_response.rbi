# typed: strong

module OpenAI
  module Models
    class ImagesResponse < OpenAI::Internal::Type::BaseModel
      # The Unix timestamp (in seconds) of when the image was created.
      sig { returns(Integer) }
      attr_accessor :created

      # The list of generated images.
      sig { returns(T.nilable(T::Array[OpenAI::Models::Image])) }
      attr_reader :data

      sig { params(data: T::Array[T.any(OpenAI::Models::Image, OpenAI::Internal::AnyHash)]).void }
      attr_writer :data

      # For `gpt-image-1` only, the token usage information for the image generation.
      sig { returns(T.nilable(OpenAI::Models::ImagesResponse::Usage)) }
      attr_reader :usage

      sig { params(usage: T.any(OpenAI::Models::ImagesResponse::Usage, OpenAI::Internal::AnyHash)).void }
      attr_writer :usage

      # The response from the image generation endpoint.
      sig do
        params(
          created: Integer,
          data: T::Array[T.any(OpenAI::Models::Image, OpenAI::Internal::AnyHash)],
          usage: T.any(OpenAI::Models::ImagesResponse::Usage, OpenAI::Internal::AnyHash)
        )
          .returns(T.attached_class)
      end
      def self.new(
        # The Unix timestamp (in seconds) of when the image was created.
        created:,
        # The list of generated images.
        data: nil,
        # For `gpt-image-1` only, the token usage information for the image generation.
        usage: nil
      ); end
      sig do
        override
          .returns(
            {created: Integer, data: T::Array[OpenAI::Models::Image], usage: OpenAI::Models::ImagesResponse::Usage}
          )
      end
      def to_hash; end

      class Usage < OpenAI::Internal::Type::BaseModel
        # The number of tokens (images and text) in the input prompt.
        sig { returns(Integer) }
        attr_accessor :input_tokens

        # The input tokens detailed information for the image generation.
        sig { returns(OpenAI::Models::ImagesResponse::Usage::InputTokensDetails) }
        attr_reader :input_tokens_details

        sig do
          params(
            input_tokens_details: T.any(OpenAI::Models::ImagesResponse::Usage::InputTokensDetails, OpenAI::Internal::AnyHash)
          )
            .void
        end
        attr_writer :input_tokens_details

        # The number of image tokens in the output image.
        sig { returns(Integer) }
        attr_accessor :output_tokens

        # The total number of tokens (images and text) used for the image generation.
        sig { returns(Integer) }
        attr_accessor :total_tokens

        # For `gpt-image-1` only, the token usage information for the image generation.
        sig do
          params(
            input_tokens: Integer,
            input_tokens_details: T.any(OpenAI::Models::ImagesResponse::Usage::InputTokensDetails, OpenAI::Internal::AnyHash),
            output_tokens: Integer,
            total_tokens: Integer
          )
            .returns(T.attached_class)
        end
        def self.new(
          # The number of tokens (images and text) in the input prompt.
          input_tokens:,
          # The input tokens detailed information for the image generation.
          input_tokens_details:,
          # The number of image tokens in the output image.
          output_tokens:,
          # The total number of tokens (images and text) used for the image generation.
          total_tokens:
        ); end
        sig do
          override
            .returns(
              {
                input_tokens: Integer,
                input_tokens_details: OpenAI::Models::ImagesResponse::Usage::InputTokensDetails,
                output_tokens: Integer,
                total_tokens: Integer
              }
            )
        end
        def to_hash; end

        class InputTokensDetails < OpenAI::Internal::Type::BaseModel
          # The number of image tokens in the input prompt.
          sig { returns(Integer) }
          attr_accessor :image_tokens

          # The number of text tokens in the input prompt.
          sig { returns(Integer) }
          attr_accessor :text_tokens

          # The input tokens detailed information for the image generation.
          sig { params(image_tokens: Integer, text_tokens: Integer).returns(T.attached_class) }
          def self.new(
            # The number of image tokens in the input prompt.
            image_tokens:,
            # The number of text tokens in the input prompt.
            text_tokens:
          ); end
          sig { override.returns({image_tokens: Integer, text_tokens: Integer}) }
          def to_hash; end
        end
      end
    end
  end
end
