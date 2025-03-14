# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class FileSearchToolCall < OpenAI::BaseModel
            # The ID of the tool call object.
            sig { returns(String) }
            def id
            end

            sig { params(_: String).returns(String) }
            def id=(_)
            end

            # For now, this is always going to be an empty object.
            sig { returns(OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch) }
            def file_search
            end

            sig do
              params(_: OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch)
                .returns(OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch)
            end
            def file_search=(_)
            end

            # The type of tool call. This is always going to be `file_search` for this type of
            #   tool call.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            sig do
              params(
                id: String,
                file_search: OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch,
                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(id:, file_search:, type: :file_search)
            end

            sig do
              override
                .returns(
                  {id: String, file_search: OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch, type: Symbol}
                )
            end
            def to_hash
            end

            class FileSearch < OpenAI::BaseModel
              # The ranking options for the file search.
              sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions)) }
              def ranking_options
              end

              sig do
                params(_: OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions)
                  .returns(OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions)
              end
              def ranking_options=(_)
              end

              # The results of the file search.
              sig { returns(T.nilable(T::Array[OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result])) }
              def results
              end

              sig do
                params(_: T::Array[OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result])
                  .returns(T::Array[OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result])
              end
              def results=(_)
              end

              # For now, this is always going to be an empty object.
              sig do
                params(
                  ranking_options: OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions,
                  results: T::Array[OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result]
                )
                  .returns(T.attached_class)
              end
              def self.new(ranking_options: nil, results: nil)
              end

              sig do
                override
                  .returns(
                    {
                      ranking_options: OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions,
                      results: T::Array[OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result]
                    }
                  )
              end
              def to_hash
              end

              class RankingOptions < OpenAI::BaseModel
                # The ranker to use for the file search. If not specified will use the `auto`
                #   ranker.
                sig { returns(Symbol) }
                def ranker
                end

                sig { params(_: Symbol).returns(Symbol) }
                def ranker=(_)
                end

                # The score threshold for the file search. All values must be a floating point
                #   number between 0 and 1.
                sig { returns(Float) }
                def score_threshold
                end

                sig { params(_: Float).returns(Float) }
                def score_threshold=(_)
                end

                # The ranking options for the file search.
                sig { params(ranker: Symbol, score_threshold: Float).returns(T.attached_class) }
                def self.new(ranker:, score_threshold:)
                end

                sig { override.returns({ranker: Symbol, score_threshold: Float}) }
                def to_hash
                end

                # The ranker to use for the file search. If not specified will use the `auto`
                #   ranker.
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

              class Result < OpenAI::BaseModel
                # The ID of the file that result was found in.
                sig { returns(String) }
                def file_id
                end

                sig { params(_: String).returns(String) }
                def file_id=(_)
                end

                # The name of the file that result was found in.
                sig { returns(String) }
                def file_name
                end

                sig { params(_: String).returns(String) }
                def file_name=(_)
                end

                # The score of the result. All values must be a floating point number between 0
                #   and 1.
                sig { returns(Float) }
                def score
                end

                sig { params(_: Float).returns(Float) }
                def score=(_)
                end

                # The content of the result that was found. The content is only included if
                #   requested via the include query parameter.
                sig do
                  returns(
                    T.nilable(T::Array[OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content])
                  )
                end
                def content
                end

                sig do
                  params(_: T::Array[OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content])
                    .returns(T::Array[OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content])
                end
                def content=(_)
                end

                # A result instance of the file search.
                sig do
                  params(
                    file_id: String,
                    file_name: String,
                    score: Float,
                    content: T::Array[OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content]
                  )
                    .returns(T.attached_class)
                end
                def self.new(file_id:, file_name:, score:, content: nil)
                end

                sig do
                  override
                    .returns(
                      {
                        file_id: String,
                        file_name: String,
                        score: Float,
                        content: T::Array[OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content]
                      }
                    )
                end
                def to_hash
                end

                class Content < OpenAI::BaseModel
                  # The text content of the file.
                  sig { returns(T.nilable(String)) }
                  def text
                  end

                  sig { params(_: String).returns(String) }
                  def text=(_)
                  end

                  # The type of the content.
                  sig { returns(T.nilable(Symbol)) }
                  def type
                  end

                  sig { params(_: Symbol).returns(Symbol) }
                  def type=(_)
                  end

                  sig { params(text: String, type: Symbol).returns(T.attached_class) }
                  def self.new(text: nil, type: nil)
                  end

                  sig { override.returns({text: String, type: Symbol}) }
                  def to_hash
                  end

                  # The type of the content.
                  class Type < OpenAI::Enum
                    abstract!

                    TEXT = :text

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
    end
  end
end
