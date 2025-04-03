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

        # @!attribute [r] file_search
        #   Overrides for the file search tool.
        #
        #   @return [OpenAI::Models::Beta::FileSearchTool::FileSearch, nil]
        optional :file_search, -> { OpenAI::Models::Beta::FileSearchTool::FileSearch }

        # @!parse
        #   # @return [OpenAI::Models::Beta::FileSearchTool::FileSearch]
        #   attr_writer :file_search

        # @!parse
        #   # @param file_search [OpenAI::Models::Beta::FileSearchTool::FileSearch]
        #   # @param type [Symbol, :file_search]
        #   #
        #   def initialize(file_search: nil, type: :file_search, **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

        # @see OpenAI::Models::Beta::FileSearchTool#file_search
        class FileSearch < OpenAI::Internal::Type::BaseModel
          # @!attribute [r] max_num_results
          #   The maximum number of results the file search tool should output. The default is
          #     20 for `gpt-4*` models and 5 for `gpt-3.5-turbo`. This number should be between
          #     1 and 50 inclusive.
          #
          #     Note that the file search tool may output fewer than `max_num_results` results.
          #     See the
          #     [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings)
          #     for more information.
          #
          #   @return [Integer, nil]
          optional :max_num_results, Integer

          # @!parse
          #   # @return [Integer]
          #   attr_writer :max_num_results

          # @!attribute [r] ranking_options
          #   The ranking options for the file search. If not specified, the file search tool
          #     will use the `auto` ranker and a score_threshold of 0.
          #
          #     See the
          #     [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings)
          #     for more information.
          #
          #   @return [OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions, nil]
          optional :ranking_options, -> { OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions }

          # @!parse
          #   # @return [OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions]
          #   attr_writer :ranking_options

          # @!parse
          #   # Overrides for the file search tool.
          #   #
          #   # @param max_num_results [Integer]
          #   # @param ranking_options [OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions]
          #   #
          #   def initialize(max_num_results: nil, ranking_options: nil, **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

          # @see OpenAI::Models::Beta::FileSearchTool::FileSearch#ranking_options
          class RankingOptions < OpenAI::Internal::Type::BaseModel
            # @!attribute score_threshold
            #   The score threshold for the file search. All values must be a floating point
            #     number between 0 and 1.
            #
            #   @return [Float]
            required :score_threshold, Float

            # @!attribute [r] ranker
            #   The ranker to use for the file search. If not specified will use the `auto`
            #     ranker.
            #
            #   @return [Symbol, OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions::Ranker, nil]
            optional :ranker, enum: -> { OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions::Ranker }

            # @!parse
            #   # @return [Symbol, OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions::Ranker]
            #   attr_writer :ranker

            # @!parse
            #   # The ranking options for the file search. If not specified, the file search tool
            #   #   will use the `auto` ranker and a score_threshold of 0.
            #   #
            #   #   See the
            #   #   [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings)
            #   #   for more information.
            #   #
            #   # @param score_threshold [Float]
            #   # @param ranker [Symbol, OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions::Ranker]
            #   #
            #   def initialize(score_threshold:, ranker: nil, **) = super

            # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

            # The ranker to use for the file search. If not specified will use the `auto`
            #   ranker.
            #
            # @see OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions#ranker
            module Ranker
              extend OpenAI::Internal::Type::Enum

              AUTO = :auto
              DEFAULT_2024_08_21 = :default_2024_08_21

              finalize!

              # @!parse
              #   # @return [Array<Symbol>]
              #   def self.values; end
            end
          end
        end
      end
    end
  end
end
