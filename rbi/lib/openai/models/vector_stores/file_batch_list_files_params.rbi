# typed: strong

module OpenAI
  module Models
    module VectorStores
      class FileBatchListFilesParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        sig { returns(String) }
        def vector_store_id
        end

        sig { params(_: String).returns(String) }
        def vector_store_id=(_)
        end

        # A cursor for use in pagination. `after` is an object ID that defines your place
        #   in the list. For instance, if you make a list request and receive 100 objects,
        #   ending with obj_foo, your subsequent call can include after=obj_foo in order to
        #   fetch the next page of the list.
        sig { returns(T.nilable(String)) }
        def after
        end

        sig { params(_: String).returns(String) }
        def after=(_)
        end

        # A cursor for use in pagination. `before` is an object ID that defines your place
        #   in the list. For instance, if you make a list request and receive 100 objects,
        #   starting with obj_foo, your subsequent call can include before=obj_foo in order
        #   to fetch the previous page of the list.
        sig { returns(T.nilable(String)) }
        def before
        end

        sig { params(_: String).returns(String) }
        def before=(_)
        end

        # Filter by file status. One of `in_progress`, `completed`, `failed`, `cancelled`.
        sig { returns(T.nilable(OpenAI::Models::VectorStores::FileBatchListFilesParams::Filter::OrSymbol)) }
        def filter
        end

        sig do
          params(_: OpenAI::Models::VectorStores::FileBatchListFilesParams::Filter::OrSymbol)
            .returns(OpenAI::Models::VectorStores::FileBatchListFilesParams::Filter::OrSymbol)
        end
        def filter=(_)
        end

        # A limit on the number of objects to be returned. Limit can range between 1 and
        #   100, and the default is 20.
        sig { returns(T.nilable(Integer)) }
        def limit
        end

        sig { params(_: Integer).returns(Integer) }
        def limit=(_)
        end

        # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
        #   order and `desc` for descending order.
        sig { returns(T.nilable(OpenAI::Models::VectorStores::FileBatchListFilesParams::Order::OrSymbol)) }
        def order
        end

        sig do
          params(_: OpenAI::Models::VectorStores::FileBatchListFilesParams::Order::OrSymbol)
            .returns(OpenAI::Models::VectorStores::FileBatchListFilesParams::Order::OrSymbol)
        end
        def order=(_)
        end

        sig do
          params(
            vector_store_id: String,
            after: String,
            before: String,
            filter: OpenAI::Models::VectorStores::FileBatchListFilesParams::Filter::OrSymbol,
            limit: Integer,
            order: OpenAI::Models::VectorStores::FileBatchListFilesParams::Order::OrSymbol,
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(vector_store_id:, after: nil, before: nil, filter: nil, limit: nil, order: nil, request_options: {})
        end

        sig do
          override
            .returns(
              {
                vector_store_id: String,
                after: String,
                before: String,
                filter: OpenAI::Models::VectorStores::FileBatchListFilesParams::Filter::OrSymbol,
                limit: Integer,
                order: OpenAI::Models::VectorStores::FileBatchListFilesParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash
        end

        # Filter by file status. One of `in_progress`, `completed`, `failed`, `cancelled`.
        module Filter
          extend OpenAI::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::VectorStores::FileBatchListFilesParams::Filter) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::VectorStores::FileBatchListFilesParams::Filter::TaggedSymbol) }

          IN_PROGRESS =
            T.let(:in_progress, OpenAI::Models::VectorStores::FileBatchListFilesParams::Filter::OrSymbol)
          COMPLETED = T.let(:completed, OpenAI::Models::VectorStores::FileBatchListFilesParams::Filter::OrSymbol)
          FAILED = T.let(:failed, OpenAI::Models::VectorStores::FileBatchListFilesParams::Filter::OrSymbol)
          CANCELLED = T.let(:cancelled, OpenAI::Models::VectorStores::FileBatchListFilesParams::Filter::OrSymbol)
        end

        # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
        #   order and `desc` for descending order.
        module Order
          extend OpenAI::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::VectorStores::FileBatchListFilesParams::Order) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::VectorStores::FileBatchListFilesParams::Order::TaggedSymbol) }

          ASC = T.let(:asc, OpenAI::Models::VectorStores::FileBatchListFilesParams::Order::OrSymbol)
          DESC = T.let(:desc, OpenAI::Models::VectorStores::FileBatchListFilesParams::Order::OrSymbol)
        end
      end
    end
  end
end
