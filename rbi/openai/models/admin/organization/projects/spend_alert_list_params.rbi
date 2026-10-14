# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          class SpendAlertListParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::SpendAlertListParams,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :project_id

            # Cursor for pagination. Provide the ID of the last spend alert from the previous
            # response to fetch the next page.
            sig { returns(T.nilable(String)) }
            attr_reader :after

            sig { params(after: String).void }
            attr_writer :after

            # Cursor for pagination. Provide the ID of the first spend alert from the previous
            # response to fetch the previous page.
            sig { returns(T.nilable(String)) }
            attr_reader :before

            sig { params(before: String).void }
            attr_writer :before

            # A limit on the number of spend alerts to return. Defaults to 20.
            sig { returns(T.nilable(Integer)) }
            attr_reader :limit

            sig { params(limit: Integer).void }
            attr_writer :limit

            # Sort order for the returned spend alerts.
            sig do
              returns(
                T.nilable(
                  OpenAI::Admin::Organization::Projects::SpendAlertListParams::Order::OrSymbol
                )
              )
            end
            attr_reader :order

            sig do
              params(
                order:
                  OpenAI::Admin::Organization::Projects::SpendAlertListParams::Order::OrSymbol
              ).void
            end
            attr_writer :order

            sig do
              params(
                project_id: String,
                after: String,
                before: String,
                limit: Integer,
                order:
                  OpenAI::Admin::Organization::Projects::SpendAlertListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              project_id:,
              # Cursor for pagination. Provide the ID of the last spend alert from the previous
              # response to fetch the next page.
              after: nil,
              # Cursor for pagination. Provide the ID of the first spend alert from the previous
              # response to fetch the previous page.
              before: nil,
              # A limit on the number of spend alerts to return. Defaults to 20.
              limit: nil,
              # Sort order for the returned spend alerts.
              order: nil,
              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  project_id: String,
                  after: String,
                  before: String,
                  limit: Integer,
                  order:
                    OpenAI::Admin::Organization::Projects::SpendAlertListParams::Order::OrSymbol,
                  request_options: OpenAI::RequestOptions
                }
              )
            end
            def to_hash
            end

            # Sort order for the returned spend alerts.
            module Order
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Admin::Organization::Projects::SpendAlertListParams::Order
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              ASC =
                T.let(
                  :asc,
                  OpenAI::Admin::Organization::Projects::SpendAlertListParams::Order::TaggedSymbol
                )
              DESC =
                T.let(
                  :desc,
                  OpenAI::Admin::Organization::Projects::SpendAlertListParams::Order::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Admin::Organization::Projects::SpendAlertListParams::Order::TaggedSymbol
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
end
