# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class GroupListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::GroupListParams,
                OpenAI::Internal::AnyHash
              )
            end

          # A cursor for use in pagination. `after` is a group ID that defines your place in
          # the list. For instance, if you make a list request and receive 100 objects,
          # ending with group_abc, your subsequent call can include `after=group_abc` in
          # order to fetch the next page of the list.
          sig { returns(T.nilable(String)) }
          attr_reader :after

          sig { params(after: String).void }
          attr_writer :after

          # A limit on the number of groups to be returned. Limit can range between 0 and
          # 1000, and the default is 100.
          sig { returns(T.nilable(Integer)) }
          attr_reader :limit

          sig { params(limit: Integer).void }
          attr_writer :limit

          # Specifies the sort order of the returned groups.
          sig do
            returns(
              T.nilable(
                OpenAI::Admin::Organization::GroupListParams::Order::OrSymbol
              )
            )
          end
          attr_reader :order

          sig do
            params(
              order:
                OpenAI::Admin::Organization::GroupListParams::Order::OrSymbol
            ).void
          end
          attr_writer :order

          sig do
            params(
              after: String,
              limit: Integer,
              order:
                OpenAI::Admin::Organization::GroupListParams::Order::OrSymbol,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # A cursor for use in pagination. `after` is a group ID that defines your place in
            # the list. For instance, if you make a list request and receive 100 objects,
            # ending with group_abc, your subsequent call can include `after=group_abc` in
            # order to fetch the next page of the list.
            after: nil,
            # A limit on the number of groups to be returned. Limit can range between 0 and
            # 1000, and the default is 100.
            limit: nil,
            # Specifies the sort order of the returned groups.
            order: nil,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                after: String,
                limit: Integer,
                order:
                  OpenAI::Admin::Organization::GroupListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          # Specifies the sort order of the returned groups.
          module Order
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Admin::Organization::GroupListParams::Order
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            ASC =
              T.let(
                :asc,
                OpenAI::Admin::Organization::GroupListParams::Order::TaggedSymbol
              )
            DESC =
              T.let(
                :desc,
                OpenAI::Admin::Organization::GroupListParams::Order::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Admin::Organization::GroupListParams::Order::TaggedSymbol
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
