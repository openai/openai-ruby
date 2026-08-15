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
      # The API limit for files attached in one vector store batch.
      #
      # @api private
      MAX_FILES_PER_BATCH = 2_000

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
      # @param max_files [Integer] Maximum number of inputs that may be uploaded.
      # @return [Array<OpenAI::Models::FileObject>]
      def upload(files, max_files: MAX_FILES_PER_BATCH)
        staged = stage(files, max_files: max_files)
        return [] if staged.empty?

        queue = Queue.new
        staged.each_with_index { |file, index| queue << [index, file] }
        queue.close

        lock = Mutex.new
        uploaded = []
        state = {error: nil, stopping: false}
        workers = []

        Thread.handle_interrupt(Exception => :never) do
          workers = start_workers(queue, [@max_concurrency, staged.length].min, lock, uploaded, state)

          begin
            Thread.handle_interrupt(Exception => :immediate) { workers.each(&:join) }
          ensure
            stop_workers(workers, lock, state)
          end
        end

        error = lock.synchronize { state[:error] }
        raise error unless error.nil?

        uploaded
      end

      private def stage(files, max_files:)
        unless max_files.is_a?(Integer) && max_files >= 0
          raise ArgumentError, "`max_files` must be a non-negative integer"
        end

        staged = files.each_with_object([]) do |file, result|
          if result.length >= max_files
            raise ArgumentError, "`files` exceeds the remaining vector store batch capacity of #{max_files}"
          end

          result << file
        end

        staged.each { validate_open!(_1) }
        staged
      end

      private def validate_open!(file)
        content = file.is_a?(OpenAI::FilePart) ? file.content : file
        return unless (content.is_a?(IO) || content.is_a?(StringIO)) && content.closed?

        raise ArgumentError, "IO inputs yielded by `files` must remain open until `upload_and_poll` returns"
      end

      private def start_workers(queue, worker_count, lock, uploaded, state)
        workers = []
        begin
          worker_count.times do
            workers << Thread.new do
              while (work = queue.pop)
                next if lock.synchronize { state[:stopping] || !state[:error].nil? }

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
          stop_workers(workers, lock, state)
          raise
        end
      end

      private def stop_workers(workers, lock, state)
        lock.synchronize { state[:stopping] = true }
        workers.each(&:join)
      end
    end
  end
end
