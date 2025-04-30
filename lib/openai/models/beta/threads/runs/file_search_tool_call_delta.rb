# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class FileSearchToolCallDelta < OpenAI::Internal::Type::BaseModel
            # @!attribute file_search
            #   For now, this is always going to be an empty object.
            #
            #   @return [Object]
            required :file_search, OpenAI::Internal::Type::Unknown

            # @!attribute index
            #   The index of the tool call in the tool calls array.
            #
            #   @return [Integer]
            required :index, Integer

            # @!attribute type
            #   The type of tool call. This is always going to be `file_search` for this type of
            #   tool call.
            #
            #   @return [Symbol, :file_search]
            required :type, const: :file_search

            # @!attribute id
            #   The ID of the tool call object.
            #
            #   @return [String, nil]
            optional :id, String

            # @!method initialize(file_search:, index:, id: nil, type: :file_search)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Beta::Threads::Runs::FileSearchToolCallDelta} for more details.
            #
            #   @param file_search [Object] For now, this is always going to be an empty object.
            #
            #   @param index [Integer] The index of the tool call in the tool calls array.
            #
            #   @param id [String] The ID of the tool call object.
            #
            #   @param type [Symbol, :file_search] The type of tool call. This is always going to be `file_search` for this type of
            #   ...
          end
        end
      end
    end
  end
end
