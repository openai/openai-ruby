# typed: strong

module OpenAI
  module Models

    module Beta

      module Agents

        module Environments

          class FileListParams < OpenAI::Internal::Type::BaseModel

            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::Agents::Environments::FileListParams,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :environment_id

            # The maximum number of files to return, between 1 and 100.
            sig { returns(T.nilable(Integer)) }
            attr_accessor :limit

            # Sort by case-sensitive path components. Defaults to descending.
            sig { returns(T.nilable(OpenAI::Beta::Agents::Environments::FileListParams::Order::OrSymbol)) }
            attr_reader :order

            sig { params(order: OpenAI::Beta::Agents::Environments::FileListParams::Order::OrSymbol).void }
            attr_writer :order

            # The opaque token from the previous page. Keep the same path, order, and limit.
            sig { returns(T.nilable(String)) }
            attr_reader :page

            sig { params(page: String).void }
            attr_writer :page

            # Restrict the listing to this absolute workspace directory.
            sig { returns(T.nilable(String)) }
            attr_accessor :path

            sig do
              params(

                environment_id: String,

                limit: T.nilable(Integer),

                order: OpenAI::Beta::Agents::Environments::FileListParams::Order::OrSymbol,

                page: String,

                path: T.nilable(String),

                request_options: OpenAI::RequestOptions::OrHash
              )
                .returns(T.attached_class)
            end
            def self.new(

              environment_id:,

              # The maximum number of files to return, between 1 and 100.
              limit: nil,

              # Sort by case-sensitive path components. Defaults to descending.
              order: nil,

              # The opaque token from the previous page. Keep the same path, order, and limit.
              page: nil,

              # Restrict the listing to this absolute workspace directory.
              path: nil,

              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  environment_id: String,
                  limit: T.nilable(Integer),
                  order: OpenAI::Beta::Agents::Environments::FileListParams::Order::OrSymbol,
                  page: String,
                  path: T.nilable(String),
                  request_options: OpenAI::RequestOptions
                }
              )
            end
            def to_hash
            end

            # Sort by case-sensitive path components. Defaults to descending.
            module Order
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::Agents::Environments::FileListParams::Order) }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              # Returns resources in ascending order.
              ASC = T.let(:asc, OpenAI::Beta::Agents::Environments::FileListParams::Order::TaggedSymbol)

              # Returns resources in descending order.
              DESC = T.let(:desc, OpenAI::Beta::Agents::Environments::FileListParams::Order::TaggedSymbol)

              sig {
                override.returns(T::Array[OpenAI::Beta::Agents::Environments::FileListParams::Order::TaggedSymbol])
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
