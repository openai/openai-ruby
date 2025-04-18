# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Batches#list
    class BatchListParams < OpenAI::Internal::Type::BaseModel
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

      # @!attribute limit
      #   A limit on the number of objects to be returned. Limit can range between 1 and
      #   100, and the default is 20.
      #
      #   @return [Integer, nil]
      optional :limit, Integer

      # @!method initialize(after: nil, limit: nil, request_options: {})
      #   @param after [String]
      #   @param limit [Integer]
      #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
    end
  end
end
