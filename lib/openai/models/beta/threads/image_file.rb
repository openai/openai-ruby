# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class ImageFile < OpenAI::BaseModel
          # @!attribute file_id
          #   The [File](https://platform.openai.com/docs/api-reference/files) ID of the image
          #     in the message content. Set `purpose="vision"` when uploading the File if you
          #     need to later display the file content.
          #
          #   @return [String]
          required :file_id, String

          # @!attribute [r] detail
          #   Specifies the detail level of the image if specified by the user. `low` uses
          #     fewer tokens, you can opt in to high resolution using `high`.
          #
          #   @return [Symbol, OpenAI::Models::Beta::Threads::ImageFile::Detail, nil]
          optional :detail, enum: -> { OpenAI::Models::Beta::Threads::ImageFile::Detail }

          # @!parse
          #   # @return [Symbol, OpenAI::Models::Beta::Threads::ImageFile::Detail]
          #   attr_writer :detail

          # @!parse
          #   # @param file_id [String]
          #   # @param detail [Symbol, OpenAI::Models::Beta::Threads::ImageFile::Detail]
          #   #
          #   def initialize(file_id:, detail: nil, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void

          # Specifies the detail level of the image if specified by the user. `low` uses
          #   fewer tokens, you can opt in to high resolution using `high`.
          module Detail
            extend OpenAI::Enum

            AUTO = :auto
            LOW = :low
            HIGH = :high

            finalize!

            # @!parse
            #   # @return [Array<Symbol>]
            #   def self.values; end
          end
        end
      end
    end
  end
end
