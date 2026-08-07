# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseFileSearchToolCall < OpenAI::Internal::Type::BaseModel
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
        #   @return [Symbol, OpenAI::Models::Beta::BetaResponseFileSearchToolCall::Status]
        required :status, enum: -> { OpenAI::Beta::BetaResponseFileSearchToolCall::Status }

        # @!attribute type
        #   The type of the file search tool call. Always `file_search_call`.
        #
        #   @return [Symbol, :file_search_call]
        required :type, const: :file_search_call

        # @!attribute agent
        #   The agent that produced this item.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseFileSearchToolCall::Agent, nil]
        optional :agent, -> { OpenAI::Beta::BetaResponseFileSearchToolCall::Agent }, nil?: true

        # @!attribute results
        #   The results of the file search tool call.
        #
        #   @return [Array<OpenAI::Models::Beta::BetaResponseFileSearchToolCall::Result>, nil]
        optional :results,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::BetaResponseFileSearchToolCall::Result] },
                 nil?: true

        # @!method initialize(id:, queries:, status:, agent: nil, results: nil, type: :file_search_call)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseFileSearchToolCall} for more details.
        #
        #   The results of a file search tool call. See the
        #   [file search guide](https://platform.openai.com/docs/guides/tools-file-search)
        #   for more information.
        #
        #   @param id [String] The unique ID of the file search tool call.
        #
        #   @param queries [Array<String>] The queries used to search for files.
        #
        #   @param status [Symbol, OpenAI::Models::Beta::BetaResponseFileSearchToolCall::Status] The status of the file search tool call. One of `in_progress`,
        #
        #   @param agent [OpenAI::Models::Beta::BetaResponseFileSearchToolCall::Agent, nil] The agent that produced this item.
        #
        #   @param results [Array<OpenAI::Models::Beta::BetaResponseFileSearchToolCall::Result>, nil] The results of the file search tool call.
        #
        #   @param type [Symbol, :file_search_call] The type of the file search tool call. Always `file_search_call`.

        # The status of the file search tool call. One of `in_progress`, `searching`,
        # `incomplete` or `failed`,
        #
        # @see OpenAI::Models::Beta::BetaResponseFileSearchToolCall#status
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

        # @see OpenAI::Models::Beta::BetaResponseFileSearchToolCall#agent
        class Agent < OpenAI::Internal::Type::BaseModel
          # @!attribute agent_name
          #   The canonical name of the agent that produced this item.
          #
          #   @return [String]
          required :agent_name, String

          # @!method initialize(agent_name:)
          #   The agent that produced this item.
          #
          #   @param agent_name [String] The canonical name of the agent that produced this item.
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
                     OpenAI::Internal::Type::HashOf[union: OpenAI::Beta::BetaResponseFileSearchToolCall::Result::Attribute]
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
          #   {OpenAI::Models::Beta::BetaResponseFileSearchToolCall::Result} for more details.
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
          end
        end
      end
    end

    BetaResponseFileSearchToolCall = Beta::BetaResponseFileSearchToolCall
  end
end
