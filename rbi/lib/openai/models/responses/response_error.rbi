# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseError < OpenAI::BaseModel
        # The error code for the response.
        sig { returns(Symbol) }
        def code
        end

        sig { params(_: Symbol).returns(Symbol) }
        def code=(_)
        end

        # A human-readable description of the error.
        sig { returns(String) }
        def message
        end

        sig { params(_: String).returns(String) }
        def message=(_)
        end

        # An error object returned when the model fails to generate a Response.
        sig { params(code: Symbol, message: String).returns(T.attached_class) }
        def self.new(code:, message:)
        end

        sig { override.returns({code: Symbol, message: String}) }
        def to_hash
        end

        # The error code for the response.
        class Code < OpenAI::Enum
          abstract!

          SERVER_ERROR = :server_error
          RATE_LIMIT_EXCEEDED = :rate_limit_exceeded
          INVALID_PROMPT = :invalid_prompt
          VECTOR_STORE_TIMEOUT = :vector_store_timeout
          INVALID_IMAGE = :invalid_image
          INVALID_IMAGE_FORMAT = :invalid_image_format
          INVALID_BASE64_IMAGE = :invalid_base64_image
          INVALID_IMAGE_URL = :invalid_image_url
          IMAGE_TOO_LARGE = :image_too_large
          IMAGE_TOO_SMALL = :image_too_small
          IMAGE_PARSE_ERROR = :image_parse_error
          IMAGE_CONTENT_POLICY_VIOLATION = :image_content_policy_violation
          INVALID_IMAGE_MODE = :invalid_image_mode
          IMAGE_FILE_TOO_LARGE = :image_file_too_large
          UNSUPPORTED_IMAGE_MEDIA_TYPE = :unsupported_image_media_type
          EMPTY_IMAGE_FILE = :empty_image_file
          FAILED_TO_DOWNLOAD_IMAGE = :failed_to_download_image
          IMAGE_FILE_NOT_FOUND = :image_file_not_found

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end
      end
    end
  end
end
