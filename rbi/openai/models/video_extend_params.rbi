# typed: strong

module OpenAI
  module Models

    class VideoExtendParams < OpenAI::Internal::Type::BaseModel

      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash = T.type_alias do
        T.any(
          OpenAI::VideoExtendParams,
          OpenAI::Internal::AnyHash
        )
      end

      # Updated text prompt that directs the extension generation.
      sig { returns(String) }
      attr_accessor :prompt

      # Length of the newly generated extension segment in seconds (allowed values: 4,
      # 8, 12, 16, 20).
      sig { returns(OpenAI::VideoSeconds::OrSymbol) }
      attr_accessor :seconds

      # Reference to the completed video to extend.
      #
      # `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
      # metadata. Use `OpenAI::FilePart` when you need to override the filename or
      # content type.
      sig { returns(T.any(OpenAI::Internal::FileInput, OpenAI::VideoExtendParams::Video::VideoReferenceInputParam)) }
      attr_accessor :video

      sig do
        params(

          prompt: String,

          seconds: OpenAI::VideoSeconds::OrSymbol,

          video: T.any(OpenAI::Internal::FileInput, OpenAI::VideoExtendParams::Video::VideoReferenceInputParam::OrHash),

          request_options: OpenAI::RequestOptions::OrHash
        )
          .returns(T.attached_class)
      end
      def self.new(

        # Updated text prompt that directs the extension generation.
        prompt:,

        # Length of the newly generated extension segment in seconds (allowed values: 4,
        # 8, 12, 16, 20).
        seconds:,

        # Reference to the completed video to extend.
        #
        # `String`, `StringIO`, and pathless `IO` inputs are sent with generic upload
        # metadata. Use `OpenAI::FilePart` when you need to override the filename or
        # content type.
        video:,

        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            prompt: String,
            seconds: OpenAI::VideoSeconds::OrSymbol,
            video: T.any(OpenAI::Internal::FileInput, OpenAI::VideoExtendParams::Video::VideoReferenceInputParam),
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end

      # Reference to the completed video to extend.
      module Video
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias { T.any(StringIO, OpenAI::VideoExtendParams::Video::VideoReferenceInputParam) }

        class VideoReferenceInputParam < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::VideoExtendParams::Video::VideoReferenceInputParam,
              OpenAI::Internal::AnyHash
            )
          end

          # The identifier of the completed video.
          sig { returns(String) }
          attr_accessor :id

          # Reference to the completed video.
          sig do
            params(

              id: String
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The identifier of the completed video.

            id:
          )
          end

          sig do
            override.returns(
              {id: String}
            )
          end
          def to_hash
          end

        end

        sig { override.returns(T::Array[OpenAI::VideoExtendParams::Video::Variants]) }
        def self.variants
        end

      end

    end

  end
end
