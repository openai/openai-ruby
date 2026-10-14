# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Uploads#create
    class UploadCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute bytes
      #   The number of bytes in the file you are uploading.
      #
      #   @return [Integer]
      required :bytes, Integer

      # @!attribute filename
      #   The name of the file to upload.
      #
      #   @return [String]
      required :filename, String

      # @!attribute mime_type
      #   The MIME type of the file.
      #
      #   This must fall within the supported MIME types for your file purpose. See the
      #   supported MIME types for assistants and vision.
      #
      #   @return [String]
      required :mime_type, String

      # @!attribute purpose
      #   The intended purpose of the uploaded file.
      #
      #   See the
      #   [documentation on File purposes](https://developers.openai.com/api/reference/resources/files/methods/create#%28resource%29%20files%20%3E%20%28method%29%20create%20%3E%20%28params%29%200%20%3E%20%28param%29%20purpose%20%3E%20%28schema%29).
      #
      #   @return [Symbol, OpenAI::Models::FilePurpose]
      required :purpose, enum: -> { OpenAI::FilePurpose }

      # @!attribute expires_after
      #   The expiration policy for a file. By default, files with `purpose=batch` expire
      #   after 30 days and all other files are persisted until they are manually deleted.
      #
      #   @return [OpenAI::Models::UploadCreateParams::ExpiresAfter, nil]
      optional :expires_after, -> { OpenAI::UploadCreateParams::ExpiresAfter }

      # @!method initialize(bytes:, filename:, mime_type:, purpose:, expires_after: nil, request_options: {})
      #   @param bytes [Integer]
      #     The number of bytes in the file you are uploading.
      #
      #   @param filename [String]
      #     The name of the file to upload.
      #
      #   @param mime_type [String]
      #     The MIME type of the file.
      #
      #     This must fall within the supported MIME types for your file purpose. See the
      #     supported MIME types for assistants and vision.
      #
      #   @param purpose [Symbol, OpenAI::Models::FilePurpose]
      #     The intended purpose of the uploaded file.
      #
      #     See the
      #     [documentation on File purposes](https://developers.openai.com/api/reference/resources/files/methods/create#%28resource%29%20files%20%3E%20%28method%29%20create%20%3E%20%28params%29%200%20%3E%20%28param%29%20purpose%20%3E%20%28schema%29).
      #
      #   @param expires_after [OpenAI::Models::UploadCreateParams::ExpiresAfter]
      #     The expiration policy for a file. By default, files with `purpose=batch` expire
      #     after 30 days and all other files are persisted until they are manually deleted.
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

      class ExpiresAfter < OpenAI::Internal::Type::BaseModel
        # @!attribute anchor
        #   Anchor timestamp after which the expiration policy applies. Supported anchors:
        #   `created_at`.
        #
        #   @return [Symbol, :created_at]
        required :anchor, const: :created_at

        # @!attribute seconds
        #   The number of seconds after the anchor time that the file will expire. Must be
        #   between 3600 (1 hour) and 2592000 (30 days).
        #
        #   @return [Integer]
        required :seconds, Integer

        # @!method initialize(seconds:, anchor: :created_at)
        #   The expiration policy for a file. By default, files with `purpose=batch` expire
        #   after 30 days and all other files are persisted until they are manually deleted.
        #
        #   @param seconds [Integer]
        #     The number of seconds after the anchor time that the file will expire. Must be
        #     between 3600 (1 hour) and 2592000 (30 days).
        #
        #   @param anchor [Symbol, :created_at]
        #     Anchor timestamp after which the expiration policy applies. Supported anchors:
        #     `created_at`.
      end
    end
  end
end
