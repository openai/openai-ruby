# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::APIKeys#list
          class APIKeyListParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute project_id
            #
            #   @return [String]
            required :project_id, String

            # @!attribute after
            #   A cursor for use in pagination. `after` is an object ID that defines your place
            #   in the list. For instance, if you make a list request and receive 100 objects,
            #   ending with obj_foo, your subsequent call can include after=obj_foo in order to
            #   fetch the next page of the list.
            #
            #   @return [String, nil]
            optional :after, String

            # @!attribute limit
            #   A limit on the number of objects to be returned. Limit can range between 1 and
            #   100, and the default is 20.
            #
            #   @return [Integer, nil]
            optional :limit, Integer

            # @!attribute owner_project_access
            #   Filter API keys by whether the owner currently has effective access to the
            #   project. Use `active` for owners with access, `inactive` for owners without
            #   access, or `any` for all enabled project API keys. If omitted, the endpoint
            #   applies its existing membership-based visibility rules, which may exclude some
            #   enabled keys.
            #
            #   @return [Symbol, OpenAI::Models::Admin::Organization::Projects::APIKeyListParams::OwnerProjectAccess, nil]
            optional :owner_project_access,
                     enum: -> { OpenAI::Admin::Organization::Projects::APIKeyListParams::OwnerProjectAccess }

            # @!method initialize(project_id:, after: nil, limit: nil, owner_project_access: nil, request_options: {})
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Admin::Organization::Projects::APIKeyListParams} for more
            #   details.
            #
            #   @param project_id [String]
            #
            #   @param after [String] A cursor for use in pagination. `after` is an object ID that defines your place
            #
            #   @param limit [Integer] A limit on the number of objects to be returned. Limit can range between 1 and 1
            #
            #   @param owner_project_access [Symbol, OpenAI::Models::Admin::Organization::Projects::APIKeyListParams::OwnerProjectAccess] Filter API keys by whether the owner currently has effective access to the proje
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

            # Filter API keys by whether the owner currently has effective access to the
            # project. Use `active` for owners with access, `inactive` for owners without
            # access, or `any` for all enabled project API keys. If omitted, the endpoint
            # applies its existing membership-based visibility rules, which may exclude some
            # enabled keys.
            module OwnerProjectAccess
              extend OpenAI::Internal::Type::Enum

              ACTIVE = :active
              INACTIVE = :inactive
              ANY = :any

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end
        end
      end
    end
  end
end
