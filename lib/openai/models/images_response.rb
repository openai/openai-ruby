# frozen_string_literal: true

module OpenAI
  module Models
    class ImagesResponse < OpenAI::BaseModel
      # @!attribute created
      #
      #   @return [Integer]
      required :created, Integer

      # @!attribute data
      #
      #   @return [Array<OpenAI::Models::Image>]
      required :data, -> { OpenAI::ArrayOf[OpenAI::Models::Image] }

      # @!parse
      #   # @param created [Integer]
      #   # @param data [Array<OpenAI::Models::Image>]
      #   #
      #   def initialize(created:, data:, **) = super

      # def initialize: (Hash | OpenAI::BaseModel) -> void
    end
  end
end
