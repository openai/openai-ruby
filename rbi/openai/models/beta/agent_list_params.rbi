# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentListParams < OpenAI::Internal::Type::BaseModel

        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentListParams,
            OpenAI::Internal::AnyHash
          )
        end

        # Return resources after this resource ID in the selected order.
        sig { returns(T.nilable(String)) }
        attr_reader :after

        sig { params(after: String).void }
        attr_writer :after

        # The maximum number of resources to return.
        sig { returns(T.nilable(Integer)) }
        attr_accessor :limit

        # The order in which resources are returned. Defaults to `desc`.
        sig { returns(T.nilable(OpenAI::Beta::AgentListParams::Order::OrSymbol)) }
        attr_reader :order

        sig { params(order: OpenAI::Beta::AgentListParams::Order::OrSymbol).void }
        attr_writer :order

        sig do
          params(

            after: String,

            limit: T.nilable(Integer),

            order: OpenAI::Beta::AgentListParams::Order::OrSymbol,

            request_options: OpenAI::RequestOptions::OrHash
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Return resources after this resource ID in the selected order.
          after: nil,

          # The maximum number of resources to return.
          limit: nil,

          # The order in which resources are returned. Defaults to `desc`.
          order: nil,

          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              after: String,
              limit: T.nilable(Integer),
              order: OpenAI::Beta::AgentListParams::Order::OrSymbol,
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        # The order in which resources are returned. Defaults to `desc`.
        module Order
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::AgentListParams::Order) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          # Returns resources in ascending order.
          ASC = T.let(:asc, OpenAI::Beta::AgentListParams::Order::TaggedSymbol)

          # Returns resources in descending order.
          DESC = T.let(:desc, OpenAI::Beta::AgentListParams::Order::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Beta::AgentListParams::Order::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
