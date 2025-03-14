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
        sig { returns(T.nilable(Symbol)) }
        def filter
        end

        sig { params(_: Symbol).returns(Symbol) }
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
        sig { returns(T.nilable(Symbol)) }
        def order
        end

        sig { params(_: Symbol).returns(Symbol) }
        def order=(_)
        end

        sig do
          params(
            after: String,
            before: String,
            filter: Symbol,
            limit: Integer,
            order: Symbol,
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
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
                filter: Symbol,
                limit: Integer,
                order: Symbol,
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash
        end

        # Filter by file status. One of `in_progress`, `completed`, `failed`, `cancelled`.
        class Filter < OpenAI::Enum
          abstract!

          IN_PROGRESS = :in_progress
          COMPLETED = :completed
          FAILED = :failed
          CANCELLED = :cancelled

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end

        # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
        #   order and `desc` for descending order.
        class Order < OpenAI::Enum
          abstract!

          ASC = :asc
          DESC = :desc

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end
      end
    end
  end
end
