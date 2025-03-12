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

        sig { returns(T.nilable(String)) }
        def after
        end

        sig { params(_: String).returns(String) }
        def after=(_)
        end

        sig { returns(T.nilable(String)) }
        def before
        end

        sig { params(_: String).returns(String) }
        def before=(_)
        end

        sig { returns(T.nilable(Symbol)) }
        def filter
        end

        sig { params(_: Symbol).returns(Symbol) }
        def filter=(_)
        end

        sig { returns(T.nilable(Integer)) }
        def limit
        end

        sig { params(_: Integer).returns(Integer) }
        def limit=(_)
        end

        sig { returns(T.nilable(Symbol)) }
        def order
        end

        sig { params(_: Symbol).returns(Symbol) }
        def order=(_)
        end

        sig do
          params(
            vector_store_id: String,
            after: String,
            before: String,
            filter: Symbol,
            limit: Integer,
            order: Symbol,
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
                filter: Symbol,
                limit: Integer,
                order: Symbol,
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash
        end

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
