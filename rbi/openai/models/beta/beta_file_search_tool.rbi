# typed: strong

module OpenAI
  module Models
    BetaFileSearchTool = Beta::BetaFileSearchTool

    module Beta
      class BetaFileSearchTool < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Beta::BetaFileSearchTool, OpenAI::Internal::AnyHash)
          end

        # The type of the file search tool. Always `file_search`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The IDs of the vector stores to search.
        sig { returns(T::Array[String]) }
        attr_accessor :vector_store_ids

        # A filter to apply.
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter,
                OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter
              )
            )
          )
        end
        attr_accessor :filters

        # The maximum number of results to return. This number should be between 1 and 50
        # inclusive.
        sig { returns(T.nilable(Integer)) }
        attr_reader :max_num_results

        sig { params(max_num_results: Integer).void }
        attr_writer :max_num_results

        # Ranking options for search.
        sig do
          returns(T.nilable(OpenAI::Beta::BetaFileSearchTool::RankingOptions))
        end
        attr_reader :ranking_options

        sig do
          params(
            ranking_options:
              OpenAI::Beta::BetaFileSearchTool::RankingOptions::OrHash
          ).void
        end
        attr_writer :ranking_options

        # A tool that searches for relevant content from uploaded files. Learn more about
        # the
        # [file search tool](https://platform.openai.com/docs/guides/tools-file-search).
        sig do
          params(
            vector_store_ids: T::Array[String],
            filters:
              T.nilable(
                T.any(
                  OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter::OrHash,
                  OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::OrHash
                )
              ),
            max_num_results: Integer,
            ranking_options:
              OpenAI::Beta::BetaFileSearchTool::RankingOptions::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The IDs of the vector stores to search.
          vector_store_ids:,
          # A filter to apply.
          filters: nil,
          # The maximum number of results to return. This number should be between 1 and 50
          # inclusive.
          max_num_results: nil,
          # Ranking options for search.
          ranking_options: nil,
          # The type of the file search tool. Always `file_search`.
          type: :file_search
        )
        end

        sig do
          override.returns(
            {
              type: Symbol,
              vector_store_ids: T::Array[String],
              filters:
                T.nilable(
                  T.any(
                    OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter,
                    OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter
                  )
                ),
              max_num_results: Integer,
              ranking_options: OpenAI::Beta::BetaFileSearchTool::RankingOptions
            }
          )
        end
        def to_hash
        end

        # A filter to apply.
        module Filters
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter,
                OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter
              )
            end

          class ComparisonFilter < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter,
                  OpenAI::Internal::AnyHash
                )
              end

            # The key to compare against the value.
            sig { returns(String) }
            attr_accessor :key

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
            sig do
              returns(
                OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter::Type::OrSymbol
              )
            end
            attr_accessor :type

            # The value to compare against the attribute key; supports string, number, or
            # boolean types.
            sig do
              returns(
                OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter::Value::Variants
              )
            end
            attr_accessor :value

            # A filter used to compare a specified attribute key to a given value using a
            # defined comparison operation.
            sig do
              params(
                key: String,
                type:
                  OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter::Type::OrSymbol,
                value:
                  OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter::Value::Variants
              ).returns(T.attached_class)
            end
            def self.new(
              # The key to compare against the value.
              key:,
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
              type:,
              # The value to compare against the attribute key; supports string, number, or
              # boolean types.
              value:
            )
            end

            sig do
              override.returns(
                {
                  key: String,
                  type:
                    OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter::Type::OrSymbol,
                  value:
                    OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter::Value::Variants
                }
              )
            end
            def to_hash
            end

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
            module Type
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter::Type
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              EQ =
                T.let(
                  :eq,
                  OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter::Type::TaggedSymbol
                )
              NE =
                T.let(
                  :ne,
                  OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter::Type::TaggedSymbol
                )
              GT =
                T.let(
                  :gt,
                  OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter::Type::TaggedSymbol
                )
              GTE =
                T.let(
                  :gte,
                  OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter::Type::TaggedSymbol
                )
              LT =
                T.let(
                  :lt,
                  OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter::Type::TaggedSymbol
                )
              LTE =
                T.let(
                  :lte,
                  OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter::Type::TaggedSymbol
                )
              IN =
                T.let(
                  :in,
                  OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter::Type::TaggedSymbol
                )
              NIN =
                T.let(
                  :nin,
                  OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter::Type::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter::Type::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end

            # The value to compare against the attribute key; supports string, number, or
            # boolean types.
            module Value
              extend OpenAI::Internal::Type::Union

              Variants =
                T.type_alias do
                  T.any(
                    String,
                    Float,
                    T::Boolean,
                    T::Array[
                      OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter::Value::UnionMember3::Variants
                    ]
                  )
                end

              module UnionMember3
                extend OpenAI::Internal::Type::Union

                Variants = T.type_alias { T.any(String, Float) }

                sig do
                  override.returns(
                    T::Array[
                      OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter::Value::UnionMember3::Variants
                    ]
                  )
                end
                def self.variants
                end
              end

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter::Value::Variants
                  ]
                )
              end
              def self.variants
              end

              UnionMember3Array =
                T.let(
                  OpenAI::Internal::Type::ArrayOf[
                    union:
                      OpenAI::Beta::BetaFileSearchTool::Filters::ComparisonFilter::Value::UnionMember3
                  ],
                  OpenAI::Internal::Type::Converter
                )
            end
          end

          class CompoundFilter < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter,
                  OpenAI::Internal::AnyHash
                )
              end

            # Array of filters to combine. Items can be `ComparisonFilter` or
            # `CompoundFilter`.
            sig do
              returns(
                T::Array[
                  T.any(
                    OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter,
                    T.anything
                  )
                ]
              )
            end
            attr_accessor :filters

            # Type of operation: `and` or `or`.
            sig do
              returns(
                OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Type::OrSymbol
              )
            end
            attr_accessor :type

            # Combine multiple filters using `and` or `or`.
            sig do
              params(
                filters:
                  T::Array[
                    T.any(
                      OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::OrHash,
                      T.anything
                    )
                  ],
                type:
                  OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Type::OrSymbol
              ).returns(T.attached_class)
            end
            def self.new(
              # Array of filters to combine. Items can be `ComparisonFilter` or
              # `CompoundFilter`.
              filters:,
              # Type of operation: `and` or `or`.
              type:
            )
            end

            sig do
              override.returns(
                {
                  filters:
                    T::Array[
                      T.any(
                        OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter,
                        T.anything
                      )
                    ],
                  type:
                    OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Type::OrSymbol
                }
              )
            end
            def to_hash
            end

            # A filter used to compare a specified attribute key to a given value using a
            # defined comparison operation.
            module Filter
              extend OpenAI::Internal::Type::Union

              Variants =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter,
                    T.anything
                  )
                end

              class ComparisonFilter < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # The key to compare against the value.
                sig { returns(String) }
                attr_accessor :key

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
                sig do
                  returns(
                    OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::Type::OrSymbol
                  )
                end
                attr_accessor :type

                # The value to compare against the attribute key; supports string, number, or
                # boolean types.
                sig do
                  returns(
                    OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::Value::Variants
                  )
                end
                attr_accessor :value

                # A filter used to compare a specified attribute key to a given value using a
                # defined comparison operation.
                sig do
                  params(
                    key: String,
                    type:
                      OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::Type::OrSymbol,
                    value:
                      OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::Value::Variants
                  ).returns(T.attached_class)
                end
                def self.new(
                  # The key to compare against the value.
                  key:,
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
                  type:,
                  # The value to compare against the attribute key; supports string, number, or
                  # boolean types.
                  value:
                )
                end

                sig do
                  override.returns(
                    {
                      key: String,
                      type:
                        OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::Type::OrSymbol,
                      value:
                        OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::Value::Variants
                    }
                  )
                end
                def to_hash
                end

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
                module Type
                  extend OpenAI::Internal::Type::Enum

                  TaggedSymbol =
                    T.type_alias do
                      T.all(
                        Symbol,
                        OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::Type
                      )
                    end
                  OrSymbol = T.type_alias { T.any(Symbol, String) }

                  EQ =
                    T.let(
                      :eq,
                      OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::Type::TaggedSymbol
                    )
                  NE =
                    T.let(
                      :ne,
                      OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::Type::TaggedSymbol
                    )
                  GT =
                    T.let(
                      :gt,
                      OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::Type::TaggedSymbol
                    )
                  GTE =
                    T.let(
                      :gte,
                      OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::Type::TaggedSymbol
                    )
                  LT =
                    T.let(
                      :lt,
                      OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::Type::TaggedSymbol
                    )
                  LTE =
                    T.let(
                      :lte,
                      OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::Type::TaggedSymbol
                    )
                  IN =
                    T.let(
                      :in,
                      OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::Type::TaggedSymbol
                    )
                  NIN =
                    T.let(
                      :nin,
                      OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::Type::TaggedSymbol
                    )

                  sig do
                    override.returns(
                      T::Array[
                        OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::Type::TaggedSymbol
                      ]
                    )
                  end
                  def self.values
                  end
                end

                # The value to compare against the attribute key; supports string, number, or
                # boolean types.
                module Value
                  extend OpenAI::Internal::Type::Union

                  Variants =
                    T.type_alias do
                      T.any(
                        String,
                        Float,
                        T::Boolean,
                        T::Array[
                          OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::Value::UnionMember3::Variants
                        ]
                      )
                    end

                  module UnionMember3
                    extend OpenAI::Internal::Type::Union

                    Variants = T.type_alias { T.any(String, Float) }

                    sig do
                      override.returns(
                        T::Array[
                          OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::Value::UnionMember3::Variants
                        ]
                      )
                    end
                    def self.variants
                    end
                  end

                  sig do
                    override.returns(
                      T::Array[
                        OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::Value::Variants
                      ]
                    )
                  end
                  def self.variants
                  end

                  UnionMember3Array =
                    T.let(
                      OpenAI::Internal::Type::ArrayOf[
                        union:
                          OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::ComparisonFilter::Value::UnionMember3
                      ],
                      OpenAI::Internal::Type::Converter
                    )
                end
              end

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Filter::Variants
                  ]
                )
              end
              def self.variants
              end
            end

            # Type of operation: `and` or `or`.
            module Type
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Type
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              AND =
                T.let(
                  :and,
                  OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Type::TaggedSymbol
                )
              OR =
                T.let(
                  :or,
                  OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Type::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Beta::BetaFileSearchTool::Filters::CompoundFilter::Type::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end
          end

          sig do
            override.returns(
              T::Array[OpenAI::Beta::BetaFileSearchTool::Filters::Variants]
            )
          end
          def self.variants
          end
        end

        class RankingOptions < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaFileSearchTool::RankingOptions,
                OpenAI::Internal::AnyHash
              )
            end

          # Weights that control how reciprocal rank fusion balances semantic embedding
          # matches versus sparse keyword matches when hybrid search is enabled.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::BetaFileSearchTool::RankingOptions::HybridSearch
              )
            )
          end
          attr_reader :hybrid_search

          sig do
            params(
              hybrid_search:
                OpenAI::Beta::BetaFileSearchTool::RankingOptions::HybridSearch::OrHash
            ).void
          end
          attr_writer :hybrid_search

          # The ranker to use for the file search.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::BetaFileSearchTool::RankingOptions::Ranker::OrSymbol
              )
            )
          end
          attr_reader :ranker

          sig do
            params(
              ranker:
                OpenAI::Beta::BetaFileSearchTool::RankingOptions::Ranker::OrSymbol
            ).void
          end
          attr_writer :ranker

          # The score threshold for the file search, a number between 0 and 1. Numbers
          # closer to 1 will attempt to return only the most relevant results, but may
          # return fewer results.
          sig { returns(T.nilable(Float)) }
          attr_reader :score_threshold

          sig { params(score_threshold: Float).void }
          attr_writer :score_threshold

          # Ranking options for search.
          sig do
            params(
              hybrid_search:
                OpenAI::Beta::BetaFileSearchTool::RankingOptions::HybridSearch::OrHash,
              ranker:
                OpenAI::Beta::BetaFileSearchTool::RankingOptions::Ranker::OrSymbol,
              score_threshold: Float
            ).returns(T.attached_class)
          end
          def self.new(
            # Weights that control how reciprocal rank fusion balances semantic embedding
            # matches versus sparse keyword matches when hybrid search is enabled.
            hybrid_search: nil,
            # The ranker to use for the file search.
            ranker: nil,
            # The score threshold for the file search, a number between 0 and 1. Numbers
            # closer to 1 will attempt to return only the most relevant results, but may
            # return fewer results.
            score_threshold: nil
          )
          end

          sig do
            override.returns(
              {
                hybrid_search:
                  OpenAI::Beta::BetaFileSearchTool::RankingOptions::HybridSearch,
                ranker:
                  OpenAI::Beta::BetaFileSearchTool::RankingOptions::Ranker::OrSymbol,
                score_threshold: Float
              }
            )
          end
          def to_hash
          end

          class HybridSearch < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaFileSearchTool::RankingOptions::HybridSearch,
                  OpenAI::Internal::AnyHash
                )
              end

            # The weight of the embedding in the reciprocal ranking fusion.
            sig { returns(Float) }
            attr_accessor :embedding_weight

            # The weight of the text in the reciprocal ranking fusion.
            sig { returns(Float) }
            attr_accessor :text_weight

            # Weights that control how reciprocal rank fusion balances semantic embedding
            # matches versus sparse keyword matches when hybrid search is enabled.
            sig do
              params(embedding_weight: Float, text_weight: Float).returns(
                T.attached_class
              )
            end
            def self.new(
              # The weight of the embedding in the reciprocal ranking fusion.
              embedding_weight:,
              # The weight of the text in the reciprocal ranking fusion.
              text_weight:
            )
            end

            sig do
              override.returns({ embedding_weight: Float, text_weight: Float })
            end
            def to_hash
            end
          end

          # The ranker to use for the file search.
          module Ranker
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Beta::BetaFileSearchTool::RankingOptions::Ranker
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            AUTO =
              T.let(
                :auto,
                OpenAI::Beta::BetaFileSearchTool::RankingOptions::Ranker::TaggedSymbol
              )
            DEFAULT_2024_11_15 =
              T.let(
                :"default-2024-11-15",
                OpenAI::Beta::BetaFileSearchTool::RankingOptions::Ranker::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::BetaFileSearchTool::RankingOptions::Ranker::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end
      end
    end
  end
end
