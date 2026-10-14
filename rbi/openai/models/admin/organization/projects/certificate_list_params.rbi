# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          class CertificateListParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::CertificateListParams,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :project_id

            # A cursor for use in pagination. `after` is an object ID that defines your place
            # in the list. For instance, if you make a list request and receive 100 objects,
            # ending with obj_foo, your subsequent call can include after=obj_foo in order to
            # fetch the next page of the list.
            sig { returns(T.nilable(String)) }
            attr_reader :after

            sig { params(after: String).void }
            attr_writer :after

            # A limit on the number of objects to be returned. Limit can range between 1 and
            # 100, and the default is 20.
            sig { returns(T.nilable(Integer)) }
            attr_reader :limit

            sig { params(limit: Integer).void }
            attr_writer :limit

            # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
            # order and `desc` for descending order.
            sig do
              returns(
                T.nilable(
                  OpenAI::Admin::Organization::Projects::CertificateListParams::Order::OrSymbol
                )
              )
            end
            attr_reader :order

            sig do
              params(
                order:
                  OpenAI::Admin::Organization::Projects::CertificateListParams::Order::OrSymbol
              ).void
            end
            attr_writer :order

            sig do
              params(
                project_id: String,
                after: String,
                limit: Integer,
                order:
                  OpenAI::Admin::Organization::Projects::CertificateListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              project_id:,
              # A cursor for use in pagination. `after` is an object ID that defines your place
              # in the list. For instance, if you make a list request and receive 100 objects,
              # ending with obj_foo, your subsequent call can include after=obj_foo in order to
              # fetch the next page of the list.
              after: nil,
              # A limit on the number of objects to be returned. Limit can range between 1 and
              # 100, and the default is 20.
              limit: nil,
              # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
              # order and `desc` for descending order.
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
                    OpenAI::Admin::Organization::Projects::CertificateListParams::Order::OrSymbol,
                  request_options: OpenAI::RequestOptions
                }
              )
            end
            def to_hash
            end

            # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
            # order and `desc` for descending order.
            module Order
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Admin::Organization::Projects::CertificateListParams::Order
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              ASC =
                T.let(
                  :asc,
                  OpenAI::Admin::Organization::Projects::CertificateListParams::Order::TaggedSymbol
                )
              DESC =
                T.let(
                  :desc,
                  OpenAI::Admin::Organization::Projects::CertificateListParams::Order::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Admin::Organization::Projects::CertificateListParams::Order::TaggedSymbol
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
