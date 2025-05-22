# frozen_string_literal: true

module OpenAI
  module Models
    module Evals
      module Runs
        # @see OpenAI::Resources::Evals::Runs::OutputItems#list
        class OutputItemListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute eval_id
          #
          #   @return [String]
          required :eval_id, String

          # @!attribute after
          #   Identifier for the last output item from the previous pagination request.
          #
          #   @return [String, nil]
          optional :after, String

          # @!attribute limit
          #   Number of output items to retrieve.
          #
          #   @return [Integer, nil]
          optional :limit, Integer

          # @!attribute order
          #   Sort order for output items by timestamp. Use `asc` for ascending order or
          #   `desc` for descending order. Defaults to `asc`.
          #
          #   @return [Symbol, OpenAI::Models::Evals::Runs::OutputItemListParams::Order, nil]
          optional :order, enum: -> { OpenAI::Evals::Runs::OutputItemListParams::Order }

          # @!attribute status
          #   Filter output items by status. Use `failed` to filter by failed output items or
          #   `pass` to filter by passed output items.
          #
          #   @return [Symbol, OpenAI::Models::Evals::Runs::OutputItemListParams::Status, nil]
          optional :status, enum: -> { OpenAI::Evals::Runs::OutputItemListParams::Status }

          # @!method initialize(eval_id:, after: nil, limit: nil, order: nil, status: nil, request_options: {})
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Evals::Runs::OutputItemListParams} for more details.
          #
          #   @param eval_id [String]
          #
          #   @param after [String] Identifier for the last output item from the previous pagination request.
          #
          #   @param limit [Integer] Number of output items to retrieve.
          #
          #   @param order [Symbol, OpenAI::Models::Evals::Runs::OutputItemListParams::Order] Sort order for output items by timestamp. Use `asc` for ascending order or `desc
          #
          #   @param status [Symbol, OpenAI::Models::Evals::Runs::OutputItemListParams::Status] Filter output items by status. Use `failed` to filter by failed output
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          # Sort order for output items by timestamp. Use `asc` for ascending order or
          # `desc` for descending order. Defaults to `asc`.
          module Order
            extend OpenAI::Internal::Type::Enum

            ASC = :asc
            DESC = :desc

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # Filter output items by status. Use `failed` to filter by failed output items or
          # `pass` to filter by passed output items.
          module Status
            extend OpenAI::Internal::Type::Enum

            FAIL = :fail
            PASS = :pass

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
