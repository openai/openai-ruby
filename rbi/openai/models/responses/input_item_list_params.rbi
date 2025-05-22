# typed: strong

module OpenAI
  module Models
    module Responses
      class InputItemListParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::InputItemListParams,
              OpenAI::Internal::AnyHash
            )
          end

        # An item ID to list items after, used in pagination.
        sig { returns(T.nilable(String)) }
        attr_reader :after

        sig { params(after: String).void }
        attr_writer :after

        # An item ID to list items before, used in pagination.
        sig { returns(T.nilable(String)) }
        attr_reader :before

        sig { params(before: String).void }
        attr_writer :before

        # Additional fields to include in the response. See the `include` parameter for
        # Response creation above for more information.
        sig do
          returns(
            T.nilable(T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol])
          )
        end
        attr_reader :include

        sig do
          params(
            include: T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol]
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
            T.nilable(OpenAI::Responses::InputItemListParams::Order::OrSymbol)
          )
        end
        attr_reader :order

        sig do
          params(
            order: OpenAI::Responses::InputItemListParams::Order::OrSymbol
          ).void
        end
        attr_writer :order

        sig do
          params(
            after: String,
            before: String,
            include: T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol],
            limit: Integer,
            order: OpenAI::Responses::InputItemListParams::Order::OrSymbol,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # An item ID to list items after, used in pagination.
          after: nil,
          # An item ID to list items before, used in pagination.
          before: nil,
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
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              after: String,
              before: String,
              include:
                T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol],
              limit: Integer,
              order: OpenAI::Responses::InputItemListParams::Order::OrSymbol,
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
              T.all(Symbol, OpenAI::Responses::InputItemListParams::Order)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          ASC =
            T.let(
              :asc,
              OpenAI::Responses::InputItemListParams::Order::TaggedSymbol
            )
          DESC =
            T.let(
              :desc,
              OpenAI::Responses::InputItemListParams::Order::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::InputItemListParams::Order::TaggedSymbol
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
