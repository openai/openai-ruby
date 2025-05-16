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
      #   @return [Pathname, StringIO, IO, OpenAI::FilePart]
      required :file, OpenAI::Internal::Type::FileInput

      # @!attribute purpose
      #   The intended purpose of the uploaded file. One of: - `assistants`: Used in the
      #   Assistants API - `batch`: Used in the Batch API - `fine-tune`: Used for
      #   fine-tuning - `vision`: Images used for vision fine-tuning - `user_data`:
      #   Flexible file type for any purpose - `evals`: Used for eval data sets
      #
      #   @return [Symbol, OpenAI::FilePurpose]
      required :purpose, enum: -> { OpenAI::FilePurpose }

      # @!method initialize(file:, purpose:, request_options: {})
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::FileCreateParams} for more details.
      #
      #   @param file [Pathname, StringIO, IO, OpenAI::FilePart] The File object (not file name) to be uploaded.
      #
      #   @param purpose [Symbol, OpenAI::FilePurpose] The intended purpose of the uploaded file. One of: - `assistants`: Used in the A
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
    end
  end
end
