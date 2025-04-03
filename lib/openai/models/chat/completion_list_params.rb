# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      # @see OpenAI::Resources::Chat::Completions#list
      class CompletionListParams < OpenAI::BaseModel
        # @!parse
        #   extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute [r] after
        #   Identifier for the last chat completion from the previous pagination request.
        #
        #   @return [String, nil]
        optional :after, String

        # @!parse
        #   # @return [String]
        #   attr_writer :after

        # @!attribute [r] limit
        #   Number of Chat Completions to retrieve.
        #
        #   @return [Integer, nil]
        optional :limit, Integer

        # @!parse
        #   # @return [Integer]
        #   attr_writer :limit

        # @!attribute metadata
        #   A list of metadata keys to filter the Chat Completions by. Example:
        #
        #     `metadata[key1]=value1&metadata[key2]=value2`
        #
        #   @return [Hash{Symbol=>String}, nil]
        optional :metadata, OpenAI::HashOf[String], nil?: true

        # @!attribute [r] model
        #   The model used to generate the Chat Completions.
        #
        #   @return [String, nil]
        optional :model, String

        # @!parse
        #   # @return [String]
        #   attr_writer :model

        # @!attribute [r] order
        #   Sort order for Chat Completions by timestamp. Use `asc` for ascending order or
        #     `desc` for descending order. Defaults to `asc`.
        #
        #   @return [Symbol, OpenAI::Models::Chat::CompletionListParams::Order, nil]
        optional :order, enum: -> { OpenAI::Models::Chat::CompletionListParams::Order }

        # @!parse
        #   # @return [Symbol, OpenAI::Models::Chat::CompletionListParams::Order]
        #   attr_writer :order

        # @!parse
        #   # @param after [String]
        #   # @param limit [Integer]
        #   # @param metadata [Hash{Symbol=>String}, nil]
        #   # @param model [String]
        #   # @param order [Symbol, OpenAI::Models::Chat::CompletionListParams::Order]
        #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        #   #
        #   def initialize(after: nil, limit: nil, metadata: nil, model: nil, order: nil, request_options: {}, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # Sort order for Chat Completions by timestamp. Use `asc` for ascending order or
        #   `desc` for descending order. Defaults to `asc`.
        module Order
          extend OpenAI::Enum

          ASC = :asc
          DESC = :desc

          finalize!

          # @!parse
          #   # @return [Array<Symbol>]
          #   def self.values; end
        end
      end
    end
  end
end
