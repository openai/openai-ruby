# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::Users#list
          class UserListParams < OpenAI::Internal::Type::BaseModel
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

            # @!method initialize(project_id:, after: nil, limit: nil, request_options: {})
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Admin::Organization::Projects::UserListParams} for more
            #   details.
            #
            #   @param project_id [String]
            #
            #   @param after [String] A cursor for use in pagination. `after` is an object ID that defines your place
            #
            #   @param limit [Integer] A limit on the number of objects to be returned. Limit can range between 1 and 1
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
