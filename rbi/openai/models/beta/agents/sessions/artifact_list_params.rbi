# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        module Sessions

          class ArtifactListParams < OpenAI::Internal::Type::BaseModel

            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Sessions::ArtifactListParams,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :session_id

            # Return artifacts after this immutable artifact ID.
            sig { returns(T.nilable(String)) }
            attr_accessor :after

            # Restrict the listing to artifacts produced by this environment.
            sig { returns(T.nilable(String)) }
            attr_accessor :environment_id

            # The maximum number of artifacts to return, between 1 and 100.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :limit

            # Sort by creation time and ID. Defaults to descending.
            sig { returns(T.nilable(OpenAI::Beta::Agents::Sessions::ArtifactListParams::Order::OrSymbol)) }
            attr_reader :order

            sig { params(order: OpenAI::Beta::Agents::Sessions::ArtifactListParams::Order::OrSymbol).void }
            attr_writer :order

            sig do
              params(

                session_id: String,

                after: T.nilable(String),

                environment_id: T.nilable(String),

                limit: T.nilable(Integer),

                order: OpenAI::Beta::Agents::Sessions::ArtifactListParams::Order::OrSymbol,

                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(T.attached_class)
            end
            def self.new(

              session_id:,

              # Return artifacts after this immutable artifact ID.
              after: nil,

              # Restrict the listing to artifacts produced by this environment.
              environment_id: nil,

              # The maximum number of artifacts to return, between 1 and 100.
              limit: nil,

              # Sort by creation time and ID. Defaults to descending.
              order: nil,

              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  session_id: String,
                  after: T.nilable(String),
                  environment_id: T.nilable(String),
                  limit: T.nilable(Integer),
                  order: OpenAI::Beta::Agents::Sessions::ArtifactListParams::Order::OrSymbol,
                  request_options: OpenAI::RequestOptions
                }
              )
            end
            def to_hash
            end

            # Sort by creation time and ID. Defaults to descending.
            module Order
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::Agents::Sessions::ArtifactListParams::Order) }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              # Returns resources in ascending order.
              ASC = T.let(:asc, OpenAI::Beta::Agents::Sessions::ArtifactListParams::Order::TaggedSymbol)

              # Returns resources in descending order.
              DESC = T.let(:desc, OpenAI::Beta::Agents::Sessions::ArtifactListParams::Order::TaggedSymbol)

              sig {
                override.returns(T::Array[OpenAI::Beta::Agents::Sessions::ArtifactListParams::Order::TaggedSymbol])
              }
              def self.values
              end
            end

          end

        end

      end

    end

  end
end
