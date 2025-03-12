# typed: strong

module OpenAI
  module RequestParameters
    abstract!

    sig { returns(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])) }
    def request_options
    end

    sig do
      params(_: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        .returns(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
    end
    def request_options=(_)
    end

    module Converter
      sig { params(params: T.anything).returns([T.anything, T::Hash[Symbol, T.anything]]) }
      def dump_request(params)
      end
    end
  end

  class RequestOptions < OpenAI::BaseModel
    sig { params(opts: T.any(T.self_type, T::Hash[Symbol, T.anything])).void }
    def self.validate!(opts)
    end

    sig { returns(T.nilable(String)) }
    def idempotency_key
    end

    sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
    def idempotency_key=(_)
    end

    sig { returns(T.nilable(T::Hash[String, T.nilable(T.any(T::Array[String], String))])) }
    def extra_query
    end

    sig do
      params(_: T.nilable(T::Hash[String, T.nilable(T.any(T::Array[String], String))]))
        .returns(T.nilable(T::Hash[String, T.nilable(T.any(T::Array[String], String))]))
    end
    def extra_query=(_)
    end

    sig { returns(T.nilable(T::Hash[String, T.nilable(String)])) }
    def extra_headers
    end

    sig do
      params(_: T.nilable(T::Hash[String, T.nilable(String)]))
        .returns(T.nilable(T::Hash[String, T.nilable(String)]))
    end
    def extra_headers=(_)
    end

    sig { returns(T.nilable(T::Hash[Symbol, T.anything])) }
    def extra_body
    end

    sig { params(_: T.nilable(T::Hash[Symbol, T.anything])).returns(T.nilable(T::Hash[Symbol, T.anything])) }
    def extra_body=(_)
    end

    sig { returns(T.nilable(Integer)) }
    def max_retries
    end

    sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def max_retries=(_)
    end

    sig { returns(T.nilable(Float)) }
    def timeout
    end

    sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
    def timeout=(_)
    end

    sig { params(values: T::Hash[Symbol, T.anything]).returns(T.attached_class) }
    def self.new(values = {})
    end
  end
end
