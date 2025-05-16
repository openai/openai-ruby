# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class FileSearchTool < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of tool being defined: `file_search`
        #
        #   @return [Symbol, :file_search]
        required :type, const: :file_search

        # @!attribute file_search
        #   Overrides for the file search tool.
        #
        #   @return [OpenAI::Beta::FileSearchTool::FileSearch, nil]
        optional :file_search, -> { OpenAI::Beta::FileSearchTool::FileSearch }

        # @!method initialize(file_search: nil, type: :file_search)
        #   @param file_search [OpenAI::Beta::FileSearchTool::FileSearch] Overrides for the file search tool.
        #
        #   @param type [Symbol, :file_search] The type of tool being defined: `file_search`

        # @see OpenAI::Beta::FileSearchTool#file_search
        class FileSearch < OpenAI::Internal::Type::BaseModel
          # @!attribute max_num_results
          #   The maximum number of results the file search tool should output. The default is
          #   20 for `gpt-4*` models and 5 for `gpt-3.5-turbo`. This number should be between
          #   1 and 50 inclusive.
          #
          #   Note that the file search tool may output fewer than `max_num_results` results.
          #   See the
          #   [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings)
          #   for more information.
          #
          #   @return [Integer, nil]
          optional :max_num_results, Integer

          # @!attribute ranking_options
          #   The ranking options for the file search. If not specified, the file search tool
          #   will use the `auto` ranker and a score_threshold of 0.
          #
          #   See the
          #   [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings)
          #   for more information.
          #
          #   @return [OpenAI::Beta::FileSearchTool::FileSearch::RankingOptions, nil]
          optional :ranking_options, -> { OpenAI::Beta::FileSearchTool::FileSearch::RankingOptions }

          # @!method initialize(max_num_results: nil, ranking_options: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Beta::FileSearchTool::FileSearch} for more details.
          #
          #   Overrides for the file search tool.
          #
          #   @param max_num_results [Integer] The maximum number of results the file search tool should output. The default is
          #
          #   @param ranking_options [OpenAI::Beta::FileSearchTool::FileSearch::RankingOptions] The ranking options for the file search. If not specified, the file search tool

          # @see OpenAI::Beta::FileSearchTool::FileSearch#ranking_options
          class RankingOptions < OpenAI::Internal::Type::BaseModel
            # @!attribute score_threshold
            #   The score threshold for the file search. All values must be a floating point
            #   number between 0 and 1.
            #
            #   @return [Float]
            required :score_threshold, Float

            # @!attribute ranker
            #   The ranker to use for the file search. If not specified will use the `auto`
            #   ranker.
            #
            #   @return [Symbol, OpenAI::Beta::FileSearchTool::FileSearch::RankingOptions::Ranker, nil]
            optional :ranker, enum: -> { OpenAI::Beta::FileSearchTool::FileSearch::RankingOptions::Ranker }

            # @!method initialize(score_threshold:, ranker: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Beta::FileSearchTool::FileSearch::RankingOptions} for more details.
            #
            #   The ranking options for the file search. If not specified, the file search tool
            #   will use the `auto` ranker and a score_threshold of 0.
            #
            #   See the
            #   [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings)
            #   for more information.
            #
            #   @param score_threshold [Float] The score threshold for the file search. All values must be a floating point num
            #
            #   @param ranker [Symbol, OpenAI::Beta::FileSearchTool::FileSearch::RankingOptions::Ranker] The ranker to use for the file search. If not specified will use the `auto` rank

            # The ranker to use for the file search. If not specified will use the `auto`
            # ranker.
            #
            # @see OpenAI::Beta::FileSearchTool::FileSearch::RankingOptions#ranker
            module Ranker
              extend OpenAI::Internal::Type::Enum

              AUTO = :auto
              DEFAULT_2024_08_21 = :default_2024_08_21

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end
        end
      end
    end
  end
end
