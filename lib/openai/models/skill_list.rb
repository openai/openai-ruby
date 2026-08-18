# frozen_string_literal: true

module OpenAI
  module Models
    class SkillList < OpenAI::Internal::Type::BaseModel
      # @!attribute data
      #   A list of items
      #
      #   @return [Array<OpenAI::Models::Skill>]
      required :data, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Skill] }

      # @!attribute first_id
      #   The ID of the first item in the list.
      #
      #   @return [String, nil]
      required :first_id, String, nil?: true

      # @!attribute has_more
      #   Whether there are more items available.
      #
      #   @return [Boolean]
      required :has_more, OpenAI::Internal::Type::Boolean

      # @!attribute last_id
      #   The ID of the last item in the list.
      #
      #   @return [String, nil]
      required :last_id, String, nil?: true

      # @!attribute object
      #   The type of object returned, must be `list`.
      #
      #   @return [Symbol, :list]
      required :object, const: :list

      # @!method initialize(data:, first_id:, has_more:, last_id:, object: :list)
      #   @param data [Array<OpenAI::Models::Skill>] A list of items
      #
      #   @param first_id [String, nil] The ID of the first item in the list.
      #
      #   @param has_more [Boolean] Whether there are more items available.
      #
      #   @param last_id [String, nil] The ID of the last item in the list.
      #
      #   @param object [Symbol, :list] The type of object returned, must be `list`.
    end
  end
end
