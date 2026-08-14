# frozen_string_literal: true

module OpenAI
  module Internal
    # Uploads files for a vector store with bounded concurrency.
    #
    # The caller enumerates the input so lazy and stateful Ruby enumerables are never
    # advanced from worker threads. Results retain input order.
    #
    # @api private
    class VectorStoreFileUploader
      # @api private
      #
      # @param client [OpenAI::Client]
      # @param max_concurrency [Integer]
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      def initialize(client:, max_concurrency:, request_options:)
        unless max_concurrency.is_a?(Integer) && max_concurrency.positive?
          raise ArgumentError, "`max_concurrency` must be a positive integer"
        end

        @client = client
        @max_concurrency = max_concurrency
        @request_options = request_options
      end

      # @api private
      #
      # @param files [Enumerable<Pathname, StringIO, IO, String, OpenAI::FilePart>]
      # @return [Array<OpenAI::Models::FileObject>]
      def upload(files)
        queue = SizedQueue.new(@max_concurrency)
        finished = Object.new
        lock = Mutex.new
        uploaded = []
        state = {error: nil}
        workers = start_workers(queue, finished, lock, uploaded, state)

        begin
          files.each_with_index do |file, index|
            break unless lock.synchronize { state[:error].nil? }

            queue << [index, file]
          end
        rescue StandardError => e
          lock.synchronize { state[:error] ||= e }
        ensure
          workers.length.times { queue << finished }
        end

        workers.each(&:join)
        raise state[:error] unless state[:error].nil?

        uploaded
      end

      private def start_workers(queue, finished, lock, uploaded, state)
        workers = []
        begin
          @max_concurrency.times do
            workers << Thread.new do
              loop do
                work = queue.pop
                break if work.equal?(finished)
                next unless lock.synchronize { state[:error].nil? }

                begin
                  index, file = work
                  result = @client.files.create(
                    file: file,
                    purpose: :assistants,
                    request_options: @request_options
                  )
                  lock.synchronize { uploaded[index] = result }
                rescue StandardError => e
                  lock.synchronize { state[:error] ||= e }
                end
              end
            end.tap { _1.report_on_exception = false }
          end
          workers
        rescue ThreadError
          workers.length.times { queue << finished }
          workers.each(&:join)
          raise
        end
      end
    end
  end
end
