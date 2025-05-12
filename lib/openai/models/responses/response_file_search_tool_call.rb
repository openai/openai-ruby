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
        #   @return [Symbol, OpenAI::Responses::ResponseFileSearchToolCall::Status]
        required :status, enum: -> { OpenAI::Responses::ResponseFileSearchToolCall::Status }

        # @!attribute type
        #   The type of the file search tool call. Always `file_search_call`.
        #
        #   @return [Symbol, :file_search_call]
        required :type, const: :file_search_call

        # @!attribute results
        #   The results of the file search tool call.
        #
        #   @return [Array<OpenAI::Responses::ResponseFileSearchToolCall::Result>, nil]
        optional :results,
                 -> {
                   OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ResponseFileSearchToolCall::Result]
                 },
                 nil?: true

        # @!method initialize(id:, queries:, status:, results: nil, type: :file_search_call)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Responses::ResponseFileSearchToolCall} for more details.
        #
        #   The results of a file search tool call. See the
        #   [file search guide](https://platform.openai.com/docs/guides/tools-file-search)
        #   for more information.
        #
        #   @param id [String] The unique ID of the file search tool call.
        #
        #   @param queries [Array<String>] The queries used to search for files.
        #
        #   @param status [Symbol, OpenAI::Responses::ResponseFileSearchToolCall::Status] The status of the file search tool call. One of `in_progress`,
        #
        #   @param results [Array<OpenAI::Responses::ResponseFileSearchToolCall::Result>, nil] The results of the file search tool call.
        #
        #   @param type [Symbol, :file_search_call] The type of the file search tool call. Always `file_search_call`.

        # The status of the file search tool call. One of `in_progress`, `searching`,
        # `incomplete` or `failed`,
        #
        # @see OpenAI::Responses::ResponseFileSearchToolCall#status
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
                   -> {
                     OpenAI::Internal::Type::HashOf[union: OpenAI::Responses::ResponseFileSearchToolCall::Result::Attribute]
                   },
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
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Responses::ResponseFileSearchToolCall::Result} for more details.
          #
          #   @param attributes [Hash{Symbol=>String, Float, Boolean}, nil] Set of 16 key-value pairs that can be attached to an object. This can be
          #
          #   @param file_id [String] The unique ID of the file.
          #
          #   @param filename [String] The name of the file.
          #
          #   @param score [Float] The relevance score of the file - a value between 0 and 1.
          #
          #   @param text [String] The text that was retrieved from the file.

          module Attribute
            extend OpenAI::Internal::Type::Union

            variant String

            variant Float

            variant OpenAI::Internal::Type::Boolean

            # @!method self.variants
            #   @return [Array(String, Float, Boolean)]

            define_sorbet_constant!(:Variants) do
              T.type_alias { T.any(String, Float, T::Boolean) }
            end
          end
        end
      end
    end
  end
end
