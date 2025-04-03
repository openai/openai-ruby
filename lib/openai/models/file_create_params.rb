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
      #   @return [IO, StringIO]
      required :file, IO

      # @!attribute purpose
      #   The intended purpose of the uploaded file. One of: - `assistants`: Used in the
      #     Assistants API - `batch`: Used in the Batch API - `fine-tune`: Used for
      #     fine-tuning - `vision`: Images used for vision fine-tuning - `user_data`:
      #     Flexible file type for any purpose - `evals`: Used for eval data sets
      #
      #   @return [Symbol, OpenAI::Models::FilePurpose]
      required :purpose, enum: -> { OpenAI::Models::FilePurpose }

      # @!parse
      #   # @param file [IO, StringIO]
      #   # @param purpose [Symbol, OpenAI::Models::FilePurpose]
      #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      #   #
      #   def initialize(file:, purpose:, request_options: {}, **) = super

      # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
    end
  end
end
