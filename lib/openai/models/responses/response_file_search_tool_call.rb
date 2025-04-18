# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseFileSearchToolCall < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the file search tool call.
        #
        #   @return [String]
        required :id, String

        # @!attribute queries
        #   The queries used to search for files.
        #
        #   @return [Array<String>]
        required :queries, OpenAI::Internal::Type::ArrayOf[String]

        # @!attribute status
        #   The status of the file search tool call. One of `in_progress`, `searching`,
        #   `incomplete` or `failed`,
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseFileSearchToolCall::Status]
        required :status, enum: -> { OpenAI::Models::Responses::ResponseFileSearchToolCall::Status }

        # @!attribute type
        #   The type of the file search tool call. Always `file_search_call`.
        #
        #   @return [Symbol, :file_search_call]
        required :type, const: :file_search_call

        # @!attribute results
        #   The results of the file search tool call.
        #
        #   @return [Array<OpenAI::Models::Responses::ResponseFileSearchToolCall::Result>, nil]
        optional :results,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Responses::ResponseFileSearchToolCall::Result] },
                 nil?: true

        # @!method initialize(id:, queries:, status:, results: nil, type: :file_search_call)
        #   The results of a file search tool call. See the
        #   [file search guide](https://platform.openai.com/docs/guides/tools-file-search)
        #   for more information.
        #
        #   @param id [String]
        #   @param queries [Array<String>]
        #   @param status [Symbol, OpenAI::Models::Responses::ResponseFileSearchToolCall::Status]
        #   @param results [Array<OpenAI::Models::Responses::ResponseFileSearchToolCall::Result>, nil]
        #   @param type [Symbol, :file_search_call]

        # The status of the file search tool call. One of `in_progress`, `searching`,
        # `incomplete` or `failed`,
        #
        # @see OpenAI::Models::Responses::ResponseFileSearchToolCall#status
        module Status
          extend OpenAI::Internal::Type::Enum

          IN_PROGRESS = :in_progress
          SEARCHING = :searching
          COMPLETED = :completed
          INCOMPLETE = :incomplete
          FAILED = :failed

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        class Result < OpenAI::Internal::Type::BaseModel
          # @!attribute attributes
          #   Set of 16 key-value pairs that can be attached to an object. This can be useful
          #   for storing additional information about the object in a structured format, and
          #   querying for objects via API or the dashboard. Keys are strings with a maximum
          #   length of 64 characters. Values are strings with a maximum length of 512
          #   characters, booleans, or numbers.
          #
          #   @return [Hash{Symbol=>String, Float, Boolean}, nil]
          optional :attributes,
                   -> { OpenAI::Internal::Type::HashOf[union: OpenAI::Models::Responses::ResponseFileSearchToolCall::Result::Attribute] },
                   nil?: true

          # @!attribute file_id
          #   The unique ID of the file.
          #
          #   @return [String, nil]
          optional :file_id, String

          # @!attribute filename
          #   The name of the file.
          #
          #   @return [String, nil]
          optional :filename, String

          # @!attribute score
          #   The relevance score of the file - a value between 0 and 1.
          #
          #   @return [Float, nil]
          optional :score, Float

          # @!attribute text
          #   The text that was retrieved from the file.
          #
          #   @return [String, nil]
          optional :text, String

          # @!method initialize(attributes: nil, file_id: nil, filename: nil, score: nil, text: nil)
          #   @param attributes [Hash{Symbol=>String, Float, Boolean}, nil]
          #   @param file_id [String]
          #   @param filename [String]
          #   @param score [Float]
          #   @param text [String]

          module Attribute
            extend OpenAI::Internal::Type::Union

            variant String

            variant Float

            variant OpenAI::Internal::Type::Boolean

            # @!method self.variants
            #   @return [Array(String, Float, Boolean)]
          end
        end
      end
    end
  end
end
