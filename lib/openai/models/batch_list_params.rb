# frozen_string_literal: true

module OpenAI
  module Models
    class BatchListParams < OpenAI::BaseModel
      # @!parse
      #   extend OpenAI::Type::RequestParameters::Converter
      include OpenAI::RequestParameters

      # @!attribute [r] after
      #   A cursor for use in pagination. `after` is an object ID that defines your place
      #     in the list. For instance, if you make a list request and receive 100 objects,
      #     ending with obj_foo, your subsequent call can include after=obj_foo in order to
      #     fetch the next page of the list.
      #
      #   @return [String, nil]
      optional :after, String

      # @!parse
      #   # @return [String]
      #   attr_writer :after

      # @!attribute [r] limit
      #   A limit on the number of objects to be returned. Limit can range between 1 and
      #     100, and the default is 20.
      #
      #   @return [Integer, nil]
      optional :limit, Integer

      # @!parse
      #   # @return [Integer]
      #   attr_writer :limit

      # @!parse
      #   # @param after [String]
      #   # @param limit [Integer]
      #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      #   #
      #   def initialize(after: nil, limit: nil, request_options: {}, **) = super

      # def initialize: (Hash | OpenAI::BaseModel) -> void
    end
  end
end
