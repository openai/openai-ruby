# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        module Sessions

          class TurnListParams < OpenAI::Internal::Type::BaseModel

            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Sessions::TurnListParams,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :session_id

            # Return resources after this resource ID in the selected order.
            sig { returns(T.nilable(String)) }
            attr_reader :after

            sig { params(after: String).void }
            attr_writer :after

            # The maximum number of resources to return, between 1 and 100. Defaults to 20.
            sig { returns(T.nilable(Integer)) }
            attr_reader :limit

            sig { params(limit: Integer).void }
            attr_writer :limit

            # The order in which resources are returned. Defaults to `desc`.
            sig { returns(T.nilable(OpenAI::Beta::Agents::Sessions::TurnListParams::Order::OrSymbol)) }
            attr_reader :order

            sig { params(order: OpenAI::Beta::Agents::Sessions::TurnListParams::Order::OrSymbol).void }
            attr_writer :order

            sig do
              params(

                session_id: String,

                after: String,

                limit: Integer,

                order: OpenAI::Beta::Agents::Sessions::TurnListParams::Order::OrSymbol,

                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(T.attached_class)
            end
            def self.new(

              session_id:,

              # Return resources after this resource ID in the selected order.
              after: nil,

              # The maximum number of resources to return, between 1 and 100. Defaults to 20.
              limit: nil,

              # The order in which resources are returned. Defaults to `desc`.
              order: nil,

              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  session_id: String,
                  after: String,
                  limit: Integer,
                  order: OpenAI::Beta::Agents::Sessions::TurnListParams::Order::OrSymbol,
                  request_options: OpenAI::RequestOptions
                }
              )
            end
            def to_hash
            end

            # The order in which resources are returned. Defaults to `desc`.
            module Order
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::Agents::Sessions::TurnListParams::Order) }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              # Returns resources in ascending order.
              ASC = T.let(:asc, OpenAI::Beta::Agents::Sessions::TurnListParams::Order::TaggedSymbol)

              # Returns resources in descending order.
              DESC = T.let(:desc, OpenAI::Beta::Agents::Sessions::TurnListParams::Order::TaggedSymbol)

              sig { override.returns(T::Array[OpenAI::Beta::Agents::Sessions::TurnListParams::Order::TaggedSymbol]) }
              def self.values
              end
            end

          end

        end

      end

    end

  end
end
