# typed: strong

module OpenAI
  # @api private
  module RequestParameters
    # Options to specify HTTP behaviour for this request.
    sig { returns(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])) }
    def request_options
    end

    sig do
      params(_: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
        .returns(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
    end
    def request_options=(_)
    end

    # @api private
    module Converter
      # @api private
      sig { params(params: T.anything).returns([T.anything, T::Hash[Symbol, T.anything]]) }
      def dump_request(params)
      end
    end
  end

  # Specify HTTP behaviour to use for a specific request. These options supplement
  #   or override those provided at the client level.
  #
  #   When making a request, you can pass an actual {RequestOptions} instance, or
  #   simply pass a Hash with symbol keys matching the attributes on this class.
  class RequestOptions < OpenAI::BaseModel
    # @api private
    sig { params(opts: T.any(T.self_type, T::Hash[Symbol, T.anything])).void }
    def self.validate!(opts)
    end

    # Idempotency key to send with request and all associated retries. Will only be
    #   sent for write requests.
    sig { returns(T.nilable(String)) }
    def idempotency_key
    end

    sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
    def idempotency_key=(_)
    end

    # Extra query params to send with the request. These are `.merge`’d into any
    #   `query` given at the client level.
    sig { returns(T.nilable(T::Hash[String, T.nilable(T.any(T::Array[String], String))])) }
    def extra_query
    end

    sig do
      params(_: T.nilable(T::Hash[String, T.nilable(T.any(T::Array[String], String))]))
        .returns(T.nilable(T::Hash[String, T.nilable(T.any(T::Array[String], String))]))
    end
    def extra_query=(_)
    end

    # Extra headers to send with the request. These are `.merged`’d into any
    #   `extra_headers` given at the client level.
    sig { returns(T.nilable(T::Hash[String, T.nilable(String)])) }
    def extra_headers
    end

    sig do
      params(_: T.nilable(T::Hash[String, T.nilable(String)]))
        .returns(T.nilable(T::Hash[String, T.nilable(String)]))
    end
    def extra_headers=(_)
    end

    # Extra data to send with the request. These are deep merged into any data
    #   generated as part of the normal request.
    sig { returns(T.nilable(T::Hash[Symbol, T.anything])) }
    def extra_body
    end

    sig { params(_: T.nilable(T::Hash[Symbol, T.anything])).returns(T.nilable(T::Hash[Symbol, T.anything])) }
    def extra_body=(_)
    end

    # Maximum number of retries to attempt after a failed initial request.
    sig { returns(T.nilable(Integer)) }
    def max_retries
    end

    sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def max_retries=(_)
    end

    # Request timeout in seconds.
    sig { returns(T.nilable(Float)) }
    def timeout
    end

    sig { params(_: T.nilable(Float)).returns(T.nilable(Float)) }
    def timeout=(_)
    end

    # Returns a new instance of RequestOptions.
    sig { params(values: T::Hash[Symbol, T.anything]).returns(T.attached_class) }
    def self.new(values = {})
    end
  end
end
