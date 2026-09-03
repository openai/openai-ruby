# typed: strong

module OpenAI
  module Models

    module Responses

      class ResponseError < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Responses::ResponseError,
            OpenAI::Internal::AnyHash
          )
        end

        # The error code for the response.
        sig { returns(OpenAI::Responses::ResponseError::Code::TaggedSymbol) }
        attr_accessor :code

        # A human-readable description of the error.
        sig { returns(String) }
        attr_accessor :message

        sig { returns(T.nilable(OpenAI::Responses::ResponseError::Misalignment)) }
        attr_reader :misalignment

        sig { params(misalignment: OpenAI::Responses::ResponseError::Misalignment::OrHash).void }
        attr_writer :misalignment

        # An error object returned when the model fails to generate a Response.
        sig do
          params(

            code: OpenAI::Responses::ResponseError::Code::OrSymbol,

            message: String,

            misalignment: OpenAI::Responses::ResponseError::Misalignment::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The error code for the response.
          code:,

          # A human-readable description of the error.
          message:,

          misalignment: nil
        )
        end

        sig do
          override.returns(
            {
              code: OpenAI::Responses::ResponseError::Code::TaggedSymbol,
              message: String,
              misalignment: OpenAI::Responses::ResponseError::Misalignment
            }
          )
        end
        def to_hash
        end

        # The error code for the response.
        module Code
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Responses::ResponseError::Code) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          SERVER_ERROR = T.let(:server_error, OpenAI::Responses::ResponseError::Code::TaggedSymbol)
          RATE_LIMIT_EXCEEDED = T.let(:rate_limit_exceeded, OpenAI::Responses::ResponseError::Code::TaggedSymbol)
          INVALID_PROMPT = T.let(:invalid_prompt, OpenAI::Responses::ResponseError::Code::TaggedSymbol)
          DATA_RESIDENCY_MISMATCH = T.let(
            :data_residency_mismatch,
            OpenAI::Responses::ResponseError::Code::TaggedSymbol
          )
          BIO_POLICY = T.let(:bio_policy, OpenAI::Responses::ResponseError::Code::TaggedSymbol)
          MISALIGNMENT_POLICY_VIOLATION = T.let(
            :misalignment_policy_violation,
            OpenAI::Responses::ResponseError::Code::TaggedSymbol
          )
          VECTOR_STORE_TIMEOUT = T.let(:vector_store_timeout, OpenAI::Responses::ResponseError::Code::TaggedSymbol)
          INVALID_IMAGE = T.let(:invalid_image, OpenAI::Responses::ResponseError::Code::TaggedSymbol)
          INVALID_IMAGE_FORMAT = T.let(:invalid_image_format, OpenAI::Responses::ResponseError::Code::TaggedSymbol)
          INVALID_BASE64_IMAGE = T.let(:invalid_base64_image, OpenAI::Responses::ResponseError::Code::TaggedSymbol)
          INVALID_IMAGE_URL = T.let(:invalid_image_url, OpenAI::Responses::ResponseError::Code::TaggedSymbol)
          IMAGE_TOO_LARGE = T.let(:image_too_large, OpenAI::Responses::ResponseError::Code::TaggedSymbol)
          IMAGE_TOO_SMALL = T.let(:image_too_small, OpenAI::Responses::ResponseError::Code::TaggedSymbol)
          IMAGE_PARSE_ERROR = T.let(:image_parse_error, OpenAI::Responses::ResponseError::Code::TaggedSymbol)
          IMAGE_CONTENT_POLICY_VIOLATION = T.let(
            :image_content_policy_violation,
            OpenAI::Responses::ResponseError::Code::TaggedSymbol
          )
          INVALID_IMAGE_MODE = T.let(:invalid_image_mode, OpenAI::Responses::ResponseError::Code::TaggedSymbol)
          IMAGE_FILE_TOO_LARGE = T.let(:image_file_too_large, OpenAI::Responses::ResponseError::Code::TaggedSymbol)
          UNSUPPORTED_IMAGE_MEDIA_TYPE = T.let(
            :unsupported_image_media_type,
            OpenAI::Responses::ResponseError::Code::TaggedSymbol
          )
          EMPTY_IMAGE_FILE = T.let(:empty_image_file, OpenAI::Responses::ResponseError::Code::TaggedSymbol)
          FAILED_TO_DOWNLOAD_IMAGE = T.let(
            :failed_to_download_image,
            OpenAI::Responses::ResponseError::Code::TaggedSymbol
          )
          IMAGE_FILE_NOT_FOUND = T.let(:image_file_not_found, OpenAI::Responses::ResponseError::Code::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Responses::ResponseError::Code::TaggedSymbol]) }
          def self.values
          end
        end

        class Misalignment < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Responses::ResponseError::Misalignment,
              OpenAI::Internal::AnyHash
            )
          end

          # The public explanation for this block.
          sig { returns(T.nilable(String)) }
          attr_reader :detailed_explanation

          sig { params(detailed_explanation: String).void }
          attr_writer :detailed_explanation

          # An optional classification; clients must accept additional values.
          sig { returns(T.nilable(OpenAI::Responses::ResponseError::Misalignment::ErrorType::Variants)) }
          attr_reader :error_type

          sig {
            params(error_type: T.any(String, OpenAI::Responses::ResponseError::Misalignment::ErrorType::OrSymbol)).void
          }
          attr_writer :error_type

          # An optional public continuation instruction.
          sig { returns(T.nilable(OpenAI::Responses::ResponseError::Misalignment::Steer)) }
          attr_reader :steer

          sig { params(steer: OpenAI::Responses::ResponseError::Misalignment::Steer::OrHash).void }
          attr_writer :steer

          sig do
            params(

              detailed_explanation: String,

              error_type: T.any(String, OpenAI::Responses::ResponseError::Misalignment::ErrorType::OrSymbol),

              steer: OpenAI::Responses::ResponseError::Misalignment::Steer::OrHash
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The public explanation for this block.
            detailed_explanation: nil,

            # An optional classification; clients must accept additional values.
            error_type: nil,

            # An optional public continuation instruction.

            steer: nil
          )
          end

          sig do
            override.returns(
              {
                detailed_explanation: String,
                error_type: OpenAI::Responses::ResponseError::Misalignment::ErrorType::Variants,
                steer: OpenAI::Responses::ResponseError::Misalignment::Steer
              }
            )
          end
          def to_hash
          end

          # An optional classification; clients must accept additional values.
          module ErrorType
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias {
              T.any(String, OpenAI::Responses::ResponseError::Misalignment::ErrorType::TaggedSymbol)
            }

            sig { override.returns(T::Array[OpenAI::Responses::ResponseError::Misalignment::ErrorType::Variants]) }
            def self.variants
            end

            TaggedSymbol = T.type_alias do
              T.all(Symbol, OpenAI::Responses::ResponseError::Misalignment::ErrorType)
            end

            OrSymbol = T.type_alias { T.any(Symbol, String) }

            POTENTIALLY_UNINTENDED_DATA_TRANSFER = T.let(
              :potentially_unintended_data_transfer,
              OpenAI::Responses::ResponseError::Misalignment::ErrorType::TaggedSymbol
            )
            POTENTIALLY_UNINTENDED_DATA_ACCESS = T.let(
              :potentially_unintended_data_access,
              OpenAI::Responses::ResponseError::Misalignment::ErrorType::TaggedSymbol
            )
            POTENTIALLY_UNINTENDED_DESTRUCTIVE_ACTIVITY = T.let(
              :potentially_unintended_destructive_activity,
              OpenAI::Responses::ResponseError::Misalignment::ErrorType::TaggedSymbol
            )
            OTHER = T.let(:other, OpenAI::Responses::ResponseError::Misalignment::ErrorType::TaggedSymbol)

          end

          class Steer < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Responses::ResponseError::Misalignment::Steer,
                OpenAI::Internal::AnyHash
              )
            end

            # The public continuation instruction.
            sig { returns(String) }
            attr_accessor :message

            # An optional public continuation instruction.
            sig do
              params(

                message: String
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The public continuation instruction.

              message:
            )
            end

            sig do
              override.returns(
                {message: String}
              )
            end
            def to_hash
            end

          end
        end

      end

    end

  end
end
