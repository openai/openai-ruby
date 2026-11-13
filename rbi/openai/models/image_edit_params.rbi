# typed: strong

module OpenAI
  module Models

    class ImageEditParams < OpenAI::Internal::Type::BaseModel

      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash = T.type_alias do
        T.any(
          OpenAI::ImageEditParams,
          OpenAI::Internal::AnyHash
        )
      end

      # The image(s) to edit. Must be a supported image file or an array of images.
      #
      # For the GPT image models (`gpt-image-1-mini`, `gpt-image-1.5`, `gpt-image-2`,
      # `gpt-image-2-2026-04-21`, `gpt-image-2.5-sunburst`,
      # `gpt-image-2.5-sunburst-2026-09-08`, `gpt-image-2.5-flare`, and
      # `gpt-image-2.5-flare-2026-09-08`), each image should be a `png`, `webp`, or
      # `jpg` file less than 50MB. You can provide up to 16 images.
      # `chatgpt-image-latest` follows the same input constraints as GPT image models.
      #
      # `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
      # metadata. Use `OpenAI::FilePart` when you need to override the filename or
      # content type.
      sig { returns(OpenAI::ImageEditParams::Image::Variants) }
      attr_accessor :image

      # A text description of the desired image(s). The maximum length is 32000
      # characters for the GPT image models.
      sig { returns(String) }
      attr_accessor :prompt

      # Allows to set transparency for the background of the generated image(s). Must be
      # one of `transparent`, `opaque`, or `auto` (default value). When `auto` is used,
      # the model will automatically determine the best background for the image.
      #
      # `gpt-image-2.5-sunburst` and `gpt-image-2.5-flare`, including their `2026-09-08`
      # snapshots, support `opaque` and `transparent` backgrounds. Transparent
      # backgrounds are available for supported GPT Image models. For `gpt-image-2` and
      # `gpt-image-2-2026-04-21`, this support is in preview. When using `transparent`,
      # set the output format to `png` or `webp`.
      sig { returns(T.nilable(OpenAI::ImageEditParams::Background::OrSymbol)) }
      attr_accessor :background

      # Computation spent planning the image, independently of rendering quality. Uses
      # the image model's configured default when omitted. For SVG output, controls the
      # reference image, independently of the SVG author's reasoning.
      sig { returns(T.nilable(OpenAI::ImageEditParams::Complexity::OrSymbol)) }
      attr_accessor :complexity

      # Number of frames for GIF output. Accepts integers from 2 through 16. Defaults to
      # 9 when omitted. Only supported with output_format=gif. The requested size must
      # satisfy the selected model's GIF size limits. GIF output does not support
      # streaming, partial images, masks, or custom output compression. Requires access
      # to the GIF preview for the selected model.
      sig { returns(T.nilable(Integer)) }
      attr_accessor :frame_count

      # Requested delay per GIF frame, in milliseconds. Defaults to 200 when omitted.
      # GIF output rounds to the nearest 10 ms and caps the encoded delay at 655,350 ms
      # per frame. Only supported with output_format=gif.
      sig { returns(T.nilable(Integer)) }
      attr_accessor :frame_duration_ms

      # Control how much effort the model will exert to match the style and features,
      # especially facial features, of input images. Supports `high` and `low` on
      # `gpt-image-1.5`; `gpt-image-1-mini` supports only `low`. For `gpt-image-2`, omit
      # this parameter. Defaults to `low` on supported models.
      sig { returns(T.nilable(OpenAI::ImageEditParams::InputFidelity::OrSymbol)) }
      attr_accessor :input_fidelity

      # A transparent PNG overlaid on the first image to guide the edit. Must match that
      # image's dimensions after orientation and contain transparent pixels. Supports
      # GPT Image 2.5. Cannot be combined with mask.
      #
      # `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
      # metadata. Use `OpenAI::FilePart` when you need to override the filename or
      # content type.
      sig { returns(T.nilable(OpenAI::Internal::FileInput)) }
      attr_reader :markup

      sig { params(markup: OpenAI::Internal::FileInput).void }
      attr_writer :markup

      # An additional image whose fully transparent areas (e.g. where alpha is zero)
      # indicate where `image` should be edited. If there are multiple images provided,
      # the mask will be applied on the first image. Must be a valid PNG file, less than
      # 4MB, and have the same dimensions as `image`.
      #
      # `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
      # metadata. Use `OpenAI::FilePart` when you need to override the filename or
      # content type.
      sig { returns(T.nilable(OpenAI::Internal::FileInput)) }
      attr_reader :mask

      sig { params(mask: OpenAI::Internal::FileInput).void }
      attr_writer :mask

      # The GPT image model to use for image editing (`gpt-image-1-mini`,
      # `gpt-image-1.5`, `gpt-image-2`, `gpt-image-2-2026-04-21`,
      # `gpt-image-2.5-sunburst`, `gpt-image-2.5-sunburst-2026-09-08`,
      # `gpt-image-2.5-flare`, `gpt-image-2.5-flare-2026-09-08`,
      # `gpt-image-2.6-sunburst`, `gpt-image-2.6-flare`, or `chatgpt-image-latest`).
      #
      # `gpt-image-1` was shut down on October 23, 2026. Use `gpt-image-2.5-sunburst` or
      # `gpt-image-2.5-flare` instead.
      sig { returns(T.nilable(T.any(String, OpenAI::ImageModel::OrSymbol))) }
      attr_accessor :model

      # The number of images to generate. Must be between 1 and 10.
      sig { returns(T.nilable(Integer)) }
      attr_accessor :n

      # The compression level (0-100%) for the generated images. This parameter is only
      # supported for the GPT image models with the `webp` or `jpeg` output formats, and
      # defaults to 100.
      sig { returns(T.nilable(Integer)) }
      attr_accessor :output_compression

      # The format in which the generated images are returned. This parameter is only
      # supported for the GPT image models. The default value is `png`. SVG output
      # requires a supported image model and project access.
      sig { returns(T.nilable(OpenAI::ImageEditParams::OutputFormat::OrSymbol)) }
      attr_accessor :output_format

      # The number of partial images to generate. This parameter is used for streaming
      # responses that return partial images. Value must be between 0 and 3. When set to
      # 0, the response will be a single image sent in one streaming event.
      #
      # Note that the final image may be sent before the full number of partial images
      # are generated if the full image is generated more quickly.
      sig { returns(T.nilable(Integer)) }
      attr_accessor :partial_images

      # The quality of the image that will be generated for GPT image models. The GPT
      # image models support `low`, `medium`, and `high`. `gpt-image-2.5-sunburst` and
      # `gpt-image-2.5-flare`, including their `2026-09-08` snapshots, also support
      # `xhigh` and `max`. Defaults to `auto`.
      sig { returns(T.nilable(OpenAI::ImageEditParams::Quality::OrSymbol)) }
      attr_accessor :quality

      # Legacy response format parameter for retired image models. Unsupported for GPT
      # image models, which always return base64-encoded images.
      sig { returns(T.nilable(OpenAI::ImageEditParams::ResponseFormat::OrSymbol)) }
      attr_accessor :response_format

      # A stable identifier for an end user in your organization, used for safety
      # monitoring and abuse detection. Hash a username or email address to avoid
      # sending identifying information. A non-empty value takes precedence over the
      # deprecated `user` parameter. If omitted, null, or empty, the API uses `user`
      # when available.
      # [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
      sig { returns(T.nilable(String)) }
      attr_accessor :safety_identifier

      # The size of the generated images. Defaults to `auto`. For `gpt-image-2`,
      # `gpt-image-2-2026-04-21`, `gpt-image-2.5-sunburst`,
      # `gpt-image-2.5-sunburst-2026-09-08`, `gpt-image-2.5-flare`, and
      # `gpt-image-2.5-flare-2026-09-08`, arbitrary resolutions are supported as
      # `WIDTHxHEIGHT` strings, for example `1536x864`. Width and height must both be
      # divisible by 16 and the requested aspect ratio must be between 1:3 and 3:1.
      # Resolutions above `2560x1440` are experimental, and the maximum supported
      # resolution is `3840x2160`. The requested size must also satisfy the model's
      # current pixel and edge limits. The standard sizes `1024x1024`, `1536x1024`, and
      # `1024x1536` are supported by the GPT image models; `auto` is supported for
      # models that allow automatic sizing.
      sig { returns(T.nilable(T.any(String, OpenAI::ImageEditParams::Size::OrSymbol))) }
      attr_accessor :size

      # Selects the author model and reasoning effort for `output_format=svg`. Supply
      # `svg.model` when SVG model selection is enabled. Otherwise, omit this object.
      # SVG output requires `n=1` and cannot use streaming, partial images, or output
      # compression. Use multipart fields such as `svg[model]`.
      sig { returns(T.nilable(OpenAI::ImageEditParams::Svg)) }
      attr_reader :svg

      sig { params(svg: T.nilable(OpenAI::ImageEditParams::Svg::OrHash)).void }
      attr_writer :svg

      # Deprecated: use `safety_identifier` instead. This parameter remains accepted for
      # backward compatibility and is used when `safety_identifier` is omitted, null, or
      # empty.
      # [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
      sig { returns(T.nilable(String)) }
      attr_reader :user

      sig { params(user: String).void }
      attr_writer :user

      sig do
        params(

          image: OpenAI::ImageEditParams::Image::Variants,

          prompt: String,

          background: T.nilable(OpenAI::ImageEditParams::Background::OrSymbol),

          complexity: T.nilable(OpenAI::ImageEditParams::Complexity::OrSymbol),

          frame_count: T.nilable(Integer),

          frame_duration_ms: T.nilable(Integer),

          input_fidelity: T.nilable(OpenAI::ImageEditParams::InputFidelity::OrSymbol),

          markup: OpenAI::Internal::FileInput,

          mask: OpenAI::Internal::FileInput,

          model: T.nilable(T.any(String, OpenAI::ImageModel::OrSymbol)),

          n: T.nilable(Integer),

          output_compression: T.nilable(Integer),

          output_format: T.nilable(OpenAI::ImageEditParams::OutputFormat::OrSymbol),

          partial_images: T.nilable(Integer),

          quality: T.nilable(OpenAI::ImageEditParams::Quality::OrSymbol),

          response_format: T.nilable(OpenAI::ImageEditParams::ResponseFormat::OrSymbol),

          safety_identifier: T.nilable(String),

          size: T.nilable(T.any(String, OpenAI::ImageEditParams::Size::OrSymbol)),

          svg: T.nilable(OpenAI::ImageEditParams::Svg::OrHash),

          user: String,

          request_options: OpenAI::RequestOptions::OrHash
        )
          .returns(T.attached_class)
      end
      def self.new(

        # The image(s) to edit. Must be a supported image file or an array of images.
        #
        # For the GPT image models (`gpt-image-1-mini`, `gpt-image-1.5`, `gpt-image-2`,
        # `gpt-image-2-2026-04-21`, `gpt-image-2.5-sunburst`,
        # `gpt-image-2.5-sunburst-2026-09-08`, `gpt-image-2.5-flare`, and
        # `gpt-image-2.5-flare-2026-09-08`), each image should be a `png`, `webp`, or
        # `jpg` file less than 50MB. You can provide up to 16 images.
        # `chatgpt-image-latest` follows the same input constraints as GPT image models.
        #
        # `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
        # metadata. Use `OpenAI::FilePart` when you need to override the filename or
        # content type.
        image:,

        # A text description of the desired image(s). The maximum length is 32000
        # characters for the GPT image models.
        prompt:,

        # Allows to set transparency for the background of the generated image(s). Must be
        # one of `transparent`, `opaque`, or `auto` (default value). When `auto` is used,
        # the model will automatically determine the best background for the image.
        #
        # `gpt-image-2.5-sunburst` and `gpt-image-2.5-flare`, including their `2026-09-08`
        # snapshots, support `opaque` and `transparent` backgrounds. Transparent
        # backgrounds are available for supported GPT Image models. For `gpt-image-2` and
        # `gpt-image-2-2026-04-21`, this support is in preview. When using `transparent`,
        # set the output format to `png` or `webp`.
        background: nil,

        # Computation spent planning the image, independently of rendering quality. Uses
        # the image model's configured default when omitted. For SVG output, controls the
        # reference image, independently of the SVG author's reasoning.
        complexity: nil,

        # Number of frames for GIF output. Accepts integers from 2 through 16. Defaults to
        # 9 when omitted. Only supported with output_format=gif. The requested size must
        # satisfy the selected model's GIF size limits. GIF output does not support
        # streaming, partial images, masks, or custom output compression. Requires access
        # to the GIF preview for the selected model.
        frame_count: nil,

        # Requested delay per GIF frame, in milliseconds. Defaults to 200 when omitted.
        # GIF output rounds to the nearest 10 ms and caps the encoded delay at 655,350 ms
        # per frame. Only supported with output_format=gif.
        frame_duration_ms: nil,

        # Control how much effort the model will exert to match the style and features,
        # especially facial features, of input images. Supports `high` and `low` on
        # `gpt-image-1.5`; `gpt-image-1-mini` supports only `low`. For `gpt-image-2`, omit
        # this parameter. Defaults to `low` on supported models.
        input_fidelity: nil,

        # A transparent PNG overlaid on the first image to guide the edit. Must match that
        # image's dimensions after orientation and contain transparent pixels. Supports
        # GPT Image 2.5. Cannot be combined with mask.
        #
        # `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
        # metadata. Use `OpenAI::FilePart` when you need to override the filename or
        # content type.
        markup: nil,

        # An additional image whose fully transparent areas (e.g. where alpha is zero)
        # indicate where `image` should be edited. If there are multiple images provided,
        # the mask will be applied on the first image. Must be a valid PNG file, less than
        # 4MB, and have the same dimensions as `image`.
        #
        # `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
        # metadata. Use `OpenAI::FilePart` when you need to override the filename or
        # content type.
        mask: nil,

        # The GPT image model to use for image editing (`gpt-image-1-mini`,
        # `gpt-image-1.5`, `gpt-image-2`, `gpt-image-2-2026-04-21`,
        # `gpt-image-2.5-sunburst`, `gpt-image-2.5-sunburst-2026-09-08`,
        # `gpt-image-2.5-flare`, `gpt-image-2.5-flare-2026-09-08`,
        # `gpt-image-2.6-sunburst`, `gpt-image-2.6-flare`, or `chatgpt-image-latest`).
        #
        # `gpt-image-1` was shut down on October 23, 2026. Use `gpt-image-2.5-sunburst` or
        # `gpt-image-2.5-flare` instead.
        model: nil,

        # The number of images to generate. Must be between 1 and 10.
        n: nil,

        # The compression level (0-100%) for the generated images. This parameter is only
        # supported for the GPT image models with the `webp` or `jpeg` output formats, and
        # defaults to 100.
        output_compression: nil,

        # The format in which the generated images are returned. This parameter is only
        # supported for the GPT image models. The default value is `png`. SVG output
        # requires a supported image model and project access.
        output_format: nil,

        # The number of partial images to generate. This parameter is used for streaming
        # responses that return partial images. Value must be between 0 and 3. When set to
        # 0, the response will be a single image sent in one streaming event.
        #
        # Note that the final image may be sent before the full number of partial images
        # are generated if the full image is generated more quickly.
        partial_images: nil,

        # The quality of the image that will be generated for GPT image models. The GPT
        # image models support `low`, `medium`, and `high`. `gpt-image-2.5-sunburst` and
        # `gpt-image-2.5-flare`, including their `2026-09-08` snapshots, also support
        # `xhigh` and `max`. Defaults to `auto`.
        quality: nil,

        # Legacy response format parameter for retired image models. Unsupported for GPT
        # image models, which always return base64-encoded images.
        response_format: nil,

        # A stable identifier for an end user in your organization, used for safety
        # monitoring and abuse detection. Hash a username or email address to avoid
        # sending identifying information. A non-empty value takes precedence over the
        # deprecated `user` parameter. If omitted, null, or empty, the API uses `user`
        # when available.
        # [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
        safety_identifier: nil,

        # The size of the generated images. Defaults to `auto`. For `gpt-image-2`,
        # `gpt-image-2-2026-04-21`, `gpt-image-2.5-sunburst`,
        # `gpt-image-2.5-sunburst-2026-09-08`, `gpt-image-2.5-flare`, and
        # `gpt-image-2.5-flare-2026-09-08`, arbitrary resolutions are supported as
        # `WIDTHxHEIGHT` strings, for example `1536x864`. Width and height must both be
        # divisible by 16 and the requested aspect ratio must be between 1:3 and 3:1.
        # Resolutions above `2560x1440` are experimental, and the maximum supported
        # resolution is `3840x2160`. The requested size must also satisfy the model's
        # current pixel and edge limits. The standard sizes `1024x1024`, `1536x1024`, and
        # `1024x1536` are supported by the GPT image models; `auto` is supported for
        # models that allow automatic sizing.
        size: nil,

        # Selects the author model and reasoning effort for `output_format=svg`. Supply
        # `svg.model` when SVG model selection is enabled. Otherwise, omit this object.
        # SVG output requires `n=1` and cannot use streaming, partial images, or output
        # compression. Use multipart fields such as `svg[model]`.
        svg: nil,

        # Deprecated: use `safety_identifier` instead. This parameter remains accepted for
        # backward compatibility and is used when `safety_identifier` is omitted, null, or
        # empty.
        # [Learn more](https://developers.openai.com/api/docs/guides/safety-best-practices#implement-safety-identifiers).
        user: nil,

        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            image: OpenAI::ImageEditParams::Image::Variants,
            prompt: String,
            background: T.nilable(OpenAI::ImageEditParams::Background::OrSymbol),
            complexity: T.nilable(OpenAI::ImageEditParams::Complexity::OrSymbol),
            frame_count: T.nilable(Integer),
            frame_duration_ms: T.nilable(Integer),
            input_fidelity: T.nilable(OpenAI::ImageEditParams::InputFidelity::OrSymbol),
            markup: OpenAI::Internal::FileInput,
            mask: OpenAI::Internal::FileInput,
            model: T.nilable(T.any(String, OpenAI::ImageModel::OrSymbol)),
            n: T.nilable(Integer),
            output_compression: T.nilable(Integer),
            output_format: T.nilable(OpenAI::ImageEditParams::OutputFormat::OrSymbol),
            partial_images: T.nilable(Integer),
            quality: T.nilable(OpenAI::ImageEditParams::Quality::OrSymbol),
            response_format: T.nilable(OpenAI::ImageEditParams::ResponseFormat::OrSymbol),
            safety_identifier: T.nilable(String),
            size: T.nilable(T.any(String, OpenAI::ImageEditParams::Size::OrSymbol)),
            svg: T.nilable(OpenAI::ImageEditParams::Svg),
            user: String,
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end

      # The image(s) to edit. Must be a supported image file or an array of images.
      #
      # For the GPT image models (`gpt-image-1-mini`, `gpt-image-1.5`, `gpt-image-2`,
      # `gpt-image-2-2026-04-21`, `gpt-image-2.5-sunburst`,
      # `gpt-image-2.5-sunburst-2026-09-08`, `gpt-image-2.5-flare`, and
      # `gpt-image-2.5-flare-2026-09-08`), each image should be a `png`, `webp`, or
      # `jpg` file less than 50MB. You can provide up to 16 images.
      # `chatgpt-image-latest` follows the same input constraints as GPT image models.
      module Image
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias { T.any(StringIO, T::Array[StringIO]) }

        sig { override.returns(T::Array[OpenAI::ImageEditParams::Image::Variants]) }
        def self.variants
        end

        StringArray = T.let(
          OpenAI::Internal::Type::ArrayOf[OpenAI::Internal::Type::FileInput],
          OpenAI::Internal::Type::Converter
        )

      end

      # Allows to set transparency for the background of the generated image(s). Must be
      # one of `transparent`, `opaque`, or `auto` (default value). When `auto` is used,
      # the model will automatically determine the best background for the image.
      #
      # `gpt-image-2.5-sunburst` and `gpt-image-2.5-flare`, including their `2026-09-08`
      # snapshots, support `opaque` and `transparent` backgrounds. Transparent
      # backgrounds are available for supported GPT Image models. For `gpt-image-2` and
      # `gpt-image-2-2026-04-21`, this support is in preview. When using `transparent`,
      # set the output format to `png` or `webp`.
      module Background
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::ImageEditParams::Background) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        TRANSPARENT = T.let(:transparent, OpenAI::ImageEditParams::Background::TaggedSymbol)
        OPAQUE = T.let(:opaque, OpenAI::ImageEditParams::Background::TaggedSymbol)
        AUTO = T.let(:auto, OpenAI::ImageEditParams::Background::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::ImageEditParams::Background::TaggedSymbol]) }
        def self.values
        end
      end

      # Computation spent planning the image, independently of rendering quality. Uses
      # the image model's configured default when omitted. For SVG output, controls the
      # reference image, independently of the SVG author's reasoning.
      module Complexity
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::ImageEditParams::Complexity) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        LOW = T.let(:low, OpenAI::ImageEditParams::Complexity::TaggedSymbol)
        MEDIUM = T.let(:medium, OpenAI::ImageEditParams::Complexity::TaggedSymbol)
        HIGH = T.let(:high, OpenAI::ImageEditParams::Complexity::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::ImageEditParams::Complexity::TaggedSymbol]) }
        def self.values
        end
      end

      # Control how much effort the model will exert to match the style and features,
      # especially facial features, of input images. Supports `high` and `low` on
      # `gpt-image-1.5`; `gpt-image-1-mini` supports only `low`. For `gpt-image-2`, omit
      # this parameter. Defaults to `low` on supported models.
      module InputFidelity
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::ImageEditParams::InputFidelity) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        HIGH = T.let(:high, OpenAI::ImageEditParams::InputFidelity::TaggedSymbol)
        LOW = T.let(:low, OpenAI::ImageEditParams::InputFidelity::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::ImageEditParams::InputFidelity::TaggedSymbol]) }
        def self.values
        end
      end

      # The GPT image model to use for image editing (`gpt-image-1-mini`,
      # `gpt-image-1.5`, `gpt-image-2`, `gpt-image-2-2026-04-21`,
      # `gpt-image-2.5-sunburst`, `gpt-image-2.5-sunburst-2026-09-08`,
      # `gpt-image-2.5-flare`, `gpt-image-2.5-flare-2026-09-08`,
      # `gpt-image-2.6-sunburst`, `gpt-image-2.6-flare`, or `chatgpt-image-latest`).
      #
      # `gpt-image-1` was shut down on October 23, 2026. Use `gpt-image-2.5-sunburst` or
      # `gpt-image-2.5-flare` instead.
      module Model
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias { T.any(String, OpenAI::ImageModel::TaggedSymbol) }

        sig { override.returns(T::Array[OpenAI::ImageEditParams::Model::Variants]) }
        def self.variants
        end

      end

      # The format in which the generated images are returned. This parameter is only
      # supported for the GPT image models. The default value is `png`. SVG output
      # requires a supported image model and project access.
      module OutputFormat
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::ImageEditParams::OutputFormat) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        PNG = T.let(:png, OpenAI::ImageEditParams::OutputFormat::TaggedSymbol)
        WEBP = T.let(:webp, OpenAI::ImageEditParams::OutputFormat::TaggedSymbol)
        JPEG = T.let(:jpeg, OpenAI::ImageEditParams::OutputFormat::TaggedSymbol)
        GIF = T.let(:gif, OpenAI::ImageEditParams::OutputFormat::TaggedSymbol)
        SVG = T.let(:svg, OpenAI::ImageEditParams::OutputFormat::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::ImageEditParams::OutputFormat::TaggedSymbol]) }
        def self.values
        end
      end

      # The quality of the image that will be generated for GPT image models. The GPT
      # image models support `low`, `medium`, and `high`. `gpt-image-2.5-sunburst` and
      # `gpt-image-2.5-flare`, including their `2026-09-08` snapshots, also support
      # `xhigh` and `max`. Defaults to `auto`.
      module Quality
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::ImageEditParams::Quality) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        LOW = T.let(:low, OpenAI::ImageEditParams::Quality::TaggedSymbol)
        MEDIUM = T.let(:medium, OpenAI::ImageEditParams::Quality::TaggedSymbol)
        HIGH = T.let(:high, OpenAI::ImageEditParams::Quality::TaggedSymbol)
        XHIGH = T.let(:xhigh, OpenAI::ImageEditParams::Quality::TaggedSymbol)
        MAX = T.let(:max, OpenAI::ImageEditParams::Quality::TaggedSymbol)
        AUTO = T.let(:auto, OpenAI::ImageEditParams::Quality::TaggedSymbol)
        STANDARD = T.let(:standard, OpenAI::ImageEditParams::Quality::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::ImageEditParams::Quality::TaggedSymbol]) }
        def self.values
        end
      end

      # Legacy response format parameter for retired image models. Unsupported for GPT
      # image models, which always return base64-encoded images.
      module ResponseFormat
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::ImageEditParams::ResponseFormat) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        URL = T.let(:url, OpenAI::ImageEditParams::ResponseFormat::TaggedSymbol)
        B64_JSON = T.let(:b64_json, OpenAI::ImageEditParams::ResponseFormat::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::ImageEditParams::ResponseFormat::TaggedSymbol]) }
        def self.values
        end
      end

      # The size of the generated images. Defaults to `auto`. For `gpt-image-2`,
      # `gpt-image-2-2026-04-21`, `gpt-image-2.5-sunburst`,
      # `gpt-image-2.5-sunburst-2026-09-08`, `gpt-image-2.5-flare`, and
      # `gpt-image-2.5-flare-2026-09-08`, arbitrary resolutions are supported as
      # `WIDTHxHEIGHT` strings, for example `1536x864`. Width and height must both be
      # divisible by 16 and the requested aspect ratio must be between 1:3 and 3:1.
      # Resolutions above `2560x1440` are experimental, and the maximum supported
      # resolution is `3840x2160`. The requested size must also satisfy the model's
      # current pixel and edge limits. The standard sizes `1024x1024`, `1536x1024`, and
      # `1024x1536` are supported by the GPT image models; `auto` is supported for
      # models that allow automatic sizing.
      module Size
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias { T.any(String, OpenAI::ImageEditParams::Size::TaggedSymbol) }

        sig { override.returns(T::Array[OpenAI::ImageEditParams::Size::Variants]) }
        def self.variants
        end

        TaggedSymbol = T.type_alias do
          T.all(Symbol, OpenAI::ImageEditParams::Size)
        end

        OrSymbol = T.type_alias { T.any(Symbol, String) }

        SIZE_1024X1024 = T.let(:"1024x1024", OpenAI::ImageEditParams::Size::TaggedSymbol)
        SIZE_1536X1024 = T.let(:"1536x1024", OpenAI::ImageEditParams::Size::TaggedSymbol)
        SIZE_1024X1536 = T.let(:"1024x1536", OpenAI::ImageEditParams::Size::TaggedSymbol)
        AUTO = T.let(:auto, OpenAI::ImageEditParams::Size::TaggedSymbol)
        SIZE_256X256 = T.let(:"256x256", OpenAI::ImageEditParams::Size::TaggedSymbol)
        SIZE_512X512 = T.let(:"512x512", OpenAI::ImageEditParams::Size::TaggedSymbol)

      end

      class Svg < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias do
          T.any(
            OpenAI::ImageEditParams::Svg,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(T.nilable(String)) }
        attr_reader :model

        sig { params(model: String).void }
        attr_writer :model

        # Reasoning effort for SVG authoring. When omitted, uses the author model's
        # default in both Images and Responses.
        sig { returns(T.nilable(OpenAI::ImageEditParams::Svg::Reasoning)) }
        attr_reader :reasoning

        sig { params(reasoning: T.nilable(OpenAI::ImageEditParams::Svg::Reasoning::OrHash)).void }
        attr_writer :reasoning

        # Selects the author model and reasoning effort for `output_format=svg`. Supply
        # `svg.model` when SVG model selection is enabled. Otherwise, omit this object.
        # SVG output requires `n=1` and cannot use streaming, partial images, or output
        # compression. Use multipart fields such as `svg[model]`.
        sig do
          params(

            model: String,

            reasoning: T.nilable(OpenAI::ImageEditParams::Svg::Reasoning::OrHash)
          )
            .returns(T.attached_class)
        end
        def self.new(

          model: nil,

          # Reasoning effort for SVG authoring. When omitted, uses the author model's
          # default in both Images and Responses.

          reasoning: nil
        )
        end

        sig do
          override.returns(
            {model: String, reasoning: T.nilable(OpenAI::ImageEditParams::Svg::Reasoning)}
          )
        end
        def to_hash
        end

        class Reasoning < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::ImageEditParams::Svg::Reasoning,
              OpenAI::Internal::AnyHash
            )
          end

          # Controls how much effort the model should spend on reasoning for this request.
          sig { returns(T.nilable(OpenAI::ImageEditParams::Svg::Reasoning::Effort::OrSymbol)) }
          attr_reader :effort

          sig { params(effort: OpenAI::ImageEditParams::Svg::Reasoning::Effort::OrSymbol).void }
          attr_writer :effort

          # Reasoning effort for SVG authoring. When omitted, uses the author model's
          # default in both Images and Responses.
          sig do
            params(

              effort: OpenAI::ImageEditParams::Svg::Reasoning::Effort::OrSymbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Controls how much effort the model should spend on reasoning for this request.

            effort: nil
          )
          end

          sig do
            override.returns(
              {effort: OpenAI::ImageEditParams::Svg::Reasoning::Effort::OrSymbol}
            )
          end
          def to_hash
          end

          # Controls how much effort the model should spend on reasoning for this request.
          module Effort
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::ImageEditParams::Svg::Reasoning::Effort) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            NONE = T.let(:none, OpenAI::ImageEditParams::Svg::Reasoning::Effort::TaggedSymbol)
            MINIMAL = T.let(:minimal, OpenAI::ImageEditParams::Svg::Reasoning::Effort::TaggedSymbol)
            LOW = T.let(:low, OpenAI::ImageEditParams::Svg::Reasoning::Effort::TaggedSymbol)
            MEDIUM = T.let(:medium, OpenAI::ImageEditParams::Svg::Reasoning::Effort::TaggedSymbol)
            HIGH = T.let(:high, OpenAI::ImageEditParams::Svg::Reasoning::Effort::TaggedSymbol)
            XHIGH = T.let(:xhigh, OpenAI::ImageEditParams::Svg::Reasoning::Effort::TaggedSymbol)
            MAX = T.let(:max, OpenAI::ImageEditParams::Svg::Reasoning::Effort::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::ImageEditParams::Svg::Reasoning::Effort::TaggedSymbol]) }
            def self.values
            end
          end
        end
      end

    end

  end
end
