# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Projects#list
        class ProjectListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute after
          #   A cursor for use in pagination. `after` is an object ID that defines your place
          #   in the list. For instance, if you make a list request and receive 100 objects,
          #   ending with obj_foo, your subsequent call can include after=obj_foo in order to
          #   fetch the next page of the list.
          #
          #   @return [String, nil]
          optional :after, String

          # @!attribute include_archived
          #   If `true` returns all projects including those that have been `archived`.
          #   Archived projects are not included by default.
          #
          #   @return [Boolean, nil]
          optional :include_archived, OpenAI::Internal::Type::Boolean

          # @!attribute limit
          #   A limit on the number of objects to be returned. Limit can range between 1 and
          #   100, and the default is 20.
          #
          #   @return [Integer, nil]
          optional :limit, Integer

          # @!method initialize(after: nil, include_archived: nil, limit: nil, request_options: {})
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Admin::Organization::ProjectListParams} for more details.
          #
          #   @param after [String] A cursor for use in pagination. `after` is an object ID that defines your place
          #
          #   @param include_archived [Boolean] If `true` returns all projects including those that have been `archived`. Archiv
          #
          #   @param limit [Integer] A limit on the number of objects to be returned. Limit can range between 1 and 1
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        end
      end
    end
  end
end
