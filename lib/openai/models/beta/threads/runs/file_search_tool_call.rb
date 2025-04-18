# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class FileSearchToolCall < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The ID of the tool call object.
            #
            #   @return [String]
            required :id, String

            # @!attribute file_search
            #   For now, this is always going to be an empty object.
            #
            #   @return [OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch]
            required :file_search, -> { OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch }

            # @!attribute type
            #   The type of tool call. This is always going to be `file_search` for this type of
            #   tool call.
            #
            #   @return [Symbol, :file_search]
            required :type, const: :file_search

            # @!method initialize(id:, file_search:, type: :file_search)
            #   @param id [String]
            #   @param file_search [OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch]
            #   @param type [Symbol, :file_search]

            # @see OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall#file_search
            class FileSearch < OpenAI::Internal::Type::BaseModel
              # @!attribute ranking_options
              #   The ranking options for the file search.
              #
              #   @return [OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions, nil]
              optional :ranking_options,
                       -> { OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions }

              # @!attribute results
              #   The results of the file search.
              #
              #   @return [Array<OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result>, nil]
              optional :results,
                       -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result] }

              # @!method initialize(ranking_options: nil, results: nil)
              #   For now, this is always going to be an empty object.
              #
              #   @param ranking_options [OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions]
              #   @param results [Array<OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result>]

              # @see OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch#ranking_options
              class RankingOptions < OpenAI::Internal::Type::BaseModel
                # @!attribute ranker
                #   The ranker to use for the file search. If not specified will use the `auto`
                #   ranker.
                #
                #   @return [Symbol, OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions::Ranker]
                required :ranker,
                         enum: -> { OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions::Ranker }

                # @!attribute score_threshold
                #   The score threshold for the file search. All values must be a floating point
                #   number between 0 and 1.
                #
                #   @return [Float]
                required :score_threshold, Float

                # @!method initialize(ranker:, score_threshold:)
                #   The ranking options for the file search.
                #
                #   @param ranker [Symbol, OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions::Ranker]
                #   @param score_threshold [Float]

                # The ranker to use for the file search. If not specified will use the `auto`
                # ranker.
                #
                # @see OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions#ranker
                module Ranker
                  extend OpenAI::Internal::Type::Enum

                  AUTO = :auto
                  DEFAULT_2024_08_21 = :default_2024_08_21

                  # @!method self.values
                  #   @return [Array<Symbol>]
                end
              end

              class Result < OpenAI::Internal::Type::BaseModel
                # @!attribute file_id
                #   The ID of the file that result was found in.
                #
                #   @return [String]
                required :file_id, String

                # @!attribute file_name
                #   The name of the file that result was found in.
                #
                #   @return [String]
                required :file_name, String

                # @!attribute score
                #   The score of the result. All values must be a floating point number between 0
                #   and 1.
                #
                #   @return [Float]
                required :score, Float

                # @!attribute content
                #   The content of the result that was found. The content is only included if
                #   requested via the include query parameter.
                #
                #   @return [Array<OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content>, nil]
                optional :content,
                         -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content] }

                # @!method initialize(file_id:, file_name:, score:, content: nil)
                #   A result instance of the file search.
                #
                #   @param file_id [String]
                #   @param file_name [String]
                #   @param score [Float]
                #   @param content [Array<OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content>]

                class Content < OpenAI::Internal::Type::BaseModel
                  # @!attribute text
                  #   The text content of the file.
                  #
                  #   @return [String, nil]
                  optional :text, String

                  # @!attribute type
                  #   The type of the content.
                  #
                  #   @return [Symbol, OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content::Type, nil]
                  optional :type,
                           enum: -> { OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content::Type }

                  # @!method initialize(text: nil, type: nil)
                  #   @param text [String]
                  #   @param type [Symbol, OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content::Type]

                  # The type of the content.
                  #
                  # @see OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content#type
                  module Type
                    extend OpenAI::Internal::Type::Enum

                    TEXT = :text

                    # @!method self.values
                    #   @return [Array<Symbol>]
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
