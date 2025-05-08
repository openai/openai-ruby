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

          # @!attribute refusal
          #
          #   @return [String, nil]
          optional :refusal, String

          # @!method initialize(index:, refusal: nil, type: :refusal)
          #   The refusal content that is part of a message.
          #
          #   @param index [Integer] The index of the refusal part in the message.
          #
          #   @param refusal [String]
          #
          #   @param type [Symbol, :refusal] Always `refusal`.
        end
      end
    end
  end
end
