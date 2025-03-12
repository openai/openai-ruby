# typed: strong

module OpenAI
  module Models
    module Beta
      class FileSearchTool < OpenAI::BaseModel
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig { returns(T.nilable(OpenAI::Models::Beta::FileSearchTool::FileSearch)) }
        def file_search
        end

        sig do
          params(_: OpenAI::Models::Beta::FileSearchTool::FileSearch)
            .returns(OpenAI::Models::Beta::FileSearchTool::FileSearch)
        end
        def file_search=(_)
        end

        sig do
          params(file_search: OpenAI::Models::Beta::FileSearchTool::FileSearch, type: Symbol)
            .returns(T.attached_class)
        end
        def self.new(file_search: nil, type: :file_search)
        end

        sig { override.returns({type: Symbol, file_search: OpenAI::Models::Beta::FileSearchTool::FileSearch}) }
        def to_hash
        end

        class FileSearch < OpenAI::BaseModel
          sig { returns(T.nilable(Integer)) }
          def max_num_results
          end

          sig { params(_: Integer).returns(Integer) }
          def max_num_results=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions)) }
          def ranking_options
          end

          sig do
            params(_: OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions)
              .returns(OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions)
          end
          def ranking_options=(_)
          end

          sig do
            params(
              max_num_results: Integer,
              ranking_options: OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions
            )
              .returns(T.attached_class)
          end
          def self.new(max_num_results: nil, ranking_options: nil)
          end

          sig do
            override
              .returns(
                {max_num_results: Integer, ranking_options: OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions}
              )
          end
          def to_hash
          end

          class RankingOptions < OpenAI::BaseModel
            sig { returns(Float) }
            def score_threshold
            end

            sig { params(_: Float).returns(Float) }
            def score_threshold=(_)
            end

            sig { returns(T.nilable(Symbol)) }
            def ranker
            end

            sig { params(_: Symbol).returns(Symbol) }
            def ranker=(_)
            end

            sig { params(score_threshold: Float, ranker: Symbol).returns(T.attached_class) }
            def self.new(score_threshold:, ranker: nil)
            end

            sig { override.returns({score_threshold: Float, ranker: Symbol}) }
            def to_hash
            end

            class Ranker < OpenAI::Enum
              abstract!

              AUTO = :auto
              DEFAULT_2024_08_21 = :default_2024_08_21

              class << self
                sig { override.returns(T::Array[Symbol]) }
                def values
                end
              end
            end
          end
        end
      end
    end
  end
end
