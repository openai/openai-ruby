# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::SpendLimit#update
        class SpendLimitUpdateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute currency
          #   The currency for the threshold amount. Currently, only `USD` is supported.
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::SpendLimitUpdateParams::Currency]
          required :currency, enum: -> { OpenAI::Admin::Organization::SpendLimitUpdateParams::Currency }

          # @!attribute interval
          #   The time interval for evaluating spend against the threshold. Currently, only
          #   `month` is supported.
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::SpendLimitUpdateParams::Interval]
          required :interval, enum: -> { OpenAI::Admin::Organization::SpendLimitUpdateParams::Interval }

          # @!attribute threshold_amount
          #   The hard spend limit amount, in cents.
          #
          #   @return [Integer]
          required :threshold_amount, Integer

          # @!attribute notification_channel
          #   Configure email notifications when the spend limit is reached. Leave this out to
          #   keep the current settings, or send null to reset to owner-only notifications.
          #
          #   @return [OpenAI::Models::Admin::Organization::SpendLimitUpdateParams::NotificationChannel, nil]
          optional(
            :notification_channel,
            -> { OpenAI::Admin::Organization::SpendLimitUpdateParams::NotificationChannel },
            nil?: true
          )

          # @!method initialize(currency:, interval:, threshold_amount:, notification_channel: nil, request_options: {})
          #   @param currency [Symbol, OpenAI::Models::Admin::Organization::SpendLimitUpdateParams::Currency]
          #     The currency for the threshold amount. Currently, only `USD` is supported.
          #
          #   @param interval [Symbol, OpenAI::Models::Admin::Organization::SpendLimitUpdateParams::Interval]
          #     The time interval for evaluating spend against the threshold. Currently, only
          #     `month` is supported.
          #
          #   @param threshold_amount [Integer]
          #     The hard spend limit amount, in cents.
          #
          #   @param notification_channel [OpenAI::Models::Admin::Organization::SpendLimitUpdateParams::NotificationChannel, nil]
          #     Configure email notifications when the spend limit is reached. Leave this out to
          #     keep the current settings, or send null to reset to owner-only notifications.
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

          class NotificationChannel < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #
            #   @return [Symbol, :email]
            required :type, const: :email

            # @!attribute recipients
            #   Additional email recipients. Omit to keep them unchanged; send [] to clear them.
            #
            #   @return [Array<String>, nil]
            optional :recipients, OpenAI::Internal::Type::ArrayOf[String]

            # @!attribute subject_prefix
            #   Email subject prefix. Omit to keep it unchanged; send null or an empty string to
            #   clear it.
            #
            #   @return [String, nil]
            optional :subject_prefix, String, nil?: true

            # @!method initialize(recipients: nil, subject_prefix: nil, type: :email)
            #   Configure email notifications when the spend limit is reached. Leave this out to
            #   keep the current settings, or send null to reset to owner-only notifications.
            #
            #   @param recipients [Array<String>]
            #     Additional email recipients. Omit to keep them unchanged; send [] to clear them.
            #
            #   @param subject_prefix [String, nil]
            #     Email subject prefix. Omit to keep it unchanged; send null or an empty string to
            #     clear it.
            #
            #   @param type [Symbol, :email]
          end
        end
      end
    end
  end
end
