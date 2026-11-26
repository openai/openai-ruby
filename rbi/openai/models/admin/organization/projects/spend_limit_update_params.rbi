# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        module Projects

          class SpendLimitUpdateParams < OpenAI::Internal::Type::BaseModel

            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash = T.type_alias do
              T.any(
                OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :project_id

            # The currency for the threshold amount. Currently, only `USD` is supported.
            sig { returns(OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Currency::OrSymbol) }
            attr_accessor :currency

            # The time interval for evaluating spend against the threshold. Currently, only
            # `month` is supported.
            sig { returns(OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Interval::OrSymbol) }
            attr_accessor :interval

            # The hard spend limit amount, in cents.
            sig { returns(Integer) }
            attr_accessor :threshold_amount

            # Configure email notifications when the spend limit is reached. Leave this out to
            # keep the current settings, or send null to reset to owner-only notifications.
            sig {
              returns(T.nilable(OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::NotificationChannel))
            }
            attr_reader :notification_channel

            sig {
              params(
                notification_channel: T.nilable(
                  OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::NotificationChannel::OrHash
                )
              )
                .void
            }
            attr_writer :notification_channel

            sig do
              params(

                project_id: String,

                currency: OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Currency::OrSymbol,

                interval: OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Interval::OrSymbol,

                threshold_amount: Integer,

                notification_channel: T.nilable(
                  OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::NotificationChannel::OrHash
                ),

                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(T.attached_class)
            end
            def self.new(

              project_id:,

              # The currency for the threshold amount. Currently, only `USD` is supported.
              currency:,

              # The time interval for evaluating spend against the threshold. Currently, only
              # `month` is supported.
              interval:,

              # The hard spend limit amount, in cents.
              threshold_amount:,

              # Configure email notifications when the spend limit is reached. Leave this out to
              # keep the current settings, or send null to reset to owner-only notifications.
              notification_channel: nil,

              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  project_id: String,
                  currency: OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Currency::OrSymbol,
                  interval: OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Interval::OrSymbol,
                  threshold_amount: Integer,
                  notification_channel: T.nilable(
                    OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::NotificationChannel
                  ),
                  request_options: OpenAI::RequestOptions
                }
              )
            end
            def to_hash
            end

            # The currency for the threshold amount. Currently, only `USD` is supported.
            module Currency
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias {
                T.all(Symbol, OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Currency)
              }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              USD = T.let(:USD, OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Currency::TaggedSymbol)

              sig {
                override.returns(
                  T::Array[OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Currency::TaggedSymbol]
                )
              }
              def self.values
              end
            end

            # The time interval for evaluating spend against the threshold. Currently, only
            # `month` is supported.
            module Interval
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias {
                T.all(Symbol, OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Interval)
              }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              MONTH = T.let(
                :month,
                OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Interval::TaggedSymbol
              )

              sig {
                override.returns(
                  T::Array[OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Interval::TaggedSymbol]
                )
              }
              def self.values
              end
            end

            class NotificationChannel < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::NotificationChannel,
                  OpenAI::Internal::AnyHash
                )
              end

              sig { returns(Symbol) }
              attr_accessor :type

              # Additional email recipients. Omit to keep them unchanged; send [] to clear them.
              sig { returns(T.nilable(T::Array[String])) }
              attr_reader :recipients

              sig { params(recipients: T::Array[String]).void }
              attr_writer :recipients

              # Email subject prefix. Omit to keep it unchanged; send null or an empty string to
              # clear it.
              sig { returns(T.nilable(String)) }
              attr_accessor :subject_prefix

              # Configure email notifications when the spend limit is reached. Leave this out to
              # keep the current settings, or send null to reset to owner-only notifications.
              sig do
                params(

                  recipients: T::Array[String],

                  subject_prefix: T.nilable(String),

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # Additional email recipients. Omit to keep them unchanged; send [] to clear them.
                recipients: nil,

                # Email subject prefix. Omit to keep it unchanged; send null or an empty string to
                # clear it.
                subject_prefix: nil,

                type: :email
              )
              end

              sig do
                override.returns(
                  {type: Symbol, recipients: T::Array[String], subject_prefix: T.nilable(String)}
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
end
