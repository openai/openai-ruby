# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::RateLimits#list_rate_limits
          class RateLimitListRateLimitsParams < OpenAI::Internal::Type::BaseModel
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

            # @!attribute before
            #   A cursor for use in pagination. `before` is an object ID that defines your place
            #   in the list. For instance, if you make a list request and receive 100 objects,
            #   beginning with obj_foo, your subsequent call can include before=obj_foo in order
            #   to fetch the previous page of the list.
            #
            #   @return [String, nil]
            optional :before, String

            # @!attribute limit
            #   A limit on the number of objects to be returned. The default is 100.
            #
            #   @return [Integer, nil]
            optional :limit, Integer

            # @!method initialize(project_id:, after: nil, before: nil, limit: nil, request_options: {})
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Admin::Organization::Projects::RateLimitListRateLimitsParams}
            #   for more details.
            #
            #   @param project_id [String]
            #
            #   @param after [String] A cursor for use in pagination. `after` is an object ID that defines your place
            #
            #   @param before [String] A cursor for use in pagination. `before` is an object ID that defines your place
            #
            #   @param limit [Integer] A limit on the number of objects to be returned. The default is 100.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
