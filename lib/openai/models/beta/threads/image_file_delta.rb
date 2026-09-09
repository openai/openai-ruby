# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageFileDelta < OpenAI::Internal::Type::BaseModel
          # @!attribute detail
          #   Specifies the detail level of the image if specified by the user. `low` uses
          #   fewer tokens, you can opt in to high resolution using `high`.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Threads::ImageFileDelta::Detail, nil]
          optional :detail, enum: -> { OpenAI::Beta::Threads::ImageFileDelta::Detail }

          # @!attribute file_id
          #   The [File](https://developers.openai.com/api/reference/resources/files) ID of
          #   the image in the message content. Set `purpose="vision"` when uploading the File
          #   if you need to later display the file content.
          #
          #   @return [String, nil]
          optional :file_id, String

          # @!method initialize(detail: nil, file_id: nil)
          #   @param detail [Symbol, OpenAI::Models::Beta::Threads::ImageFileDelta::Detail]
          #     Specifies the detail level of the image if specified by the user. `low` uses
          #     fewer tokens, you can opt in to high resolution using `high`.
          #
          #   @param file_id [String]
          #     The [File](https://developers.openai.com/api/reference/resources/files) ID of
          #     the image in the message content. Set `purpose="vision"` when uploading the File
          #     if you need to later display the file content.

          # Specifies the detail level of the image if specified by the user. `low` uses
          # fewer tokens, you can opt in to high resolution using `high`.
          #
          # @see OpenAI::Models::Beta::Threads::ImageFileDelta#detail
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
