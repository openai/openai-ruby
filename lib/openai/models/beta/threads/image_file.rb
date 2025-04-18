# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageFile < OpenAI::Internal::Type::BaseModel
          # @!attribute file_id
          #   The [File](https://platform.openai.com/docs/api-reference/files) ID of the image
          #   in the message content. Set `purpose="vision"` when uploading the File if you
          #   need to later display the file content.
          #
          #   @return [String]
          required :file_id, String

          # @!attribute [r] detail
          #   Specifies the detail level of the image if specified by the user. `low` uses
          #   fewer tokens, you can opt in to high resolution using `high`.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Threads::ImageFile::Detail, nil]
          optional :detail, enum: -> { OpenAI::Models::Beta::Threads::ImageFile::Detail }

          # @!parse
          #   # @return [Symbol, OpenAI::Models::Beta::Threads::ImageFile::Detail]
          #   attr_writer :detail

          # @!method initialize(file_id:, detail: nil)
          #   @param file_id [String]
          #   @param detail [Symbol, OpenAI::Models::Beta::Threads::ImageFile::Detail]

          # Specifies the detail level of the image if specified by the user. `low` uses
          # fewer tokens, you can opt in to high resolution using `high`.
          #
          # @see OpenAI::Models::Beta::Threads::ImageFile#detail
          module Detail
            extend OpenAI::Internal::Type::Enum

            AUTO = :auto
            LOW = :low
            HIGH = :high

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
