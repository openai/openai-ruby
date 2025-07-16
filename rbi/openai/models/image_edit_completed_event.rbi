# typed: strong

module OpenAI
  module Models
    class ImageEditCompletedEvent < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias do
          T.any(OpenAI::ImageEditCompletedEvent, OpenAI::Internal::AnyHash)
        end

      # Base64-encoded final edited image data, suitable for rendering as an image.
      sig { returns(String) }
      attr_accessor :b64_json

      # The background setting for the edited image.
      sig { returns(OpenAI::ImageEditCompletedEvent::Background::TaggedSymbol) }
      attr_accessor :background

      # The Unix timestamp when the event was created.
      sig { returns(Integer) }
      attr_accessor :created_at

      # The output format for the edited image.
      sig do
        returns(OpenAI::ImageEditCompletedEvent::OutputFormat::TaggedSymbol)
      end
      attr_accessor :output_format

      # The quality setting for the edited image.
      sig { returns(OpenAI::ImageEditCompletedEvent::Quality::TaggedSymbol) }
      attr_accessor :quality

      # The size of the edited image.
      sig { returns(OpenAI::ImageEditCompletedEvent::Size::TaggedSymbol) }
      attr_accessor :size

      # The type of the event. Always `image_edit.completed`.
      sig { returns(Symbol) }
      attr_accessor :type

      # For `gpt-image-1` only, the token usage information for the image generation.
      sig { returns(OpenAI::ImageEditCompletedEvent::Usage) }
      attr_reader :usage

      sig { params(usage: OpenAI::ImageEditCompletedEvent::Usage::OrHash).void }
      attr_writer :usage

      # Emitted when image editing has completed and the final image is available.
      sig do
        params(
          b64_json: String,
          background: OpenAI::ImageEditCompletedEvent::Background::OrSymbol,
          created_at: Integer,
          output_format:
            OpenAI::ImageEditCompletedEvent::OutputFormat::OrSymbol,
          quality: OpenAI::ImageEditCompletedEvent::Quality::OrSymbol,
          size: OpenAI::ImageEditCompletedEvent::Size::OrSymbol,
          usage: OpenAI::ImageEditCompletedEvent::Usage::OrHash,
          type: Symbol
        ).returns(T.attached_class)
      end
      def self.new(
        # Base64-encoded final edited image data, suitable for rendering as an image.
        b64_json:,
        # The background setting for the edited image.
        background:,
        # The Unix timestamp when the event was created.
        created_at:,
        # The output format for the edited image.
        output_format:,
        # The quality setting for the edited image.
        quality:,
        # The size of the edited image.
        size:,
        # For `gpt-image-1` only, the token usage information for the image generation.
        usage:,
        # The type of the event. Always `image_edit.completed`.
        type: :"image_edit.completed"
      )
      end

      sig do
        override.returns(
          {
            b64_json: String,
            background:
              OpenAI::ImageEditCompletedEvent::Background::TaggedSymbol,
            created_at: Integer,
            output_format:
              OpenAI::ImageEditCompletedEvent::OutputFormat::TaggedSymbol,
            quality: OpenAI::ImageEditCompletedEvent::Quality::TaggedSymbol,
            size: OpenAI::ImageEditCompletedEvent::Size::TaggedSymbol,
            type: Symbol,
            usage: OpenAI::ImageEditCompletedEvent::Usage
          }
        )
      end
      def to_hash
      end

      # The background setting for the edited image.
      module Background
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias do
            T.all(Symbol, OpenAI::ImageEditCompletedEvent::Background)
          end
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        TRANSPARENT =
          T.let(
            :transparent,
            OpenAI::ImageEditCompletedEvent::Background::TaggedSymbol
          )
        OPAQUE =
          T.let(
            :opaque,
            OpenAI::ImageEditCompletedEvent::Background::TaggedSymbol
          )
        AUTO =
          T.let(
            :auto,
            OpenAI::ImageEditCompletedEvent::Background::TaggedSymbol
          )

        sig do
          override.returns(
            T::Array[OpenAI::ImageEditCompletedEvent::Background::TaggedSymbol]
          )
        end
        def self.values
        end
      end

      # The output format for the edited image.
      module OutputFormat
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias do
            T.all(Symbol, OpenAI::ImageEditCompletedEvent::OutputFormat)
          end
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        PNG =
          T.let(
            :png,
            OpenAI::ImageEditCompletedEvent::OutputFormat::TaggedSymbol
          )
        WEBP =
          T.let(
            :webp,
            OpenAI::ImageEditCompletedEvent::OutputFormat::TaggedSymbol
          )
        JPEG =
          T.let(
            :jpeg,
            OpenAI::ImageEditCompletedEvent::OutputFormat::TaggedSymbol
          )

        sig do
          override.returns(
            T::Array[
              OpenAI::ImageEditCompletedEvent::OutputFormat::TaggedSymbol
            ]
          )
        end
        def self.values
        end
      end

      # The quality setting for the edited image.
      module Quality
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias do
            T.all(Symbol, OpenAI::ImageEditCompletedEvent::Quality)
          end
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        LOW =
          T.let(:low, OpenAI::ImageEditCompletedEvent::Quality::TaggedSymbol)
        MEDIUM =
          T.let(:medium, OpenAI::ImageEditCompletedEvent::Quality::TaggedSymbol)
        HIGH =
          T.let(:high, OpenAI::ImageEditCompletedEvent::Quality::TaggedSymbol)
        AUTO =
          T.let(:auto, OpenAI::ImageEditCompletedEvent::Quality::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::ImageEditCompletedEvent::Quality::TaggedSymbol]
          )
        end
        def self.values
        end
      end

      # The size of the edited image.
      module Size
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::ImageEditCompletedEvent::Size) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        SIZE_1024X1024 =
          T.let(
            :"1024x1024",
            OpenAI::ImageEditCompletedEvent::Size::TaggedSymbol
          )
        SIZE_1024X1536 =
          T.let(
            :"1024x1536",
            OpenAI::ImageEditCompletedEvent::Size::TaggedSymbol
          )
        SIZE_1536X1024 =
          T.let(
            :"1536x1024",
            OpenAI::ImageEditCompletedEvent::Size::TaggedSymbol
          )
        AUTO = T.let(:auto, OpenAI::ImageEditCompletedEvent::Size::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::ImageEditCompletedEvent::Size::TaggedSymbol]
          )
        end
        def self.values
        end
      end

      class Usage < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::ImageEditCompletedEvent::Usage,
              OpenAI::Internal::AnyHash
            )
          end

        # The number of tokens (images and text) in the input prompt.
        sig { returns(Integer) }
        attr_accessor :input_tokens

        # The input tokens detailed information for the image generation.
        sig do
          returns(OpenAI::ImageEditCompletedEvent::Usage::InputTokensDetails)
        end
        attr_reader :input_tokens_details

        sig do
          params(
            input_tokens_details:
              OpenAI::ImageEditCompletedEvent::Usage::InputTokensDetails::OrHash
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
              OpenAI::ImageEditCompletedEvent::Usage::InputTokensDetails::OrHash,
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
                OpenAI::ImageEditCompletedEvent::Usage::InputTokensDetails,
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
                OpenAI::ImageEditCompletedEvent::Usage::InputTokensDetails,
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
