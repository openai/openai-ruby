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
        #   @return [Symbol, OpenAI::Evals::RunListParams::Order, nil]
        optional :order, enum: -> { OpenAI::Evals::RunListParams::Order }

        # @!attribute status
        #   Filter runs by status. One of `queued` | `in_progress` | `failed` | `completed`
        #   | `canceled`.
        #
        #   @return [Symbol, OpenAI::Evals::RunListParams::Status, nil]
        optional :status, enum: -> { OpenAI::Evals::RunListParams::Status }

        # @!method initialize(after: nil, limit: nil, order: nil, status: nil, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Evals::RunListParams} for more details.
        #
        #   @param after [String] Identifier for the last run from the previous pagination request.
        #
        #   @param limit [Integer] Number of runs to retrieve.
        #
        #   @param order [Symbol, OpenAI::Evals::RunListParams::Order] Sort order for runs by timestamp. Use `asc` for ascending order or `desc` for de
        #
        #   @param status [Symbol, OpenAI::Evals::RunListParams::Status] Filter runs by status. One of `queued` | `in_progress` | `failed` | `completed`
        #
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

        # Filter runs by status. One of `queued` | `in_progress` | `failed` | `completed`
        # | `canceled`.
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
