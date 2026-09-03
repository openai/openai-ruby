# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseError < OpenAI::Internal::Type::BaseModel
        # @!attribute code
        #   The error code for the response.
        #
        #   @return [Symbol, OpenAI::Models::Beta::BetaResponseError::Code]
        required :code, enum: -> { OpenAI::Beta::BetaResponseError::Code }

        # @!attribute message
        #   A human-readable description of the error.
        #
        #   @return [String]
        required :message, String

        # @!attribute misalignment
        #
        #   @return [OpenAI::Models::Beta::BetaResponseError::Misalignment, nil]
        optional :misalignment, -> { OpenAI::Beta::BetaResponseError::Misalignment }

        # @!method initialize(code:, message:, misalignment: nil)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseError} for more details.
        #
        #   An error object returned when the model fails to generate a Response.
        #
        #   @param code [Symbol, OpenAI::Models::Beta::BetaResponseError::Code] The error code for the response.
        #
        #   @param message [String] A human-readable description of the error.
        #
        #   @param misalignment [OpenAI::Models::Beta::BetaResponseError::Misalignment]

        # The error code for the response.
        #
        # @see OpenAI::Models::Beta::BetaResponseError#code
        module Code
          extend OpenAI::Internal::Type::Enum

          SERVER_ERROR = :server_error
          RATE_LIMIT_EXCEEDED = :rate_limit_exceeded
          INVALID_PROMPT = :invalid_prompt
          DATA_RESIDENCY_MISMATCH = :data_residency_mismatch
          BIO_POLICY = :bio_policy
          MISALIGNMENT_POLICY_VIOLATION = :misalignment_policy_violation
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

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @see OpenAI::Models::Beta::BetaResponseError#misalignment
        class Misalignment < OpenAI::Internal::Type::BaseModel
          # @!attribute detailed_explanation
          #   The public explanation for this block.
          #
          #   @return [String, nil]
          optional :detailed_explanation, String

          # @!attribute error_type
          #   An optional classification; clients must accept additional values.
          #
          #   @return [String, Symbol, OpenAI::Models::Beta::BetaResponseError::Misalignment::ErrorType, nil]
          optional :error_type, union: -> { OpenAI::Beta::BetaResponseError::Misalignment::ErrorType }

          # @!attribute steer
          #   An optional public continuation instruction.
          #
          #   @return [OpenAI::Models::Beta::BetaResponseError::Misalignment::Steer, nil]
          optional :steer, -> { OpenAI::Beta::BetaResponseError::Misalignment::Steer }

          # @!method initialize(detailed_explanation: nil, error_type: nil, steer: nil)
          #   @param detailed_explanation [String] The public explanation for this block.
          #
          #   @param error_type [String, Symbol, OpenAI::Models::Beta::BetaResponseError::Misalignment::ErrorType] An optional classification; clients must accept additional values.
          #
          #   @param steer [OpenAI::Models::Beta::BetaResponseError::Misalignment::Steer] An optional public continuation instruction.

          # An optional classification; clients must accept additional values.
          #
          # @see OpenAI::Models::Beta::BetaResponseError::Misalignment#error_type
          module ErrorType
            extend OpenAI::Internal::Type::Union

            variant String

            variant(
              const: -> {
                OpenAI::Models::Beta::BetaResponseError::Misalignment::ErrorType::POTENTIALLY_UNINTENDED_DATA_TRANSFER
              }
            )

            variant(
              const: -> {
                OpenAI::Models::Beta::BetaResponseError::Misalignment::ErrorType::POTENTIALLY_UNINTENDED_DATA_ACCESS
              }
            )

            variant(
              const: -> {
                OpenAI::Models::Beta::BetaResponseError::Misalignment::ErrorType::POTENTIALLY_UNINTENDED_DESTRUCTIVE_ACTIVITY
              }
            )

            variant const: -> { OpenAI::Models::Beta::BetaResponseError::Misalignment::ErrorType::OTHER }

            # @!method self.variants
            #   @return [Array(String, Symbol)]

            define_sorbet_constant!(:Variants) do
              T.type_alias { T.any(String, OpenAI::Beta::BetaResponseError::Misalignment::ErrorType::TaggedSymbol) }
            end

            # @!group

            POTENTIALLY_UNINTENDED_DATA_TRANSFER = :potentially_unintended_data_transfer
            POTENTIALLY_UNINTENDED_DATA_ACCESS = :potentially_unintended_data_access
            POTENTIALLY_UNINTENDED_DESTRUCTIVE_ACTIVITY = :potentially_unintended_destructive_activity
            OTHER = :other

            # @!endgroup
          end

          # @see OpenAI::Models::Beta::BetaResponseError::Misalignment#steer
          class Steer < OpenAI::Internal::Type::BaseModel
            # @!attribute message
            #   The public continuation instruction.
            #
            #   @return [String]
            required :message, String

            # @!method initialize(message:)
            #   An optional public continuation instruction.
            #
            #   @param message [String] The public continuation instruction.
          end
        end
      end
    end

    BetaResponseError = Beta::BetaResponseError
  end
end
