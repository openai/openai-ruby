# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class FilePathAnnotation < OpenAI::Internal::Type::BaseModel
          # @!attribute end_index
          #
          #   @return [Integer]
          required :end_index, Integer

          # @!attribute file_path
          #
          #   @return [OpenAI::Models::Beta::Threads::FilePathAnnotation::FilePath]
          required :file_path, -> { OpenAI::Models::Beta::Threads::FilePathAnnotation::FilePath }

          # @!attribute start_index
          #
          #   @return [Integer]
          required :start_index, Integer

          # @!attribute text
          #   The text in the message content that needs to be replaced.
          #
          #   @return [String]
          required :text, String

          # @!attribute type
          #   Always `file_path`.
          #
          #   @return [Symbol, :file_path]
          required :type, const: :file_path

          # @!parse
          #   # A URL for the file that's generated when the assistant used the
          #   # `code_interpreter` tool to generate a file.
          #   #
          #   # @param end_index [Integer]
          #   # @param file_path [OpenAI::Models::Beta::Threads::FilePathAnnotation::FilePath]
          #   # @param start_index [Integer]
          #   # @param text [String]
          #   # @param type [Symbol, :file_path]
          #   #
          #   def initialize(end_index:, file_path:, start_index:, text:, type: :file_path, **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

          # @see OpenAI::Models::Beta::Threads::FilePathAnnotation#file_path
          class FilePath < OpenAI::Internal::Type::BaseModel
            # @!attribute file_id
            #   The ID of the file that was generated.
            #
            #   @return [String]
            required :file_id, String

            # @!parse
            #   # @param file_id [String]
            #   #
            #   def initialize(file_id:, **) = super

            # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
          end
        end
      end
    end
  end
end
