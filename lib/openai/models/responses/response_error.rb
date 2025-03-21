# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseError < OpenAI::BaseModel
        # @!attribute code
        #   The error code for the response.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseError::Code]
        required :code, enum: -> { OpenAI::Models::Responses::ResponseError::Code }

        # @!attribute message
        #   A human-readable description of the error.
        #
        #   @return [String]
        required :message, String

        # @!parse
        #   # An error object returned when the model fails to generate a Response.
        #   #
        #   # @param code [Symbol, OpenAI::Models::Responses::ResponseError::Code]
        #   # @param message [String]
        #   #
        #   def initialize(code:, message:, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # The error code for the response.
        module Code
          extend OpenAI::Enum

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

          finalize!

          # @!parse
          #   # @return [Array<Symbol>]
          #   def self.values; end
        end
      end
    end
  end
end
