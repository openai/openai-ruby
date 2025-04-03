# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Files#list
    class FileListParams < OpenAI::Internal::Type::BaseModel
      # @!parse
      #   extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

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
      #     10,000, and the default is 10,000.
      #
      #   @return [Integer, nil]
      optional :limit, Integer

      # @!parse
      #   # @return [Integer]
      #   attr_writer :limit

      # @!attribute [r] order
      #   Sort order by the `created_at` timestamp of the objects. `asc` for ascending
      #     order and `desc` for descending order.
      #
      #   @return [Symbol, OpenAI::Models::FileListParams::Order, nil]
      optional :order, enum: -> { OpenAI::Models::FileListParams::Order }

      # @!parse
      #   # @return [Symbol, OpenAI::Models::FileListParams::Order]
      #   attr_writer :order

      # @!attribute [r] purpose
      #   Only return files with the given purpose.
      #
      #   @return [String, nil]
      optional :purpose, String

      # @!parse
      #   # @return [String]
      #   attr_writer :purpose

      # @!parse
      #   # @param after [String]
      #   # @param limit [Integer]
      #   # @param order [Symbol, OpenAI::Models::FileListParams::Order]
      #   # @param purpose [String]
      #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      #   #
      #   def initialize(after: nil, limit: nil, order: nil, purpose: nil, request_options: {}, **) = super

      # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

      # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
      #   order and `desc` for descending order.
      module Order
        extend OpenAI::Internal::Type::Enum

        ASC = :asc
        DESC = :desc

        finalize!

        # @!parse
        #   # @return [Array<Symbol>]
        #   def self.values; end
      end
    end
  end
end
