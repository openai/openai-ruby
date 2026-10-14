# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Videos#list
    class VideoListParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute after
      #   Identifier for the last item from the previous pagination request
      #
      #   @return [String, nil]
      optional :after, String

      # @!attribute limit
      #   Number of items to retrieve
      #
      #   @return [Integer, nil]
      optional :limit, Integer

      # @!attribute order
      #   Sort order of results by timestamp. Use `asc` for ascending order or `desc` for
      #   descending order.
      #
      #   @return [Symbol, OpenAI::Models::VideoListParams::Order, nil]
      optional :order, enum: -> { OpenAI::VideoListParams::Order }

      # @!method initialize(after: nil, limit: nil, order: nil, request_options: {})
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::VideoListParams} for more details.
      #
      #   @param after [String] Identifier for the last item from the previous pagination request
      #
      #   @param limit [Integer] Number of items to retrieve
      #
      #   @param order [Symbol, OpenAI::Models::VideoListParams::Order] Sort order of results by timestamp. Use `asc` for ascending order or `desc` for
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

      # Sort order of results by timestamp. Use `asc` for ascending order or `desc` for
      # descending order.
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
