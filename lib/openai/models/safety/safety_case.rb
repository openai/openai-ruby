# frozen_string_literal: true

module OpenAI
  module Models
    module Safety
      # @see OpenAI::Resources::Safety::Cases#retrieve
      class SafetyCase < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute entity_identifier
        #
        #   @return [String]
        required :entity_identifier, String

        # @!attribute notice
        #
        #   @return [OpenAI::Models::Safety::SafetyCase::Notice]
        required :notice, -> { OpenAI::Safety::SafetyCase::Notice }

        # @!attribute object
        #
        #   @return [Symbol, :"safety.case"]
        required :object, const: :"safety.case"

        # @!attribute reason
        #
        #   @return [String, nil]
        required :reason, String, nil?: true

        # @!method initialize(id:, created_at:, entity_identifier:, notice:, reason:, object: :"safety.case")
        #   @param id [String]
        #   @param created_at [Integer]
        #   @param entity_identifier [String]
        #   @param notice [OpenAI::Models::Safety::SafetyCase::Notice]
        #   @param reason [String, nil]
        #   @param object [Symbol, :"safety.case"]

        # @see OpenAI::Models::Safety::SafetyCase#notice
        class Notice < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #
          #   @return [Symbol, OpenAI::Models::Safety::SafetyCase::Notice::Type]
          required :type, enum: -> { OpenAI::Safety::SafetyCase::Notice::Type }

          # @!method initialize(type:)
          #   @param type [Symbol, OpenAI::Models::Safety::SafetyCase::Notice::Type]

          # @see OpenAI::Models::Safety::SafetyCase::Notice#type
          module Type
            extend OpenAI::Internal::Type::Enum

            WARNING = :warning
            DEACTIVATION = :deactivation

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end

    SafetyCase = Safety::SafetyCase
  end
end
