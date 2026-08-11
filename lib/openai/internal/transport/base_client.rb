# frozen_string_literal: true

require_relative "../logging"

module OpenAI
  module Internal
    module Transport
      # @api private
      #
      # @abstract
      class BaseClient
        extend OpenAI::Internal::Util::SorbetRuntimeSupport

        # from whatwg fetch spec
        MAX_REDIRECTS = 20

        # rubocop:disable Style/MutableConstant
        PLATFORM_HEADERS =
          {
            "x-stainless-arch" => OpenAI::Internal::Util.arch,
            "x-stainless-lang" => "ruby",
            "x-stainless-os" => OpenAI::Internal::Util.os,
            "x-stainless-package-version" => OpenAI::VERSION,
            "x-stainless-runtime" => ::RUBY_ENGINE,
            "x-stainless-runtime-version" => ::RUBY_ENGINE_VERSION
          }
        # rubocop:enable Style/MutableConstant

        class << self
          # @api private
          #
          # @param req [Hash{Symbol=>Object}]
          #
          # @raise [ArgumentError]
          def validate!(req)
            keys = [
              :method,
              :path,
              :query,
              :headers,
              :body,
              :unwrap,
              :page,
              :stream,
              :model,
              :security,
              :options
            ]
            case req
            in Hash
              req.each_key do |k|
                unless keys.include?(k)
                  raise ArgumentError.new("Request `req` keys must be one of #{keys}, got #{k.inspect}")
                end
              end
            else
              raise ArgumentError.new("Request `req` must be a Hash or RequestOptions, got #{req.inspect}")
            end
          end

          # @api private
          #
          # @param status [Integer]
          # @param headers [Hash{String=>String}]
          #
          # @return [Boolean]
          def should_retry?(status, headers:)
            coerced = OpenAI::Internal::Util.coerce_boolean(headers["x-should-retry"])
            case [coerced, status]
            in [true | false, _]
              coerced
            in [_, 408 | 409 | 429 | (500..)]
              # retry on:
              # 408: timeouts
              # 409: locks
              # 429: rate limits
              # 500+: unknown errors
              true
            else
              false
            end
          end

          # @api private
          #
          # @param body [Object]
          #
          # @return [Boolean]
          def request_body_replayable?(body)
            case body
            in nil | String | StringIO | Pathname
              true
            in OpenAI::FilePart
              request_body_replayable?(body.content)
            in Hash
              body.each_value.all? { request_body_replayable?(_1) }
            in Array
              body.all? { request_body_replayable?(_1) }
            in IO | Enumerable
              false
            else
              !body.respond_to?(:read)
            end
          end

          # @api private
          #
          # @param request [Hash{Symbol=>Object}] .
          #
          #   @option request [Symbol] :method
          #
          #   @option request [URI::Generic] :url
          #
          #   @option request [Hash{String=>String}] :headers
          #
          #   @option request [Object] :body
          #
          #   @option request [Integer] :max_retries
          #
          #   @option request [Float] :timeout
          #
          # @param status [Integer]
          #
          # @param response_headers [Hash{String=>String}]
          #
          # @return [Hash{Symbol=>Object}]
          def follow_redirect(request, status:, response_headers:)
            method, url, headers = request.fetch_values(:method, :url, :headers)
            location =
              Kernel.then do
                URI.join(url, response_headers["location"])
              rescue ArgumentError
                message = "Server responded with status #{status} but no valid location header."
                raise OpenAI::Errors::APIConnectionError.new(
                  url: url,
                  response: response_headers,
                  message: message
                )
              end

            request = {**request, url: location}

            case [url.scheme, location.scheme]
            in ["https", "http"]
              message = "Tried to redirect to a insecure URL"
              raise OpenAI::Errors::APIConnectionError.new(
                url: url,
                response: response_headers,
                message: message
              )
            else
              nil
            end

            # from whatwg fetch spec
            case [status, method]
            in [301 | 302, :post] | [303, _]
              drop = %w[content-encoding content-language content-length content-location content-type]
              request = {
                **request,
                method: method == :head ? :head : :get,
                headers: headers.except(*drop),
                body: nil
              }
            else
            end

            # from undici
            if OpenAI::Internal::Util.uri_origin(url) != OpenAI::Internal::Util.uri_origin(location)
              drop = %w[authorization cookie host proxy-authorization]
              request = {**request, headers: request.fetch(:headers).except(*drop)}
            end

            unless request_body_replayable?(request[:body])
              message = "Cannot follow a body-preserving redirect with a non-replayable request body."
              raise OpenAI::Errors::APIConnectionError.new(
                url: location,
                response: response_headers,
                message: message
              )
            end

            request
          end

          # @api private
          #
          # @param status [Integer, OpenAI::Errors::APIConnectionError]
          # @param stream [Enumerable<String>, nil]
          def reap_connection!(status, stream:)
            case status
            in (..199) | (300..499)
              stream&.each { next }
            in OpenAI::Errors::APIConnectionError | (500..)
              OpenAI::Internal::Util.close_fused!(stream)
            else
            end
          end
        end

        # @return [URI::Generic]
        attr_reader :base_url

        # @return [Float, nil]
        attr_reader :timeout

        # @return [Integer]
        attr_reader :max_retries

        # @return [Float]
        attr_reader :initial_retry_delay

        # @return [Float]
        attr_reader :max_retry_delay

        # @return [Hash{String=>String}]
        attr_reader :headers

        # @return [String, nil]
        attr_reader :idempotency_header

        # @return [#debug, #info, #warn, #error, nil]
        attr_reader :logger

        # @return [Symbol]
        attr_reader :log_level

        # @return [Proc, nil]
        attr_reader :on_retry

        # @api private
        # @return [#execute]
        attr_reader :requester

        # @api private
        #
        # @param base_url [String]
        # @param timeout [Float, nil]
        # @param max_retries [Integer]
        # @param initial_retry_delay [Float]
        # @param max_retry_delay [Float]
        # @param headers [Hash{String=>String, Integer, Array<String, Integer, nil>, nil}]
        # @param idempotency_header [String, nil]
        # @param http_client [#execute, nil]
        # @param logger [#debug, #info, #warn, #error, nil]
        # @param log_level [Symbol, String, nil]
        # @param on_retry [Proc, nil]
        def initialize(
          base_url:,
          timeout: 0.0,
          max_retries: 0,
          initial_retry_delay: 0.0,
          max_retry_delay: 0.0,
          headers: {},
          idempotency_header: nil,
          http_client: nil,
          logger: nil,
          log_level: nil,
          on_retry: nil
        )
          unless http_client.nil? || http_client.respond_to?(:execute)
            raise ArgumentError, "`http_client` must respond to `execute`"
          end
          unless on_retry.nil? || on_retry.respond_to?(:call)
            raise ArgumentError, "`on_retry` must respond to `call`"
          end

          if log_level.nil?
            log_level = ENV.fetch("OPENAI_LOG", logger.nil? ? :off : :info)
          end
          @log_level = OpenAI::Internal::Logging.normalize_level(log_level)
          OpenAI::Internal::Logging.validate_logger!(logger)
          @logger = logger
          @logger ||= OpenAI::Internal::Logging.default_logger unless @log_level == :off
          @on_retry = on_retry
          @requester = http_client || OpenAI::NetHTTPClient.new
          @headers = OpenAI::Internal::Util.normalized_headers(
            self.class::PLATFORM_HEADERS,
            {
              "accept" => "application/json",
              "content-type" => "application/json",
              "user-agent" => user_agent
            },
            headers
          )
          @base_url_components = OpenAI::Internal::Util.parse_uri(base_url)
          @base_url = OpenAI::Internal::Util.unparse_uri(@base_url_components)
          @idempotency_header = idempotency_header&.to_s&.downcase
          @timeout = timeout
          @max_retries = max_retries
          @initial_retry_delay = initial_retry_delay
          @max_retry_delay = max_retry_delay
        end

        # @api private
        #
        # @return [Hash{String=>String}]
        private def auth_headers = {}

        # Apply final per-attempt request transformations after retry headers are
        # set and immediately before the request reaches the transport.
        #
        # @api private
        private def prepare_request(request, **_context)
          request
        end

        # @api private
        #
        # @return [String]
        private def user_agent = "#{self.class.name}/Ruby #{OpenAI::VERSION}"

        # @api private
        #
        # @return [String]
        private def generate_idempotency_key = "stainless-ruby-retry-#{SecureRandom.uuid}"

        # @api private
        #
        # @param req [Hash{Symbol=>Object}] .
        #
        #   @option req [Symbol] :method
        #
        #   @option req [String, Array<String>] :path
        #
        #   @option req [Hash{String=>Array<String>, String, nil}, nil] :query
        #
        #   @option req [Hash{String=>String, Integer, Array<String, Integer, nil>, nil}, nil] :headers
        #
        #   @option req [Object, nil] :body
        #
        #   @option req [Symbol, Integer, Array<Symbol, Integer>, Proc, nil] :unwrap
        #
        #   @option req [Class<OpenAI::Internal::Type::BasePage>, nil] :page
        #
        #   @option req [Class<OpenAI::Internal::Type::BaseStream>, nil] :stream
        #
        #   @option req [OpenAI::Internal::Type::Converter, Class, nil] :model
        #
        #   @option req [Hash{Symbol=>Boolean}, nil] :security
        #
        # @param opts [Hash{Symbol=>Object}] .
        #
        #   @option opts [String, nil] :idempotency_key
        #
        #   @option opts [Hash{String=>Array<String>, String, nil}, nil] :extra_query
        #
        #   @option opts [Hash{String=>String, nil}, nil] :extra_headers
        #
        #   @option opts [Object, nil] :extra_body
        #
        #   @option opts [Integer, nil] :max_retries
        #
        #   @option opts [Float, nil] :timeout
        #
        # @return [Hash{Symbol=>Object}]
        private def build_request(req, opts)
          method, uninterpolated_path = req.fetch_values(:method, :path)

          path = OpenAI::Internal::Util.interpolate_path(uninterpolated_path)

          query = OpenAI::Internal::Util.deep_merge(req[:query].to_h, opts[:extra_query].to_h)

          headers = OpenAI::Internal::Util.normalized_headers(
            @headers,
            auth_headers(
              security: req.fetch(
                :security,
                {bearer_auth: true, admin_api_key_auth: true}
              )
            ),
            req[:headers].to_h,
            opts[:extra_headers].to_h
          )

          if @idempotency_header &&
             !headers.key?(@idempotency_header) &&
             (!Net::HTTP::IDEMPOTENT_METHODS_.include?(method.to_s.upcase) || opts.key?(:idempotency_key))
            headers[@idempotency_header] = opts.fetch(:idempotency_key) { generate_idempotency_key }
          end

          unless headers.key?("x-stainless-retry-count")
            headers["x-stainless-retry-count"] = "0"
          end

          timeout = opts.fetch(:timeout, @timeout)
          timeout = timeout.to_f.clamp(0..) unless timeout.nil?
          unless headers.key?("x-stainless-timeout") || timeout.nil? || timeout.zero?
            headers["x-stainless-timeout"] = timeout.to_s
          end

          headers.reject! { |_, v| v.to_s.empty? }

          body =
            case method
            in :get | :head | :options | :trace
              nil
            else
              OpenAI::Internal::Util.deep_merge(*[req[:body], opts[:extra_body]].compact)
            end

          # Generated methods always pass `req[:body]` for operations that define a
          # request body, so only elide the content-type header when the operation
          # has no body at all, not when an optional body param was omitted.
          headers.delete("content-type") if body.nil? && !req.key?(:body)

          url = OpenAI::Internal::Util.join_parsed_uri(
            @base_url_components,
            {**req, path: path, query: query}
          )
          max_retries = opts.fetch(:max_retries, @max_retries)
          max_retries = 0 unless self.class.request_body_replayable?(body)
          {
            method: method,
            url: url,
            headers: headers,
            body: body,
            max_retries: max_retries,
            timeout: timeout
          }
        end

        # @api private
        private def request_replayable?(request)
          self.class.request_body_replayable?(request[:body])
        end

        # @api private
        #
        # @param headers [Hash{String=>String}]
        # @param retry_count [Integer]
        #
        # @return [Float]
        private def retry_delay(headers, retry_count:)
          # Non-standard extension
          span = Float(headers["retry-after-ms"], exception: false)&.then { _1 / 1000 }
          return span if span

          retry_header = headers["retry-after"]
          return span if (span = Float(retry_header, exception: false))

          span = retry_header&.then do
            Time.httpdate(_1) - Time.now
          rescue ArgumentError
            nil
          end
          return span if span

          scale = retry_count**2
          jitter = 1 - (0.25 * rand)
          (@initial_retry_delay * scale * jitter).clamp(0, @max_retry_delay)
        end

        # @api private
        private def raise_status_error!(url:, status:, headers:, response:, stream:)
          decoded = Kernel.then do
            OpenAI::Internal::Util.decode_content(headers, stream: stream, suppress_error: true)
          ensure
            self.class.reap_connection!(status, stream: stream)
          end

          raise OpenAI::Errors::APIStatusError.for(
            url: url,
            status: status,
            headers: headers,
            body: decoded,
            request: nil,
            response: response
          )
        end

        # @api private
        #
        # @param request [Hash{Symbol=>Object}] .
        #
        #   @option request [Symbol] :method
        #
        #   @option request [URI::Generic] :url
        #
        #   @option request [Hash{String=>String}] :headers
        #
        #   @option request [Object] :body
        #
        #   @option request [Integer] :max_retries
        #
        #   @option request [Float, nil] :timeout
        #
        # @param redirect_count [Integer]
        #
        # @param retry_count [Integer]
        #
        # @param send_retry_header [Boolean]
        #
        # @yieldreturn [OpenAI::Internal::Logging::Context]
        #
        # @raise [OpenAI::Errors::APIError]
        # @return [OpenAI::HTTPClient::Response]
        def send_request(request, redirect_count:, retry_count:, send_retry_header:, &context_provider)
          # Generated clients override this hook. A block keeps observability
          # state out of their stable keyword signature and is forwarded by
          # their existing `super` calls.
          log_context = context_provider.call
          if send_retry_header
            request = request.merge(
              headers: request.fetch(:headers).merge("x-stainless-retry-count" => retry_count.to_s)
            )
          end

          encoded_headers, encoded_body = OpenAI::Internal::Util.encode_content(
            request.fetch(:headers),
            request[:body]
          )
          attempt_request = request.merge(headers: encoded_headers, body: encoded_body)
          prepared_request = prepare_request(
            attempt_request,
            redirect_count: redirect_count,
            retry_count: retry_count
          )
          url, max_retries, timeout = prepared_request.fetch_values(:url, :max_retries, :timeout)
          input = OpenAI::HTTPClient::Request.new(
            method: prepared_request.fetch(:method),
            url: url,
            headers: prepared_request.fetch(:headers),
            body: prepared_request[:body],
            timeout: timeout
          )
          log_context.request_started(input, redirect_count: redirect_count)

          begin
            http_response = @requester.execute(input)
            unless http_response.is_a?(OpenAI::HTTPClient::Response)
              raise TypeError, "`http_client#execute` must return an OpenAI::HTTPClient::Response"
            end

            status = http_response.status
            headers = http_response.headers
            http_response = log_context.response_received(http_response)
            stream = http_response.body
          rescue OpenAI::Errors::APIConnectionError => e
            status = e
            stream = nil
            headers = {}
            log_context.attempt_failed(e)
          end

          terminal_status =
            case status
            in 300..399
              prepared_request[:follow_redirects] == false
            in (400..)
              retry_count >= max_retries || !self.class.should_retry?(status, headers: headers)
            else
              false
            end
          if terminal_status
            raise_status_error!(
              url: url,
              status: status,
              headers: headers,
              response: http_response,
              stream: stream
            )
          end

          case status
          in ..299
            http_response
          in 300..399 if redirect_count >= self.class::MAX_REDIRECTS
            self.class.reap_connection!(status, stream: stream)

            message = "Failed to complete the request within #{self.class::MAX_REDIRECTS} redirects."
            raise OpenAI::Errors::APIConnectionError.new(url: url, response: http_response, message: message)
          in 300..399
            self.class.reap_connection!(status, stream: stream)

            redirect_source = request.merge(url: prepared_request.fetch(:url))
            redirected_request = self.class.follow_redirect(
              redirect_source,
              status: status,
              response_headers: headers
            )
            send_request(
              redirected_request,
              redirect_count: redirect_count + 1,
              retry_count: retry_count,
              send_retry_header: send_retry_header,
              &context_provider
            )
          in OpenAI::Errors::APIConnectionError if retry_count >= max_retries
            raise status
          in (400..) | OpenAI::Errors::APIConnectionError
            self.class.reap_connection!(status, stream: stream)

            delay = retry_delay(headers, retry_count: retry_count)
            log_context.retry_scheduled(
              status,
              delay: delay,
              response: http_response&.metadata,
              retry_count: retry_count,
              max_retries: max_retries
            )
            sleep(delay)

            send_request(
              request,
              redirect_count: redirect_count,
              retry_count: retry_count + 1,
              send_retry_header: send_retry_header,
              &context_provider
            )
          end
        end

        # Execute the request specified by `req`. This is the method that all resource
        # methods call into.
        #
        # @overload request(method, path, query: {}, headers: {}, body: nil, unwrap: nil, page: nil, stream: nil, model: OpenAI::Internal::Type::Unknown, security: {bearer_auth: true, admin_api_key_auth: true}, options: {})
        #
        # @param method [Symbol]
        #
        # @param path [String, Array<String>]
        #
        # @param query [Hash{String=>Array<String>, String, nil}, nil]
        #
        # @param headers [Hash{String=>String, Integer, Array<String, Integer, nil>, nil}, nil]
        #
        # @param body [Object, nil]
        #
        # @param unwrap [Symbol, Integer, Array<Symbol, Integer>, Proc, nil]
        #
        # @param page [Class<OpenAI::Internal::Type::BasePage>, nil]
        #
        # @param stream [Class<OpenAI::Internal::Type::BaseStream>, nil]
        #
        # @param model [OpenAI::Internal::Type::Converter, Class, nil]
        #
        # @param security [Hash{Symbol=>Boolean}, nil]
        #
        # @param options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] .
        #
        #   @option options [String, nil] :idempotency_key
        #
        #   @option options [Hash{String=>Array<String>, String, nil}, nil] :extra_query
        #
        #   @option options [Hash{String=>String, nil}, nil] :extra_headers
        #
        #   @option options [Object, nil] :extra_body
        #
        #   @option options [Integer, nil] :max_retries
        #
        #   @option options [Float, nil] :timeout
        #
        # @raise [OpenAI::Errors::APIError]
        # @return [Object]
        def request(req)
          url, response, log_context = perform_request(req)
          finish_request(log_context, response) do
            parse_response(req, url: url, response: response)
          end
        end

        # @api private
        #
        # @param req [Hash{Symbol=>Object}]
        # @return [Array(URI::Generic, OpenAI::HTTPClient::Response, OpenAI::Internal::Logging::Context)]
        private def perform_request(req)
          self.class.validate!(req)
          opts = req[:options].to_h
          OpenAI::RequestOptions.validate!(opts)
          request = build_request(req.except(:options), opts)
          url = request.fetch(:url)
          log_context = OpenAI::Internal::Logging::Context.new(
            logger: @logger,
            log_level: @log_level,
            on_retry: @on_retry,
            method: request.fetch(:method),
            url: url
          )

          # Don't send the current retry count in the headers if the caller modified the header defaults.
          send_retry_header = request.fetch(:headers)["x-stainless-retry-count"] == "0"
          response = send_request(
            request,
            redirect_count: 0,
            retry_count: 0,
            send_retry_header: send_retry_header
          ) { log_context }
          [url, response, log_context]
        rescue StandardError => e
          log_context&.request_failed(e)
          raise
        end

        # @api private
        #
        # @param log_context [OpenAI::Internal::Logging::Context]
        # @param response [OpenAI::HTTPClient::Response]
        # @return [Object]
        private def finish_request(log_context, response)
          result = yield
          if result.is_a?(OpenAI::Internal::Type::BaseStream)
            return log_context.observe_stream(result, response: response)
          end

          log_context.completed(response)
          result
        rescue StandardError => e
          log_context.request_failed(e)
          raise
        end

        # @api private
        #
        # @param req [Hash{Symbol=>Object}]
        # @param url [URI::Generic]
        # @param response [OpenAI::HTTPClient::Response]
        # @return [Object]
        private def parse_response(req, url:, response:)
          model = req.fetch(:model) { OpenAI::Internal::Type::Unknown }
          unwrap = req[:unwrap]
          response_metadata = response.metadata

          decoded = OpenAI::Internal::Util.decode_content(response.headers, stream: response.body)
          case req
          in {stream: Class => st}
            st.new(
              model: model,
              url: url,
              response_metadata: response_metadata,
              response: response,
              unwrap: unwrap,
              stream: decoded
            )
          in {page: Class => page}
            page.new(client: self, req: req, response_metadata: response_metadata, page_data: decoded)
          else
            unwrapped = OpenAI::Internal::Util.dig(decoded, unwrap)
            OpenAI::Internal::Type::Converter.coerce(model, unwrapped).tap do |result|
              if result.is_a?(OpenAI::Internal::Type::BaseModel)
                result._set_last_response(response_metadata)
              end
            end
          end
        end

        # @api private
        #
        # @return [String]
        def inspect
          # rubocop:disable Layout/LineLength
          "#<#{self.class.name}:0x#{object_id.to_s(16)} base_url=#{@base_url} max_retries=#{@max_retries} timeout=#{@timeout}>"
          # rubocop:enable Layout/LineLength
        end

        define_sorbet_constant!(:RequestComponents) do
          T.type_alias do
            {
              method: Symbol,
              path: T.any(String, T::Array[String]),
              query: T.nilable(T::Hash[String, T.nilable(T.any(T::Array[String], String))]),
              headers: T.nilable(
                T::Hash[String,
                        T.nilable(
                          T.any(
                            String,
                            Integer,
                            T::Array[T.nilable(T.any(String, Integer))]
                          )
                        )]
              ),
              body: T.nilable(T.anything),
              unwrap: T.nilable(
                T.any(
                  Symbol,
                  Integer,
                  T::Array[T.any(Symbol, Integer)],
                  T.proc.params(arg0: T.anything).returns(T.anything)
                )
              ),
              page: T.nilable(T::Class[OpenAI::Internal::Type::BasePage[OpenAI::Internal::Type::BaseModel]]),
              stream: T.nilable(T::Class[OpenAI::Internal::Type::BaseStream[T.anything, OpenAI::Internal::Type::BaseModel]]),
              model: T.nilable(OpenAI::Internal::Type::Converter::Input),
              security: T.nilable({bearer_auth?: T::Boolean, admin_api_key_auth?: T::Boolean}),
              options: T.nilable(OpenAI::RequestOptions::OrHash)
            }
          end
        end
        define_sorbet_constant!(:RequestInput) do
          T.type_alias do
            {
              method: Symbol,
              url: URI::Generic,
              headers: T::Hash[String, String],
              body: T.anything,
              max_retries: Integer,
              timeout: T.nilable(Float)
            }
          end
        end
      end
    end
  end
end
