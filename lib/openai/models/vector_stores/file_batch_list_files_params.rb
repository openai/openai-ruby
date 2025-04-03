# frozen_string_literal: true

module OpenAI
  module Models
    module VectorStores
      # @see OpenAI::Resources::VectorStores::FileBatches#list_files
      class FileBatchListFilesParams < OpenAI::Internal::Type::BaseModel
        # @!parse
        #   extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute vector_store_id
        #
        #   @return [String]
        required :vector_store_id, String

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

        # @!attribute [r] before
        #   A cursor for use in pagination. `before` is an object ID that defines your place
        #     in the list. For instance, if you make a list request and receive 100 objects,
        #     starting with obj_foo, your subsequent call can include before=obj_foo in order
        #     to fetch the previous page of the list.
        #
        #   @return [String, nil]
        optional :before, String

        # @!parse
        #   # @return [String]
        #   attr_writer :before

        # @!attribute [r] filter
        #   Filter by file status. One of `in_progress`, `completed`, `failed`, `cancelled`.
        #
        #   @return [Symbol, OpenAI::Models::VectorStores::FileBatchListFilesParams::Filter, nil]
        optional :filter, enum: -> { OpenAI::Models::VectorStores::FileBatchListFilesParams::Filter }

        # @!parse
        #   # @return [Symbol, OpenAI::Models::VectorStores::FileBatchListFilesParams::Filter]
        #   attr_writer :filter

        # @!attribute [r] limit
        #   A limit on the number of objects to be returned. Limit can range between 1 and
        #     100, and the default is 20.
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
        #   @return [Symbol, OpenAI::Models::VectorStores::FileBatchListFilesParams::Order, nil]
        optional :order, enum: -> { OpenAI::Models::VectorStores::FileBatchListFilesParams::Order }

        # @!parse
        #   # @return [Symbol, OpenAI::Models::VectorStores::FileBatchListFilesParams::Order]
        #   attr_writer :order

        # @!parse
        #   # @param vector_store_id [String]
        #   # @param after [String]
        #   # @param before [String]
        #   # @param filter [Symbol, OpenAI::Models::VectorStores::FileBatchListFilesParams::Filter]
        #   # @param limit [Integer]
        #   # @param order [Symbol, OpenAI::Models::VectorStores::FileBatchListFilesParams::Order]
        #   # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
        #   #
        #   def initialize(vector_store_id:, after: nil, before: nil, filter: nil, limit: nil, order: nil, request_options: {}, **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

        # Filter by file status. One of `in_progress`, `completed`, `failed`, `cancelled`.
        module Filter
          extend OpenAI::Internal::Type::Enum

          IN_PROGRESS = :in_progress
          COMPLETED = :completed
          FAILED = :failed
          CANCELLED = :cancelled

          finalize!

          # @!parse
          #   # @return [Array<Symbol>]
          #   def self.values; end
        end

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
end
