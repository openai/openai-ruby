# frozen_string_literal: true

module OpenAI
  module Models
    module VectorStores
      # @see OpenAI::Resources::VectorStores::Files#list
      class FileListParams < OpenAI::Internal::Type::BaseModel
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

        # @!attribute before
        #   A cursor for use in pagination. `before` is an object ID that defines your place
        #   in the list. For instance, if you make a list request and receive 100 objects,
        #   starting with obj_foo, your subsequent call can include before=obj_foo in order
        #   to fetch the previous page of the list.
        #
        #   @return [String, nil]
        optional :before, String

        # @!attribute filter
        #   Filter by file status. One of `in_progress`, `completed`, `failed`, `cancelled`.
        #
        #   @return [Symbol, OpenAI::Models::VectorStores::FileListParams::Filter, nil]
        optional :filter, enum: -> { OpenAI::VectorStores::FileListParams::Filter }

        # @!attribute limit
        #   A limit on the number of objects to be returned. Limit can range between 1 and
        #   100, and the default is 20.
        #
        #   @return [Integer, nil]
        optional :limit, Integer

        # @!attribute order
        #   Sort order by the `created_at` timestamp of the objects. `asc` for ascending
        #   order and `desc` for descending order.
        #
        #   @return [Symbol, OpenAI::Models::VectorStores::FileListParams::Order, nil]
        optional :order, enum: -> { OpenAI::VectorStores::FileListParams::Order }

        # @!method initialize(after: nil, before: nil, filter: nil, limit: nil, order: nil, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::VectorStores::FileListParams} for more details.
        #
        #   @param after [String] A cursor for use in pagination. `after` is an object ID that defines your place
        #
        #   @param before [String] A cursor for use in pagination. `before` is an object ID that defines your place
        #
        #   @param filter [Symbol, OpenAI::Models::VectorStores::FileListParams::Filter] Filter by file status. One of `in_progress`, `completed`, `failed`, `cancelled`.
        #
        #   @param limit [Integer] A limit on the number of objects to be returned. Limit can range between 1 and 1
        #
        #   @param order [Symbol, OpenAI::Models::VectorStores::FileListParams::Order] Sort order by the `created_at` timestamp of the objects. `asc` for ascending ord
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

        # Filter by file status. One of `in_progress`, `completed`, `failed`, `cancelled`.
        module Filter
          extend OpenAI::Internal::Type::Enum

          IN_PROGRESS = :in_progress
          COMPLETED = :completed
          FAILED = :failed
          CANCELLED = :cancelled

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
        # order and `desc` for descending order.
        module Order
          extend OpenAI::Internal::Type::Enum

          ASC = :asc
          DESC = :desc

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
