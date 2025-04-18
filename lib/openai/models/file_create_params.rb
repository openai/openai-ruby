# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Files#create
    class FileCreateParams < OpenAI::Internal::Type::BaseModel
      # @!parse
      #   extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute file
      #   The File object (not file name) to be uploaded.
      #
      #   @return [Pathname, StringIO]
      required :file, OpenAI::Internal::Type::IOLike

      # @!attribute purpose
      #   The intended purpose of the uploaded file. One of: - `assistants`: Used in the
      #   Assistants API - `batch`: Used in the Batch API - `fine-tune`: Used for
      #   fine-tuning - `vision`: Images used for vision fine-tuning - `user_data`:
      #   Flexible file type for any purpose - `evals`: Used for eval data sets
      #
      #   @return [Symbol, OpenAI::Models::FilePurpose]
      required :purpose, enum: -> { OpenAI::Models::FilePurpose }

      # @!method initialize(file:, purpose:, request_options: {})
      #   @param file [Pathname, StringIO]
      #   @param purpose [Symbol, OpenAI::Models::FilePurpose]
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
    end
  end
end
