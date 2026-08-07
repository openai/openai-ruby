# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
module OpenAI
  module Models
    # @see OpenAI::Resources::ContentProvenanceChecks#create
    class ContentProvenanceCheckCreateParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute file
      #   The image or audio file to check for supported OpenAI provenance signals.
      #
      #   @return [Pathname, StringIO, IO, String, OpenAI::FilePart]
      required :file, OpenAI::Internal::Type::FileInput

      # @!method initialize(file:, request_options: {})
      #   @param file [Pathname, StringIO, IO, String, OpenAI::FilePart] The image or audio file to check for supported OpenAI provenance signals.
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
    end
  end
end
