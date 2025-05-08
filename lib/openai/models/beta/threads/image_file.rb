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

          # @!attribute detail
          #   Specifies the detail level of the image if specified by the user. `low` uses
          #   fewer tokens, you can opt in to high resolution using `high`.
          #
          #   @return [Symbol, OpenAI::Beta::Threads::ImageFile::Detail, nil]
          optional :detail, enum: -> { OpenAI::Beta::Threads::ImageFile::Detail }

          # @!method initialize(file_id:, detail: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Beta::Threads::ImageFile} for more details.
          #
          #   @param file_id [String] The [File](https://platform.openai.com/docs/api-reference/files) ID of the image
          #
          #   @param detail [Symbol, OpenAI::Beta::Threads::ImageFile::Detail] Specifies the detail level of the image if specified by the user. `low` uses few

          # Specifies the detail level of the image if specified by the user. `low` uses
          # fewer tokens, you can opt in to high resolution using `high`.
          #
          # @see OpenAI::Beta::Threads::ImageFile#detail
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
