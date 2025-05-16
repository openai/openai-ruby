# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class FilePathDeltaAnnotation < OpenAI::Internal::Type::BaseModel
          # @!attribute index
          #   The index of the annotation in the text content part.
          #
          #   @return [Integer]
          required :index, Integer

          # @!attribute type
          #   Always `file_path`.
          #
          #   @return [Symbol, :file_path]
          required :type, const: :file_path

          # @!attribute end_index
          #
          #   @return [Integer, nil]
          optional :end_index, Integer

          # @!attribute file_path
          #
          #   @return [OpenAI::Beta::Threads::FilePathDeltaAnnotation::FilePath, nil]
          optional :file_path, -> { OpenAI::Beta::Threads::FilePathDeltaAnnotation::FilePath }

          # @!attribute start_index
          #
          #   @return [Integer, nil]
          optional :start_index, Integer

          # @!attribute text
          #   The text in the message content that needs to be replaced.
          #
          #   @return [String, nil]
          optional :text, String

          # @!method initialize(index:, end_index: nil, file_path: nil, start_index: nil, text: nil, type: :file_path)
          #   A URL for the file that's generated when the assistant used the
          #   `code_interpreter` tool to generate a file.
          #
          #   @param index [Integer] The index of the annotation in the text content part.
          #
          #   @param end_index [Integer]
          #
          #   @param file_path [OpenAI::Beta::Threads::FilePathDeltaAnnotation::FilePath]
          #
          #   @param start_index [Integer]
          #
          #   @param text [String] The text in the message content that needs to be replaced.
          #
          #   @param type [Symbol, :file_path] Always `file_path`.

          # @see OpenAI::Beta::Threads::FilePathDeltaAnnotation#file_path
          class FilePath < OpenAI::Internal::Type::BaseModel
            # @!attribute file_id
            #   The ID of the file that was generated.
            #
            #   @return [String, nil]
            optional :file_id, String

            # @!method initialize(file_id: nil)
            #   @param file_id [String] The ID of the file that was generated.
          end
        end
      end
    end
  end
end
