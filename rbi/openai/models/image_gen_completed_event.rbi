# typed: strong

module OpenAI
  module Models
    class ImageGenCompletedEvent < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias do
          T.any(OpenAI::ImageGenCompletedEvent, OpenAI::Internal::AnyHash)
        end

      # Base64-encoded image data, suitable for rendering as an image.
      sig { returns(String) }
      attr_accessor :b64_json

      # The background setting for the generated image.
      sig { returns(OpenAI::ImageGenCompletedEvent::Background::TaggedSymbol) }
      attr_accessor :background

      # The Unix timestamp when the event was created.
      sig { returns(Integer) }
      attr_accessor :created_at

      # The output format for the generated image.
      sig do
        returns(OpenAI::ImageGenCompletedEvent::OutputFormat::TaggedSymbol)
      end
      attr_accessor :output_format

      # The quality setting for the generated image.
      sig { returns(OpenAI::ImageGenCompletedEvent::Quality::TaggedSymbol) }
      attr_accessor :quality

      # The size of the generated image.
      sig { returns(OpenAI::ImageGenCompletedEvent::Size::TaggedSymbol) }
      attr_accessor :size

      # The type of the event. Always `image_generation.completed`.
      sig { returns(Symbol) }
      attr_accessor :type

      # For `gpt-image-1` only, the token usage information for the image generation.
      sig { returns(OpenAI::ImageGenCompletedEvent::Usage) }
      attr_reader :usage

      sig { params(usage: OpenAI::ImageGenCompletedEvent::Usage::OrHash).void }
      attr_writer :usage

      # Emitted when image generation has completed and the final image is available.
      sig do
        params(
          b64_json: String,
          background: OpenAI::ImageGenCompletedEvent::Background::OrSymbol,
          created_at: Integer,
          output_format: OpenAI::ImageGenCompletedEvent::OutputFormat::OrSymbol,
          quality: OpenAI::ImageGenCompletedEvent::Quality::OrSymbol,
          size: OpenAI::ImageGenCompletedEvent::Size::OrSymbol,
          usage: OpenAI::ImageGenCompletedEvent::Usage::OrHash,
          type: Symbol
        ).returns(T.attached_class)
      end
      def self.new(
        # Base64-encoded image data, suitable for rendering as an image.
        b64_json:,
        # The background setting for the generated image.
        background:,
        # The Unix timestamp when the event was created.
        created_at:,
        # The output format for the generated image.
        output_format:,
        # The quality setting for the generated image.
        quality:,
        # The size of the generated image.
        size:,
        # For `gpt-image-1` only, the token usage information for the image generation.
        usage:,
        # The type of the event. Always `image_generation.completed`.
        type: :"image_generation.completed"
      )
      end

      sig do
        override.returns(
          {
            b64_json: String,
            background:
              OpenAI::ImageGenCompletedEvent::Background::TaggedSymbol,
            created_at: Integer,
            output_format:
              OpenAI::ImageGenCompletedEvent::OutputFormat::TaggedSymbol,
            quality: OpenAI::ImageGenCompletedEvent::Quality::TaggedSymbol,
            size: OpenAI::ImageGenCompletedEvent::Size::TaggedSymbol,
            type: Symbol,
            usage: OpenAI::ImageGenCompletedEvent::Usage
          }
        )
      end
      def to_hash
      end

      # The background setting for the generated image.
      module Background
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias do
            T.all(Symbol, OpenAI::ImageGenCompletedEvent::Background)
          end
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        TRANSPARENT =
          T.let(
            :transparent,
            OpenAI::ImageGenCompletedEvent::Background::TaggedSymbol
          )
        OPAQUE =
          T.let(
            :opaque,
            OpenAI::ImageGenCompletedEvent::Background::TaggedSymbol
          )
        AUTO =
          T.let(:auto, OpenAI::ImageGenCompletedEvent::Background::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::ImageGenCompletedEvent::Background::TaggedSymbol]
          )
        end
        def self.values
        end
      end

      # The output format for the generated image.
      module OutputFormat
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias do
            T.all(Symbol, OpenAI::ImageGenCompletedEvent::OutputFormat)
          end
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        PNG =
          T.let(
            :png,
            OpenAI::ImageGenCompletedEvent::OutputFormat::TaggedSymbol
          )
        WEBP =
          T.let(
            :webp,
            OpenAI::ImageGenCompletedEvent::OutputFormat::TaggedSymbol
          )
        JPEG =
          T.let(
            :jpeg,
            OpenAI::ImageGenCompletedEvent::OutputFormat::TaggedSymbol
          )

        sig do
          override.returns(
            T::Array[OpenAI::ImageGenCompletedEvent::OutputFormat::TaggedSymbol]
          )
        end
        def self.values
        end
      end

      # The quality setting for the generated image.
      module Quality
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias do
            T.all(Symbol, OpenAI::ImageGenCompletedEvent::Quality)
          end
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        LOW = T.let(:low, OpenAI::ImageGenCompletedEvent::Quality::TaggedSymbol)
        MEDIUM =
          T.let(:medium, OpenAI::ImageGenCompletedEvent::Quality::TaggedSymbol)
        HIGH =
          T.let(:high, OpenAI::ImageGenCompletedEvent::Quality::TaggedSymbol)
        AUTO =
          T.let(:auto, OpenAI::ImageGenCompletedEvent::Quality::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::ImageGenCompletedEvent::Quality::TaggedSymbol]
          )
        end
        def self.values
        end
      end

      # The size of the generated image.
      module Size
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::ImageGenCompletedEvent::Size) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        SIZE_1024X1024 =
          T.let(
            :"1024x1024",
            OpenAI::ImageGenCompletedEvent::Size::TaggedSymbol
          )
        SIZE_1024X1536 =
          T.let(
            :"1024x1536",
            OpenAI::ImageGenCompletedEvent::Size::TaggedSymbol
          )
        SIZE_1536X1024 =
          T.let(
            :"1536x1024",
            OpenAI::ImageGenCompletedEvent::Size::TaggedSymbol
          )
        AUTO = T.let(:auto, OpenAI::ImageGenCompletedEvent::Size::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::ImageGenCompletedEvent::Size::TaggedSymbol]
          )
        end
        def self.values
        end
      end

      class Usage < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::ImageGenCompletedEvent::Usage,
              OpenAI::Internal::AnyHash
            )
          end

        # The number of tokens (images and text) in the input prompt.
        sig { returns(Integer) }
        attr_accessor :input_tokens

        # The input tokens detailed information for the image generation.
        sig do
          returns(OpenAI::ImageGenCompletedEvent::Usage::InputTokensDetails)
        end
        attr_reader :input_tokens_details

        sig do
          params(
            input_tokens_details:
              OpenAI::ImageGenCompletedEvent::Usage::InputTokensDetails::OrHash
          ).void
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
            input_tokens_details:
              OpenAI::ImageGenCompletedEvent::Usage::InputTokensDetails::OrHash,
            output_tokens: Integer,
            total_tokens: Integer
          ).returns(T.attached_class)
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
        )
        end

        sig do
          override.returns(
            {
              input_tokens: Integer,
              input_tokens_details:
                OpenAI::ImageGenCompletedEvent::Usage::InputTokensDetails,
              output_tokens: Integer,
              total_tokens: Integer
            }
          )
        end
        def to_hash
        end

        class InputTokensDetails < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::ImageGenCompletedEvent::Usage::InputTokensDetails,
                OpenAI::Internal::AnyHash
              )
            end

          # The number of image tokens in the input prompt.
          sig { returns(Integer) }
          attr_accessor :image_tokens

          # The number of text tokens in the input prompt.
          sig { returns(Integer) }
          attr_accessor :text_tokens

          # The input tokens detailed information for the image generation.
          sig do
            params(image_tokens: Integer, text_tokens: Integer).returns(
              T.attached_class
            )
          end
          def self.new(
            # The number of image tokens in the input prompt.
            image_tokens:,
            # The number of text tokens in the input prompt.
            text_tokens:
          )
          end

          sig do
            override.returns({ image_tokens: Integer, text_tokens: Integer })
          end
          def to_hash
          end
        end
      end
    end
  end
end
