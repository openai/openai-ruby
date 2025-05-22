# frozen_string_literal: true

module OpenAI
  module Models
    module Containers
      # @see OpenAI::Resources::Containers::Files#list
      class FileListResponse < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   Unique identifier for the file.
        #
        #   @return [String]
        required :id, String

        # @!attribute bytes
        #   Size of the file in bytes.
        #
        #   @return [Integer]
        required :bytes, Integer

        # @!attribute container_id
        #   The container this file belongs to.
        #
        #   @return [String]
        required :container_id, String

        # @!attribute created_at
        #   Unix timestamp (in seconds) when the file was created.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute object
        #   The type of this object (`container.file`).
        #
        #   @return [Symbol, :"container.file"]
        required :object, const: :"container.file"

        # @!attribute path
        #   Path of the file in the container.
        #
        #   @return [String]
        required :path, String

        # @!attribute source
        #   Source of the file (e.g., `user`, `assistant`).
        #
        #   @return [String]
        required :source, String

        # @!method initialize(id:, bytes:, container_id:, created_at:, path:, source:, object: :"container.file")
        #   @param id [String] Unique identifier for the file.
        #
        #   @param bytes [Integer] Size of the file in bytes.
        #
        #   @param container_id [String] The container this file belongs to.
        #
        #   @param created_at [Integer] Unix timestamp (in seconds) when the file was created.
        #
        #   @param path [String] Path of the file in the container.
        #
        #   @param source [String] Source of the file (e.g., `user`, `assistant`).
        #
        #   @param object [Symbol, :"container.file"] The type of this object (`container.file`).
      end
    end
  end
end
