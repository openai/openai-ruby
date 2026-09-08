# frozen_string_literal: true

require "securerandom"
require "digest"

module OpenAI
  module Errors
    class RealtimeAudioSessionError < Error
    end

    class RealtimeAudioStateError < RealtimeAudioSessionError
    end

    class RealtimeAudioConsumerTooSlowError < RealtimeAudioSessionError
    end
  end

  module Errors
    class RealtimeAudioTurnError < RealtimeAudioSessionError
      attr_reader :event

      # @api private
      def initialize(event:)
        @event = event
        super("The server rejected this audio turn.")
      end
    end
  end

  module Realtime
    class AudioSession
      PlaybackStarted = Data.define(:response_id, :item_id, :content_index)
      PlaybackFinished = Data.define(:response_id, :item_id, :content_index, :position)
      PlaybackInterrupted = Data.define(:response_id, :item_id, :content_index, :position, :reason)
      InputStateChanged = Data.define(:capturing, :muted, :reason)
      Closed = Data.define(:reason)
      ItemPosition = Data.define(:response_id, :item_id, :content_index, :position)
      Interruption = Data.define(:items) do
        def initialize(items:) = super(items: items.dup.freeze)
      end

      class InputTurn
        # @api private
        def initialize(session)
          @session = session
        end

        def commit = @session.finish_turn(self, :commit)
        def discard = @session.finish_turn(self, :discard)
        def inspect = "#<OpenAI::Realtime::AudioSession::InputTurn>"
      end

      # @api private
      def initialize(resource:, configuration:, input_device:, output_device:, connection_options:)
        require "async"
        require "async/semaphore"

        @configuration = configuration
        @options = configuration.options
        @resource, @connection_options = resource, connection_options
        @input_device, @output_device = input_device, output_device
        @mutex = Mutex.new
        @changed = ConditionVariable.new
        @commands = Queue.new
        @notifications = Queue.new
        @events = []
        @state = :starting
        @responses = {}
        @items = {}
        @truncated = {}
        @created_items = {}
        @completed_cancels = {}
        @tool_calls = {}
        @tool_outputs = {}
        @commit_serial = @clear_serial = 0
        @input_frames = 0
        @muted = false
        @capture_gate = false
        @generation_epoch = 0
        @conversation_epoch = 0
        @response_generation = 0
        @capture = SizedQueue.new([(@options[:input_buffer_duration] / @options[:frame_duration]).ceil, 1].max)
        @runtime = Thread.new { run }
        @runtime.report_on_exception = false
        @mutex.synchronize do
          @changed.wait(@mutex) while @state == :starting && !@failure
          raise @failure if @failure
        end

        initialized = true
      ensure
        close if @runtime && !initialized
      end

      def start = invoke(:start)
      def mute = invoke(:mute)
      def unmute = invoke(:unmute)
      def interrupt
        @mutex.synchronize { @interrupt_requested = @response_generation }
        invoke(:interrupt)
      end

      def start_turn = invoke(:start_turn)
      def send_text(text) = invoke(:send_text, text)
      def submit_tool_output(call_id:, output:) = invoke(:submit_tool_output, call_id, output)
      def respond = invoke(:respond, @conversation_epoch)

      # @api private
      def finish_turn(turn, action) = invoke(:finish_turn, turn, action)

      def state = @mutex.synchronize { @state }
      def inspect = "#<OpenAI::Realtime::AudioSession state=#{state}>"

      def each
        return enum_for(:each) unless block_given?
        @mutex.synchronize do
          raise Errors::RealtimeAudioStateError, "Audio session already has a consumer." if @consumer
          @consumer = true
        end

        begin
          loop do
            event = @mutex.synchronize do
              @changed.wait(@mutex) while @events.empty? && !@failure && ![:closed, :failed].include?(@state)
              raise @failure if @failure
              @events.shift
            end

            break unless event
            yield event
          end

          self
        ensure
          close
          @mutex.synchronize { @consumer = false }
        end
      end

      def wait
        each { |_event| nil }
        nil
      end

      def close
        @mutex.synchronize do
          @closing = true
          @capture_gate = false
          @state = :closing unless [:closed, :failed].include?(@state)
          @changed.broadcast
        end

        @runtime.join unless @runtime == Thread.current
        nil
      end

      # @api private
      def raise_failure
        @mutex.synchronize { raise @failure if @failure }
        nil
      end

      private def invoke(operation, *arguments)
        result = Queue.new
        @mutex.synchronize do
          raise @failure if @failure
          raise Errors::RealtimeAudioStateError, "Audio session is closed." if @closing
          @commands << [operation, arguments, result]
        end

        loop do
          value = result.pop(true)
          raise value[1] if value[0] == :error
          return value[1]
        rescue ThreadError
          @mutex.synchronize do
            raise @failure if @failure
            raise Errors::RealtimeAudioStateError, "Audio session is closed." if @closing
            @changed.wait(@mutex, 0.01)
          end
        end
      end

      private def run
        Async do |task|
          @task = task
          @send_lock = Async::Semaphore.new(1)
          @resource.connect(**@connection_options, reconnect: false) do |connection|
            @connection = connection
            receiver = task.async { receive_events }
            begin
              send_wire(type: "session.update", session: @configuration.session)
              await { @configured }
              @mutex.synchronize {
                @state = :ready
                @changed.broadcast
              }
              dispatcher = task.async { dispatch }
              capture_pump = task.async do
                until closing?
                  drain_capture
                  task.sleep(0.005)
                end

              rescue StandardError => error
                fail_session(error)
              end

              begin
                until closing?
                  requested = @mutex.synchronize do
                    value = @interrupt_requested
                    @interrupt_requested = false
                    value
                  end

                  start_local_interruption if requested == @response_generation
                  drain_notifications
                  task.sleep(0.005)
                end

              ensure
                dispatcher.stop
                capture_pump.stop
              end

            ensure
              @mutex.synchronize { @capture_gate = false }
              # Native cleanup runs before socket teardown, independently of its writer.
              @microphone&.stop
              @output&.close
              @capture_thread&.join
              @abort_thread&.join(@options[:cleanup_timeout])
              @reconciliation_task&.stop
              receiver.stop
              connection.abort
            end
          end
        end
          .wait
      rescue StandardError => error
        fail_session(error)
      ensure
        @mutex.synchronize do
          @closing = true
          @state = @failure ? :failed : :closed
          @events << Closed.new(reason: @remote_closed ? :remote : :local) unless @failure
          @changed.broadcast
        end
      end

      private def dispatch
        until closing?
          entry = @commands.pop(true) rescue nil
          unless entry
            @task.sleep(0.005)
            next
          end

          operation, arguments, result = entry
          begin
            value = @task.with_timeout(@options[:control_timeout]) { control(operation, *arguments) }
            result << [:ok, value] if result
          rescue ArgumentError, Errors::RealtimeAudioStateError, Errors::RealtimeAudioTurnError => error
            result << [:error, error] if result
          rescue StandardError => error
            error = fail_session(error)
            result << [:error, error] if result
          ensure
            @mutex.synchronize { @changed.broadcast }
          end
        end
      end

      private def send_wire(**event)
        @send_lock.acquire do
          @task.with_timeout(@options[:control_timeout]) { @connection.send_event(event) }
        end
      end

      private def await
        @task.with_timeout(@options[:control_timeout]) do
          until yield
            raise_failure
            raise Errors::RealtimeAudioStateError, "Audio session closed during a control." if closing?
            @task.sleep(0.005)
          end
        end
      end

      private def background(cleanup: nil)
        result = Queue.new
        ownership = Mutex.new
        abandoned = false
        thread = Thread.new do
          value = yield
          discard = ownership.synchronize do
            if abandoned
              true
            else
              result << [:ok, value]
              false
            end
          end

          cleanup&.call(value) if discard
        rescue StandardError => error
          result << [:error, error]
        end

        thread.report_on_exception = false
        @task.sleep(0.005) while result.empty?
        status, value = result.pop
        claimed = true
        raise value if status == :error
        value
      ensure
        unless claimed
          ownership&.synchronize { abandoned = true }
          if result && !result.empty?
            status, value = result.pop
            cleanup&.call(value) if status == :ok
          end
        end

        thread&.join(@options[:cleanup_timeout])
      end

      private def closing? = @mutex.synchronize { @closing }

      private def fail_session(error)
        if error.is_a?(Async::TimeoutError)
          error = Errors::RealtimeAudioSessionError.new("A managed audio control timed out.")
        end

        @mutex.synchronize do
          @failure ||= error
          @closing = true
          @capture_gate = false
          @changed.broadcast
          @failure
        end
      end

      private def publish(event)
        @mutex.synchronize do
          capacity = @options[:event_queue_capacity]
          if capacity && @events.length >= capacity
            raise Errors::RealtimeAudioConsumerTooSlowError, "Audio session event consumer fell behind."
          end

          @events << event
          @changed.broadcast
        end
      end
    end
  end
end

require_relative "controls"
require_relative "events"
