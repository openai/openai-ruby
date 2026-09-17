# frozen_string_literal: true

module OpenAI
  module Responses
    class SessionError < OpenAI::Errors::Error
      def cause = nil
    end

    class BufferError < SessionError
    end

    class StateLostError < SessionError
    end

    class RequestError < SessionError
      attr_reader :event

      # @api private
      def initialize(event)
        @event = event
        super("The Responses WebSocket request returned an error event.")
      end
    end

    # Explicit application budgets for an opt-in session, not service limits.
    # Bytes count serialized event data, not Ruby object or transport overhead.
    # max_lanes counts all registered IDs, including detached IDs, until reconnect.
    class SessionLimits
      attr_reader(
        :max_lanes,
        :max_events_per_lane,
        :max_events,
        :max_bytes_per_lane,
        :max_bytes,
        :max_response_bytes
      )

      def initialize(
        max_lanes:,
        max_events_per_lane:,
        max_events:,
        max_bytes_per_lane:,
        max_bytes:,
        max_response_bytes:
      )
        values = [max_lanes, max_events_per_lane, max_events, max_bytes_per_lane, max_bytes, max_response_bytes]
        unless values.all? { |value| value.is_a?(Integer) && value.positive? }
          raise ArgumentError, "Responses session limits must be positive integers."
        end

        @max_lanes, @max_events_per_lane, @max_events, @max_bytes_per_lane, @max_bytes, @max_response_bytes = values
        freeze
      end
    end

    # @api private
    class SessionAccumulator
      attr_reader :final_response, :error

      def initialize(limit)
        @limit = limit
        @bytes = 0
        @items = {}
        @state = OpenAI::Helpers::Streaming::ResponseStreamState.new(text_format: nil, starting_after: 0)
        @decoder = OpenAI::Helpers::Streaming::ResponseEventDecoder.new(model: OpenAI::Responses::ResponseStreamEvent)
      end

      def add(event, bytes)
        type = event.type.to_s
        if type == "response.created"
          @bytes = 0
          @items.clear
          @final_response = nil
          @error = nil
          @state = OpenAI::Helpers::Streaming::ResponseStreamState.new(text_format: nil, starting_after: 0)
        end

        if type == "error"
          @error = RequestError.new(event)
          clear
          return
        end

        return if @error
        unless %w[response.created response.output_item.done response.completed response.failed response.incomplete]
            .include?(type)
          return
        end

        @bytes += bytes
        raise BufferError, "Response collection exceeded max_response_bytes." if @bytes > @limit

        if type == "response.output_item.done"
          # Retain wire data independently of the mutable event returned by receive.
          completed_item = OpenAI::Internal::Type::BaseModel.recursively_to_h(event.item, convert: false)
          @items[event.output_index] = JSON.parse(JSON.generate(completed_item), symbolize_names: true)
        elsif %w[response.completed response.failed response.incomplete].include?(type)
          data = OpenAI::Internal::Type::BaseModel.recursively_to_h(event, convert: false)
          data = JSON.parse(JSON.generate(data), symbolize_names: true)
          response = data.fetch(:response)
          if response[:output].nil?
            response = response.merge(output: @items.sort.map { |_index, item| item.to_h })
            data = data.merge(response: response)
          end

          decoded = @decoder.decode(data)
          if type == "response.completed"
            @state.handle_event(decoded)
            @final_response = @state.completed_response
          else
            @final_response = decoded.response
          end

          clear
        else
          data = OpenAI::Internal::Type::BaseModel.recursively_to_h(event, convert: false)
          @state.handle_event(@decoder.decode(data))
        end

      rescue StandardError => error
        @error = error.is_a?(SessionError) ? error : SessionError.new("Could not collect the Responses final response.")
        clear
      end

      private def clear
        @state = nil
        @items.clear
        @bytes = 0
      end
    end

    # One routed consumer. Canceling its wait never cancels the socket reader.
    class SessionLane
      attr_reader :stream_id

      # @api private
      def initialize(session, stream_id, pending_steers)
        @session = session
        @stream_id = stream_id
        @queue = []
        @bytes = 0
        @closed = false
        @receiving = false
        @in_flight = false
        @pending_steers = pending_steers
        @response_id = nil
        @changed = Async::Condition.new
        @accumulator = SessionAccumulator.new(session.limits.max_response_bytes)
      end

      def send_event(event)
        @session.assert_owner!
        raise @detached_error if @detached_error
        raise SessionError, "The Responses lane is detached." if @closed

        data = @session.encode_client_event(event)
        type = data[:type]
        if type.to_s == "response.create"
          key = data.key?("stream_id") ? "stream_id" : :stream_id
          if data.key?(key) && data[key] != @stream_id
            raise ArgumentError, "The command stream_id does not match its lane."
          end

          data[key] = @stream_id unless @stream_id.nil?
          queued_response = @queue.any? do |queued_event, _bytes|
            queued_event.type.to_s == "response.created" && queued_event.to_h[:stream_id] == @stream_id
          end

          pending = @pending_steers[@response_id]
          if @in_flight || queued_response || (pending && pending[:count].positive?)
            raise SessionError, "Consume the current response before sending another create on this lane."
          end

          @accumulator = SessionAccumulator.new(@session.limits.max_response_bytes)
          @in_flight = true
        elsif type.to_s == "response.steer" &&
            (steer_parent = data[:previous_response_id]).is_a?(String) &&
            !steer_parent.empty?
          pending = (@pending_steers[steer_parent] ||= {count: 0, outcomes: {}})
          pending[:count] += 1
        end

        @session.send_event(data)
      rescue OpenAI::Errors::ResponsesClientEventError
        @in_flight = false if type.to_s == "response.create"
        if type.to_s == "response.steer" && pending
          pending[:count] -= 1
          @pending_steers.delete(steer_parent) if pending[:count].zero? && pending[:outcomes].empty?
        end

        raise
      end

      def receive
        @session.assert_owner!
        raise SessionError, "This Responses lane already has a consumer." if @receiving

        @receiving = true
        begin
          loop do
            raise @detached_error if @detached_error
            raise SessionError, "The Responses lane is detached." if @closed

            unless @queue.empty?
              event, bytes, raw_command_sent = @queue.shift
              @bytes -= bytes
              @session.consumed(bytes)
              if %w[response.steer.pending response.steer.failed].include?(event.type.to_s)
                parent = event.steer.previous_response_id
                pending = @pending_steers[parent]
                id = event.steer.id
                if pending
                  previously_pending = pending[:outcomes].delete(id)
                  if event.type.to_s == "response.steer.pending" && !id.nil?
                    pending[:outcomes][id] = true
                  end

                  unless previously_pending
                    pending[:count] -= 1
                  end

                  @pending_steers.delete(parent) if pending[:count].zero? && pending[:outcomes].empty?
                end
              end
              # Unregistered named streams remain available for raw inspection,
              # without changing the default lane's response state.
              if event.to_h[:stream_id] == @stream_id
                # Prior raw commands leave generic errors uncorrelated. Use the
                # receipt-time snapshot, so later commands cannot change attribution.
                if event.type.to_s == "error" &&
                    @stream_id.nil? &&
                    @in_flight &&
                    event.to_h[:sequence_number].nil? &&
                    raw_command_sent
                  discard(RequestError.new(event))
                  @session.detach(self)
                  return event
                end

                @accumulator.add(event, bytes)
                if event.type.to_s == "response.created"
                  @in_flight = true
                  @pending_steers.delete(@response_id) if @response_id != event.response.id
                  @response_id = event.response.id.dup.freeze
                elsif %w[response.completed response.failed response.incomplete error].include?(event.type.to_s)
                  @in_flight = false
                  @response_id = event.response.id.dup.freeze unless event.type.to_s == "error"
                end
              end

              return event
            end

            @session.check_reader!
            @changed.wait
          end

        ensure
          @receiving = false
        end
      end

      def get_final_response
        @session.assert_owner!
        loop do
          raise @accumulator.error if @accumulator.error
          if (response = @accumulator.final_response)
            @accumulator = SessionAccumulator.new(@session.limits.max_response_bytes)
            return response
          end

          receive
        end
      end

      def close
        @session.assert_owner!
        @session.detach(self)
        nil
      end

      # @api private
      def enqueue(event, bytes, raw_command_sent = false)
        return if @closed

        limits = @session.limits
        if @queue.length >= limits.max_events_per_lane || @bytes + bytes > limits.max_bytes_per_lane
          raise BufferError, "The Responses lane exceeded its buffered event budget."
        end

        @queue << [event, bytes, raw_command_sent]
        @bytes += bytes
        @changed.signal
        true
      end

      # @api private
      def discard(error = nil)
        return if @closed

        @closed = true
        @detached_error = error
        @queue.each { |_event, bytes| @session.consumed(bytes) }
        @queue.clear
        @bytes = 0
        @accumulator = SessionAccumulator.new(@session.limits.max_response_bytes)
        @changed.signal
      end

      # @api private
      def wake = @changed.signal
    end

    # Owns one connection and one Async reader. Use only its lanes to receive.
    class Session
      attr_reader :limits, :default

      def self.open(
        client:,
        limits:,
        request_options: nil,
        websocket_base_url: nil,
        transport: nil,
        transport_options: {}
      )
        raise ArgumentError, "A block is required to open a Responses session." unless block_given?

        begin
          require "async"
          require "async/queue"
          require "async/condition"

        rescue LoadError
          raise OpenAI::Errors::Error, "Responses sessions require the async gem.", cause: nil
        end

        Sync do |task|
          session = new(
            task: task,
            client: client,
            limits: limits,
            request_options: request_options,
            websocket_base_url: websocket_base_url,
            transport: transport,
            transport_options: transport_options
          )
          begin
            session.start
            yield(session)
          ensure
            pending_error = $ERROR_INFO
            begin
              session.close
            rescue StandardError
              raise if pending_error.nil?
            end
          end
        end
      end

      # @api private
      def initialize(task:, client:, limits:, request_options:, websocket_base_url:, transport:, transport_options:)
        @task = task
        @client = client
        @limits = limits
        @request_options = request_options
        @websocket_base_url = websocket_base_url
        @transport = transport
        @transport_options = transport_options
        @owner = Thread.current
        @lanes = {}
        @lane_ids = {}
        # Steering targets a response ID, independently of the lane sending the command.
        @pending_steers = {}
        @events = 0
        @bytes = 0
        @closed = false
        @default = lane(nil)
      end

      def lane(stream_id)
        assert_owner!
        raise SessionError, "The Responses session is closed." if @closed

        unless stream_id.nil? || (stream_id.is_a?(String) && /\A[A-Za-z0-9_.-]{1,256}\z/.match?(stream_id))
          raise ArgumentError, "Invalid Responses WebSocket stream ID."
        end

        stream_id = stream_id&.dup&.freeze
        raise ArgumentError, "The Responses lane is already registered." if @lane_ids.key?(stream_id)
        raise BufferError, "The Responses session exceeded max_lanes." if @lane_ids.length >= @limits.max_lanes

        value = SessionLane.new(self, stream_id, @pending_steers)
        @lane_ids[stream_id] = true
        @lanes[stream_id] = value
      end

      # Replace the transport explicitly; old lane state is lost, never replayed.
      # The restore callback registers new lanes and supplies application state.
      def reconnect(restore:, client: @client, request_options: @request_options)
        assert_owner!
        raise SessionError, "The Responses session is closed." if @closed
        raise SessionError, "The Responses session is already reconnecting." if @reconnecting

        @reconnecting = true
        restored = false
        begin
          @lanes.each_value { |value|
            value.discard(
              StateLostError.new("The Responses connection was replaced; restore application state explicitly.")
            )
          }
          stop_reader
          @lanes.clear
          @lane_ids.clear
          @pending_steers.clear
          @default = lane(nil)
          @client = client
          @request_options = request_options
          start
          restore.call(self)
          restored = true
          self
        ensure
          close unless restored
          @reconnecting = false
        end
      end

      def close
        assert_owner!
        return if @closed

        @closed = true
        stop_reader
        @lanes.each_value(&:discard)
        @lanes.clear
        @lane_ids.clear
        @pending_steers.clear
        nil
      end

      # @api private
      def start
        @ended = false
        @error = nil
        @raw_command_sent = false
        generation = @generation = Object.new
        ready = Async::Queue.new
        opened = false
        @reader = @task.async do
          begin
            @client
              .responses
              .connect(
                request_options: @request_options,
                websocket_base_url: @websocket_base_url,
                transport: @transport,
                transport_options: @transport_options
              ) do |connection|
                @connection = connection
                opened = true
                ready.enqueue(true)
                connection.each { |event| dispatch(event) }
              end

          rescue StandardError => error
            @error = error if @generation.equal?(generation)
          ensure
            @ended = true if @generation.equal?(generation)
            ready.enqueue(false) unless opened
            @lanes.each_value(&:wake)
          end
        end

        raise @error || SessionError.new("The Responses connection did not open.") unless ready.dequeue
        nil
      end

      # @api private
      def encode_client_event(event)
        assert_owner!
        @connection.encode_client_event(event)
      end

      # @api private
      def send_event(event)
        assert_owner!
        check_reader!
        prior_raw_command_sent = @raw_command_sent
        @raw_command_sent = true unless event[:type].to_s == "response.create"
        @connection.send_event(event)
      rescue OpenAI::Errors::ResponsesClientEventError
        @raw_command_sent = prior_raw_command_sent
        raise
      rescue OpenAI::Errors::ResponsesSendError => error
        @error = error
        stop_reader
        raise
      end

      # @api private
      def check_reader!
        raise @error if @error
        raise SessionError, "The Responses connection closed before another event arrived." if @closed || @ended
      end

      # @api private
      def assert_owner!
        raise SessionError, "Responses sessions are single-thread owned." unless Thread.current.equal?(@owner)
      end

      # @api private
      def consumed(bytes)
        @events -= 1
        @bytes -= bytes
      end

      # @api private
      def detach(value)
        @lanes.delete(value.stream_id) if @lanes[value.stream_id].equal?(value)
        value.discard
      end

      private def dispatch(event)
        data = event.to_h
        value = @lanes.fetch(data[:stream_id], @lanes[nil])
        return unless value

        bytes = JSON.generate(data).bytesize
        if @events >= @limits.max_events || @bytes + bytes > @limits.max_bytes
          raise BufferError, "The Responses session exceeded its buffered event budget."
        end

        @events += 1
        @bytes += bytes
        begin
          consumed(bytes) unless value.enqueue(event, bytes, @raw_command_sent)
        rescue StandardError
          consumed(bytes)
          raise
        end
      end

      private def stop_reader
        @reader&.stop
        @reader&.wait
      end
    end
  end
end
