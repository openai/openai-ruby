# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::SpendLimit#retrieve
          class ProjectSpendLimit < OpenAI::Internal::Type::BaseModel
            # @!attribute currency
            #   The currency for the threshold amount. Currently, only `USD` is supported.
            #
            #   @return [String, Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectSpendLimit::Currency]
            required :currency, union: -> { OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Currency }

            # @!attribute enforcement
            #   The current enforcement state of the hard spend limit.
            #
            #   @return [OpenAI::Models::Admin::Organization::Projects::ProjectSpendLimit::Enforcement]
            required :enforcement, -> { OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Enforcement }

            # @!attribute interval
            #   The time interval for evaluating spend against the threshold. Currently, only
            #   `month` is supported.
            #
            #   @return [String, Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectSpendLimit::Interval]
            required :interval, union: -> { OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Interval }

            # @!attribute object
            #   The object type, which is always `project.spend_limit`.
            #
            #   @return [Symbol, :"project.spend_limit"]
            required :object, const: :"project.spend_limit"

            # @!attribute threshold_amount
            #   The hard spend limit amount, in cents.
            #
            #   @return [Integer]
            required :threshold_amount, Integer

            # @!method initialize(currency:, enforcement:, interval:, threshold_amount:, object: :"project.spend_limit")
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Admin::Organization::Projects::ProjectSpendLimit} for more
            #   details.
            #
            #   Represents a hard spend limit configured at the project level.
            #
            #   @param currency [String, Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectSpendLimit::Currency] The currency for the threshold amount. Currently, only `USD` is supported.
            #
            #   @param enforcement [OpenAI::Models::Admin::Organization::Projects::ProjectSpendLimit::Enforcement] The current enforcement state of the hard spend limit.
            #
            #   @param interval [String, Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectSpendLimit::Interval] The time interval for evaluating spend against the threshold. Currently, only `m
            #
            #   @param threshold_amount [Integer] The hard spend limit amount, in cents.
            #
            #   @param object [Symbol, :"project.spend_limit"] The object type, which is always `project.spend_limit`.

            # The currency for the threshold amount. Currently, only `USD` is supported.
            #
            # @see OpenAI::Models::Admin::Organization::Projects::ProjectSpendLimit#currency
            module Currency
              extend OpenAI::Internal::Type::Union

              variant String

              variant const: -> { OpenAI::Models::Admin::Organization::Projects::ProjectSpendLimit::Currency::USD }

              # @!method self.variants
              #   @return [Array(String, Symbol)]

              define_sorbet_constant!(:Variants) do
                T.type_alias { T.any(String, OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Currency::TaggedSymbol) }
              end

              # @!group

              USD = :USD

              # @!endgroup
            end

            # @see OpenAI::Models::Admin::Organization::Projects::ProjectSpendLimit#enforcement
            class Enforcement < OpenAI::Internal::Type::BaseModel
              # @!attribute status
              #   Whether the hard spend limit is currently enforcing.
              #
              #   @return [String, Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectSpendLimit::Enforcement::Status]
              required :status,
                       union: -> { OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Enforcement::Status }

              # @!method initialize(status:)
              #   The current enforcement state of the hard spend limit.
              #
              #   @param status [String, Symbol, OpenAI::Models::Admin::Organization::Projects::ProjectSpendLimit::Enforcement::Status] Whether the hard spend limit is currently enforcing.

              # Whether the hard spend limit is currently enforcing.
              #
              # @see OpenAI::Models::Admin::Organization::Projects::ProjectSpendLimit::Enforcement#status
              module Status
                extend OpenAI::Internal::Type::Union

                variant String

                variant const: -> { OpenAI::Models::Admin::Organization::Projects::ProjectSpendLimit::Enforcement::Status::INACTIVE }

                variant const: -> { OpenAI::Models::Admin::Organization::Projects::ProjectSpendLimit::Enforcement::Status::ENFORCING }

                # @!method self.variants
                #   @return [Array(String, Symbol)]

                define_sorbet_constant!(:Variants) do
                  T.type_alias { T.any(String, OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Enforcement::Status::TaggedSymbol) }
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
            # @see OpenAI::Models::Admin::Organization::Projects::ProjectSpendLimit#interval
            module Interval
              extend OpenAI::Internal::Type::Union

              variant String

              variant const: -> { OpenAI::Models::Admin::Organization::Projects::ProjectSpendLimit::Interval::MONTH }

              # @!method self.variants
              #   @return [Array(String, Symbol)]

              define_sorbet_constant!(:Variants) do
                T.type_alias { T.any(String, OpenAI::Admin::Organization::Projects::ProjectSpendLimit::Interval::TaggedSymbol) }
              end

              # @!group

              MONTH = :month

              # @!endgroup
            end
          end
        end

        ProjectSpendLimit = Projects::ProjectSpendLimit
      end
    end
  end
end
