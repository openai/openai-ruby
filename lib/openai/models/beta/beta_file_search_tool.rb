# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaFileSearchTool < OpenAI::Internal::Type::BaseModel
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
        #   @return [OpenAI::Models::Beta::BetaFileSearchTool::Filters::ComparisonFilter, OpenAI::Models::Beta::BetaFileSearchTool::Filters::CompoundFilter, nil]
        optional :filters, union: -> { OpenAI::Beta::BetaFileSearchTool::Filters }, nil?: true

        # @!attribute max_num_results
        #   The maximum number of results to return. This number should be between 1 and 50
        #   inclusive.
        #
        #   @return [Integer, nil]
        optional :max_num_results, Integer

        # @!attribute ranking_options
        #   Ranking options for search.
        #
        #   @return [OpenAI::Models::Beta::BetaFileSearchTool::RankingOptions, nil]
        optional :ranking_options, -> { OpenAI::Beta::BetaFileSearchTool::RankingOptions }

        # @!method initialize(vector_store_ids:, filters: nil, max_num_results: nil, ranking_options: nil, type: :file_search)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaFileSearchTool} for more details.
        #
        #   A tool that searches for relevant content from uploaded files. Learn more about
        #   the
        #   [file search tool](https://platform.openai.com/docs/guides/tools-file-search).
        #
        #   @param vector_store_ids [Array<String>] The IDs of the vector stores to search.
        #
        #   @param filters [OpenAI::Models::Beta::BetaFileSearchTool::Filters::ComparisonFilter, OpenAI::Models::Beta::BetaFileSearchTool::Filters::CompoundFilter, nil] A filter to apply.
        #
        #   @param max_num_results [Integer] The maximum number of results to return. This number should be between 1 and 50
        #
        #   @param ranking_options [OpenAI::Models::Beta::BetaFileSearchTool::RankingOptions] Ranking options for search.
        #
        #   @param type [Symbol, :file_search] The type of the file search tool. Always `file_search`.

        # A filter to apply.
        #
        # @see OpenAI::Models::Beta::BetaFileSearchTool#filters
        module Filters
          extend OpenAI::Internal::Type::Union

          # A filter used to compare a specified attribute key to a given value using a defined comparison operation.
          variant -> { OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter }

          # Combine multiple filters using `and` or `or`.
          variant -> { OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter }

          class ComparisonFilter < OpenAI::Internal::Type::BaseModel
            # @!attribute key
            #   The key to compare against the value.
            #
            #   @return [String]
            required :key, String

            # @!attribute type
            #   Specifies the comparison operator: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`, `in`,
            #   `nin`.
            #
            #   - `eq`: equals
            #   - `ne`: not equal
            #   - `gt`: greater than
            #   - `gte`: greater than or equal
            #   - `lt`: less than
            #   - `lte`: less than or equal
            #   - `in`: in
            #   - `nin`: not in
            #
            #   @return [Symbol, OpenAI::Models::Beta::BetaFileSearchTool::Filters::ComparisonFilter::Type]
            required :type, enum: -> { OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter::Type }

            # @!attribute value
            #   The value to compare against the attribute key; supports string, number, or
            #   boolean types.
            #
            #   @return [String, Float, Boolean, Array<String, Float>]
            required :value, union: -> { OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter::Value }

            # @!method initialize(key:, type:, value:)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Beta::BetaFileSearchTool::Filters::ComparisonFilter} for more
            #   details.
            #
            #   A filter used to compare a specified attribute key to a given value using a
            #   defined comparison operation.
            #
            #   @param key [String] The key to compare against the value.
            #
            #   @param type [Symbol, OpenAI::Models::Beta::BetaFileSearchTool::Filters::ComparisonFilter::Type] Specifies the comparison operator: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`, `in`, `
            #
            #   @param value [String, Float, Boolean, Array<String, Float>] The value to compare against the attribute key; supports string, number, or bool

            # Specifies the comparison operator: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`, `in`,
            # `nin`.
            #
            # - `eq`: equals
            # - `ne`: not equal
            # - `gt`: greater than
            # - `gte`: greater than or equal
            # - `lt`: less than
            # - `lte`: less than or equal
            # - `in`: in
            # - `nin`: not in
            #
            # @see OpenAI::Models::Beta::BetaFileSearchTool::Filters::ComparisonFilter#type
            module Type
              extend OpenAI::Internal::Type::Enum

              EQ = :eq
              NE = :ne
              GT = :gt
              GTE = :gte
              LT = :lt
              LTE = :lte
              IN = :in
              NIN = :nin

              # @!method self.values
              #   @return [Array<Symbol>]
            end

            # The value to compare against the attribute key; supports string, number, or
            # boolean types.
            #
            # @see OpenAI::Models::Beta::BetaFileSearchTool::Filters::ComparisonFilter#value
            module Value
              extend OpenAI::Internal::Type::Union

              variant String

              variant Float

              variant OpenAI::Internal::Type::Boolean

              variant -> { OpenAI::Models::Beta::BetaFileSearchTool::Filters::ComparisonFilter::Value::UnionMember3Array }

              module UnionMember3
                extend OpenAI::Internal::Type::Union

                variant String

                variant Float

                # @!method self.variants
                #   @return [Array(String, Float)]
              end

              # @!method self.variants
              #   @return [Array(String, Float, Boolean, Array<String, Float>)]

              # @type [OpenAI::Internal::Type::Converter]
              UnionMember3Array =
                OpenAI::Internal::Type::ArrayOf[union: -> {
                  OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter::Value::UnionMember3
                }]
            end
          end

          class CompoundFilter < OpenAI::Internal::Type::BaseModel
            # @!attribute filters
            #   Array of filters to combine. Items can be `ComparisonFilter` or
            #   `CompoundFilter`.
            #
            #   @return [Array<OpenAI::Models::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter, Object>]
            required :filters,
                     -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter] }

            # @!attribute type
            #   Type of operation: `and` or `or`.
            #
            #   @return [Symbol, OpenAI::Models::Beta::BetaFileSearchTool::Filters::CompoundFilter::Type]
            required :type, enum: -> { OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Type }

            # @!method initialize(filters:, type:)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Beta::BetaFileSearchTool::Filters::CompoundFilter} for more
            #   details.
            #
            #   Combine multiple filters using `and` or `or`.
            #
            #   @param filters [Array<OpenAI::Models::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter, Object>] Array of filters to combine. Items can be `ComparisonFilter` or `CompoundFilter`
            #
            #   @param type [Symbol, OpenAI::Models::Beta::BetaFileSearchTool::Filters::CompoundFilter::Type] Type of operation: `and` or `or`.

            # A filter used to compare a specified attribute key to a given value using a
            # defined comparison operation.
            module Filter
              extend OpenAI::Internal::Type::Union

              # A filter used to compare a specified attribute key to a given value using a defined comparison operation.
              variant -> { OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter }

              variant OpenAI::Internal::Type::Unknown

              class ComparisonFilter < OpenAI::Internal::Type::BaseModel
                # @!attribute key
                #   The key to compare against the value.
                #
                #   @return [String]
                required :key, String

                # @!attribute type
                #   Specifies the comparison operator: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`, `in`,
                #   `nin`.
                #
                #   - `eq`: equals
                #   - `ne`: not equal
                #   - `gt`: greater than
                #   - `gte`: greater than or equal
                #   - `lt`: less than
                #   - `lte`: less than or equal
                #   - `in`: in
                #   - `nin`: not in
                #
                #   @return [Symbol, OpenAI::Models::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::Type]
                required :type,
                         enum: -> { OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::Type }

                # @!attribute value
                #   The value to compare against the attribute key; supports string, number, or
                #   boolean types.
                #
                #   @return [String, Float, Boolean, Array<String, Float>]
                required :value,
                         union: -> { OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::Value }

                # @!method initialize(key:, type:, value:)
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter}
                #   for more details.
                #
                #   A filter used to compare a specified attribute key to a given value using a
                #   defined comparison operation.
                #
                #   @param key [String] The key to compare against the value.
                #
                #   @param type [Symbol, OpenAI::Models::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::Type] Specifies the comparison operator: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`, `in`, `
                #
                #   @param value [String, Float, Boolean, Array<String, Float>] The value to compare against the attribute key; supports string, number, or bool

                # Specifies the comparison operator: `eq`, `ne`, `gt`, `gte`, `lt`, `lte`, `in`,
                # `nin`.
                #
                # - `eq`: equals
                # - `ne`: not equal
                # - `gt`: greater than
                # - `gte`: greater than or equal
                # - `lt`: less than
                # - `lte`: less than or equal
                # - `in`: in
                # - `nin`: not in
                #
                # @see OpenAI::Models::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter#type
                module Type
                  extend OpenAI::Internal::Type::Enum

                  EQ = :eq
                  NE = :ne
                  GT = :gt
                  GTE = :gte
                  LT = :lt
                  LTE = :lte
                  IN = :in
                  NIN = :nin

                  # @!method self.values
                  #   @return [Array<Symbol>]
                end

                # The value to compare against the attribute key; supports string, number, or
                # boolean types.
                #
                # @see OpenAI::Models::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter#value
                module Value
                  extend OpenAI::Internal::Type::Union

                  variant String

                  variant Float

                  variant OpenAI::Internal::Type::Boolean

                  variant -> { OpenAI::Models::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::Value::UnionMember3Array }

                  module UnionMember3
                    extend OpenAI::Internal::Type::Union

                    variant String

                    variant Float

                    # @!method self.variants
                    #   @return [Array(String, Float)]
                  end

                  # @!method self.variants
                  #   @return [Array(String, Float, Boolean, Array<String, Float>)]

                  # @type [OpenAI::Internal::Type::Converter]
                  UnionMember3Array =
                    OpenAI::Internal::Type::ArrayOf[
                      union: -> { OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::Value::UnionMember3 }
                    ]
                end
              end

              # @!method self.variants
              #   @return [Array(OpenAI::Models::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter, Object)]
            end

            # Type of operation: `and` or `or`.
            #
            # @see OpenAI::Models::Beta::BetaFileSearchTool::Filters::CompoundFilter#type
            module Type
              extend OpenAI::Internal::Type::Enum

              AND = :and
              OR = :or

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Beta::BetaFileSearchTool::Filters::ComparisonFilter, OpenAI::Models::Beta::BetaFileSearchTool::Filters::CompoundFilter)]
        end

        # @see OpenAI::Models::Beta::BetaFileSearchTool#ranking_options
        class RankingOptions < OpenAI::Internal::Type::BaseModel
          # @!attribute hybrid_search
          #   Weights that control how reciprocal rank fusion balances semantic embedding
          #   matches versus sparse keyword matches when hybrid search is enabled.
          #
          #   @return [OpenAI::Models::Beta::BetaFileSearchTool::RankingOptions::HybridSearch, nil]
          optional :hybrid_search, -> { OpenAI::Beta::BetaFileSearchTool::RankingOptions::HybridSearch }

          # @!attribute ranker
          #   The ranker to use for the file search.
          #
          #   @return [Symbol, OpenAI::Models::Beta::BetaFileSearchTool::RankingOptions::Ranker, nil]
          optional :ranker, enum: -> { OpenAI::Beta::BetaFileSearchTool::RankingOptions::Ranker }

          # @!attribute score_threshold
          #   The score threshold for the file search, a number between 0 and 1. Numbers
          #   closer to 1 will attempt to return only the most relevant results, but may
          #   return fewer results.
          #
          #   @return [Float, nil]
          optional :score_threshold, Float

          # @!method initialize(hybrid_search: nil, ranker: nil, score_threshold: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaFileSearchTool::RankingOptions} for more details.
          #
          #   Ranking options for search.
          #
          #   @param hybrid_search [OpenAI::Models::Beta::BetaFileSearchTool::RankingOptions::HybridSearch] Weights that control how reciprocal rank fusion balances semantic embedding matc
          #
          #   @param ranker [Symbol, OpenAI::Models::Beta::BetaFileSearchTool::RankingOptions::Ranker] The ranker to use for the file search.
          #
          #   @param score_threshold [Float] The score threshold for the file search, a number between 0 and 1. Numbers close

          # @see OpenAI::Models::Beta::BetaFileSearchTool::RankingOptions#hybrid_search
          class HybridSearch < OpenAI::Internal::Type::BaseModel
            # @!attribute embedding_weight
            #   The weight of the embedding in the reciprocal ranking fusion.
            #
            #   @return [Float]
            required :embedding_weight, Float

            # @!attribute text_weight
            #   The weight of the text in the reciprocal ranking fusion.
            #
            #   @return [Float]
            required :text_weight, Float

            # @!method initialize(embedding_weight:, text_weight:)
            #   Weights that control how reciprocal rank fusion balances semantic embedding
            #   matches versus sparse keyword matches when hybrid search is enabled.
            #
            #   @param embedding_weight [Float] The weight of the embedding in the reciprocal ranking fusion.
            #
            #   @param text_weight [Float] The weight of the text in the reciprocal ranking fusion.
          end

          # The ranker to use for the file search.
          #
          # @see OpenAI::Models::Beta::BetaFileSearchTool::RankingOptions#ranker
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

    BetaFileSearchTool = Beta::BetaFileSearchTool
  end
end
