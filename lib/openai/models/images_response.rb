# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Images#create_variation
    class ImagesResponse < OpenAI::Internal::Type::BaseModel
      # @!attribute created
      #
      #   @return [Integer]
      required :created, Integer

      # @!attribute data
      #
      #   @return [Array<OpenAI::Models::Image>]
      required :data, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Image] }

      # @!method initialize(created:, data:)
      #   @param created [Integer]
      #   @param data [Array<OpenAI::Models::Image>]
    end
  end
end
