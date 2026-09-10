# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        class SessionListParams < OpenAI::Internal::Type::BaseModel

          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::Agents::SessionListParams,
              OpenAI::Internal::AnyHash
            )
          end

          # Return resources after this resource ID in the selected order.
          sig { returns(T.nilable(String)) }
          attr_reader :after

          sig { params(after: String).void }
          attr_writer :after

          # Only return sessions whose root agent has this ID. Omit to return sessions for
          # all agents.
          sig { returns(T.nilable(String)) }
          attr_reader :agent_id

          sig { params(agent_id: String).void }
          attr_writer :agent_id

          # The maximum number of resources to return.
          sig { returns(T.nilable(Integer)) }
          attr_accessor :limit

          # Sort order by the `created_at` timestamp. Use `asc` for ascending order or
          # `desc` for descending order. Defaults to `desc`.
          sig { returns(T.nilable(OpenAI::Beta::Agents::SessionListParams::Order::OrSymbol)) }
          attr_reader :order

          sig { params(order: OpenAI::Beta::Agents::SessionListParams::Order::OrSymbol).void }
          attr_writer :order

          sig do
            params(

              after: String,

              agent_id: String,

              limit: T.nilable(Integer),

              order: OpenAI::Beta::Agents::SessionListParams::Order::OrSymbol,

              request_options: OpenAI::RequestOptions::OrHash
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Return resources after this resource ID in the selected order.
            after: nil,

            # Only return sessions whose root agent has this ID. Omit to return sessions for
            # all agents.
            agent_id: nil,

            # The maximum number of resources to return.
            limit: nil,

            # Sort order by the `created_at` timestamp. Use `asc` for ascending order or
            # `desc` for descending order. Defaults to `desc`.
            order: nil,

            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                after: String,
                agent_id: String,
                limit: T.nilable(Integer),
                order: OpenAI::Beta::Agents::SessionListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          # Sort order by the `created_at` timestamp. Use `asc` for ascending order or
          # `desc` for descending order. Defaults to `desc`.
          module Order
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::Agents::SessionListParams::Order) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            # Returns resources in ascending order.
            ASC = T.let(:asc, OpenAI::Beta::Agents::SessionListParams::Order::TaggedSymbol)

            # Returns resources in descending order.
            DESC = T.let(:desc, OpenAI::Beta::Agents::SessionListParams::Order::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Beta::Agents::SessionListParams::Order::TaggedSymbol]) }
            def self.values
            end
          end

        end

      end

    end

  end
end
