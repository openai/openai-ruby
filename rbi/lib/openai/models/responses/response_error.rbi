# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseError < OpenAI::Internal::Type::BaseModel
        # The error code for the response.
        sig { returns(OpenAI::Models::Responses::ResponseError::Code::TaggedSymbol) }
        attr_accessor :code

        # A human-readable description of the error.
        sig { returns(String) }
        attr_accessor :message

        # An error object returned when the model fails to generate a Response.
        sig do
          params(code: OpenAI::Models::Responses::ResponseError::Code::OrSymbol, message: String)
            .returns(T.attached_class)
        end
        def self.new(code:, message:); end

        sig { override.returns({code: OpenAI::Models::Responses::ResponseError::Code::TaggedSymbol, message: String}) }
        def to_hash; end

        # The error code for the response.
        module Code
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseError::Code) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          SERVER_ERROR = T.let(:server_error, OpenAI::Models::Responses::ResponseError::Code::TaggedSymbol)
          RATE_LIMIT_EXCEEDED =
            T.let(:rate_limit_exceeded, OpenAI::Models::Responses::ResponseError::Code::TaggedSymbol)
          INVALID_PROMPT = T.let(:invalid_prompt, OpenAI::Models::Responses::ResponseError::Code::TaggedSymbol)
          VECTOR_STORE_TIMEOUT =
            T.let(:vector_store_timeout, OpenAI::Models::Responses::ResponseError::Code::TaggedSymbol)
          INVALID_IMAGE = T.let(:invalid_image, OpenAI::Models::Responses::ResponseError::Code::TaggedSymbol)
          INVALID_IMAGE_FORMAT =
            T.let(:invalid_image_format, OpenAI::Models::Responses::ResponseError::Code::TaggedSymbol)
          INVALID_BASE64_IMAGE =
            T.let(:invalid_base64_image, OpenAI::Models::Responses::ResponseError::Code::TaggedSymbol)
          INVALID_IMAGE_URL =
            T.let(:invalid_image_url, OpenAI::Models::Responses::ResponseError::Code::TaggedSymbol)
          IMAGE_TOO_LARGE = T.let(:image_too_large, OpenAI::Models::Responses::ResponseError::Code::TaggedSymbol)
          IMAGE_TOO_SMALL = T.let(:image_too_small, OpenAI::Models::Responses::ResponseError::Code::TaggedSymbol)
          IMAGE_PARSE_ERROR =
            T.let(:image_parse_error, OpenAI::Models::Responses::ResponseError::Code::TaggedSymbol)
          IMAGE_CONTENT_POLICY_VIOLATION =
            T.let(:image_content_policy_violation, OpenAI::Models::Responses::ResponseError::Code::TaggedSymbol)
          INVALID_IMAGE_MODE =
            T.let(:invalid_image_mode, OpenAI::Models::Responses::ResponseError::Code::TaggedSymbol)
          IMAGE_FILE_TOO_LARGE =
            T.let(:image_file_too_large, OpenAI::Models::Responses::ResponseError::Code::TaggedSymbol)
          UNSUPPORTED_IMAGE_MEDIA_TYPE =
            T.let(:unsupported_image_media_type, OpenAI::Models::Responses::ResponseError::Code::TaggedSymbol)
          EMPTY_IMAGE_FILE = T.let(:empty_image_file, OpenAI::Models::Responses::ResponseError::Code::TaggedSymbol)
          FAILED_TO_DOWNLOAD_IMAGE =
            T.let(:failed_to_download_image, OpenAI::Models::Responses::ResponseError::Code::TaggedSymbol)
          IMAGE_FILE_NOT_FOUND =
            T.let(:image_file_not_found, OpenAI::Models::Responses::ResponseError::Code::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Responses::ResponseError::Code::TaggedSymbol]) }
          def self.values; end
        end
      end
    end
  end
end
