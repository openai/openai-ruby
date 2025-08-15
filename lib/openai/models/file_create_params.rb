# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Files#create
    class FileCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute file
      #   The File object (not file name) to be uploaded.
      #
      #   @return [Pathname, StringIO, IO, String, OpenAI::FilePart]
      required :file, OpenAI::Internal::Type::FileInput

      # @!attribute purpose
      #   The intended purpose of the uploaded file. One of: - `assistants`: Used in the
      #   Assistants API - `batch`: Used in the Batch API - `fine-tune`: Used for
      #   fine-tuning - `vision`: Images used for vision fine-tuning - `user_data`:
      #   Flexible file type for any purpose - `evals`: Used for eval data sets
      #
      #   @return [Symbol, OpenAI::Models::FilePurpose]
      required :purpose, enum: -> { OpenAI::FilePurpose }

      # @!attribute expires_after
      #   The expiration policy for a file. By default, files with `purpose=batch` expire
      #   after 30 days and all other files are persisted until they are manually deleted.
      #
      #   @return [OpenAI::Models::FileCreateParams::ExpiresAfter, nil]
      optional :expires_after, -> { OpenAI::FileCreateParams::ExpiresAfter }

      # @!method initialize(file:, purpose:, expires_after: nil, request_options: {})
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::FileCreateParams} for more details.
      #
      #   @param file [Pathname, StringIO, IO, String, OpenAI::FilePart] The File object (not file name) to be uploaded.
      #
      #   @param purpose [Symbol, OpenAI::Models::FilePurpose] The intended purpose of the uploaded file. One of: - `assistants`: Used in the A
      #
      #   @param expires_after [OpenAI::Models::FileCreateParams::ExpiresAfter] The expiration policy for a file. By default, files with `purpose=batch` expire
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
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::FileCreateParams::ExpiresAfter} for more details.
        #
        #   The expiration policy for a file. By default, files with `purpose=batch` expire
        #   after 30 days and all other files are persisted until they are manually deleted.
        #
        #   @param seconds [Integer] The number of seconds after the anchor time that the file will expire. Must be b
        #
        #   @param anchor [Symbol, :created_at] Anchor timestamp after which the expiration policy applies. Supported anchors: `
      end
    end
  end
end
