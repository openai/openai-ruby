# typed: strong

module OpenAI
  module Models
    module Beta
      class FileSearchTool < OpenAI::BaseModel
        # The type of tool being defined: `file_search`
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # Overrides for the file search tool.
        sig { returns(T.nilable(OpenAI::Models::Beta::FileSearchTool::FileSearch)) }
        def file_search
        end

        sig do
          params(_: T.any(OpenAI::Models::Beta::FileSearchTool::FileSearch, OpenAI::Util::AnyHash))
            .returns(T.any(OpenAI::Models::Beta::FileSearchTool::FileSearch, OpenAI::Util::AnyHash))
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
          # The maximum number of results the file search tool should output. The default is
          #   20 for `gpt-4*` models and 5 for `gpt-3.5-turbo`. This number should be between
          #   1 and 50 inclusive.
          #
          #   Note that the file search tool may output fewer than `max_num_results` results.
          #   See the
          #   [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings)
          #   for more information.
          sig { returns(T.nilable(Integer)) }
          def max_num_results
          end

          sig { params(_: Integer).returns(Integer) }
          def max_num_results=(_)
          end

          # The ranking options for the file search. If not specified, the file search tool
          #   will use the `auto` ranker and a score_threshold of 0.
          #
          #   See the
          #   [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings)
          #   for more information.
          sig { returns(T.nilable(OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions)) }
          def ranking_options
          end

          sig do
            params(_: T.any(OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions, OpenAI::Util::AnyHash))
              .returns(T.any(OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions, OpenAI::Util::AnyHash))
          end
          def ranking_options=(_)
          end

          # Overrides for the file search tool.
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
            # The score threshold for the file search. All values must be a floating point
            #   number between 0 and 1.
            sig { returns(Float) }
            def score_threshold
            end

            sig { params(_: Float).returns(Float) }
            def score_threshold=(_)
            end

            # The ranker to use for the file search. If not specified will use the `auto`
            #   ranker.
            sig { returns(T.nilable(OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions::Ranker::OrSymbol)) }
            def ranker
            end

            sig do
              params(_: OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions::Ranker::OrSymbol)
                .returns(OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions::Ranker::OrSymbol)
            end
            def ranker=(_)
            end

            # The ranking options for the file search. If not specified, the file search tool
            #   will use the `auto` ranker and a score_threshold of 0.
            #
            #   See the
            #   [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings)
            #   for more information.
            sig do
              params(
                score_threshold: Float,
                ranker: OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions::Ranker::OrSymbol
              )
                .returns(T.attached_class)
            end
            def self.new(score_threshold:, ranker: nil)
            end

            sig do
              override
                .returns(
                  {
                    score_threshold: Float,
                    ranker: OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions::Ranker::OrSymbol
                  }
                )
            end
            def to_hash
            end

            # The ranker to use for the file search. If not specified will use the `auto`
            #   ranker.
            module Ranker
              extend OpenAI::Enum

              TaggedSymbol =
                T.type_alias { T.all(Symbol, OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions::Ranker) }
              OrSymbol =
                T.type_alias { T.any(Symbol, OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions::Ranker::TaggedSymbol) }

              AUTO =
                T.let(:auto, OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions::Ranker::TaggedSymbol)
              DEFAULT_2024_08_21 =
                T.let(
                  :default_2024_08_21,
                  OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions::Ranker::TaggedSymbol
                )

              class << self
                sig do
                  override
                    .returns(T::Array[OpenAI::Models::Beta::FileSearchTool::FileSearch::RankingOptions::Ranker::TaggedSymbol])
                end
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
