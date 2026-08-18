# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          class GroupListParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::GroupListParams,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :project_id

            # Cursor for pagination. Provide the ID of the last group from the previous
            # response to fetch the next page.
            sig { returns(T.nilable(String)) }
            attr_reader :after

            sig { params(after: String).void }
            attr_writer :after

            # A limit on the number of project groups to return. Defaults to 20.
            sig { returns(T.nilable(Integer)) }
            attr_reader :limit

            sig { params(limit: Integer).void }
            attr_writer :limit

            # Sort order for the returned groups.
            sig do
              returns(
                T.nilable(
                  OpenAI::Admin::Organization::Projects::GroupListParams::Order::OrSymbol
                )
              )
            end
            attr_reader :order

            sig do
              params(
                order:
                  OpenAI::Admin::Organization::Projects::GroupListParams::Order::OrSymbol
              ).void
            end
            attr_writer :order

            sig do
              params(
                project_id: String,
                after: String,
                limit: Integer,
                order:
                  OpenAI::Admin::Organization::Projects::GroupListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              project_id:,
              # Cursor for pagination. Provide the ID of the last group from the previous
              # response to fetch the next page.
              after: nil,
              # A limit on the number of project groups to return. Defaults to 20.
              limit: nil,
              # Sort order for the returned groups.
              order: nil,
              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  project_id: String,
                  after: String,
                  limit: Integer,
                  order:
                    OpenAI::Admin::Organization::Projects::GroupListParams::Order::OrSymbol,
                  request_options: OpenAI::RequestOptions
                }
              )
            end
            def to_hash
            end

            # Sort order for the returned groups.
            module Order
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Admin::Organization::Projects::GroupListParams::Order
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              ASC =
                T.let(
                  :asc,
                  OpenAI::Admin::Organization::Projects::GroupListParams::Order::TaggedSymbol
                )
              DESC =
                T.let(
                  :desc,
                  OpenAI::Admin::Organization::Projects::GroupListParams::Order::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Admin::Organization::Projects::GroupListParams::Order::TaggedSymbol
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
