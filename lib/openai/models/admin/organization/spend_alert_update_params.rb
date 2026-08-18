# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::SpendAlerts#update
        class SpendAlertUpdateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute alert_id
          #
          #   @return [String]
          required :alert_id, String

          # @!attribute currency
          #   The currency for the threshold amount.
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::SpendAlertUpdateParams::Currency]
          required :currency, enum: -> { OpenAI::Admin::Organization::SpendAlertUpdateParams::Currency }

          # @!attribute interval
          #   The time interval for evaluating spend against the threshold.
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::SpendAlertUpdateParams::Interval]
          required :interval, enum: -> { OpenAI::Admin::Organization::SpendAlertUpdateParams::Interval }

          # @!attribute notification_channel
          #   Email notification settings for a spend alert.
          #
          #   @return [OpenAI::Models::Admin::Organization::SpendAlertUpdateParams::NotificationChannel]
          required :notification_channel,
                   -> { OpenAI::Admin::Organization::SpendAlertUpdateParams::NotificationChannel }

          # @!attribute threshold_amount
          #   The alert threshold amount, in cents.
          #
          #   @return [Integer]
          required :threshold_amount, Integer

          # @!method initialize(alert_id:, currency:, interval:, notification_channel:, threshold_amount:, request_options: {})
          #   @param alert_id [String]
          #
          #   @param currency [Symbol, OpenAI::Models::Admin::Organization::SpendAlertUpdateParams::Currency] The currency for the threshold amount.
          #
          #   @param interval [Symbol, OpenAI::Models::Admin::Organization::SpendAlertUpdateParams::Interval] The time interval for evaluating spend against the threshold.
          #
          #   @param notification_channel [OpenAI::Models::Admin::Organization::SpendAlertUpdateParams::NotificationChannel] Email notification settings for a spend alert.
          #
          #   @param threshold_amount [Integer] The alert threshold amount, in cents.
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          # The currency for the threshold amount.
          module Currency
            extend OpenAI::Internal::Type::Enum

            USD = :USD

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # The time interval for evaluating spend against the threshold.
          module Interval
            extend OpenAI::Internal::Type::Enum

            MONTH = :month

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          class NotificationChannel < OpenAI::Internal::Type::BaseModel
            # @!attribute recipients
            #   Email addresses that receive the spend alert notification.
            #
            #   @return [Array<String>]
            required :recipients, OpenAI::Internal::Type::ArrayOf[String]

            # @!attribute type
            #   The notification channel type. Currently only `email` is supported.
            #
            #   @return [Symbol, :email]
            required :type, const: :email

            # @!attribute subject_prefix
            #   Optional subject prefix for alert emails.
            #
            #   @return [String, nil]
            optional :subject_prefix, String, nil?: true

            # @!method initialize(recipients:, subject_prefix: nil, type: :email)
            #   Email notification settings for a spend alert.
            #
            #   @param recipients [Array<String>] Email addresses that receive the spend alert notification.
            #
            #   @param subject_prefix [String, nil] Optional subject prefix for alert emails.
            #
            #   @param type [Symbol, :email] The notification channel type. Currently only `email` is supported.
          end
        end
      end
    end
  end
end
