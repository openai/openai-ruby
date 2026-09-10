# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        module Vaults

          class CredentialListParams < OpenAI::Internal::Type::BaseModel

            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Vaults::CredentialListParams,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :vault_id

            # Return resources after this resource ID in the selected order.
            sig { returns(T.nilable(String)) }
            attr_reader :after

            sig { params(after: String).void }
            attr_writer :after

            # The maximum number of resources to return. Defaults to 20. Values are clamped
            # between 1 and 100.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :limit

            # Sort order by the `created_at` timestamp. Use `asc` for ascending order or
            # `desc` for descending order. Defaults to `desc`.
            sig { returns(T.nilable(OpenAI::Beta::Agents::Vaults::CredentialListParams::Order::OrSymbol)) }
            attr_reader :order

            sig { params(order: OpenAI::Beta::Agents::Vaults::CredentialListParams::Order::OrSymbol).void }
            attr_writer :order

            # Filter by one status or a list, such as `status=active` or
            # `status[]=active&status[]=archived`. Both statuses are included by default.
            sig {
              returns(
                T.nilable(
                  T.any(
                    OpenAI::Beta::Agents::VaultStatus::OrSymbol,
                    T::Array[OpenAI::Beta::Agents::VaultStatus::OrSymbol]
                  )
                )
              )
            }
            attr_reader :status

            sig {
              params(
                status: T.any(
                  OpenAI::Beta::Agents::VaultStatus::OrSymbol,
                  T::Array[OpenAI::Beta::Agents::VaultStatus::OrSymbol]
                )
              )
                .void
            }
            attr_writer :status

            sig do
              params(

                vault_id: String,

                after: String,

                limit: T.nilable(Integer),

                order: OpenAI::Beta::Agents::Vaults::CredentialListParams::Order::OrSymbol,

                status: T.any(
                  OpenAI::Beta::Agents::VaultStatus::OrSymbol,
                  T::Array[OpenAI::Beta::Agents::VaultStatus::OrSymbol]
                ),

                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(T.attached_class)
            end
            def self.new(

              vault_id:,

              # Return resources after this resource ID in the selected order.
              after: nil,

              # The maximum number of resources to return. Defaults to 20. Values are clamped
              # between 1 and 100.
              limit: nil,

              # Sort order by the `created_at` timestamp. Use `asc` for ascending order or
              # `desc` for descending order. Defaults to `desc`.
              order: nil,

              # Filter by one status or a list, such as `status=active` or
              # `status[]=active&status[]=archived`. Both statuses are included by default.
              status: nil,

              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  vault_id: String,
                  after: String,
                  limit: T.nilable(Integer),
                  order: OpenAI::Beta::Agents::Vaults::CredentialListParams::Order::OrSymbol,
                  status: T.any(
                    OpenAI::Beta::Agents::VaultStatus::OrSymbol,
                    T::Array[OpenAI::Beta::Agents::VaultStatus::OrSymbol]
                  ),
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

              TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::Agents::Vaults::CredentialListParams::Order) }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              # Returns resources in ascending order.
              ASC = T.let(:asc, OpenAI::Beta::Agents::Vaults::CredentialListParams::Order::TaggedSymbol)

              # Returns resources in descending order.
              DESC = T.let(:desc, OpenAI::Beta::Agents::Vaults::CredentialListParams::Order::TaggedSymbol)

              sig {
                override.returns(T::Array[OpenAI::Beta::Agents::Vaults::CredentialListParams::Order::TaggedSymbol])
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
