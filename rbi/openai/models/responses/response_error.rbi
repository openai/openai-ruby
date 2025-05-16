# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseError < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Responses::ResponseError, OpenAI::Internal::AnyHash)
          end

        # The error code for the response.
        sig { returns(OpenAI::Responses::ResponseError::Code::TaggedSymbol) }
        attr_accessor :code

        # A human-readable description of the error.
        sig { returns(String) }
        attr_accessor :message

        # An error object returned when the model fails to generate a Response.
        sig do
          params(
            code: OpenAI::Responses::ResponseError::Code::OrSymbol,
            message: String
          ).returns(T.attached_class)
        end
        def self.new(
          # The error code for the response.
          code:,
          # A human-readable description of the error.
          message:
        )
        end

        sig do
          override.returns(
            {
              code: OpenAI::Responses::ResponseError::Code::TaggedSymbol,
              message: String
            }
          )
        end
        def to_hash
        end

        # The error code for the response.
        module Code
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Responses::ResponseError::Code)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          SERVER_ERROR =
            T.let(
              :server_error,
              OpenAI::Responses::ResponseError::Code::TaggedSymbol
            )
          RATE_LIMIT_EXCEEDED =
            T.let(
              :rate_limit_exceeded,
              OpenAI::Responses::ResponseError::Code::TaggedSymbol
            )
          INVALID_PROMPT =
            T.let(
              :invalid_prompt,
              OpenAI::Responses::ResponseError::Code::TaggedSymbol
            )
          VECTOR_STORE_TIMEOUT =
            T.let(
              :vector_store_timeout,
              OpenAI::Responses::ResponseError::Code::TaggedSymbol
            )
          INVALID_IMAGE =
            T.let(
              :invalid_image,
              OpenAI::Responses::ResponseError::Code::TaggedSymbol
            )
          INVALID_IMAGE_FORMAT =
            T.let(
              :invalid_image_format,
              OpenAI::Responses::ResponseError::Code::TaggedSymbol
            )
          INVALID_BASE64_IMAGE =
            T.let(
              :invalid_base64_image,
              OpenAI::Responses::ResponseError::Code::TaggedSymbol
            )
          INVALID_IMAGE_URL =
            T.let(
              :invalid_image_url,
              OpenAI::Responses::ResponseError::Code::TaggedSymbol
            )
          IMAGE_TOO_LARGE =
            T.let(
              :image_too_large,
              OpenAI::Responses::ResponseError::Code::TaggedSymbol
            )
          IMAGE_TOO_SMALL =
            T.let(
              :image_too_small,
              OpenAI::Responses::ResponseError::Code::TaggedSymbol
            )
          IMAGE_PARSE_ERROR =
            T.let(
              :image_parse_error,
              OpenAI::Responses::ResponseError::Code::TaggedSymbol
            )
          IMAGE_CONTENT_POLICY_VIOLATION =
            T.let(
              :image_content_policy_violation,
              OpenAI::Responses::ResponseError::Code::TaggedSymbol
            )
          INVALID_IMAGE_MODE =
            T.let(
              :invalid_image_mode,
              OpenAI::Responses::ResponseError::Code::TaggedSymbol
            )
          IMAGE_FILE_TOO_LARGE =
            T.let(
              :image_file_too_large,
              OpenAI::Responses::ResponseError::Code::TaggedSymbol
            )
          UNSUPPORTED_IMAGE_MEDIA_TYPE =
            T.let(
              :unsupported_image_media_type,
              OpenAI::Responses::ResponseError::Code::TaggedSymbol
            )
          EMPTY_IMAGE_FILE =
            T.let(
              :empty_image_file,
              OpenAI::Responses::ResponseError::Code::TaggedSymbol
            )
          FAILED_TO_DOWNLOAD_IMAGE =
            T.let(
              :failed_to_download_image,
              OpenAI::Responses::ResponseError::Code::TaggedSymbol
            )
          IMAGE_FILE_NOT_FOUND =
            T.let(
              :image_file_not_found,
              OpenAI::Responses::ResponseError::Code::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[OpenAI::Responses::ResponseError::Code::TaggedSymbol]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
