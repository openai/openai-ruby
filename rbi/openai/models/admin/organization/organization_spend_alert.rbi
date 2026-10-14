# typed: strong

module OpenAI
  module Models

    module Admin

      OrganizationSpendAlert = Organization::OrganizationSpendAlert

      module Organization

        class OrganizationSpendAlert < OpenAI::Internal::Type::BaseModel

          OrHash = T.type_alias do
            T.any(
              OpenAI::Admin::Organization::OrganizationSpendAlert,
              OpenAI::Internal::AnyHash
            )
          end

          # The identifier, which can be referenced in API endpoints.
          sig { returns(String) }
          attr_accessor :id

          # The currency for the threshold amount.
          sig { returns(OpenAI::Admin::Organization::OrganizationSpendAlert::Currency::TaggedSymbol) }
          attr_accessor :currency

          # The time interval for evaluating spend against the threshold.
          sig { returns(OpenAI::Admin::Organization::OrganizationSpendAlert::Interval::TaggedSymbol) }
          attr_accessor :interval

          # Email notification settings for a spend alert.
          sig { returns(OpenAI::Admin::Organization::OrganizationSpendAlert::NotificationChannel) }
          attr_reader :notification_channel

          sig {
            params(
              notification_channel: OpenAI::Admin::Organization::OrganizationSpendAlert::NotificationChannel::OrHash
            )
              .void
          }
          attr_writer :notification_channel

          # The object type, which is always `organization.spend_alert`.
          sig { returns(Symbol) }
          attr_accessor :object

          # The alert threshold amount, in cents.
          sig { returns(Integer) }
          attr_accessor :threshold_amount

          # Represents a spend alert configured at the organization level.
          sig do
            params(

              id: String,

              currency: OpenAI::Admin::Organization::OrganizationSpendAlert::Currency::OrSymbol,

              interval: OpenAI::Admin::Organization::OrganizationSpendAlert::Interval::OrSymbol,

              notification_channel: OpenAI::Admin::Organization::OrganizationSpendAlert::NotificationChannel::OrHash,

              threshold_amount: Integer,

              object: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The identifier, which can be referenced in API endpoints.
            id:,

            # The currency for the threshold amount.
            currency:,

            # The time interval for evaluating spend against the threshold.
            interval:,

            # Email notification settings for a spend alert.
            notification_channel:,

            # The alert threshold amount, in cents.
            threshold_amount:,

            # The object type, which is always `organization.spend_alert`.

            object: :"organization.spend_alert"
          )
          end

          sig do
            override.returns(
              {
                id: String,
                currency: OpenAI::Admin::Organization::OrganizationSpendAlert::Currency::TaggedSymbol,
                interval: OpenAI::Admin::Organization::OrganizationSpendAlert::Interval::TaggedSymbol,
                notification_channel: OpenAI::Admin::Organization::OrganizationSpendAlert::NotificationChannel,
                object: Symbol,
                threshold_amount: Integer
              }
            )
          end
          def to_hash
          end

          # The currency for the threshold amount.
          module Currency
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias {
              T.all(Symbol, OpenAI::Admin::Organization::OrganizationSpendAlert::Currency)
            }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            USD = T.let(:USD, OpenAI::Admin::Organization::OrganizationSpendAlert::Currency::TaggedSymbol)

            sig {
              override.returns(T::Array[OpenAI::Admin::Organization::OrganizationSpendAlert::Currency::TaggedSymbol])
            }
            def self.values
            end
          end

          # The time interval for evaluating spend against the threshold.
          module Interval
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias {
              T.all(Symbol, OpenAI::Admin::Organization::OrganizationSpendAlert::Interval)
            }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            MONTH = T.let(:month, OpenAI::Admin::Organization::OrganizationSpendAlert::Interval::TaggedSymbol)

            sig {
              override.returns(T::Array[OpenAI::Admin::Organization::OrganizationSpendAlert::Interval::TaggedSymbol])
            }
            def self.values
            end
          end

          class NotificationChannel < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Admin::Organization::OrganizationSpendAlert::NotificationChannel,
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
              )
                .returns(T.attached_class)
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
                {recipients: T::Array[String], type: Symbol, subject_prefix: T.nilable(String)}
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
