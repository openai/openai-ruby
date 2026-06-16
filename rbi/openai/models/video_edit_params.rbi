# typed: strong

module OpenAI
  module Models
    class VideoEditParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash =
        T.type_alias do
          T.any(OpenAI::VideoEditParams, OpenAI::Internal::AnyHash)
        end

      # Text prompt that describes how to edit the source video.
      sig { returns(String) }
      attr_accessor :prompt

      # Reference to the completed video to edit.
      sig do
        returns(
          T.any(
            OpenAI::Internal::FileInput,
            OpenAI::VideoEditParams::Video::VideoReferenceInputParam
          )
        )
      end
      attr_accessor :video

      sig do
        params(
          prompt: String,
          video:
            T.any(
              OpenAI::Internal::FileInput,
              OpenAI::VideoEditParams::Video::VideoReferenceInputParam::OrHash
            ),
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(
        # Text prompt that describes how to edit the source video.
        prompt:,
        # Reference to the completed video to edit.
        video:,
        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            prompt: String,
            video:
              T.any(
                OpenAI::Internal::FileInput,
                OpenAI::VideoEditParams::Video::VideoReferenceInputParam
              ),
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end

      # Reference to the completed video to edit.
      module Video
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              StringIO,
              OpenAI::VideoEditParams::Video::VideoReferenceInputParam
            )
          end

        class VideoReferenceInputParam < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::VideoEditParams::Video::VideoReferenceInputParam,
                OpenAI::Internal::AnyHash
              )
            end

          # The identifier of the completed video.
          sig { returns(String) }
          attr_accessor :id

          # Reference to the completed video.
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

        sig do
          override.returns(T::Array[OpenAI::VideoEditParams::Video::Variants])
        end
        def self.variants
        end
      end
    end
  end
end
