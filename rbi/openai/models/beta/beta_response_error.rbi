# typed: strong

module OpenAI
  module Models

    BetaResponseError = Beta::BetaResponseError

    module Beta

      class BetaResponseError < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::BetaResponseError,
            OpenAI::Internal::AnyHash
          )
        end

        # The error code for the response.
        sig { returns(OpenAI::Beta::BetaResponseError::Code::TaggedSymbol) }
        attr_accessor :code

        # A human-readable description of the error.
        sig { returns(String) }
        attr_accessor :message

        sig { returns(T.nilable(OpenAI::Beta::BetaResponseError::Misalignment)) }
        attr_reader :misalignment

        sig { params(misalignment: OpenAI::Beta::BetaResponseError::Misalignment::OrHash).void }
        attr_writer :misalignment

        # An error object returned when the model fails to generate a Response.
        sig do
          params(

            code: OpenAI::Beta::BetaResponseError::Code::OrSymbol,

            message: String,

            misalignment: OpenAI::Beta::BetaResponseError::Misalignment::OrHash
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
              code: OpenAI::Beta::BetaResponseError::Code::TaggedSymbol,
              message: String,
              misalignment: OpenAI::Beta::BetaResponseError::Misalignment
            }
          )
        end
        def to_hash
        end

        # The error code for the response.
        module Code
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::BetaResponseError::Code) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          SERVER_ERROR = T.let(:server_error, OpenAI::Beta::BetaResponseError::Code::TaggedSymbol)
          RATE_LIMIT_EXCEEDED = T.let(:rate_limit_exceeded, OpenAI::Beta::BetaResponseError::Code::TaggedSymbol)
          INVALID_PROMPT = T.let(:invalid_prompt, OpenAI::Beta::BetaResponseError::Code::TaggedSymbol)
          DATA_RESIDENCY_MISMATCH = T.let(:data_residency_mismatch, OpenAI::Beta::BetaResponseError::Code::TaggedSymbol)
          BIO_POLICY = T.let(:bio_policy, OpenAI::Beta::BetaResponseError::Code::TaggedSymbol)
          MISALIGNMENT_POLICY_VIOLATION = T.let(
            :misalignment_policy_violation,
            OpenAI::Beta::BetaResponseError::Code::TaggedSymbol
          )
          VECTOR_STORE_TIMEOUT = T.let(:vector_store_timeout, OpenAI::Beta::BetaResponseError::Code::TaggedSymbol)
          INVALID_IMAGE = T.let(:invalid_image, OpenAI::Beta::BetaResponseError::Code::TaggedSymbol)
          INVALID_IMAGE_FORMAT = T.let(:invalid_image_format, OpenAI::Beta::BetaResponseError::Code::TaggedSymbol)
          INVALID_BASE64_IMAGE = T.let(:invalid_base64_image, OpenAI::Beta::BetaResponseError::Code::TaggedSymbol)
          INVALID_IMAGE_URL = T.let(:invalid_image_url, OpenAI::Beta::BetaResponseError::Code::TaggedSymbol)
          IMAGE_TOO_LARGE = T.let(:image_too_large, OpenAI::Beta::BetaResponseError::Code::TaggedSymbol)
          IMAGE_TOO_SMALL = T.let(:image_too_small, OpenAI::Beta::BetaResponseError::Code::TaggedSymbol)
          IMAGE_PARSE_ERROR = T.let(:image_parse_error, OpenAI::Beta::BetaResponseError::Code::TaggedSymbol)
          IMAGE_CONTENT_POLICY_VIOLATION = T.let(
            :image_content_policy_violation,
            OpenAI::Beta::BetaResponseError::Code::TaggedSymbol
          )
          INVALID_IMAGE_MODE = T.let(:invalid_image_mode, OpenAI::Beta::BetaResponseError::Code::TaggedSymbol)
          IMAGE_FILE_TOO_LARGE = T.let(:image_file_too_large, OpenAI::Beta::BetaResponseError::Code::TaggedSymbol)
          UNSUPPORTED_IMAGE_MEDIA_TYPE = T.let(
            :unsupported_image_media_type,
            OpenAI::Beta::BetaResponseError::Code::TaggedSymbol
          )
          EMPTY_IMAGE_FILE = T.let(:empty_image_file, OpenAI::Beta::BetaResponseError::Code::TaggedSymbol)
          FAILED_TO_DOWNLOAD_IMAGE = T.let(
            :failed_to_download_image,
            OpenAI::Beta::BetaResponseError::Code::TaggedSymbol
          )
          IMAGE_FILE_NOT_FOUND = T.let(:image_file_not_found, OpenAI::Beta::BetaResponseError::Code::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Beta::BetaResponseError::Code::TaggedSymbol]) }
          def self.values
          end
        end

        class Misalignment < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseError::Misalignment,
              OpenAI::Internal::AnyHash
            )
          end

          # The public explanation for this block.
          sig { returns(T.nilable(String)) }
          attr_reader :detailed_explanation

          sig { params(detailed_explanation: String).void }
          attr_writer :detailed_explanation

          # An optional classification; clients must accept additional values.
          sig { returns(T.nilable(OpenAI::Beta::BetaResponseError::Misalignment::ErrorType::Variants)) }
          attr_reader :error_type

          sig {
            params(error_type: T.any(String, OpenAI::Beta::BetaResponseError::Misalignment::ErrorType::OrSymbol)).void
          }
          attr_writer :error_type

          # An optional public continuation instruction.
          sig { returns(T.nilable(OpenAI::Beta::BetaResponseError::Misalignment::Steer)) }
          attr_reader :steer

          sig { params(steer: OpenAI::Beta::BetaResponseError::Misalignment::Steer::OrHash).void }
          attr_writer :steer

          sig do
            params(

              detailed_explanation: String,

              error_type: T.any(String, OpenAI::Beta::BetaResponseError::Misalignment::ErrorType::OrSymbol),

              steer: OpenAI::Beta::BetaResponseError::Misalignment::Steer::OrHash
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
                error_type: OpenAI::Beta::BetaResponseError::Misalignment::ErrorType::Variants,
                steer: OpenAI::Beta::BetaResponseError::Misalignment::Steer
              }
            )
          end
          def to_hash
          end

          # An optional classification; clients must accept additional values.
          module ErrorType
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias {
              T.any(String, OpenAI::Beta::BetaResponseError::Misalignment::ErrorType::TaggedSymbol)
            }

            sig { override.returns(T::Array[OpenAI::Beta::BetaResponseError::Misalignment::ErrorType::Variants]) }
            def self.variants
            end

            TaggedSymbol = T.type_alias do
              T.all(Symbol, OpenAI::Beta::BetaResponseError::Misalignment::ErrorType)
            end

            OrSymbol = T.type_alias { T.any(Symbol, String) }

            POTENTIALLY_UNINTENDED_DATA_TRANSFER = T.let(
              :potentially_unintended_data_transfer,
              OpenAI::Beta::BetaResponseError::Misalignment::ErrorType::TaggedSymbol
            )
            POTENTIALLY_UNINTENDED_DATA_ACCESS = T.let(
              :potentially_unintended_data_access,
              OpenAI::Beta::BetaResponseError::Misalignment::ErrorType::TaggedSymbol
            )
            POTENTIALLY_UNINTENDED_DESTRUCTIVE_ACTIVITY = T.let(
              :potentially_unintended_destructive_activity,
              OpenAI::Beta::BetaResponseError::Misalignment::ErrorType::TaggedSymbol
            )
            OTHER = T.let(:other, OpenAI::Beta::BetaResponseError::Misalignment::ErrorType::TaggedSymbol)

          end

          class Steer < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseError::Misalignment::Steer,
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
