# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class InlineSkillSource < OpenAI::Internal::Type::BaseModel
        # @!attribute data
        #   Base64-encoded skill zip bundle.
        #
        #   @return [String]
        required :data, String

        # @!attribute media_type
        #   The media type of the inline skill payload. Must be `application/zip`.
        #
        #   @return [Symbol, :"application/zip"]
        required :media_type, const: :"application/zip"

        # @!attribute type
        #   The type of the inline skill source. Must be `base64`.
        #
        #   @return [Symbol, :base64]
        required :type, const: :base64

        # @!method initialize(data:, media_type: :"application/zip", type: :base64)
        #   Inline skill payload
        #
        #   @param data [String] Base64-encoded skill zip bundle.
        #
        #   @param media_type [Symbol, :"application/zip"] The media type of the inline skill payload. Must be `application/zip`.
        #
        #   @param type [Symbol, :base64] The type of the inline skill source. Must be `base64`.
      end
    end
  end
end
