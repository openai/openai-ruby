# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class FileSearchToolCall < OpenAI::BaseModel
            sig { returns(String) }
            def id
            end

            sig { params(_: String).returns(String) }
            def id=(_)
            end

            sig { returns(OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch) }
            def file_search
            end

            sig do
              params(_: OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch)
                .returns(OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch)
            end
            def file_search=(_)
            end

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
              sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions)) }
              def ranking_options
              end

              sig do
                params(_: OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions)
                  .returns(OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions)
              end
              def ranking_options=(_)
              end

              sig { returns(T.nilable(T::Array[OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result])) }
              def results
              end

              sig do
                params(_: T::Array[OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result])
                  .returns(T::Array[OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result])
              end
              def results=(_)
              end

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
                sig { returns(Symbol) }
                def ranker
                end

                sig { params(_: Symbol).returns(Symbol) }
                def ranker=(_)
                end

                sig { returns(Float) }
                def score_threshold
                end

                sig { params(_: Float).returns(Float) }
                def score_threshold=(_)
                end

                sig { params(ranker: Symbol, score_threshold: Float).returns(T.attached_class) }
                def self.new(ranker:, score_threshold:)
                end

                sig { override.returns({ranker: Symbol, score_threshold: Float}) }
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

              class Result < OpenAI::BaseModel
                sig { returns(String) }
                def file_id
                end

                sig { params(_: String).returns(String) }
                def file_id=(_)
                end

                sig { returns(String) }
                def file_name
                end

                sig { params(_: String).returns(String) }
                def file_name=(_)
                end

                sig { returns(Float) }
                def score
                end

                sig { params(_: Float).returns(Float) }
                def score=(_)
                end

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
                  sig { returns(T.nilable(String)) }
                  def text
                  end

                  sig { params(_: String).returns(String) }
                  def text=(_)
                  end

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
