# frozen_string_literal: true

module OpenAI
  module Models
    class DecisionInputJSON < OpenAI::Internal::Type::BaseModel
      # @!attribute data
      #
      #   @return [Hash{Symbol=>Object}, Array<Hash{Symbol=>Object}>]
      required :data, union: -> { OpenAI::DecisionInputJSON::Data }

      # @!attribute type
      #
      #   @return [Symbol, :input_json]
      required :type, const: :input_json

      # @!method initialize(data:, type: :input_json)
      #   A JSON object or an array of objects rendered as text. Nested values may be any
      #   JSON value. Limited to 32 container levels, 10,000 values, and 256 KiB of
      #   compact UTF-8 JSON.
      #
      #   @param data [Hash{Symbol=>Object}, Array<Hash{Symbol=>Object}>]
      #   @param type [Symbol, :input_json]

      # @see OpenAI::Models::DecisionInputJSON#data
      module Data
        extend OpenAI::Internal::Type::Union

        variant -> { OpenAI::Models::DecisionInputJSON::Data::UnionMember0Map }

        variant -> { OpenAI::Models::DecisionInputJSON::Data::UnionMember1Array }

        # @!method self.variants
        #   @return [Array(Hash{Symbol=>Object}, Array<Hash{Symbol=>Object, nil}>)]

        # @type [OpenAI::Internal::Type::Converter]
        UnionMember0Map = OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

        # @type [OpenAI::Internal::Type::Converter]
        UnionMember1Array = OpenAI::Internal::Type::ArrayOf[
          OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown, nil?: true]
        ]
      end
    end
  end
end
