# typed: strong

module OpenAI
  module Models
    module VectorStores
      class FileListParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

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
        sig { returns(T.nilable(OpenAI::Models::VectorStores::FileListParams::Filter::OrSymbol)) }
        def filter
        end

        sig do
          params(_: OpenAI::Models::VectorStores::FileListParams::Filter::OrSymbol)
            .returns(OpenAI::Models::VectorStores::FileListParams::Filter::OrSymbol)
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
        sig { returns(T.nilable(OpenAI::Models::VectorStores::FileListParams::Order::OrSymbol)) }
        def order
        end

        sig do
          params(_: OpenAI::Models::VectorStores::FileListParams::Order::OrSymbol)
            .returns(OpenAI::Models::VectorStores::FileListParams::Order::OrSymbol)
        end
        def order=(_)
        end

        sig do
          params(
            after: String,
            before: String,
            filter: OpenAI::Models::VectorStores::FileListParams::Filter::OrSymbol,
            limit: Integer,
            order: OpenAI::Models::VectorStores::FileListParams::Order::OrSymbol,
            request_options: T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash)
          )
            .returns(T.attached_class)
        end
        def self.new(after: nil, before: nil, filter: nil, limit: nil, order: nil, request_options: {})
        end

        sig do
          override
            .returns(
              {
                after: String,
                before: String,
                filter: OpenAI::Models::VectorStores::FileListParams::Filter::OrSymbol,
                limit: Integer,
                order: OpenAI::Models::VectorStores::FileListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash
        end

        # Filter by file status. One of `in_progress`, `completed`, `failed`, `cancelled`.
        module Filter
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::VectorStores::FileListParams::Filter) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::VectorStores::FileListParams::Filter::TaggedSymbol) }

          IN_PROGRESS = T.let(:in_progress, OpenAI::Models::VectorStores::FileListParams::Filter::TaggedSymbol)
          COMPLETED = T.let(:completed, OpenAI::Models::VectorStores::FileListParams::Filter::TaggedSymbol)
          FAILED = T.let(:failed, OpenAI::Models::VectorStores::FileListParams::Filter::TaggedSymbol)
          CANCELLED = T.let(:cancelled, OpenAI::Models::VectorStores::FileListParams::Filter::TaggedSymbol)

          class << self
            sig { override.returns(T::Array[OpenAI::Models::VectorStores::FileListParams::Filter::TaggedSymbol]) }
            def values
            end
          end
        end

        # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
        #   order and `desc` for descending order.
        module Order
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::VectorStores::FileListParams::Order) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::VectorStores::FileListParams::Order::TaggedSymbol) }

          ASC = T.let(:asc, OpenAI::Models::VectorStores::FileListParams::Order::TaggedSymbol)
          DESC = T.let(:desc, OpenAI::Models::VectorStores::FileListParams::Order::TaggedSymbol)

          class << self
            sig { override.returns(T::Array[OpenAI::Models::VectorStores::FileListParams::Order::TaggedSymbol]) }
            def values
            end
          end
        end
      end
    end
  end
end
