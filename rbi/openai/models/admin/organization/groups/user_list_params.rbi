# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Groups
          class UserListParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Groups::UserListParams,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :group_id

            # A cursor for use in pagination. Provide the ID of the last user from the
            # previous list response to retrieve the next page.
            sig { returns(T.nilable(String)) }
            attr_reader :after

            sig { params(after: String).void }
            attr_writer :after

            # A limit on the number of users to be returned. Limit can range between 0 and
            # 1000, and the default is 100.
            sig { returns(T.nilable(Integer)) }
            attr_reader :limit

            sig { params(limit: Integer).void }
            attr_writer :limit

            # Specifies the sort order of users in the list.
            sig do
              returns(
                T.nilable(
                  OpenAI::Admin::Organization::Groups::UserListParams::Order::OrSymbol
                )
              )
            end
            attr_reader :order

            sig do
              params(
                order:
                  OpenAI::Admin::Organization::Groups::UserListParams::Order::OrSymbol
              ).void
            end
            attr_writer :order

            sig do
              params(
                group_id: String,
                after: String,
                limit: Integer,
                order:
                  OpenAI::Admin::Organization::Groups::UserListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              group_id:,
              # A cursor for use in pagination. Provide the ID of the last user from the
              # previous list response to retrieve the next page.
              after: nil,
              # A limit on the number of users to be returned. Limit can range between 0 and
              # 1000, and the default is 100.
              limit: nil,
              # Specifies the sort order of users in the list.
              order: nil,
              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  group_id: String,
                  after: String,
                  limit: Integer,
                  order:
                    OpenAI::Admin::Organization::Groups::UserListParams::Order::OrSymbol,
                  request_options: OpenAI::RequestOptions
                }
              )
            end
            def to_hash
            end

            # Specifies the sort order of users in the list.
            module Order
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Admin::Organization::Groups::UserListParams::Order
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              ASC =
                T.let(
                  :asc,
                  OpenAI::Admin::Organization::Groups::UserListParams::Order::TaggedSymbol
                )
              DESC =
                T.let(
                  :desc,
                  OpenAI::Admin::Organization::Groups::UserListParams::Order::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Admin::Organization::Groups::UserListParams::Order::TaggedSymbol
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
