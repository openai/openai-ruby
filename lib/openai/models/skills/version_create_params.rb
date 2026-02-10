# frozen_string_literal: true

module OpenAI
  module Models
    module Skills
      # @see OpenAI::Resources::Skills::Versions#create
      class VersionCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute default
        #   Whether to set this version as the default.
        #
        #   @return [Boolean, nil]
        optional :default, OpenAI::Internal::Type::Boolean

        # @!attribute files
        #   Skill files to upload (directory upload) or a single zip file.
        #
        #   @return [Array<Pathname, StringIO, IO, String, OpenAI::FilePart>, Pathname, StringIO, IO, String, OpenAI::FilePart, nil]
        optional :files, union: -> { OpenAI::Skills::VersionCreateParams::Files }

        # @!method initialize(default: nil, files: nil, request_options: {})
        #   @param default [Boolean] Whether to set this version as the default.
        #
        #   @param files [Array<Pathname, StringIO, IO, String, OpenAI::FilePart>, Pathname, StringIO, IO, String, OpenAI::FilePart] Skill files to upload (directory upload) or a single zip file.
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        # Skill files to upload (directory upload) or a single zip file.
        module Files
          extend OpenAI::Internal::Type::Union

          # Skill files to upload (directory upload) or a single zip file.
          variant -> { OpenAI::Models::Skills::VersionCreateParams::Files::StringArray }

          # Skill zip file to upload.
          variant OpenAI::Internal::Type::FileInput

          # @!method self.variants
          #   @return [Array(Array<StringIO>, StringIO)]

          # @type [OpenAI::Internal::Type::Converter]
          StringArray = OpenAI::Internal::Type::ArrayOf[OpenAI::Internal::Type::FileInput]
        end
      end
    end
  end
end
