# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class RefusalDeltaBlock < OpenAI::Internal::Type::BaseModel
          # @!attribute index
          #   The index of the refusal part in the message.
          #
          #   @return [Integer]
          required :index, Integer

          # @!attribute type
          #   Always `refusal`.
          #
          #   @return [Symbol, :refusal]
          required :type, const: :refusal

          # @!attribute [r] refusal
          #
          #   @return [String, nil]
          optional :refusal, String

          # @!parse
          #   # @return [String]
          #   attr_writer :refusal

          # @!method initialize(index:, refusal: nil, type: :refusal)
          #   The refusal content that is part of a message.
          #
          #   @param index [Integer]
          #   @param refusal [String]
          #   @param type [Symbol, :refusal]
        end
      end
    end
  end
end
