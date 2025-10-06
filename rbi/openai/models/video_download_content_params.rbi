# typed: strong

module OpenAI
  module Models
    class VideoDownloadContentParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash =
        T.type_alias do
          T.any(OpenAI::VideoDownloadContentParams, OpenAI::Internal::AnyHash)
        end

      # Which downloadable asset to return. Defaults to the MP4 video.
      sig do
        returns(
          T.nilable(OpenAI::VideoDownloadContentParams::Variant::OrSymbol)
        )
      end
      attr_reader :variant

      sig do
        params(
          variant: OpenAI::VideoDownloadContentParams::Variant::OrSymbol
        ).void
      end
      attr_writer :variant

      sig do
        params(
          variant: OpenAI::VideoDownloadContentParams::Variant::OrSymbol,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(
        # Which downloadable asset to return. Defaults to the MP4 video.
        variant: nil,
        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            variant: OpenAI::VideoDownloadContentParams::Variant::OrSymbol,
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end

      # Which downloadable asset to return. Defaults to the MP4 video.
      module Variant
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias do
            T.all(Symbol, OpenAI::VideoDownloadContentParams::Variant)
          end
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        VIDEO =
          T.let(
            :video,
            OpenAI::VideoDownloadContentParams::Variant::TaggedSymbol
          )
        THUMBNAIL =
          T.let(
            :thumbnail,
            OpenAI::VideoDownloadContentParams::Variant::TaggedSymbol
          )
        SPRITESHEET =
          T.let(
            :spritesheet,
            OpenAI::VideoDownloadContentParams::Variant::TaggedSymbol
          )

        sig do
          override.returns(
            T::Array[OpenAI::VideoDownloadContentParams::Variant::TaggedSymbol]
          )
        end
        def self.values
        end
      end
    end
  end
end
