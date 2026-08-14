# frozen_string_literal: true

module OpenAI
  module Internal
    # Shared polling behavior for long-running API resources.
    #
    # @api private
    class Poller
      DEFAULT_INTERVAL = 5.0
      DEFAULT_TIMEOUT = 30 * 60.0

      # @api private
      #
      # @param operation [String]
      # @param poll_interval [Integer, Float, nil]
      # @param timeout [Integer, Float, nil]
      def initialize(operation:, poll_interval: nil, timeout: DEFAULT_TIMEOUT)
        @operation = operation
        @poll_interval, @timeout = self.class.validate!(poll_interval: poll_interval, timeout: timeout)
        @deadline = monotonic_time + @timeout unless @timeout.nil?
      end

      # Validate polling configuration without starting the deadline used by the
      # eventual polling operation.
      #
      # Composite helpers call this before making any API requests so invalid local
      # arguments cannot leave partially-created remote resources behind.
      #
      # @api private
      #
      # @param poll_interval [Integer, Float, nil]
      # @param timeout [Integer, Float, nil]
      # @return [Array(Float, nil)] the normalized poll interval and timeout
      def self.validate!(poll_interval: nil, timeout: DEFAULT_TIMEOUT)
        [
          duration(poll_interval, name: :poll_interval, allow_zero: false),
          duration(timeout, name: :timeout, allow_zero: true)
        ]
      end

      # Add polling headers without discarding caller-supplied request options.
      #
      # @api private
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      # @param extra_headers [Hash{String=>String, nil}] endpoint headers to preserve
      # @param resource [Object, nil] the last resource returned by the API
      # @return [Hash{Symbol=>Object}]
      def request_options(request_options, extra_headers: {}, resource: nil)
        remaining = check_deadline!(resource)
        options = request_options.to_h
        headers = OpenAI::Internal::Util.normalized_headers(
          extra_headers,
          options[:extra_headers].to_h,
          {"X-Stainless-Poll-Helper" => "true"}
        )
        unless @poll_interval.nil?
          milliseconds = [(@poll_interval * 1000).round, 1].max
          headers["x-stainless-custom-poll-interval"] = milliseconds.to_s
        end

        bounded = {**options, extra_headers: headers}
        unless remaining.nil?
          request_timeout = options[:timeout]
          request_timeout = request_timeout.to_f.clamp(0..) unless request_timeout.nil?
          bounded[:timeout] = [request_timeout, remaining].compact.min
        end
        bounded
      end

      # Raise when the overall polling deadline has elapsed and otherwise return
      # the time remaining. Resource helpers also call this after request timeouts
      # to distinguish an exhausted polling deadline from a shorter caller timeout.
      #
      # @api private
      #
      # @param resource [Object, nil] the last resource returned by the API
      # @return [Float, nil]
      def check_deadline!(resource = nil)
        remaining = @deadline - monotonic_time unless @deadline.nil?
        raise_timeout(resource) if !remaining.nil? && remaining <= 0

        remaining
      end

      # Sleep until the next request, respecting both the server's polling hint and
      # the overall polling deadline.
      #
      # @api private
      #
      # @param resource [OpenAI::Internal::Type::BaseModel]
      # @return [void]
      def wait(resource)
        remaining = check_deadline!(resource)

        interval = @poll_interval || server_interval(resource) || DEFAULT_INTERVAL
        if !remaining.nil? && interval >= remaining
          sleep(remaining)
          raise_timeout(resource)
        end

        sleep(interval)
      end

      private def raise_timeout(resource)
        raise OpenAI::Errors::PollingTimeoutError.new(
          operation: @operation,
          timeout: @timeout,
          resource: resource
        )
      end

      private_class_method def self.duration(value, name:, allow_zero:)
        return if value.nil?

        unless value.is_a?(Integer) || value.is_a?(Float)
          return invalid_duration!(name: name, allow_zero: allow_zero)
        end

        duration = value.to_f
        valid = duration.finite? && (allow_zero ? duration >= 0 : duration.positive?)
        return duration if valid

        invalid_duration!(name: name, allow_zero: allow_zero)
      end

      private_class_method def self.invalid_duration!(name:, allow_zero:)
        qualifier = allow_zero ? "non-negative" : "positive"
        raise ArgumentError, "`#{name}` must be a #{qualifier} number of seconds or nil"
      end

      private def monotonic_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)

      private def server_interval(resource)
        value = resource.last_response&.headers&.[]("openai-poll-after-ms")
        return if value.nil?

        interval = Float(value) / 1000
        interval if interval.finite? && interval.positive?
      rescue ArgumentError, TypeError
        nil
      end
    end
  end
end
