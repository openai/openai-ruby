# frozen_string_literal: true

module OpenAI
  module Models
    module Evals
      module Runs
        # @see OpenAI::Resources::Evals::Runs::OutputItems#list
        class OutputItemListParams < OpenAI::Internal::Type::BaseModel
          # @!parse
          #   extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute eval_id
          #
          #   @return [String]
          required :eval_id, String

          # @!attribute [r] after
          #   Identifier for the last output item from the previous pagination request.
          #
          #   @return [String, nil]
          optional :after, String

          # @!parse
          #   # @return [String]
          #   attr_writer :after

          # @!attribute [r] limit
          #   Number of output items to retrieve.
          #
          #   @return [Integer, nil]
          optional :limit, Integer

          # @!parse
          #   # @return [Integer]
          #   attr_writer :limit

          # @!attribute [r] order
          #   Sort order for output items by timestamp. Use `asc` for ascending order or
          #   `desc` for descending order. Defaults to `asc`.
          #
          #   @return [Symbol, OpenAI::Models::Evals::Runs::OutputItemListParams::Order, nil]
          optional :order, enum: -> { OpenAI::Models::Evals::Runs::OutputItemListParams::Order }

          # @!parse
          #   # @return [Symbol, OpenAI::Models::Evals::Runs::OutputItemListParams::Order]
          #   attr_writer :order

          # @!attribute [r] status
          #   Filter output items by status. Use `failed` to filter by failed output items or
          #   `pass` to filter by passed output items.
          #
          #   @return [Symbol, OpenAI::Models::Evals::Runs::OutputItemListParams::Status, nil]
          optional :status, enum: -> { OpenAI::Models::Evals::Runs::OutputItemListParams::Status }

          # @!parse
          #   # @return [Symbol, OpenAI::Models::Evals::Runs::OutputItemListParams::Status]
          #   attr_writer :status

          # @!parse
          #   # @param eval_id [String]
          #   # @param after [String]
          #   # @param limit [Integer]
          #   # @param order [Symbol, OpenAI::Models::Evals::Runs::OutputItemListParams::Order]
          #   # @param status [Symbol, OpenAI::Models::Evals::Runs::OutputItemListParams::Status]
          #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          #   #
          #   def initialize(eval_id:, after: nil, limit: nil, order: nil, status: nil, request_options: {}, **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

          # Sort order for output items by timestamp. Use `asc` for ascending order or
          # `desc` for descending order. Defaults to `asc`.
          module Order
            extend OpenAI::Internal::Type::Enum

            ASC = :asc
            DESC = :desc

            finalize!

            # @!parse
            #   # @return [Array<Symbol>]
            #   def self.values; end
          end

          # Filter output items by status. Use `failed` to filter by failed output items or
          # `pass` to filter by passed output items.
          module Status
            extend OpenAI::Internal::Type::Enum

            FAIL = :fail
            PASS = :pass

            finalize!

            # @!parse
            #   # @return [Array<Symbol>]
            #   def self.values; end
          end
        end
      end
    end
  end
end
