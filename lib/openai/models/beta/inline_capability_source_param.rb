# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class InlineCapabilitySourceParam < OpenAI::Internal::Type::BaseModel
        # @!attribute data
        #   Standard-base64 encoded ZIP archive bytes.
        #
        #   @return [String]
        required :data, String

        # @!attribute media_type
        #   The archive media type, always `application/zip`.
        #
        #   @return [Symbol, :"application/zip"]
        required :media_type, const: :"application/zip"

        # @!attribute type
        #   The type of the object. Always `base64`.
        #
        #   @return [Symbol, :base64]
        required :type, const: :base64

        # @!method initialize(data:, media_type: :"application/zip", type: :base64)
        #   Provides ZIP bytes encoded with standard base64.
        #
        #   @param data [String]
        #     Standard-base64 encoded ZIP archive bytes.
        #
        #   @param media_type [Symbol, :"application/zip"]
        #     The archive media type, always `application/zip`.
        #
        #   @param type [Symbol, :base64]
        #     The type of the object. Always `base64`.
      end
    end
  end
end
