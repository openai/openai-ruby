# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      # @see OpenAI::Resources::Chat::Completions#list
      class CompletionListParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute after
        #   Identifier for the last chat completion from the previous pagination request.
        #
        #   @return [String, nil]
        optional :after, String

        # @!attribute limit
        #   Number of Chat Completions to retrieve.
        #
        #   @return [Integer, nil]
        optional :limit, Integer

        # @!attribute metadata
        #   A list of metadata keys to filter the Chat Completions by. Example:
        #
        #   `metadata[key1]=value1&metadata[key2]=value2`
        #
        #   @return [Hash{Symbol=>String}, nil]
        optional :metadata, OpenAI::Internal::Type::HashOf[String], nil?: true

        # @!attribute model
        #   The model used to generate the Chat Completions.
        #
        #   @return [String, nil]
        optional :model, String

        # @!attribute order
        #   Sort order for Chat Completions by timestamp. Use `asc` for ascending order or
        #   `desc` for descending order. Defaults to `asc`.
        #
        #   @return [Symbol, OpenAI::Chat::CompletionListParams::Order, nil]
        optional :order, enum: -> { OpenAI::Chat::CompletionListParams::Order }

        # @!method initialize(after: nil, limit: nil, metadata: nil, model: nil, order: nil, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Chat::CompletionListParams} for more details.
        #
        #   @param after [String] Identifier for the last chat completion from the previous pagination request.
        #
        #   @param limit [Integer] Number of Chat Completions to retrieve.
        #
        #   @param metadata [Hash{Symbol=>String}, nil] A list of metadata keys to filter the Chat Completions by. Example:
        #
        #   @param model [String] The model used to generate the Chat Completions.
        #
        #   @param order [Symbol, OpenAI::Chat::CompletionListParams::Order] Sort order for Chat Completions by timestamp. Use `asc` for ascending order or `
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        # Sort order for Chat Completions by timestamp. Use `asc` for ascending order or
        # `desc` for descending order. Defaults to `asc`.
        module Order
          extend OpenAI::Internal::Type::Enum

          ASC = :asc
          DESC = :desc

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
