# typed: strong

module OpenAI
  module Models
    class VideoExtendParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash =
        T.type_alias do
          T.any(OpenAI::VideoExtendParams, OpenAI::Internal::AnyHash)
        end

      # Updated text prompt that directs the extension generation.
      sig { returns(String) }
      attr_accessor :prompt

      # Length of the newly generated extension segment in seconds (allowed values: 4,
      # 8, 12, 16, 20).
      sig { returns(OpenAI::VideoSeconds::OrSymbol) }
      attr_accessor :seconds

      # Reference to the completed video to extend.
      sig { returns(OpenAI::VideoExtendParams::Video) }
      attr_reader :video

      sig { params(video: OpenAI::VideoExtendParams::Video::OrHash).void }
      attr_writer :video

      sig do
        params(
          prompt: String,
          seconds: OpenAI::VideoSeconds::OrSymbol,
          video: OpenAI::VideoExtendParams::Video::OrHash,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(
        # Updated text prompt that directs the extension generation.
        prompt:,
        # Length of the newly generated extension segment in seconds (allowed values: 4,
        # 8, 12, 16, 20).
        seconds:,
        # Reference to the completed video to extend.
        video:,
        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            prompt: String,
            seconds: OpenAI::VideoSeconds::OrSymbol,
            video: OpenAI::VideoExtendParams::Video,
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end

      class Video < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::VideoExtendParams::Video, OpenAI::Internal::AnyHash)
          end

        # The identifier of the completed video.
        sig { returns(String) }
        attr_accessor :id

        # Reference to the completed video to extend.
        sig { params(id: String).returns(T.attached_class) }
        def self.new(
          # The identifier of the completed video.
          id:
        )
        end

        sig { override.returns({ id: String }) }
        def to_hash
        end
      end
    end
  end
end
