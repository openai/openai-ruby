# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Evals#list
    class EvalListParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute after
      #   Identifier for the last eval from the previous pagination request.
      #
      #   @return [String, nil]
      optional :after, String

      # @!attribute limit
      #   Number of evals to retrieve.
      #
      #   @return [Integer, nil]
      optional :limit, Integer

      # @!attribute order
      #   Sort order for evals by timestamp. Use `asc` for ascending order or `desc` for
      #   descending order.
      #
      #   @return [Symbol, OpenAI::EvalListParams::Order, nil]
      optional :order, enum: -> { OpenAI::EvalListParams::Order }

      # @!attribute order_by
      #   Evals can be ordered by creation time or last updated time. Use `created_at` for
      #   creation time or `updated_at` for last updated time.
      #
      #   @return [Symbol, OpenAI::EvalListParams::OrderBy, nil]
      optional :order_by, enum: -> { OpenAI::EvalListParams::OrderBy }

      # @!method initialize(after: nil, limit: nil, order: nil, order_by: nil, request_options: {})
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::Models::EvalListParams} for more details.
      #
      #   @param after [String] Identifier for the last eval from the previous pagination request.
      #
      #   @param limit [Integer] Number of evals to retrieve.
      #
      #   @param order [Symbol, OpenAI::EvalListParams::Order] Sort order for evals by timestamp. Use `asc` for ascending order or `desc` for d
      #
      #   @param order_by [Symbol, OpenAI::EvalListParams::OrderBy] Evals can be ordered by creation time or last updated time. Use
      #
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

      # Sort order for evals by timestamp. Use `asc` for ascending order or `desc` for
      # descending order.
      module Order
        extend OpenAI::Internal::Type::Enum

        ASC = :asc
        DESC = :desc

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # Evals can be ordered by creation time or last updated time. Use `created_at` for
      # creation time or `updated_at` for last updated time.
      module OrderBy
        extend OpenAI::Internal::Type::Enum

        CREATED_AT = :created_at
        UPDATED_AT = :updated_at

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end
