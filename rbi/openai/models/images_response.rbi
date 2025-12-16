# typed: strong

module OpenAI
  module Models
    class ImagesResponse < OpenAI::Internal::Type::BaseModel
      OrHash =
        T.type_alias do
          T.any(OpenAI::ImagesResponse, OpenAI::Internal::AnyHash)
        end

      # The Unix timestamp (in seconds) of when the image was created.
      sig { returns(Integer) }
      attr_accessor :created

      # The background parameter used for the image generation. Either `transparent` or
      # `opaque`.
      sig do
        returns(T.nilable(OpenAI::ImagesResponse::Background::TaggedSymbol))
      end
      attr_reader :background

      sig do
        params(background: OpenAI::ImagesResponse::Background::OrSymbol).void
      end
      attr_writer :background

      # The list of generated images.
      sig { returns(T.nilable(T::Array[OpenAI::Image])) }
      attr_reader :data

      sig { params(data: T::Array[OpenAI::Image::OrHash]).void }
      attr_writer :data

      # The output format of the image generation. Either `png`, `webp`, or `jpeg`.
      sig do
        returns(T.nilable(OpenAI::ImagesResponse::OutputFormat::TaggedSymbol))
      end
      attr_reader :output_format

      sig do
        params(
          output_format: OpenAI::ImagesResponse::OutputFormat::OrSymbol
        ).void
      end
      attr_writer :output_format

      # The quality of the image generated. Either `low`, `medium`, or `high`.
      sig { returns(T.nilable(OpenAI::ImagesResponse::Quality::TaggedSymbol)) }
      attr_reader :quality

      sig { params(quality: OpenAI::ImagesResponse::Quality::OrSymbol).void }
      attr_writer :quality

      # The size of the image generated. Either `1024x1024`, `1024x1536`, or
      # `1536x1024`.
      sig { returns(T.nilable(OpenAI::ImagesResponse::Size::TaggedSymbol)) }
      attr_reader :size

      sig { params(size: OpenAI::ImagesResponse::Size::OrSymbol).void }
      attr_writer :size

      # For `gpt-image-1` only, the token usage information for the image generation.
      sig { returns(T.nilable(OpenAI::ImagesResponse::Usage)) }
      attr_reader :usage

      sig { params(usage: OpenAI::ImagesResponse::Usage::OrHash).void }
      attr_writer :usage

      # The response from the image generation endpoint.
      sig do
        params(
          created: Integer,
          background: OpenAI::ImagesResponse::Background::OrSymbol,
          data: T::Array[OpenAI::Image::OrHash],
          output_format: OpenAI::ImagesResponse::OutputFormat::OrSymbol,
          quality: OpenAI::ImagesResponse::Quality::OrSymbol,
          size: OpenAI::ImagesResponse::Size::OrSymbol,
          usage: OpenAI::ImagesResponse::Usage::OrHash
        ).returns(T.attached_class)
      end
      def self.new(
        # The Unix timestamp (in seconds) of when the image was created.
        created:,
        # The background parameter used for the image generation. Either `transparent` or
        # `opaque`.
        background: nil,
        # The list of generated images.
        data: nil,
        # The output format of the image generation. Either `png`, `webp`, or `jpeg`.
        output_format: nil,
        # The quality of the image generated. Either `low`, `medium`, or `high`.
        quality: nil,
        # The size of the image generated. Either `1024x1024`, `1024x1536`, or
        # `1536x1024`.
        size: nil,
        # For `gpt-image-1` only, the token usage information for the image generation.
        usage: nil
      )
      end

      sig do
        override.returns(
          {
            created: Integer,
            background: OpenAI::ImagesResponse::Background::TaggedSymbol,
            data: T::Array[OpenAI::Image],
            output_format: OpenAI::ImagesResponse::OutputFormat::TaggedSymbol,
            quality: OpenAI::ImagesResponse::Quality::TaggedSymbol,
            size: OpenAI::ImagesResponse::Size::TaggedSymbol,
            usage: OpenAI::ImagesResponse::Usage
          }
        )
      end
      def to_hash
      end

      # The background parameter used for the image generation. Either `transparent` or
      # `opaque`.
      module Background
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::ImagesResponse::Background) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        TRANSPARENT =
          T.let(:transparent, OpenAI::ImagesResponse::Background::TaggedSymbol)
        OPAQUE =
          T.let(:opaque, OpenAI::ImagesResponse::Background::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::ImagesResponse::Background::TaggedSymbol]
          )
        end
        def self.values
        end
      end

      # The output format of the image generation. Either `png`, `webp`, or `jpeg`.
      module OutputFormat
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::ImagesResponse::OutputFormat) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        PNG = T.let(:png, OpenAI::ImagesResponse::OutputFormat::TaggedSymbol)
        WEBP = T.let(:webp, OpenAI::ImagesResponse::OutputFormat::TaggedSymbol)
        JPEG = T.let(:jpeg, OpenAI::ImagesResponse::OutputFormat::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::ImagesResponse::OutputFormat::TaggedSymbol]
          )
        end
        def self.values
        end
      end

      # The quality of the image generated. Either `low`, `medium`, or `high`.
      module Quality
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::ImagesResponse::Quality) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        LOW = T.let(:low, OpenAI::ImagesResponse::Quality::TaggedSymbol)
        MEDIUM = T.let(:medium, OpenAI::ImagesResponse::Quality::TaggedSymbol)
        HIGH = T.let(:high, OpenAI::ImagesResponse::Quality::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::ImagesResponse::Quality::TaggedSymbol]
          )
        end
        def self.values
        end
      end

      # The size of the image generated. Either `1024x1024`, `1024x1536`, or
      # `1536x1024`.
      module Size
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::ImagesResponse::Size) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        SIZE_1024X1024 =
          T.let(:"1024x1024", OpenAI::ImagesResponse::Size::TaggedSymbol)
        SIZE_1024X1536 =
          T.let(:"1024x1536", OpenAI::ImagesResponse::Size::TaggedSymbol)
        SIZE_1536X1024 =
          T.let(:"1536x1024", OpenAI::ImagesResponse::Size::TaggedSymbol)

        sig do
          override.returns(T::Array[OpenAI::ImagesResponse::Size::TaggedSymbol])
        end
        def self.values
        end
      end

      class Usage < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::ImagesResponse::Usage, OpenAI::Internal::AnyHash)
          end

        # The number of tokens (images and text) in the input prompt.
        sig { returns(Integer) }
        attr_accessor :input_tokens

        # The input tokens detailed information for the image generation.
        sig { returns(OpenAI::ImagesResponse::Usage::InputTokensDetails) }
        attr_reader :input_tokens_details

        sig do
          params(
            input_tokens_details:
              OpenAI::ImagesResponse::Usage::InputTokensDetails::OrHash
          ).void
        end
        attr_writer :input_tokens_details

        # The number of output tokens generated by the model.
        sig { returns(Integer) }
        attr_accessor :output_tokens

        # The total number of tokens (images and text) used for the image generation.
        sig { returns(Integer) }
        attr_accessor :total_tokens

        # The output token details for the image generation.
        sig do
          returns(T.nilable(OpenAI::ImagesResponse::Usage::OutputTokensDetails))
        end
        attr_reader :output_tokens_details

        sig do
          params(
            output_tokens_details:
              OpenAI::ImagesResponse::Usage::OutputTokensDetails::OrHash
          ).void
        end
        attr_writer :output_tokens_details

        # For `gpt-image-1` only, the token usage information for the image generation.
        sig do
          params(
            input_tokens: Integer,
            input_tokens_details:
              OpenAI::ImagesResponse::Usage::InputTokensDetails::OrHash,
            output_tokens: Integer,
            total_tokens: Integer,
            output_tokens_details:
              OpenAI::ImagesResponse::Usage::OutputTokensDetails::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # The number of tokens (images and text) in the input prompt.
          input_tokens:,
          # The input tokens detailed information for the image generation.
          input_tokens_details:,
          # The number of output tokens generated by the model.
          output_tokens:,
          # The total number of tokens (images and text) used for the image generation.
          total_tokens:,
          # The output token details for the image generation.
          output_tokens_details: nil
        )
        end

        sig do
          override.returns(
            {
              input_tokens: Integer,
              input_tokens_details:
                OpenAI::ImagesResponse::Usage::InputTokensDetails,
              output_tokens: Integer,
              total_tokens: Integer,
              output_tokens_details:
                OpenAI::ImagesResponse::Usage::OutputTokensDetails
            }
          )
        end
        def to_hash
        end

        class InputTokensDetails < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::ImagesResponse::Usage::InputTokensDetails,
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

        class OutputTokensDetails < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::ImagesResponse::Usage::OutputTokensDetails,
                OpenAI::Internal::AnyHash
              )
            end

          # The number of image output tokens generated by the model.
          sig { returns(Integer) }
          attr_accessor :image_tokens

          # The number of text output tokens generated by the model.
          sig { returns(Integer) }
          attr_accessor :text_tokens

          # The output token details for the image generation.
          sig do
            params(image_tokens: Integer, text_tokens: Integer).returns(
              T.attached_class
            )
          end
          def self.new(
            # The number of image output tokens generated by the model.
            image_tokens:,
            # The number of text output tokens generated by the model.
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
