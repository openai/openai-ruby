# typed: strong

module OpenAI
  module Models
    class ImageGenPartialImageEvent < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias do
          T.any(OpenAI::ImageGenPartialImageEvent, OpenAI::Internal::AnyHash)
        end

      # Base64-encoded partial image data, suitable for rendering as an image.
      sig { returns(String) }
      attr_accessor :b64_json

      # The background setting for the requested image.
      sig do
        returns(OpenAI::ImageGenPartialImageEvent::Background::TaggedSymbol)
      end
      attr_accessor :background

      # The Unix timestamp when the event was created.
      sig { returns(Integer) }
      attr_accessor :created_at

      # The output format for the requested image.
      sig do
        returns(OpenAI::ImageGenPartialImageEvent::OutputFormat::TaggedSymbol)
      end
      attr_accessor :output_format

      # 0-based index for the partial image (streaming).
      sig { returns(Integer) }
      attr_accessor :partial_image_index

      # The quality setting for the requested image.
      sig { returns(OpenAI::ImageGenPartialImageEvent::Quality::TaggedSymbol) }
      attr_accessor :quality

      # The size of the requested image.
      sig { returns(OpenAI::ImageGenPartialImageEvent::Size::TaggedSymbol) }
      attr_accessor :size

      # The type of the event. Always `image_generation.partial_image`.
      sig { returns(Symbol) }
      attr_accessor :type

      # Emitted when a partial image is available during image generation streaming.
      sig do
        params(
          b64_json: String,
          background: OpenAI::ImageGenPartialImageEvent::Background::OrSymbol,
          created_at: Integer,
          output_format:
            OpenAI::ImageGenPartialImageEvent::OutputFormat::OrSymbol,
          partial_image_index: Integer,
          quality: OpenAI::ImageGenPartialImageEvent::Quality::OrSymbol,
          size: OpenAI::ImageGenPartialImageEvent::Size::OrSymbol,
          type: Symbol
        ).returns(T.attached_class)
      end
      def self.new(
        # Base64-encoded partial image data, suitable for rendering as an image.
        b64_json:,
        # The background setting for the requested image.
        background:,
        # The Unix timestamp when the event was created.
        created_at:,
        # The output format for the requested image.
        output_format:,
        # 0-based index for the partial image (streaming).
        partial_image_index:,
        # The quality setting for the requested image.
        quality:,
        # The size of the requested image.
        size:,
        # The type of the event. Always `image_generation.partial_image`.
        type: :"image_generation.partial_image"
      )
      end

      sig do
        override.returns(
          {
            b64_json: String,
            background:
              OpenAI::ImageGenPartialImageEvent::Background::TaggedSymbol,
            created_at: Integer,
            output_format:
              OpenAI::ImageGenPartialImageEvent::OutputFormat::TaggedSymbol,
            partial_image_index: Integer,
            quality: OpenAI::ImageGenPartialImageEvent::Quality::TaggedSymbol,
            size: OpenAI::ImageGenPartialImageEvent::Size::TaggedSymbol,
            type: Symbol
          }
        )
      end
      def to_hash
      end

      # The background setting for the requested image.
      module Background
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias do
            T.all(Symbol, OpenAI::ImageGenPartialImageEvent::Background)
          end
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        TRANSPARENT =
          T.let(
            :transparent,
            OpenAI::ImageGenPartialImageEvent::Background::TaggedSymbol
          )
        OPAQUE =
          T.let(
            :opaque,
            OpenAI::ImageGenPartialImageEvent::Background::TaggedSymbol
          )
        AUTO =
          T.let(
            :auto,
            OpenAI::ImageGenPartialImageEvent::Background::TaggedSymbol
          )

        sig do
          override.returns(
            T::Array[
              OpenAI::ImageGenPartialImageEvent::Background::TaggedSymbol
            ]
          )
        end
        def self.values
        end
      end

      # The output format for the requested image.
      module OutputFormat
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias do
            T.all(Symbol, OpenAI::ImageGenPartialImageEvent::OutputFormat)
          end
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        PNG =
          T.let(
            :png,
            OpenAI::ImageGenPartialImageEvent::OutputFormat::TaggedSymbol
          )
        WEBP =
          T.let(
            :webp,
            OpenAI::ImageGenPartialImageEvent::OutputFormat::TaggedSymbol
          )
        JPEG =
          T.let(
            :jpeg,
            OpenAI::ImageGenPartialImageEvent::OutputFormat::TaggedSymbol
          )

        sig do
          override.returns(
            T::Array[
              OpenAI::ImageGenPartialImageEvent::OutputFormat::TaggedSymbol
            ]
          )
        end
        def self.values
        end
      end

      # The quality setting for the requested image.
      module Quality
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias do
            T.all(Symbol, OpenAI::ImageGenPartialImageEvent::Quality)
          end
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        LOW =
          T.let(:low, OpenAI::ImageGenPartialImageEvent::Quality::TaggedSymbol)
        MEDIUM =
          T.let(
            :medium,
            OpenAI::ImageGenPartialImageEvent::Quality::TaggedSymbol
          )
        HIGH =
          T.let(:high, OpenAI::ImageGenPartialImageEvent::Quality::TaggedSymbol)
        AUTO =
          T.let(:auto, OpenAI::ImageGenPartialImageEvent::Quality::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::ImageGenPartialImageEvent::Quality::TaggedSymbol]
          )
        end
        def self.values
        end
      end

      # The size of the requested image.
      module Size
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias do
            T.all(Symbol, OpenAI::ImageGenPartialImageEvent::Size)
          end
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        SIZE_1024X1024 =
          T.let(
            :"1024x1024",
            OpenAI::ImageGenPartialImageEvent::Size::TaggedSymbol
          )
        SIZE_1024X1536 =
          T.let(
            :"1024x1536",
            OpenAI::ImageGenPartialImageEvent::Size::TaggedSymbol
          )
        SIZE_1536X1024 =
          T.let(
            :"1536x1024",
            OpenAI::ImageGenPartialImageEvent::Size::TaggedSymbol
          )
        AUTO =
          T.let(:auto, OpenAI::ImageGenPartialImageEvent::Size::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::ImageGenPartialImageEvent::Size::TaggedSymbol]
          )
        end
        def self.values
        end
      end
    end
  end
end
