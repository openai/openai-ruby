# frozen_string_literal: true

module OpenAI
  module Models
    class ErrorObject < OpenAI::Internal::Type::BaseModel
      # @!attribute code
      #
      #   @return [String, nil]
      required :code, String, nil?: true

      # @!attribute message
      #
      #   @return [String]
      required :message, String

      # @!attribute param
      #
      #   @return [String, nil]
      required :param, String, nil?: true

      # @!attribute type
      #
      #   @return [String]
      required :type, String

      # @!attribute misalignment
      #
      #   @return [OpenAI::Models::ErrorObject::Misalignment, nil]
      optional :misalignment, -> { OpenAI::ErrorObject::Misalignment }

      # @!method initialize(code:, message:, param:, type:, misalignment: nil)
      #   @param code [String, nil]
      #   @param message [String]
      #   @param param [String, nil]
      #   @param type [String]
      #   @param misalignment [OpenAI::Models::ErrorObject::Misalignment]

      # @see OpenAI::Models::ErrorObject#misalignment
      class Misalignment < OpenAI::Internal::Type::BaseModel
        # @!attribute detailed_explanation
        #   The public explanation for this block.
        #
        #   @return [String, nil]
        optional :detailed_explanation, String

        # @!attribute error_type
        #   An optional classification; clients must accept additional values.
        #
        #   @return [String, Symbol, OpenAI::Models::ErrorObject::Misalignment::ErrorType, nil]
        optional :error_type, union: -> { OpenAI::ErrorObject::Misalignment::ErrorType }

        # @!attribute steer
        #   An optional public continuation instruction.
        #
        #   @return [OpenAI::Models::ErrorObject::Misalignment::Steer, nil]
        optional :steer, -> { OpenAI::ErrorObject::Misalignment::Steer }

        # @!method initialize(detailed_explanation: nil, error_type: nil, steer: nil)
        #   @param detailed_explanation [String] The public explanation for this block.
        #
        #   @param error_type [String, Symbol, OpenAI::Models::ErrorObject::Misalignment::ErrorType] An optional classification; clients must accept additional values.
        #
        #   @param steer [OpenAI::Models::ErrorObject::Misalignment::Steer] An optional public continuation instruction.

        # An optional classification; clients must accept additional values.
        #
        # @see OpenAI::Models::ErrorObject::Misalignment#error_type
        module ErrorType
          extend OpenAI::Internal::Type::Union

          variant String

          variant(
            const: -> { OpenAI::Models::ErrorObject::Misalignment::ErrorType::POTENTIALLY_UNINTENDED_DATA_TRANSFER }
          )

          variant(
            const: -> { OpenAI::Models::ErrorObject::Misalignment::ErrorType::POTENTIALLY_UNINTENDED_DATA_ACCESS }
          )

          variant(
            const: -> {
              OpenAI::Models::ErrorObject::Misalignment::ErrorType::POTENTIALLY_UNINTENDED_DESTRUCTIVE_ACTIVITY
            }
          )

          variant const: -> { OpenAI::Models::ErrorObject::Misalignment::ErrorType::OTHER }

          # @!method self.variants
          #   @return [Array(String, Symbol)]

          define_sorbet_constant!(:Variants) do
            T.type_alias { T.any(String, OpenAI::ErrorObject::Misalignment::ErrorType::TaggedSymbol) }
          end

          # @!group

          POTENTIALLY_UNINTENDED_DATA_TRANSFER = :potentially_unintended_data_transfer
          POTENTIALLY_UNINTENDED_DATA_ACCESS = :potentially_unintended_data_access
          POTENTIALLY_UNINTENDED_DESTRUCTIVE_ACTIVITY = :potentially_unintended_destructive_activity
          OTHER = :other

          # @!endgroup
        end

        # @see OpenAI::Models::ErrorObject::Misalignment#steer
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
