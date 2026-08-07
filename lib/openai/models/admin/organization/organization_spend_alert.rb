# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::SpendAlerts#create
        class OrganizationSpendAlert < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The identifier, which can be referenced in API endpoints.
          #
          #   @return [String]
          required :id, String

          # @!attribute currency
          #   The currency for the threshold amount.
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::OrganizationSpendAlert::Currency]
          required :currency, enum: -> { OpenAI::Admin::Organization::OrganizationSpendAlert::Currency }

          # @!attribute interval
          #   The time interval for evaluating spend against the threshold.
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::OrganizationSpendAlert::Interval]
          required :interval, enum: -> { OpenAI::Admin::Organization::OrganizationSpendAlert::Interval }

          # @!attribute notification_channel
          #   Email notification settings for a spend alert.
          #
          #   @return [OpenAI::Models::Admin::Organization::OrganizationSpendAlert::NotificationChannel]
          required :notification_channel,
                   -> { OpenAI::Admin::Organization::OrganizationSpendAlert::NotificationChannel }

          # @!attribute object
          #   The object type, which is always `organization.spend_alert`.
          #
          #   @return [Symbol, :"organization.spend_alert"]
          required :object, const: :"organization.spend_alert"

          # @!attribute threshold_amount
          #   The alert threshold amount, in cents.
          #
          #   @return [Integer]
          required :threshold_amount, Integer

          # @!method initialize(id:, currency:, interval:, notification_channel:, threshold_amount:, object: :"organization.spend_alert")
          #   Represents a spend alert configured at the organization level.
          #
          #   @param id [String] The identifier, which can be referenced in API endpoints.
          #
          #   @param currency [Symbol, OpenAI::Models::Admin::Organization::OrganizationSpendAlert::Currency] The currency for the threshold amount.
          #
          #   @param interval [Symbol, OpenAI::Models::Admin::Organization::OrganizationSpendAlert::Interval] The time interval for evaluating spend against the threshold.
          #
          #   @param notification_channel [OpenAI::Models::Admin::Organization::OrganizationSpendAlert::NotificationChannel] Email notification settings for a spend alert.
          #
          #   @param threshold_amount [Integer] The alert threshold amount, in cents.
          #
          #   @param object [Symbol, :"organization.spend_alert"] The object type, which is always `organization.spend_alert`.

          # The currency for the threshold amount.
          #
          # @see OpenAI::Models::Admin::Organization::OrganizationSpendAlert#currency
          module Currency
            extend OpenAI::Internal::Type::Enum

            USD = :USD

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # The time interval for evaluating spend against the threshold.
          #
          # @see OpenAI::Models::Admin::Organization::OrganizationSpendAlert#interval
          module Interval
            extend OpenAI::Internal::Type::Enum

            MONTH = :month

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # @see OpenAI::Models::Admin::Organization::OrganizationSpendAlert#notification_channel
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

      OrganizationSpendAlert = Organization::OrganizationSpendAlert
    end
  end
end
