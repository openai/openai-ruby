# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class FileSearchToolCall < OpenAI::BaseModel
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
            #     tool call.
            #
            #   @return [Symbol, :file_search]
            required :type, const: :file_search

            # @!parse
            #   # @param id [String]
            #   # @param file_search [OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch]
            #   # @param type [Symbol, :file_search]
            #   #
            #   def initialize(id:, file_search:, type: :file_search, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void

            class FileSearch < OpenAI::BaseModel
              # @!attribute [r] ranking_options
              #   The ranking options for the file search.
              #
              #   @return [OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions, nil]
              optional :ranking_options,
                       -> { OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions }

              # @!parse
              #   # @return [OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions]
              #   attr_writer :ranking_options

              # @!attribute [r] results
              #   The results of the file search.
              #
              #   @return [Array<OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result>, nil]
              optional :results,
                       -> { OpenAI::ArrayOf[OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result] }

              # @!parse
              #   # @return [Array<OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result>]
              #   attr_writer :results

              # @!parse
              #   # For now, this is always going to be an empty object.
              #   #
              #   # @param ranking_options [OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::RankingOptions]
              #   # @param results [Array<OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result>]
              #   #
              #   def initialize(ranking_options: nil, results: nil, **) = super

              # def initialize: (Hash | OpenAI::BaseModel) -> void

              class RankingOptions < OpenAI::BaseModel
                # @!attribute ranker
                #   The ranker used for the file search.
                #
                #   @return [Symbol, :default_2024_08_21]
                required :ranker, const: :default_2024_08_21

                # @!attribute score_threshold
                #   The score threshold for the file search. All values must be a floating point
                #     number between 0 and 1.
                #
                #   @return [Float]
                required :score_threshold, Float

                # @!parse
                #   # The ranking options for the file search.
                #   #
                #   # @param score_threshold [Float]
                #   # @param ranker [Symbol, :default_2024_08_21]
                #   #
                #   def initialize(score_threshold:, ranker: :default_2024_08_21, **) = super

                # def initialize: (Hash | OpenAI::BaseModel) -> void
              end

              class Result < OpenAI::BaseModel
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
                #     and 1.
                #
                #   @return [Float]
                required :score, Float

                # @!attribute [r] content
                #   The content of the result that was found. The content is only included if
                #     requested via the include query parameter.
                #
                #   @return [Array<OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content>, nil]
                optional :content,
                         -> { OpenAI::ArrayOf[OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content] }

                # @!parse
                #   # @return [Array<OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content>]
                #   attr_writer :content

                # @!parse
                #   # A result instance of the file search.
                #   #
                #   # @param file_id [String]
                #   # @param file_name [String]
                #   # @param score [Float]
                #   # @param content [Array<OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content>]
                #   #
                #   def initialize(file_id:, file_name:, score:, content: nil, **) = super

                # def initialize: (Hash | OpenAI::BaseModel) -> void

                class Content < OpenAI::BaseModel
                  # @!attribute [r] text
                  #   The text content of the file.
                  #
                  #   @return [String, nil]
                  optional :text, String

                  # @!parse
                  #   # @return [String]
                  #   attr_writer :text

                  # @!attribute [r] type
                  #   The type of the content.
                  #
                  #   @return [Symbol, OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content::Type, nil]
                  optional :type,
                           enum: -> { OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content::Type }

                  # @!parse
                  #   # @return [Symbol, OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content::Type]
                  #   attr_writer :type

                  # @!parse
                  #   # @param text [String]
                  #   # @param type [Symbol, OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall::FileSearch::Result::Content::Type]
                  #   #
                  #   def initialize(text: nil, type: nil, **) = super

                  # def initialize: (Hash | OpenAI::BaseModel) -> void

                  # @abstract
                  #
                  # The type of the content.
                  class Type < OpenAI::Enum
                    TEXT = :text

                    finalize!
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
