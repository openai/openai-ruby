# frozen_string_literal: true

require "tempfile"

module OpenAI
  module Internal
    # Uploads files for a vector store with bounded concurrency.
    #
    # The caller enumerates and snapshots stream-backed inputs before workers start,
    # so lazy and stateful Ruby enumerables are never advanced from worker threads.
    # Originally streamed inputs are reopened as streams for `files.create`, retaining
    # its non-retryable request semantics. Results retain input order.
    #
    # @api private
    class VectorStoreFileUploader
      StagedFile = Data.define(:file, :streamed)
      private_constant :StagedFile

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
        @request_options = OpenAI::Internal::RequestOptionsScope.new(request_options)
      end

      # @api private
      #
      # @param files [Enumerable<Pathname, StringIO, IO, String, OpenAI::FilePart>]
      # @param max_files [Integer] Maximum number of inputs that may be uploaded.
      # @return [Array<OpenAI::Models::FileObject>]
      def upload(files, max_files: MAX_FILES_PER_BATCH)
        staged, temporary_files = stage(files, max_files: max_files)
        return [] if staged.empty?

        worker_count = [@max_concurrency, staged.length].min
        start_gate = Queue.new
        lock = Mutex.new
        uploaded = []
        state = {error: nil, next_index: 0, stopping: false}
        workers = []

        Thread.handle_interrupt(Exception => :never) do
          start_workers(start_gate, staged, worker_count, lock, uploaded, state, workers)
          Thread.handle_interrupt(Exception => :immediate) do
            start_gate.close
            workers.each(&:join)
          end
        ensure
          stop_workers(start_gate, workers, lock, state)
        end

        error = lock.synchronize { state[:error] }
        raise error unless error.nil?

        uploaded
      ensure
        temporary_files&.each { remove_temporary_file(_1) }
      end

      private def stage(files, max_files:)
        unless max_files.is_a?(Integer) && max_files >= 0
          raise ArgumentError, "`max_files` must be a non-negative integer"
        end

        staged = []
        temporary_files = []
        complete = false
        begin
          files.each do |file|
            if staged.length >= max_files
              raise ArgumentError, "`files` exceeds the remaining vector store batch capacity of #{max_files}"
            end

            staged << stage_file(file, temporary_files)
          end
          complete = true
          [staged, temporary_files]
        ensure
          temporary_files.each { remove_temporary_file(_1) } unless complete
        end
      end

      private def stage_file(file, temporary_files)
        if file.is_a?(Pathname) || (file.is_a?(OpenAI::FilePart) && file.content.is_a?(Pathname))
          return StagedFile.new(file: file, streamed: false)
        end

        case file
        in OpenAI::FilePart
          path = spool(file.content, temporary_files)
          StagedFile.new(file: file.with_content(path), streamed: file.content.is_a?(IO))
        in String
          path = spool(file, temporary_files)
          part = OpenAI::FilePart.new(path, filename: "upload", content_type: "text/plain")
          StagedFile.new(file: part, streamed: false)
        in StringIO
          path = spool(file, temporary_files)
          part = OpenAI::FilePart.new(path, filename: "upload", content_type: "application/octet-stream")
          StagedFile.new(file: part, streamed: false)
        in IO
          filename = file.to_path.nil? ? "upload" : ::File.basename(file.to_path)
          path = spool(file, temporary_files)
          part = OpenAI::FilePart.new(path, filename: filename, content_type: "application/octet-stream")
          StagedFile.new(file: part, streamed: true)
        else
          raise ArgumentError, "`files` contains an unsupported file input"
        end
      end

      private def spool(content, temporary_files)
        temporary_file = Tempfile.new("openai-vector-store-upload")
        temporary_file.binmode
        if (content.is_a?(IO) || content.is_a?(StringIO)) && content.closed?
          raise ArgumentError, "IO inputs yielded by `files` must be open while they are enumerated"
        end

        complete = false
        case content
        in StringIO
          temporary_file.write(content.string)
        in String
          temporary_file.write(content)
        in IO
          IO.copy_stream(content, temporary_file)
        else
          raise ArgumentError, "`files` contains an unsupported file input"
        end

        temporary_file.close
        temporary_files << temporary_file
        complete = true
        Pathname(temporary_file.path)
      ensure
        temporary_file&.close! unless complete
      end

      private def remove_temporary_file(temporary_file)
        temporary_file.close!
      rescue StandardError
        nil
      end

      private def start_workers(start_gate, staged, worker_count, lock, uploaded, state, workers)
        worker_count.times do
          workers << Thread.new do
            Thread.handle_interrupt(Exception => :immediate) do
              start_gate.pop
              while (work = claim_work(staged, lock, state))
                upload_one(work, lock, uploaded)
              end
            end
          rescue Exception => e # rubocop:disable Lint/RescueException -- worker failure is propagated after every join
            record_error(e, lock, state)
          end.tap { _1.report_on_exception = false }
        end
      end

      private def upload_one(work, lock, uploaded)
        index, staged_file = work
        result =
          if staged_file.streamed
            ::File.open(staged_file.file.content, "rb") do |stream|
              create_file(staged_file.file.with_content(stream), index)
            end
          else
            create_file(staged_file.file, index)
          end
        lock.synchronize { uploaded[index] = result }
      end

      private def create_file(file, index)
        @client.files.create(
          file: file,
          purpose: :assistants,
          request_options: @request_options.child("file-upload-#{index}")
        )
      end

      private def claim_work(staged, lock, state)
        lock.synchronize do
          return if state[:stopping] || !state[:error].nil?

          index = state[:next_index]
          return if index >= staged.length

          state[:next_index] = index + 1
          [index, staged.fetch(index)]
        end
      end

      private def record_error(error, lock, state)
        lock.synchronize do
          state[:error] ||= error
          state[:stopping] = true
        end
      end

      private def stop_workers(start_gate, workers, lock, state)
        lock.synchronize { state[:stopping] = true }
        start_gate.close
        workers.each(&:join)
      end
    end
  end
end
