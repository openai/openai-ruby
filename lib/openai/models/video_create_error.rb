# frozen_string_literal: true

module OpenAI
  module Models
    class VideoCreateError < OpenAI::Internal::Type::BaseModel
      # @!attribute code
      #   A machine-readable error code that was returned.
      #
      #   @return [String]
      required :code, String

      # @!attribute message
      #   A human-readable description of the error that was returned.
      #
      #   @return [String]
      required :message, String

      # @!attribute misalignment
      #
      #   @return [OpenAI::Models::VideoCreateError::Misalignment, nil]
      optional :misalignment, -> { OpenAI::VideoCreateError::Misalignment }

      # @!method initialize(code:, message:, misalignment: nil)
      #   An error that occurred while generating the response.
      #
      #   @param code [String] A machine-readable error code that was returned.
      #
      #   @param message [String] A human-readable description of the error that was returned.
      #
      #   @param misalignment [OpenAI::Models::VideoCreateError::Misalignment]

      # @see OpenAI::Models::VideoCreateError#misalignment
      class Misalignment < OpenAI::Internal::Type::BaseModel
        # @!attribute detailed_explanation
        #   The public explanation for this block.
        #
        #   @return [String, nil]
        optional :detailed_explanation, String

        # @!attribute error_type
        #   An optional classification; clients must accept additional values.
        #
        #   @return [String, Symbol, OpenAI::Models::VideoCreateError::Misalignment::ErrorType, nil]
        optional :error_type, union: -> { OpenAI::VideoCreateError::Misalignment::ErrorType }

        # @!attribute steer
        #   An optional public continuation instruction.
        #
        #   @return [OpenAI::Models::VideoCreateError::Misalignment::Steer, nil]
        optional :steer, -> { OpenAI::VideoCreateError::Misalignment::Steer }

        # @!method initialize(detailed_explanation: nil, error_type: nil, steer: nil)
        #   @param detailed_explanation [String] The public explanation for this block.
        #
        #   @param error_type [String, Symbol, OpenAI::Models::VideoCreateError::Misalignment::ErrorType] An optional classification; clients must accept additional values.
        #
        #   @param steer [OpenAI::Models::VideoCreateError::Misalignment::Steer] An optional public continuation instruction.

        # An optional classification; clients must accept additional values.
        #
        # @see OpenAI::Models::VideoCreateError::Misalignment#error_type
        module ErrorType
          extend OpenAI::Internal::Type::Union

          variant String

          variant(
            const: -> {
              OpenAI::Models::VideoCreateError::Misalignment::ErrorType::POTENTIALLY_UNINTENDED_DATA_TRANSFER
            }
          )

          variant(
            const: -> { OpenAI::Models::VideoCreateError::Misalignment::ErrorType::POTENTIALLY_UNINTENDED_DATA_ACCESS }
          )

          variant(
            const: -> {
              OpenAI::Models::VideoCreateError::Misalignment::ErrorType::POTENTIALLY_UNINTENDED_DESTRUCTIVE_ACTIVITY
            }
          )

          variant const: -> { OpenAI::Models::VideoCreateError::Misalignment::ErrorType::OTHER }

          # @!method self.variants
          #   @return [Array(String, Symbol)]

          define_sorbet_constant!(:Variants) do
            T.type_alias { T.any(String, OpenAI::VideoCreateError::Misalignment::ErrorType::TaggedSymbol) }
          end

          # @!group

          POTENTIALLY_UNINTENDED_DATA_TRANSFER = :potentially_unintended_data_transfer
          POTENTIALLY_UNINTENDED_DATA_ACCESS = :potentially_unintended_data_access
          POTENTIALLY_UNINTENDED_DESTRUCTIVE_ACTIVITY = :potentially_unintended_destructive_activity
          OTHER = :other

          # @!endgroup
        end

        # @see OpenAI::Models::VideoCreateError::Misalignment#steer
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
end
