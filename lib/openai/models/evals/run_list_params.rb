# frozen_string_literal: true

module OpenAI
  module Models
    module Evals
      # @see OpenAI::Resources::Evals::Runs#list
      class RunListParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute after
        #   Identifier for the last run from the previous pagination request.
        #
        #   @return [String, nil]
        optional :after, String

        # @!attribute limit
        #   Number of runs to retrieve.
        #
        #   @return [Integer, nil]
        optional :limit, Integer

        # @!attribute order
        #   Sort order for runs by timestamp. Use `asc` for ascending order or `desc` for
        #   descending order. Defaults to `asc`.
        #
        #   @return [Symbol, OpenAI::Models::Evals::RunListParams::Order, nil]
        optional :order, enum: -> { OpenAI::Models::Evals::RunListParams::Order }

        # @!attribute status
        #   Filter runs by status. Use "queued" | "in_progress" | "failed" | "completed" |
        #   "canceled".
        #
        #   @return [Symbol, OpenAI::Models::Evals::RunListParams::Status, nil]
        optional :status, enum: -> { OpenAI::Models::Evals::RunListParams::Status }

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
