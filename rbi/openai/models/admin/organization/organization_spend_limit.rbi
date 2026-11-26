# typed: strong

module OpenAI
  module Models

    module Admin

      OrganizationSpendLimit = Organization::OrganizationSpendLimit

      module Organization

        class OrganizationSpendLimit < OpenAI::Internal::Type::BaseModel

          OrHash = T.type_alias do
            T.any(
              OpenAI::Admin::Organization::OrganizationSpendLimit,
              OpenAI::Internal::AnyHash
            )
          end

          # The currency for the threshold amount. Currently, only `USD` is supported.
          sig { returns(OpenAI::Admin::Organization::OrganizationSpendLimit::Currency::Variants) }
          attr_accessor :currency

          # The current enforcement state of the hard spend limit.
          sig { returns(OpenAI::Admin::Organization::OrganizationSpendLimit::Enforcement) }
          attr_reader :enforcement

          sig { params(enforcement: OpenAI::Admin::Organization::OrganizationSpendLimit::Enforcement::OrHash).void }
          attr_writer :enforcement

          # The time interval for evaluating spend against the threshold. Currently, only
          # `month` is supported.
          sig { returns(OpenAI::Admin::Organization::OrganizationSpendLimit::Interval::Variants) }
          attr_accessor :interval

          # The object type, which is always `organization.spend_limit`.
          sig { returns(Symbol) }
          attr_accessor :object

          # The hard spend limit amount, in cents.
          sig { returns(Integer) }
          attr_accessor :threshold_amount

          # Email notifications sent when the hard spend limit is reached.
          sig { returns(T.nilable(OpenAI::Admin::Organization::OrganizationSpendLimit::NotificationChannel)) }
          attr_reader :notification_channel

          sig {
            params(
              notification_channel: OpenAI::Admin::Organization::OrganizationSpendLimit::NotificationChannel::OrHash
            )
              .void
          }
          attr_writer :notification_channel

          # Represents a hard spend limit configured at the organization level.
          sig do
            params(

              currency: T.any(String, OpenAI::Admin::Organization::OrganizationSpendLimit::Currency::OrSymbol),

              enforcement: OpenAI::Admin::Organization::OrganizationSpendLimit::Enforcement::OrHash,

              interval: T.any(String, OpenAI::Admin::Organization::OrganizationSpendLimit::Interval::OrSymbol),

              threshold_amount: Integer,

              notification_channel: OpenAI::Admin::Organization::OrganizationSpendLimit::NotificationChannel::OrHash,

              object: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The currency for the threshold amount. Currently, only `USD` is supported.
            currency:,

            # The current enforcement state of the hard spend limit.
            enforcement:,

            # The time interval for evaluating spend against the threshold. Currently, only
            # `month` is supported.
            interval:,

            # The hard spend limit amount, in cents.
            threshold_amount:,

            # Email notifications sent when the hard spend limit is reached.
            notification_channel: nil,

            # The object type, which is always `organization.spend_limit`.

            object: :"organization.spend_limit"
          )
          end

          sig do
            override.returns(
              {
                currency: OpenAI::Admin::Organization::OrganizationSpendLimit::Currency::Variants,
                enforcement: OpenAI::Admin::Organization::OrganizationSpendLimit::Enforcement,
                interval: OpenAI::Admin::Organization::OrganizationSpendLimit::Interval::Variants,
                object: Symbol,
                threshold_amount: Integer,
                notification_channel: OpenAI::Admin::Organization::OrganizationSpendLimit::NotificationChannel
              }
            )
          end
          def to_hash
          end

          # The currency for the threshold amount. Currently, only `USD` is supported.
          module Currency
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias {
              T.any(String, OpenAI::Admin::Organization::OrganizationSpendLimit::Currency::TaggedSymbol)
            }

            sig { override.returns(T::Array[OpenAI::Admin::Organization::OrganizationSpendLimit::Currency::Variants]) }
            def self.variants
            end

            TaggedSymbol = T.type_alias do
              T.all(Symbol, OpenAI::Admin::Organization::OrganizationSpendLimit::Currency)
            end

            OrSymbol = T.type_alias { T.any(Symbol, String) }

            USD = T.let(:USD, OpenAI::Admin::Organization::OrganizationSpendLimit::Currency::TaggedSymbol)

          end

          class Enforcement < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Admin::Organization::OrganizationSpendLimit::Enforcement,
                OpenAI::Internal::AnyHash
              )
            end

            # Whether the hard spend limit is currently enforcing.
            sig { returns(OpenAI::Admin::Organization::OrganizationSpendLimit::Enforcement::Status::Variants) }
            attr_accessor :status

            # The current enforcement state of the hard spend limit.
            sig do
              params(

                status: T.any(
                  String,
                  OpenAI::Admin::Organization::OrganizationSpendLimit::Enforcement::Status::OrSymbol
                )
              )
                .returns(T.attached_class)
            end
            def self.new(

              # Whether the hard spend limit is currently enforcing.

              status:
            )
            end

            sig do
              override.returns(
                {status: OpenAI::Admin::Organization::OrganizationSpendLimit::Enforcement::Status::Variants}
              )
            end
            def to_hash
            end

            # Whether the hard spend limit is currently enforcing.
            module Status
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias {
                T.any(String, OpenAI::Admin::Organization::OrganizationSpendLimit::Enforcement::Status::TaggedSymbol)
              }

              sig {
                override.returns(
                  T::Array[OpenAI::Admin::Organization::OrganizationSpendLimit::Enforcement::Status::Variants]
                )
              }
              def self.variants
              end

              TaggedSymbol = T.type_alias do
                T.all(Symbol, OpenAI::Admin::Organization::OrganizationSpendLimit::Enforcement::Status)
              end

              OrSymbol = T.type_alias { T.any(Symbol, String) }

              INACTIVE = T.let(
                :inactive,
                OpenAI::Admin::Organization::OrganizationSpendLimit::Enforcement::Status::TaggedSymbol
              )
              ENFORCING = T.let(
                :enforcing,
                OpenAI::Admin::Organization::OrganizationSpendLimit::Enforcement::Status::TaggedSymbol
              )

            end
          end

          # The time interval for evaluating spend against the threshold. Currently, only
          # `month` is supported.
          module Interval
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias {
              T.any(String, OpenAI::Admin::Organization::OrganizationSpendLimit::Interval::TaggedSymbol)
            }

            sig { override.returns(T::Array[OpenAI::Admin::Organization::OrganizationSpendLimit::Interval::Variants]) }
            def self.variants
            end

            TaggedSymbol = T.type_alias do
              T.all(Symbol, OpenAI::Admin::Organization::OrganizationSpendLimit::Interval)
            end

            OrSymbol = T.type_alias { T.any(Symbol, String) }

            MONTH = T.let(:month, OpenAI::Admin::Organization::OrganizationSpendLimit::Interval::TaggedSymbol)

          end

          class NotificationChannel < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Admin::Organization::OrganizationSpendLimit::NotificationChannel,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(T::Array[String]) }
            attr_accessor :recipients

            sig { returns(Symbol) }
            attr_accessor :type

            sig { returns(T.nilable(String)) }
            attr_accessor :subject_prefix

            # Email notifications sent when the hard spend limit is reached.
            sig do
              params(

                recipients: T::Array[String],

                subject_prefix: T.nilable(String),

                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(

              recipients:,

              subject_prefix: nil,

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
