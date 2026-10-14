# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        ProjectSpendLimit = Projects::ProjectSpendLimit

        module Projects
          class ProjectSpendLimit < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::ProjectSpendLimit,
                  OpenAI::Internal::AnyHash
                )
              end

            # The currency for the threshold amount. Currently, only `USD` is supported.
            sig do
              returns(
                OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Currency::Variants
              )
            end
            attr_accessor :currency

            # The current enforcement state of the hard spend limit.
            sig do
              returns(
                OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Enforcement
              )
            end
            attr_reader :enforcement

            sig do
              params(
                enforcement:
                  OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Enforcement::OrHash
              ).void
            end
            attr_writer :enforcement

            # The time interval for evaluating spend against the threshold. Currently, only
            # `month` is supported.
            sig do
              returns(
                OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Interval::Variants
              )
            end
            attr_accessor :interval

            # The object type, which is always `project.spend_limit`.
            sig { returns(Symbol) }
            attr_accessor :object

            # The hard spend limit amount, in cents.
            sig { returns(Integer) }
            attr_accessor :threshold_amount

            # Represents a hard spend limit configured at the project level.
            sig do
              params(
                currency:
                  T.any(
                    String,
                    OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Currency::OrSymbol
                  ),
                enforcement:
                  OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Enforcement::OrHash,
                interval:
                  T.any(
                    String,
                    OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Interval::OrSymbol
                  ),
                threshold_amount: Integer,
                object: Symbol
              ).returns(T.attached_class)
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
              # The object type, which is always `project.spend_limit`.
              object: :"project.spend_limit"
            )
            end

            sig do
              override.returns(
                {
                  currency:
                    OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Currency::Variants,
                  enforcement:
                    OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Enforcement,
                  interval:
                    OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Interval::Variants,
                  object: Symbol,
                  threshold_amount: Integer
                }
              )
            end
            def to_hash
            end

            # The currency for the threshold amount. Currently, only `USD` is supported.
            module Currency
              extend OpenAI::Internal::Type::Union

              Variants =
                T.type_alias do
                  T.any(
                    String,
                    OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Currency::TaggedSymbol
                  )
                end

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Currency::Variants
                  ]
                )
              end
              def self.variants
              end

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Currency
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              USD =
                T.let(
                  :USD,
                  OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Currency::TaggedSymbol
                )
            end

            class Enforcement < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Enforcement,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Whether the hard spend limit is currently enforcing.
              sig do
                returns(
                  OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Enforcement::Status::Variants
                )
              end
              attr_accessor :status

              # The current enforcement state of the hard spend limit.
              sig do
                params(
                  status:
                    T.any(
                      String,
                      OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Enforcement::Status::OrSymbol
                    )
                ).returns(T.attached_class)
              end
              def self.new(
                # Whether the hard spend limit is currently enforcing.
                status:
              )
              end

              sig do
                override.returns(
                  {
                    status:
                      OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Enforcement::Status::Variants
                  }
                )
              end
              def to_hash
              end

              # Whether the hard spend limit is currently enforcing.
              module Status
                extend OpenAI::Internal::Type::Union

                Variants =
                  T.type_alias do
                    T.any(
                      String,
                      OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Enforcement::Status::TaggedSymbol
                    )
                  end

                sig do
                  override.returns(
                    T::Array[
                      OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Enforcement::Status::Variants
                    ]
                  )
                end
                def self.variants
                end

                TaggedSymbol =
                  T.type_alias do
                    T.all(
                      Symbol,
                      OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Enforcement::Status
                    )
                  end
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                INACTIVE =
                  T.let(
                    :inactive,
                    OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Enforcement::Status::TaggedSymbol
                  )
                ENFORCING =
                  T.let(
                    :enforcing,
                    OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Enforcement::Status::TaggedSymbol
                  )
              end
            end

            # The time interval for evaluating spend against the threshold. Currently, only
            # `month` is supported.
            module Interval
              extend OpenAI::Internal::Type::Union

              Variants =
                T.type_alias do
                  T.any(
                    String,
                    OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Interval::TaggedSymbol
                  )
                end

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Interval::Variants
                  ]
                )
              end
              def self.variants
              end

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Interval
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              MONTH =
                T.let(
                  :month,
                  OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Interval::TaggedSymbol
                )
            end
          end
        end
      end
    end
  end
end
