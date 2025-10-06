# frozen_string_literal: true

module OpenAI
  module Models
    class VideoCreateError < OpenAI::Internal::Type::BaseModel
      # @!attribute code
      #
      #   @return [String]
      required :code, String

      # @!attribute message
      #
      #   @return [String]
      required :message, String

      # @!method initialize(code:, message:)
      #   @param code [String]
      #   @param message [String]
    end
  end
end
