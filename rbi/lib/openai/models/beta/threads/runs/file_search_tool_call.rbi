# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class FileSearchToolCall < OpenAI::BaseModel
            # The ID of the tool call object.
            sig { returns(String) }
            attr_accessor :id

            # For now, this is always going to be an empty object.
            sig { returns(OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch) }
            attr_reader :file_search

            sig do
              params(
                file_search: T.any(OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch, OpenAI::Util::AnyHash)
              )
                .void
            end
            attr_writer :file_search

            # The type of tool call. This is always going to be `file_search` for this type of
            #   tool call.
            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              params(
                id: String,
                file_search: T.any(OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch, OpenAI::Util::AnyHash),
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
              attr_reader :ranking_options

              sig do
                params(
                  ranking_options: T.any(
                    OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions,
                    OpenAI::Util::AnyHash
                  )
                )
                  .void
              end
              attr_writer :ranking_options

              # The results of the file search.
              sig { returns(T.nilable(T::Array[OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result])) }
              attr_reader :results

              sig do
                params(
                  results: T::Array[T.any(OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result, OpenAI::Util::AnyHash)]
                )
                  .void
              end
              attr_writer :results

              # For now, this is always going to be an empty object.
              sig do
                params(
                  ranking_options: T.any(
                    OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions,
                    OpenAI::Util::AnyHash
                  ),
                  results: T::Array[T.any(OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result, OpenAI::Util::AnyHash)]
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
                sig do
                  returns(
                    OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions::Ranker::TaggedSymbol
                  )
                end
                attr_accessor :ranker

                # The score threshold for the file search. All values must be a floating point
                #   number between 0 and 1.
                sig { returns(Float) }
                attr_accessor :score_threshold

                # The ranking options for the file search.
                sig do
                  params(
                    ranker: OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions::Ranker::OrSymbol,
                    score_threshold: Float
                  )
                    .returns(T.attached_class)
                end
                def self.new(ranker:, score_threshold:)
                end

                sig do
                  override
                    .returns(
                      {
                        ranker: OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions::Ranker::TaggedSymbol,
                        score_threshold: Float
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
                    T.type_alias { T.all(Symbol, OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions::Ranker) }
                  OrSymbol =
                    T.type_alias do
                      T.any(
                        Symbol,
                        String,
                        OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions::Ranker::TaggedSymbol
                      )
                    end

                  AUTO =
                    T.let(
                      :auto,
                      OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions::Ranker::TaggedSymbol
                    )
                  DEFAULT_2024_08_21 =
                    T.let(
                      :default_2024_08_21,
                      OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions::Ranker::TaggedSymbol
                    )

                  sig do
                    override
                      .returns(
                        T::Array[OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions::Ranker::TaggedSymbol]
                      )
                  end
                  def self.values
                  end
                end
              end

              class Result < OpenAI::BaseModel
                # The ID of the file that result was found in.
                sig { returns(String) }
                attr_accessor :file_id

                # The name of the file that result was found in.
                sig { returns(String) }
                attr_accessor :file_name

                # The score of the result. All values must be a floating point number between 0
                #   and 1.
                sig { returns(Float) }
                attr_accessor :score

                # The content of the result that was found. The content is only included if
                #   requested via the include query parameter.
                sig do
                  returns(
                    T.nilable(T::Array[OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content])
                  )
                end
                attr_reader :content

                sig do
                  params(
                    content: T::Array[
                    T.any(
                      OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content,
                      OpenAI::Util::AnyHash
                    )
                    ]
                  )
                    .void
                end
                attr_writer :content

                # A result instance of the file search.
                sig do
                  params(
                    file_id: String,
                    file_name: String,
                    score: Float,
                    content: T::Array[
                    T.any(
                      OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content,
                      OpenAI::Util::AnyHash
                    )
                    ]
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
                  attr_reader :text

                  sig { params(text: String).void }
                  attr_writer :text

                  # The type of the content.
                  sig do
                    returns(
                      T.nilable(
                        OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content::Type::TaggedSymbol
                      )
                    )
                  end
                  attr_reader :type

                  sig do
                    params(
                      type: OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content::Type::OrSymbol
                    )
                      .void
                  end
                  attr_writer :type

                  sig do
                    params(
                      text: String,
                      type: OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content::Type::OrSymbol
                    )
                      .returns(T.attached_class)
                  end
                  def self.new(text: nil, type: nil)
                  end

                  sig do
                    override
                      .returns(
                        {
                          text: String,
                          type: OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content::Type::TaggedSymbol
                        }
                      )
                  end
                  def to_hash
                  end

                  # The type of the content.
                  module Type
                    extend OpenAI::Enum

                    TaggedSymbol =
                      T.type_alias { T.all(Symbol, OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content::Type) }
                    OrSymbol =
                      T.type_alias do
                        T.any(
                          Symbol,
                          String,
                          OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content::Type::TaggedSymbol
                        )
                      end

                    TEXT =
                      T.let(
                        :text,
                        OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content::Type::TaggedSymbol
                      )

                    sig do
                      override
                        .returns(
                          T::Array[OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content::Type::TaggedSymbol]
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
      end
    end
  end
end
