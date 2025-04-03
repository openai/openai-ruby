# frozen_string_literal: true

module OpenAI
  module Models
    module Uploads
      # @see OpenAI::Resources::Uploads::Parts#create
      class UploadPart < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The upload Part unique identifier, which can be referenced in API endpoints.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   The Unix timestamp (in seconds) for when the Part was created.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute object
        #   The object type, which is always `upload.part`.
        #
        #   @return [Symbol, :"upload.part"]
        required :object, const: :"upload.part"

        # @!attribute upload_id
        #   The ID of the Upload object that this Part was added to.
        #
        #   @return [String]
        required :upload_id, String

        # @!parse
        #   # The upload Part represents a chunk of bytes we can add to an Upload object.
        #   #
        #   # @param id [String]
        #   # @param created_at [Integer]
        #   # @param upload_id [String]
        #   # @param object [Symbol, :"upload.part"]
        #   #
        #   def initialize(id:, created_at:, upload_id:, object: :"upload.part", **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end

    UploadPart = Uploads::UploadPart
  end
end
