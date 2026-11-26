# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::SpendLimit#retrieve
        class OrganizationSpendLimit < OpenAI::Internal::Type::BaseModel
          # @!attribute currency
          #   The currency for the threshold amount. Currently, only `USD` is supported.
          #
          #   @return [String, Symbol, OpenAI::Models::Admin::Organization::OrganizationSpendLimit::Currency]
          required :currency, union: -> { OpenAI::Admin::Organization::OrganizationSpendLimit::Currency }

          # @!attribute enforcement
          #   The current enforcement state of the hard spend limit.
          #
          #   @return [OpenAI::Models::Admin::Organization::OrganizationSpendLimit::Enforcement]
          required :enforcement, -> { OpenAI::Admin::Organization::OrganizationSpendLimit::Enforcement }

          # @!attribute interval
          #   The time interval for evaluating spend against the threshold. Currently, only
          #   `month` is supported.
          #
          #   @return [String, Symbol, OpenAI::Models::Admin::Organization::OrganizationSpendLimit::Interval]
          required :interval, union: -> { OpenAI::Admin::Organization::OrganizationSpendLimit::Interval }

          # @!attribute object
          #   The object type, which is always `organization.spend_limit`.
          #
          #   @return [Symbol, :"organization.spend_limit"]
          required :object, const: :"organization.spend_limit"

          # @!attribute threshold_amount
          #   The hard spend limit amount, in cents.
          #
          #   @return [Integer]
          required :threshold_amount, Integer

          # @!attribute notification_channel
          #   Email notifications sent when the hard spend limit is reached.
          #
          #   @return [OpenAI::Models::Admin::Organization::OrganizationSpendLimit::NotificationChannel, nil]
          optional(
            :notification_channel,
            -> { OpenAI::Admin::Organization::OrganizationSpendLimit::NotificationChannel }
          )

          # @!method initialize(currency:, enforcement:, interval:, threshold_amount:, notification_channel: nil, object: :"organization.spend_limit")
          #   Represents a hard spend limit configured at the organization level.
          #
          #   @param currency [String, Symbol, OpenAI::Models::Admin::Organization::OrganizationSpendLimit::Currency]
          #     The currency for the threshold amount. Currently, only `USD` is supported.
          #
          #   @param enforcement [OpenAI::Models::Admin::Organization::OrganizationSpendLimit::Enforcement]
          #     The current enforcement state of the hard spend limit.
          #
          #   @param interval [String, Symbol, OpenAI::Models::Admin::Organization::OrganizationSpendLimit::Interval]
          #     The time interval for evaluating spend against the threshold. Currently, only
          #     `month` is supported.
          #
          #   @param threshold_amount [Integer]
          #     The hard spend limit amount, in cents.
          #
          #   @param notification_channel [OpenAI::Models::Admin::Organization::OrganizationSpendLimit::NotificationChannel]
          #     Email notifications sent when the hard spend limit is reached.
          #
          #   @param object [Symbol, :"organization.spend_limit"]
          #     The object type, which is always `organization.spend_limit`.

          # The currency for the threshold amount. Currently, only `USD` is supported.
          #
          # @see OpenAI::Models::Admin::Organization::OrganizationSpendLimit#currency
          module Currency
            extend OpenAI::Internal::Type::Union

            variant String

            variant const: -> { OpenAI::Models::Admin::Organization::OrganizationSpendLimit::Currency::USD }

            # @!method self.variants
            #   @return [Array(String, Symbol)]

            define_sorbet_constant!(:Variants) do
              T.type_alias {
                T.any(String, OpenAI::Admin::Organization::OrganizationSpendLimit::Currency::TaggedSymbol)
              }
            end

            # @!group

            USD = :USD

            # @!endgroup
          end

          # @see OpenAI::Models::Admin::Organization::OrganizationSpendLimit#enforcement
          class Enforcement < OpenAI::Internal::Type::BaseModel
            # @!attribute status
            #   Whether the hard spend limit is currently enforcing.
            #
            #   @return [String, Symbol, OpenAI::Models::Admin::Organization::OrganizationSpendLimit::Enforcement::Status]
            required :status, union: -> { OpenAI::Admin::Organization::OrganizationSpendLimit::Enforcement::Status }

            # @!method initialize(status:)
            #   The current enforcement state of the hard spend limit.
            #
            #   @param status [String, Symbol, OpenAI::Models::Admin::Organization::OrganizationSpendLimit::Enforcement::Status]
            #     Whether the hard spend limit is currently enforcing.

            # Whether the hard spend limit is currently enforcing.
            #
            # @see OpenAI::Models::Admin::Organization::OrganizationSpendLimit::Enforcement#status
            module Status
              extend OpenAI::Internal::Type::Union

              variant String

              variant(
                const: -> {
                  OpenAI::Models::Admin::Organization::OrganizationSpendLimit::Enforcement::Status::INACTIVE
                }
              )

              variant(
                const: -> {
                  OpenAI::Models::Admin::Organization::OrganizationSpendLimit::Enforcement::Status::ENFORCING
                }
              )

              # @!method self.variants
              #   @return [Array(String, Symbol)]

              define_sorbet_constant!(:Variants) do
                T.type_alias {
                  T.any(String, OpenAI::Admin::Organization::OrganizationSpendLimit::Enforcement::Status::TaggedSymbol)
                }
              end

              # @!group

              INACTIVE = :inactive
              ENFORCING = :enforcing

              # @!endgroup
            end
          end

          # The time interval for evaluating spend against the threshold. Currently, only
          # `month` is supported.
          #
          # @see OpenAI::Models::Admin::Organization::OrganizationSpendLimit#interval
          module Interval
            extend OpenAI::Internal::Type::Union

            variant String

            variant const: -> { OpenAI::Models::Admin::Organization::OrganizationSpendLimit::Interval::MONTH }

            # @!method self.variants
            #   @return [Array(String, Symbol)]

            define_sorbet_constant!(:Variants) do
              T.type_alias {
                T.any(String, OpenAI::Admin::Organization::OrganizationSpendLimit::Interval::TaggedSymbol)
              }
            end

            # @!group

            MONTH = :month

            # @!endgroup
          end

          # @see OpenAI::Models::Admin::Organization::OrganizationSpendLimit#notification_channel
          class NotificationChannel < OpenAI::Internal::Type::BaseModel
            # @!attribute recipients
            #
            #   @return [Array<String>]
            required :recipients, OpenAI::Internal::Type::ArrayOf[String]

            # @!attribute type
            #
            #   @return [Symbol, :email]
            required :type, const: :email

            # @!attribute subject_prefix
            #
            #   @return [String, nil]
            optional :subject_prefix, String, nil?: true

            # @!method initialize(recipients:, subject_prefix: nil, type: :email)
            #   Email notifications sent when the hard spend limit is reached.
            #
            #   @param recipients [Array<String>]
            #   @param subject_prefix [String, nil]
            #   @param type [Symbol, :email]
          end
        end
      end

      OrganizationSpendLimit = Organization::OrganizationSpendLimit
    end
  end
end
