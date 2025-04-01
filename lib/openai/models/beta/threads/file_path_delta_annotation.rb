# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class FilePathDeltaAnnotation < OpenAI::BaseModel
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

          # @!attribute [r] end_index
          #
          #   @return [Integer, nil]
          optional :end_index, Integer

          # @!parse
          #   # @return [Integer]
          #   attr_writer :end_index

          # @!attribute [r] file_path
          #
          #   @return [OpenAI::Models::Beta::Threads::FilePathDeltaAnnotation::FilePath, nil]
          optional :file_path, -> { OpenAI::Models::Beta::Threads::FilePathDeltaAnnotation::FilePath }

          # @!parse
          #   # @return [OpenAI::Models::Beta::Threads::FilePathDeltaAnnotation::FilePath]
          #   attr_writer :file_path

          # @!attribute [r] start_index
          #
          #   @return [Integer, nil]
          optional :start_index, Integer

          # @!parse
          #   # @return [Integer]
          #   attr_writer :start_index

          # @!attribute [r] text
          #   The text in the message content that needs to be replaced.
          #
          #   @return [String, nil]
          optional :text, String

          # @!parse
          #   # @return [String]
          #   attr_writer :text

          # @!parse
          #   # A URL for the file that's generated when the assistant used the
          #   #   `code_interpreter` tool to generate a file.
          #   #
          #   # @param index [Integer]
          #   # @param end_index [Integer]
          #   # @param file_path [OpenAI::Models::Beta::Threads::FilePathDeltaAnnotation::FilePath]
          #   # @param start_index [Integer]
          #   # @param text [String]
          #   # @param type [Symbol, :file_path]
          #   #
          #   def initialize(index:, end_index: nil, file_path: nil, start_index: nil, text: nil, type: :file_path, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void

          # @see OpenAI::Models::Beta::Threads::FilePathDeltaAnnotation#file_path
          class FilePath < OpenAI::BaseModel
            # @!attribute [r] file_id
            #   The ID of the file that was generated.
            #
            #   @return [String, nil]
            optional :file_id, String

            # @!parse
            #   # @return [String]
            #   attr_writer :file_id

            # @!parse
            #   # @param file_id [String]
            #   #
            #   def initialize(file_id: nil, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void
          end
        end
      end
    end
  end
end
