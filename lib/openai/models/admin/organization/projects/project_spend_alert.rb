# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::SpendAlerts#create
          class ProjectSpendAlert < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The identifier, which can be referenced in API endpoints.
            #
            #   @return [String]
            required :id, String

            # @!attribute currency
            #   The currency for the threshold amount.
            #
            #   @return [Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectSpendAlert::Currency]
            required :currency, enum: -> { OpenAI::Admin::Organization::Projects::ProjectSpendAlert::Currency }

            # @!attribute interval
            #   The time interval for evaluating spend against the threshold.
            #
            #   @return [Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectSpendAlert::Interval]
            required :interval, enum: -> { OpenAI::Admin::Organization::Projects::ProjectSpendAlert::Interval }

            # @!attribute notification_channel
            #   Email notification settings for a spend alert.
            #
            #   @return [OpenAI::Models::Admin::Organization::Projects::ProjectSpendAlert::NotificationChannel]
            required :notification_channel,
                     -> { OpenAI::Admin::Organization::Projects::ProjectSpendAlert::NotificationChannel }

            # @!attribute object
            #   The object type, which is always `project.spend_alert`.
            #
            #   @return [Symbol, :"project.spend_alert"]
            required :object, const: :"project.spend_alert"

            # @!attribute threshold_amount
            #   The alert threshold amount, in cents.
            #
            #   @return [Integer]
            required :threshold_amount, Integer

            # @!method initialize(id:, currency:, interval:, notification_channel:, threshold_amount:, object: :"project.spend_alert")
            #   Represents a spend alert configured at the project level.
            #
            #   @param id [String] The identifier, which can be referenced in API endpoints.
            #
            #   @param currency [Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectSpendAlert::Currency] The currency for the threshold amount.
            #
            #   @param interval [Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectSpendAlert::Interval] The time interval for evaluating spend against the threshold.
            #
            #   @param notification_channel [OpenAI::Models::Admin::Organization::Projects::ProjectSpendAlert::NotificationChannel] Email notification settings for a spend alert.
            #
            #   @param threshold_amount [Integer] The alert threshold amount, in cents.
            #
            #   @param object [Symbol, :"project.spend_alert"] The object type, which is always `project.spend_alert`.

            # The currency for the threshold amount.
            #
            # @see OpenAI::Models::Admin::Organization::Projects::ProjectSpendAlert#currency
            module Currency
              extend OpenAI::Internal::Type::Enum

              USD = :USD

              # @!method self.values
              #   @return [Array<Symbol>]
            end

            # The time interval for evaluating spend against the threshold.
            #
            # @see OpenAI::Models::Admin::Organization::Projects::ProjectSpendAlert#interval
            module Interval
              extend OpenAI::Internal::Type::Enum

              MONTH = :month

              # @!method self.values
              #   @return [Array<Symbol>]
            end

            # @see OpenAI::Models::Admin::Organization::Projects::ProjectSpendAlert#notification_channel
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

        ProjectSpendAlert = Projects::ProjectSpendAlert
      end
    end
  end
end
