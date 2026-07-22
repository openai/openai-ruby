# typed: strong

module OpenAI
  module Models
    BetaResponseError = Beta::BetaResponseError

    module Beta
      class BetaResponseError < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Beta::BetaResponseError, OpenAI::Internal::AnyHash)
          end

        # The error code for the response.
        sig { returns(OpenAI::Beta::BetaResponseError::Code::TaggedSymbol) }
        attr_accessor :code

        # A human-readable description of the error.
        sig { returns(String) }
        attr_accessor :message

        # An error object returned when the model fails to generate a Response.
        sig do
          params(
            code: OpenAI::Beta::BetaResponseError::Code::OrSymbol,
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
              code: OpenAI::Beta::BetaResponseError::Code::TaggedSymbol,
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
              T.all(Symbol, OpenAI::Beta::BetaResponseError::Code)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          SERVER_ERROR =
            T.let(
              :server_error,
              OpenAI::Beta::BetaResponseError::Code::TaggedSymbol
            )
          RATE_LIMIT_EXCEEDED =
            T.let(
              :rate_limit_exceeded,
              OpenAI::Beta::BetaResponseError::Code::TaggedSymbol
            )
          INVALID_PROMPT =
            T.let(
              :invalid_prompt,
              OpenAI::Beta::BetaResponseError::Code::TaggedSymbol
            )
          DATA_RESIDENCY_MISMATCH =
            T.let(
              :data_residency_mismatch,
              OpenAI::Beta::BetaResponseError::Code::TaggedSymbol
            )
          BIO_POLICY =
            T.let(
              :bio_policy,
              OpenAI::Beta::BetaResponseError::Code::TaggedSymbol
            )
          VECTOR_STORE_TIMEOUT =
            T.let(
              :vector_store_timeout,
              OpenAI::Beta::BetaResponseError::Code::TaggedSymbol
            )
          INVALID_IMAGE =
            T.let(
              :invalid_image,
              OpenAI::Beta::BetaResponseError::Code::TaggedSymbol
            )
          INVALID_IMAGE_FORMAT =
            T.let(
              :invalid_image_format,
              OpenAI::Beta::BetaResponseError::Code::TaggedSymbol
            )
          INVALID_BASE64_IMAGE =
            T.let(
              :invalid_base64_image,
              OpenAI::Beta::BetaResponseError::Code::TaggedSymbol
            )
          INVALID_IMAGE_URL =
            T.let(
              :invalid_image_url,
              OpenAI::Beta::BetaResponseError::Code::TaggedSymbol
            )
          IMAGE_TOO_LARGE =
            T.let(
              :image_too_large,
              OpenAI::Beta::BetaResponseError::Code::TaggedSymbol
            )
          IMAGE_TOO_SMALL =
            T.let(
              :image_too_small,
              OpenAI::Beta::BetaResponseError::Code::TaggedSymbol
            )
          IMAGE_PARSE_ERROR =
            T.let(
              :image_parse_error,
              OpenAI::Beta::BetaResponseError::Code::TaggedSymbol
            )
          IMAGE_CONTENT_POLICY_VIOLATION =
            T.let(
              :image_content_policy_violation,
              OpenAI::Beta::BetaResponseError::Code::TaggedSymbol
            )
          INVALID_IMAGE_MODE =
            T.let(
              :invalid_image_mode,
              OpenAI::Beta::BetaResponseError::Code::TaggedSymbol
            )
          IMAGE_FILE_TOO_LARGE =
            T.let(
              :image_file_too_large,
              OpenAI::Beta::BetaResponseError::Code::TaggedSymbol
            )
          UNSUPPORTED_IMAGE_MEDIA_TYPE =
            T.let(
              :unsupported_image_media_type,
              OpenAI::Beta::BetaResponseError::Code::TaggedSymbol
            )
          EMPTY_IMAGE_FILE =
            T.let(
              :empty_image_file,
              OpenAI::Beta::BetaResponseError::Code::TaggedSymbol
            )
          FAILED_TO_DOWNLOAD_IMAGE =
            T.let(
              :failed_to_download_image,
              OpenAI::Beta::BetaResponseError::Code::TaggedSymbol
            )
          IMAGE_FILE_NOT_FOUND =
            T.let(
              :image_file_not_found,
              OpenAI::Beta::BetaResponseError::Code::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[OpenAI::Beta::BetaResponseError::Code::TaggedSymbol]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
