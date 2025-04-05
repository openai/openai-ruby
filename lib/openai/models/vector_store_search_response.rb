# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::VectorStores#search
    class VectorStoreSearchResponse < OpenAI::Internal::Type::BaseModel
      # @!attribute attributes
      #   Set of 16 key-value pairs that can be attached to an object. This can be useful
      #   for storing additional information about the object in a structured format, and
      #   querying for objects via API or the dashboard. Keys are strings with a maximum
      #   length of 64 characters. Values are strings with a maximum length of 512
      #   characters, booleans, or numbers.
      #
      #   @return [Hash{Symbol=>String, Float, Boolean}, nil]
      required :attributes,
               -> { OpenAI::Internal::Type::HashOf[union: OpenAI::Models::VectorStoreSearchResponse::Attribute] },
               nil?: true

      # @!attribute content
      #   Content chunks from the file.
      #
      #   @return [Array<OpenAI::Models::VectorStoreSearchResponse::Content>]
      required :content,
               -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::VectorStoreSearchResponse::Content] }

      # @!attribute file_id
      #   The ID of the vector store file.
      #
      #   @return [String]
      required :file_id, String

      # @!attribute filename
      #   The name of the vector store file.
      #
      #   @return [String]
      required :filename, String

      # @!attribute score
      #   The similarity score for the result.
      #
      #   @return [Float]
      required :score, Float

      # @!parse
      #   # @param attributes [Hash{Symbol=>String, Float, Boolean}, nil]
      #   # @param content [Array<OpenAI::Models::VectorStoreSearchResponse::Content>]
      #   # @param file_id [String]
      #   # @param filename [String]
      #   # @param score [Float]
      #   #
      #   def initialize(attributes:, content:, file_id:, filename:, score:, **) = super

      # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

      module Attribute
        extend OpenAI::Internal::Type::Union

        variant String

        variant Float

        variant OpenAI::Internal::Type::Boolean

        # @!parse
        #   # @return [Array(String, Float, Boolean)]
        #   def self.variants; end
      end

      class Content < OpenAI::Internal::Type::BaseModel
        # @!attribute text
        #   The text content returned from search.
        #
        #   @return [String]
        required :text, String

        # @!attribute type
        #   The type of content.
        #
        #   @return [Symbol, OpenAI::Models::VectorStoreSearchResponse::Content::Type]
        required :type, enum: -> { OpenAI::Models::VectorStoreSearchResponse::Content::Type }

        # @!parse
        #   # @param text [String]
        #   # @param type [Symbol, OpenAI::Models::VectorStoreSearchResponse::Content::Type]
        #   #
        #   def initialize(text:, type:, **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

        # The type of content.
        #
        # @see OpenAI::Models::VectorStoreSearchResponse::Content#type
        module Type
          extend OpenAI::Internal::Type::Enum

          TEXT = :text

          finalize!

          # @!parse
          #   # @return [Array<Symbol>]
          #   def self.values; end
        end
      end
    end
  end
end
