# typed: strong

module OpenAI
  module Models
    class ImageEditPartialImageEvent < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias do
          T.any(OpenAI::ImageEditPartialImageEvent, OpenAI::Internal::AnyHash)
        end

      # Base64-encoded partial image data, suitable for rendering as an image.
      sig { returns(String) }
      attr_accessor :b64_json

      # The background setting for the requested edited image.
      sig do
        returns(OpenAI::ImageEditPartialImageEvent::Background::TaggedSymbol)
      end
      attr_accessor :background

      # The Unix timestamp when the event was created.
      sig { returns(Integer) }
      attr_accessor :created_at

      # The output format for the requested edited image.
      sig do
        returns(OpenAI::ImageEditPartialImageEvent::OutputFormat::TaggedSymbol)
      end
      attr_accessor :output_format

      # 0-based index for the partial image (streaming).
      sig { returns(Integer) }
      attr_accessor :partial_image_index

      # The quality setting for the requested edited image.
      sig { returns(OpenAI::ImageEditPartialImageEvent::Quality::TaggedSymbol) }
      attr_accessor :quality

      # The size of the requested edited image.
      sig { returns(OpenAI::ImageEditPartialImageEvent::Size::TaggedSymbol) }
      attr_accessor :size

      # The type of the event. Always `image_edit.partial_image`.
      sig { returns(Symbol) }
      attr_accessor :type

      # Emitted when a partial image is available during image editing streaming.
      sig do
        params(
          b64_json: String,
          background: OpenAI::ImageEditPartialImageEvent::Background::OrSymbol,
          created_at: Integer,
          output_format:
            OpenAI::ImageEditPartialImageEvent::OutputFormat::OrSymbol,
          partial_image_index: Integer,
          quality: OpenAI::ImageEditPartialImageEvent::Quality::OrSymbol,
          size: OpenAI::ImageEditPartialImageEvent::Size::OrSymbol,
          type: Symbol
        ).returns(T.attached_class)
      end
      def self.new(
        # Base64-encoded partial image data, suitable for rendering as an image.
        b64_json:,
        # The background setting for the requested edited image.
        background:,
        # The Unix timestamp when the event was created.
        created_at:,
        # The output format for the requested edited image.
        output_format:,
        # 0-based index for the partial image (streaming).
        partial_image_index:,
        # The quality setting for the requested edited image.
        quality:,
        # The size of the requested edited image.
        size:,
        # The type of the event. Always `image_edit.partial_image`.
        type: :"image_edit.partial_image"
      )
      end

      sig do
        override.returns(
          {
            b64_json: String,
            background:
              OpenAI::ImageEditPartialImageEvent::Background::TaggedSymbol,
            created_at: Integer,
            output_format:
              OpenAI::ImageEditPartialImageEvent::OutputFormat::TaggedSymbol,
            partial_image_index: Integer,
            quality: OpenAI::ImageEditPartialImageEvent::Quality::TaggedSymbol,
            size: OpenAI::ImageEditPartialImageEvent::Size::TaggedSymbol,
            type: Symbol
          }
        )
      end
      def to_hash
      end

      # The background setting for the requested edited image.
      module Background
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias do
            T.all(Symbol, OpenAI::ImageEditPartialImageEvent::Background)
          end
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        TRANSPARENT =
          T.let(
            :transparent,
            OpenAI::ImageEditPartialImageEvent::Background::TaggedSymbol
          )
        OPAQUE =
          T.let(
            :opaque,
            OpenAI::ImageEditPartialImageEvent::Background::TaggedSymbol
          )
        AUTO =
          T.let(
            :auto,
            OpenAI::ImageEditPartialImageEvent::Background::TaggedSymbol
          )

        sig do
          override.returns(
            T::Array[
              OpenAI::ImageEditPartialImageEvent::Background::TaggedSymbol
            ]
          )
        end
        def self.values
        end
      end

      # The output format for the requested edited image.
      module OutputFormat
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias do
            T.all(Symbol, OpenAI::ImageEditPartialImageEvent::OutputFormat)
          end
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        PNG =
          T.let(
            :png,
            OpenAI::ImageEditPartialImageEvent::OutputFormat::TaggedSymbol
          )
        WEBP =
          T.let(
            :webp,
            OpenAI::ImageEditPartialImageEvent::OutputFormat::TaggedSymbol
          )
        JPEG =
          T.let(
            :jpeg,
            OpenAI::ImageEditPartialImageEvent::OutputFormat::TaggedSymbol
          )

        sig do
          override.returns(
            T::Array[
              OpenAI::ImageEditPartialImageEvent::OutputFormat::TaggedSymbol
            ]
          )
        end
        def self.values
        end
      end

      # The quality setting for the requested edited image.
      module Quality
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias do
            T.all(Symbol, OpenAI::ImageEditPartialImageEvent::Quality)
          end
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        LOW =
          T.let(:low, OpenAI::ImageEditPartialImageEvent::Quality::TaggedSymbol)
        MEDIUM =
          T.let(
            :medium,
            OpenAI::ImageEditPartialImageEvent::Quality::TaggedSymbol
          )
        HIGH =
          T.let(
            :high,
            OpenAI::ImageEditPartialImageEvent::Quality::TaggedSymbol
          )
        AUTO =
          T.let(
            :auto,
            OpenAI::ImageEditPartialImageEvent::Quality::TaggedSymbol
          )

        sig do
          override.returns(
            T::Array[OpenAI::ImageEditPartialImageEvent::Quality::TaggedSymbol]
          )
        end
        def self.values
        end
      end

      # The size of the requested edited image.
      module Size
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias do
            T.all(Symbol, OpenAI::ImageEditPartialImageEvent::Size)
          end
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        SIZE_1024X1024 =
          T.let(
            :"1024x1024",
            OpenAI::ImageEditPartialImageEvent::Size::TaggedSymbol
          )
        SIZE_1024X1536 =
          T.let(
            :"1024x1536",
            OpenAI::ImageEditPartialImageEvent::Size::TaggedSymbol
          )
        SIZE_1536X1024 =
          T.let(
            :"1536x1024",
            OpenAI::ImageEditPartialImageEvent::Size::TaggedSymbol
          )
        AUTO =
          T.let(:auto, OpenAI::ImageEditPartialImageEvent::Size::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::ImageEditPartialImageEvent::Size::TaggedSymbol]
          )
        end
        def self.values
        end
      end
    end
  end
end
