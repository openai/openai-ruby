# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          class SpendLimitUpdateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :project_id

            # The currency for the threshold amount. Currently, only `USD` is supported.
            sig do
              returns(
                OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Currency::OrSymbol
              )
            end
            attr_accessor :currency

            # The time interval for evaluating spend against the threshold. Currently, only
            # `month` is supported.
            sig do
              returns(
                OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Interval::OrSymbol
              )
            end
            attr_accessor :interval

            # The hard spend limit amount, in cents.
            sig { returns(Integer) }
            attr_accessor :threshold_amount

            sig do
              params(
                project_id: String,
                currency:
                  OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Currency::OrSymbol,
                interval:
                  OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Interval::OrSymbol,
                threshold_amount: Integer,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(T.attached_class)
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
              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  project_id: String,
                  currency:
                    OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Currency::OrSymbol,
                  interval:
                    OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Interval::OrSymbol,
                  threshold_amount: Integer,
                  request_options: OpenAI::RequestOptions
                }
              )
            end
            def to_hash
            end

            # The currency for the threshold amount. Currently, only `USD` is supported.
            module Currency
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Currency
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              USD =
                T.let(
                  :USD,
                  OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Currency::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Currency::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end

            # The time interval for evaluating spend against the threshold. Currently, only
            # `month` is supported.
            module Interval
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Interval
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              MONTH =
                T.let(
                  :month,
                  OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Interval::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Admin::Organization::Projects::SpendLimitUpdateParams::Interval::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end
          end
        end
      end
    end
  end
end
