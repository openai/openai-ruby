# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class FileSearchTool < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of the file search tool. Always `file_search`.
        #
        #   @return [Symbol, :file_search]
        required :type, const: :file_search

        # @!attribute vector_store_ids
        #   The IDs of the vector stores to search.
        #
        #   @return [Array<String>]
        required :vector_store_ids, OpenAI::Internal::Type::ArrayOf[String]

        # @!attribute filters
        #   A filter to apply.
        #
        #   @return [OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter, nil]
        optional :filters, union: -> { OpenAI::Responses::FileSearchTool::Filters }, nil?: true

        # @!attribute max_num_results
        #   The maximum number of results to return. This number should be between 1 and 50
        #   inclusive.
        #
        #   @return [Integer, nil]
        optional :max_num_results, Integer

        # @!attribute ranking_options
        #   Ranking options for search.
        #
        #   @return [OpenAI::Models::Responses::FileSearchTool::RankingOptions, nil]
        optional :ranking_options, -> { OpenAI::Responses::FileSearchTool::RankingOptions }

        # @!method initialize(vector_store_ids:, filters: nil, max_num_results: nil, ranking_options: nil, type: :file_search)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::FileSearchTool} for more details.
        #
        #   A tool that searches for relevant content from uploaded files. Learn more about
        #   the
        #   [file search tool](https://platform.openai.com/docs/guides/tools-file-search).
        #
        #   @param vector_store_ids [Array<String>] The IDs of the vector stores to search.
        #
        #   @param filters [OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter, nil] A filter to apply.
        #
        #   @param max_num_results [Integer] The maximum number of results to return. This number should be between 1 and 50
        #
        #   @param ranking_options [OpenAI::Models::Responses::FileSearchTool::RankingOptions] Ranking options for search.
        #
        #   @param type [Symbol, :file_search] The type of the file search tool. Always `file_search`.

        # A filter to apply.
        #
        # @see OpenAI::Models::Responses::FileSearchTool#filters
        module Filters
          extend OpenAI::Internal::Type::Union

          # A filter used to compare a specified attribute key to a given value using a defined comparison operation.
          variant -> { OpenAI::ComparisonFilter }

          # Combine multiple filters using `and` or `or`.
          variant -> { OpenAI::CompoundFilter }

          # @!method self.variants
          #   @return [Array(OpenAI::Models::ComparisonFilter, OpenAI::Models::CompoundFilter)]
        end

        # @see OpenAI::Models::Responses::FileSearchTool#ranking_options
        class RankingOptions < OpenAI::Internal::Type::BaseModel
          # @!attribute ranker
          #   The ranker to use for the file search.
          #
          #   @return [Symbol, OpenAI::Models::Responses::FileSearchTool::RankingOptions::Ranker, nil]
          optional :ranker, enum: -> { OpenAI::Responses::FileSearchTool::RankingOptions::Ranker }

          # @!attribute score_threshold
          #   The score threshold for the file search, a number between 0 and 1. Numbers
          #   closer to 1 will attempt to return only the most relevant results, but may
          #   return fewer results.
          #
          #   @return [Float, nil]
          optional :score_threshold, Float

          # @!method initialize(ranker: nil, score_threshold: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::FileSearchTool::RankingOptions} for more details.
          #
          #   Ranking options for search.
          #
          #   @param ranker [Symbol, OpenAI::Models::Responses::FileSearchTool::RankingOptions::Ranker] The ranker to use for the file search.
          #
          #   @param score_threshold [Float] The score threshold for the file search, a number between 0 and 1. Numbers close

          # The ranker to use for the file search.
          #
          # @see OpenAI::Models::Responses::FileSearchTool::RankingOptions#ranker
          module Ranker
            extend OpenAI::Internal::Type::Enum

            AUTO = :auto
            DEFAULT_2024_11_15 = :"default-2024-11-15"

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
