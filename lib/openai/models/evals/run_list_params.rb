# frozen_string_literal: true

module OpenAI
  module Models
    module Evals
      # @see OpenAI::Resources::Evals::Runs#list
      class RunListParams < OpenAI::Internal::Type::BaseModel
        # @!parse
        #   extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute [r] after
        #   Identifier for the last run from the previous pagination request.
        #
        #   @return [String, nil]
        optional :after, String

        # @!parse
        #   # @return [String]
        #   attr_writer :after

        # @!attribute [r] limit
        #   Number of runs to retrieve.
        #
        #   @return [Integer, nil]
        optional :limit, Integer

        # @!parse
        #   # @return [Integer]
        #   attr_writer :limit

        # @!attribute [r] order
        #   Sort order for runs by timestamp. Use `asc` for ascending order or `desc` for
        #   descending order. Defaults to `asc`.
        #
        #   @return [Symbol, OpenAI::Models::Evals::RunListParams::Order, nil]
        optional :order, enum: -> { OpenAI::Models::Evals::RunListParams::Order }

        # @!parse
        #   # @return [Symbol, OpenAI::Models::Evals::RunListParams::Order]
        #   attr_writer :order

        # @!attribute [r] status
        #   Filter runs by status. Use "queued" | "in_progress" | "failed" | "completed" |
        #   "canceled".
        #
        #   @return [Symbol, OpenAI::Models::Evals::RunListParams::Status, nil]
        optional :status, enum: -> { OpenAI::Models::Evals::RunListParams::Status }

        # @!parse
        #   # @return [Symbol, OpenAI::Models::Evals::RunListParams::Status]
        #   attr_writer :status

        # @!method initialize(after: nil, limit: nil, order: nil, status: nil, request_options: {})
        #   @param after [String]
        #   @param limit [Integer]
        #   @param order [Symbol, OpenAI::Models::Evals::RunListParams::Order]
        #   @param status [Symbol, OpenAI::Models::Evals::RunListParams::Status]
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        # Sort order for runs by timestamp. Use `asc` for ascending order or `desc` for
        # descending order. Defaults to `asc`.
        module Order
          extend OpenAI::Internal::Type::Enum

          ASC = :asc
          DESC = :desc

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # Filter runs by status. Use "queued" | "in_progress" | "failed" | "completed" |
        # "canceled".
        module Status
          extend OpenAI::Internal::Type::Enum

          QUEUED = :queued
          IN_PROGRESS = :in_progress
          COMPLETED = :completed
          CANCELED = :canceled
          FAILED = :failed

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
