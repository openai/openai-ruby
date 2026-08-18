# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          class APIKeyListParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::APIKeyListParams,
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

            # Filter API keys by whether the owner currently has effective access to the
            # project. Use `active` for owners with access, `inactive` for owners without
            # access, or `any` for all enabled project API keys. If omitted, the endpoint
            # applies its existing membership-based visibility rules, which may exclude some
            # enabled keys.
            sig do
              returns(
                T.nilable(
                  OpenAI::Admin::Organization::Projects::APIKeyListParams::OwnerProjectAccess::OrSymbol
                )
              )
            end
            attr_reader :owner_project_access

            sig do
              params(
                owner_project_access:
                  OpenAI::Admin::Organization::Projects::APIKeyListParams::OwnerProjectAccess::OrSymbol
              ).void
            end
            attr_writer :owner_project_access

            sig do
              params(
                project_id: String,
                after: String,
                limit: Integer,
                owner_project_access:
                  OpenAI::Admin::Organization::Projects::APIKeyListParams::OwnerProjectAccess::OrSymbol,
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
              # Filter API keys by whether the owner currently has effective access to the
              # project. Use `active` for owners with access, `inactive` for owners without
              # access, or `any` for all enabled project API keys. If omitted, the endpoint
              # applies its existing membership-based visibility rules, which may exclude some
              # enabled keys.
              owner_project_access: nil,
              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  project_id: String,
                  after: String,
                  limit: Integer,
                  owner_project_access:
                    OpenAI::Admin::Organization::Projects::APIKeyListParams::OwnerProjectAccess::OrSymbol,
                  request_options: OpenAI::RequestOptions
                }
              )
            end
            def to_hash
            end

            # Filter API keys by whether the owner currently has effective access to the
            # project. Use `active` for owners with access, `inactive` for owners without
            # access, or `any` for all enabled project API keys. If omitted, the endpoint
            # applies its existing membership-based visibility rules, which may exclude some
            # enabled keys.
            module OwnerProjectAccess
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Admin::Organization::Projects::APIKeyListParams::OwnerProjectAccess
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              ACTIVE =
                T.let(
                  :active,
                  OpenAI::Admin::Organization::Projects::APIKeyListParams::OwnerProjectAccess::TaggedSymbol
                )
              INACTIVE =
                T.let(
                  :inactive,
                  OpenAI::Admin::Organization::Projects::APIKeyListParams::OwnerProjectAccess::TaggedSymbol
                )
              ANY =
                T.let(
                  :any,
                  OpenAI::Admin::Organization::Projects::APIKeyListParams::OwnerProjectAccess::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Admin::Organization::Projects::APIKeyListParams::OwnerProjectAccess::TaggedSymbol
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
