# typed: strong

module OpenAI
  module Models
    module Beta
      module Responses
        class InputItemListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::Responses::InputItemListParams,
                OpenAI::Internal::AnyHash
              )
            end

          sig { returns(String) }
          attr_accessor :response_id

          # An item ID to list items after, used in pagination.
          sig { returns(T.nilable(String)) }
          attr_reader :after

          sig { params(after: String).void }
          attr_writer :after

          # Additional fields to include in the response. See the `include` parameter for
          # Response creation above for more information.
          sig do
            returns(
              T.nilable(
                T::Array[OpenAI::Beta::BetaResponseIncludable::OrSymbol]
              )
            )
          end
          attr_reader :include

          sig do
            params(
              include: T::Array[OpenAI::Beta::BetaResponseIncludable::OrSymbol]
            ).void
          end
          attr_writer :include

          # A limit on the number of objects to be returned. Limit can range between 1 and
          # 100, and the default is 20.
          sig { returns(T.nilable(Integer)) }
          attr_reader :limit

          sig { params(limit: Integer).void }
          attr_writer :limit

          # The order to return the input items in. Default is `desc`.
          #
          # - `asc`: Return the input items in ascending order.
          # - `desc`: Return the input items in descending order.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::Responses::InputItemListParams::Order::OrSymbol
              )
            )
          end
          attr_reader :order

          sig do
            params(
              order:
                OpenAI::Beta::Responses::InputItemListParams::Order::OrSymbol
            ).void
          end
          attr_writer :order

          sig do
            returns(
              T.nilable(
                T::Array[
                  OpenAI::Beta::Responses::InputItemListParams::Beta::OrSymbol
                ]
              )
            )
          end
          attr_reader :betas

          sig do
            params(
              betas:
                T::Array[
                  OpenAI::Beta::Responses::InputItemListParams::Beta::OrSymbol
                ]
            ).void
          end
          attr_writer :betas

          sig do
            params(
              response_id: String,
              after: String,
              include: T::Array[OpenAI::Beta::BetaResponseIncludable::OrSymbol],
              limit: Integer,
              order:
                OpenAI::Beta::Responses::InputItemListParams::Order::OrSymbol,
              betas:
                T::Array[
                  OpenAI::Beta::Responses::InputItemListParams::Beta::OrSymbol
                ],
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            response_id:,
            # An item ID to list items after, used in pagination.
            after: nil,
            # Additional fields to include in the response. See the `include` parameter for
            # Response creation above for more information.
            include: nil,
            # A limit on the number of objects to be returned. Limit can range between 1 and
            # 100, and the default is 20.
            limit: nil,
            # The order to return the input items in. Default is `desc`.
            #
            # - `asc`: Return the input items in ascending order.
            # - `desc`: Return the input items in descending order.
            order: nil,
            betas: nil,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                response_id: String,
                after: String,
                include:
                  T::Array[OpenAI::Beta::BetaResponseIncludable::OrSymbol],
                limit: Integer,
                order:
                  OpenAI::Beta::Responses::InputItemListParams::Order::OrSymbol,
                betas:
                  T::Array[
                    OpenAI::Beta::Responses::InputItemListParams::Beta::OrSymbol
                  ],
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          # The order to return the input items in. Default is `desc`.
          #
          # - `asc`: Return the input items in ascending order.
          # - `desc`: Return the input items in descending order.
          module Order
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Beta::Responses::InputItemListParams::Order
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            ASC =
              T.let(
                :asc,
                OpenAI::Beta::Responses::InputItemListParams::Order::TaggedSymbol
              )
            DESC =
              T.let(
                :desc,
                OpenAI::Beta::Responses::InputItemListParams::Order::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::Responses::InputItemListParams::Order::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          module Beta
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Beta::Responses::InputItemListParams::Beta
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            RESPONSES_MULTI_AGENT_V1 =
              T.let(
                :"responses_multi_agent=v1",
                OpenAI::Beta::Responses::InputItemListParams::Beta::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::Responses::InputItemListParams::Beta::TaggedSymbol
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
