# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Evals#list
    class EvalListParams < OpenAI::Internal::Type::BaseModel
      # @!parse
      #   extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # @!attribute [r] after
      #   Identifier for the last eval from the previous pagination request.
      #
      #   @return [String, nil]
      optional :after, String

      # @!parse
      #   # @return [String]
      #   attr_writer :after

      # @!attribute [r] limit
      #   Number of evals to retrieve.
      #
      #   @return [Integer, nil]
      optional :limit, Integer

      # @!parse
      #   # @return [Integer]
      #   attr_writer :limit

      # @!attribute [r] order
      #   Sort order for evals by timestamp. Use `asc` for ascending order or `desc` for
      #   descending order.
      #
      #   @return [Symbol, OpenAI::Models::EvalListParams::Order, nil]
      optional :order, enum: -> { OpenAI::Models::EvalListParams::Order }

      # @!parse
      #   # @return [Symbol, OpenAI::Models::EvalListParams::Order]
      #   attr_writer :order

      # @!attribute [r] order_by
      #   Evals can be ordered by creation time or last updated time. Use `created_at` for
      #   creation time or `updated_at` for last updated time.
      #
      #   @return [Symbol, OpenAI::Models::EvalListParams::OrderBy, nil]
      optional :order_by, enum: -> { OpenAI::Models::EvalListParams::OrderBy }

      # @!parse
      #   # @return [Symbol, OpenAI::Models::EvalListParams::OrderBy]
      #   attr_writer :order_by

      # @!parse
      #   # @param after [String]
      #   # @param limit [Integer]
      #   # @param order [Symbol, OpenAI::Models::EvalListParams::Order]
      #   # @param order_by [Symbol, OpenAI::Models::EvalListParams::OrderBy]
      #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      #   #
      #   def initialize(after: nil, limit: nil, order: nil, order_by: nil, request_options: {}, **) = super

      # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

      # Sort order for evals by timestamp. Use `asc` for ascending order or `desc` for
      # descending order.
      module Order
        extend OpenAI::Internal::Type::Enum

        ASC = :asc
        DESC = :desc

        finalize!

        # @!parse
        #   # @return [Array<Symbol>]
        #   def self.values; end
      end

      # Evals can be ordered by creation time or last updated time. Use `created_at` for
      # creation time or `updated_at` for last updated time.
      module OrderBy
        extend OpenAI::Internal::Type::Enum

        CREATED_AT = :created_at
        UPDATED_AT = :updated_at

        finalize!

        # @!parse
        #   # @return [Array<Symbol>]
        #   def self.values; end
      end
    end
  end
end
