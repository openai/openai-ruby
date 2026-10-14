# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class SpendAlertCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::SpendAlertCreateParams,
                OpenAI::Internal::AnyHash
              )
            end

          # The currency for the threshold amount.
          sig do
            returns(
              OpenAI::Admin::Organization::SpendAlertCreateParams::Currency::OrSymbol
            )
          end
          attr_accessor :currency

          # The time interval for evaluating spend against the threshold.
          sig do
            returns(
              OpenAI::Admin::Organization::SpendAlertCreateParams::Interval::OrSymbol
            )
          end
          attr_accessor :interval

          # Email notification settings for a spend alert.
          sig do
            returns(
              OpenAI::Admin::Organization::SpendAlertCreateParams::NotificationChannel
            )
          end
          attr_reader :notification_channel

          sig do
            params(
              notification_channel:
                OpenAI::Admin::Organization::SpendAlertCreateParams::NotificationChannel::OrHash
            ).void
          end
          attr_writer :notification_channel

          # The alert threshold amount, in cents.
          sig { returns(Integer) }
          attr_accessor :threshold_amount

          sig do
            params(
              currency:
                OpenAI::Admin::Organization::SpendAlertCreateParams::Currency::OrSymbol,
              interval:
                OpenAI::Admin::Organization::SpendAlertCreateParams::Interval::OrSymbol,
              notification_channel:
                OpenAI::Admin::Organization::SpendAlertCreateParams::NotificationChannel::OrHash,
              threshold_amount: Integer,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # The currency for the threshold amount.
            currency:,
            # The time interval for evaluating spend against the threshold.
            interval:,
            # Email notification settings for a spend alert.
            notification_channel:,
            # The alert threshold amount, in cents.
            threshold_amount:,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                currency:
                  OpenAI::Admin::Organization::SpendAlertCreateParams::Currency::OrSymbol,
                interval:
                  OpenAI::Admin::Organization::SpendAlertCreateParams::Interval::OrSymbol,
                notification_channel:
                  OpenAI::Admin::Organization::SpendAlertCreateParams::NotificationChannel,
                threshold_amount: Integer,
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          # The currency for the threshold amount.
          module Currency
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Admin::Organization::SpendAlertCreateParams::Currency
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            USD =
              T.let(
                :USD,
                OpenAI::Admin::Organization::SpendAlertCreateParams::Currency::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Admin::Organization::SpendAlertCreateParams::Currency::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          # The time interval for evaluating spend against the threshold.
          module Interval
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Admin::Organization::SpendAlertCreateParams::Interval
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            MONTH =
              T.let(
                :month,
                OpenAI::Admin::Organization::SpendAlertCreateParams::Interval::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Admin::Organization::SpendAlertCreateParams::Interval::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          class NotificationChannel < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::SpendAlertCreateParams::NotificationChannel,
                  OpenAI::Internal::AnyHash
                )
              end

            # Email addresses that receive the spend alert notification.
            sig { returns(T::Array[String]) }
            attr_accessor :recipients

            # The notification channel type. Currently only `email` is supported.
            sig { returns(Symbol) }
            attr_accessor :type

            # Optional subject prefix for alert emails.
            sig { returns(T.nilable(String)) }
            attr_accessor :subject_prefix

            # Email notification settings for a spend alert.
            sig do
              params(
                recipients: T::Array[String],
                subject_prefix: T.nilable(String),
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # Email addresses that receive the spend alert notification.
              recipients:,
              # Optional subject prefix for alert emails.
              subject_prefix: nil,
              # The notification channel type. Currently only `email` is supported.
              type: :email
            )
            end

            sig do
              override.returns(
                {
                  recipients: T::Array[String],
                  type: Symbol,
                  subject_prefix: T.nilable(String)
                }
              )
            end
            def to_hash
            end
          end
        end
      end
    end
  end
end
