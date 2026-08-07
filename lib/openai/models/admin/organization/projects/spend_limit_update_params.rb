# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::SpendLimit#update
          class SpendLimitUpdateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute project_id
            #
            #   @return [String]
            required :project_id, String

            # @!attribute currency
            #   The currency for the threshold amount. Currently, only `USD` is supported.
            #
            #   @return [Symbol, OpenAI::Models::Admin::Organization::Projects::SpendLimitUpdateParams::Currency]
            required :currency, enum: -> { OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Currency }

            # @!attribute interval
            #   The time interval for evaluating spend against the threshold. Currently, only
            #   `month` is supported.
            #
            #   @return [Symbol, OpenAI::Models::Admin::Organization::Projects::SpendLimitUpdateParams::Interval]
            required :interval, enum: -> { OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Interval }

            # @!attribute threshold_amount
            #   The hard spend limit amount, in cents.
            #
            #   @return [Integer]
            required :threshold_amount, Integer

            # @!method initialize(project_id:, currency:, interval:, threshold_amount:, request_options: {})
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Admin::Organization::Projects::SpendLimitUpdateParams} for more
            #   details.
            #
            #   @param project_id [String]
            #
            #   @param currency [Symbol, OpenAI::Models::Admin::Organization::Projects::SpendLimitUpdateParams::Currency] The currency for the threshold amount. Currently, only `USD` is supported.
            #
            #   @param interval [Symbol, OpenAI::Models::Admin::Organization::Projects::SpendLimitUpdateParams::Interval] The time interval for evaluating spend against the threshold. Currently, only `m
            #
            #   @param threshold_amount [Integer] The hard spend limit amount, in cents.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

            # The currency for the threshold amount. Currently, only `USD` is supported.
            module Currency
              extend OpenAI::Internal::Type::Enum

              USD = :USD

              # @!method self.values
              #   @return [Array<Symbol>]
            end

            # The time interval for evaluating spend against the threshold. Currently, only
            # `month` is supported.
            module Interval
              extend OpenAI::Internal::Type::Enum

              MONTH = :month

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end
        end
      end
    end
  end
end
