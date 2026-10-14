# frozen_string_literal: true

require_relative "../test_helper"
require "objspace"
require "tempfile"
require "timeout"

class OpenAI::Test::VectorStoreFileUploaderTest < Minitest::Test
  extend Minitest::Serial

  UploadedFile = Data.define(:id)
  UploadError = Class.new(StandardError)

  class FilesResource
    attr_reader :calls, :contents

    def initialize(capture_contents: true, &handler)
      @handler = handler ||
        lambda do |file|
          UploadedFile.new("uploaded_#{OpenAI::Test::VectorStoreFileUploaderTest.file_contents(file)}")
        end
      @capture_contents = capture_contents
      @calls = []
      @contents = []
      @lock = Mutex.new
    end

    def create(file:, purpose:, request_options:)
      contents = OpenAI::Test::VectorStoreFileUploaderTest.file_contents(file) if @capture_contents
      @lock.synchronize do
        @calls << {file: file, purpose: purpose, request_options: request_options}
        @contents << contents if @capture_contents
      end

      @handler.call(file)
    end
  end

  Client = Data.define(:files)

  def test_upload_reuses_capacity_and_preserves_input_order
    slow_started = Queue.new
    release_slow = Queue.new
    third_started = Queue.new
    resource = FilesResource.new do |file|
      contents = self.class.file_contents(file)
      case contents
      when "slow"
        slow_started << true
        release_slow.pop
      when "third"
        third_started << true
      end

      UploadedFile.new("uploaded_#{contents}")
    end

    runner = Thread.new { uploader(resource, max_concurrency: 2).upload(%w[slow second third]) }
    runner.report_on_exception = false

    begin
      Timeout.timeout(1) { slow_started.pop }
      assert(Timeout.timeout(1) { third_started.pop })
    ensure
      release_slow << true
    end

    assert_equal(%w[uploaded_slow uploaded_second uploaded_third], runner.value.map(&:id))
    assert_equal(%w[slow second third].sort, resource.contents.sort)
  end

  def test_upload_cleans_up_after_worker_start_failure
    resource = FilesResource.new { flunk("upload should not be called") }
    original_thread_new = Thread.method(:new)
    calls = 0
    thread_factory = lambda do |*args, &_block|
      calls += 1
      raise ThreadError, "thread limit reached" if calls == 2

      original_thread_new.call(*args) { Thread.pass }
    end

    error = Thread.stub(:new, thread_factory) do
      assert_raises(ThreadError) { uploader(resource, max_concurrency: 2).upload(%w[one two]) }
    end

    assert_equal("thread limit reached", error.message)
    assert_empty(resource.calls)
  end

  def test_upload_defers_cancellation_until_workers_stop
    first_started = Queue.new
    release_first = Queue.new
    resource = FilesResource.new do |file|
      if self.class.file_contents(file) == "one"
        first_started << true
        release_first.pop
      end

      UploadedFile.new("uploaded_#{file}")
    end

    outcome = Queue.new
    runner = Thread.new do
      Timeout.timeout(0.05) { uploader(resource).upload(%w[one two]) }
      outcome << [:returned, nil]
    rescue StandardError => e
      outcome << [:raised, e]
    end

    runner.report_on_exception = false

    begin
      Timeout.timeout(1) { first_started.pop }
      sleep(0.1)
      assert_predicate(runner, :alive?, "cancellation escaped before the upload worker stopped")
    ensure
      release_first << true
    end

    status, error = Timeout.timeout(1) { outcome.pop }
    runner.join
    assert_equal(:raised, status)
    assert_instance_of(Timeout::Error, error)
    assert_equal(["one"], resource.contents)
    refute_predicate(runner, :alive?)
  end

  def test_upload_workers_honor_async_timeouts
    resource = FilesResource.new do |file|
      Timeout.timeout(0.02) { sleep(0.2) }
      UploadedFile.new("uploaded_#{file}")
    end

    started_at = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    assert_raises(Timeout::Error) { uploader(resource).upload(["one"]) }

    elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - started_at
    assert_operator(elapsed, :<, 0.15)
  end

  def test_upload_joins_every_worker_before_reraising_a_fatal_error
    first_claimed = Queue.new
    second_finished = Queue.new
    resource = FilesResource.new do |file|
      case self.class.file_contents(file)
      when "one"
        first_claimed << true
        sleep(0.02)
        raise NotImplementedError, "fatal upload failure"
      when "two"
        sleep(0.1)
        second_finished << true
      end

      UploadedFile.new("uploaded_#{file}")
    end

    original_thread_new = Thread.method(:new)
    calls = 0
    thread_factory = lambda do |*args, &block|
      calls += 1
      if calls == 2
        original_thread_new.call(*args) do
          first_claimed.pop
          block.call
        end
      else
        original_thread_new.call(*args, &block)
      end
    end

    error = Thread.stub(:new, thread_factory) do
      assert_raises(NotImplementedError) do
        uploader(resource, max_concurrency: 2).upload(%w[one two])
      end
    end

    assert_equal("fatal upload failure", error.message)
    assert_equal(true, second_finished.pop(true), "upload returned while a worker was still running")
  end

  def test_caller_cancellation_is_not_replaced_by_a_worker_error
    second_started = Queue.new
    resource = FilesResource.new do |file|
      case self.class.file_contents(file)
      when "one"
        second_started.pop
        raise UploadError, "upload failed"
      when "two"
        second_started << true
        sleep(0.1)
      end

      UploadedFile.new("uploaded")
    end

    error = assert_raises(Timeout::Error) do
      Timeout.timeout(0.03) { uploader(resource, max_concurrency: 2).upload(%w[one two]) }
    end

    assert_equal("execution expired", error.message)
    assert_equal(%w[one two].sort, resource.contents.sort)
  end

  def test_upload_spools_lazy_in_memory_bodies_before_staging_them
    file_count = 16
    body_size = 1024 * 1024
    first_upload = Queue.new
    release_uploads = Queue.new
    staged_paths = []
    lock = Mutex.new
    resource = FilesResource.new(capture_contents: false) do |file|
      path = file.content if file.is_a?(OpenAI::FilePart) && file.content.is_a?(Pathname)
      first = lock.synchronize do
        staged_paths << path
        staged_paths.length == 1
      end

      first_upload << true if first
      release_uploads.pop
      UploadedFile.new("uploaded")
    end

    files = Enumerator.new do |yielder|
      file_count.times { yielder << ("x" * body_size) }
    end

    GC.start
    baseline = ObjectSpace.memsize_of_all(String)
    runner = Thread.new { uploader(resource, max_concurrency: 2).upload(files) }
    runner.report_on_exception = false

    Timeout.timeout(3) { first_upload.pop }
    GC.start
    retained = ObjectSpace.memsize_of_all(String) - baseline
    assert_operator(retained, :<, body_size * 4)
    assert(staged_paths.compact.all?(&:file?))
  ensure
    file_count&.times { release_uploads << true }
    runner&.join
    staged_paths&.compact&.each { refute_predicate(_1, :exist?) }
  end

  def test_upload_spools_streams_without_changing_content_or_multipart_metadata
    tempfile = Tempfile.new(["source", ".txt"])
    tempfile.binmode
    tempfile.write("prefix-file-body")
    tempfile.flush
    source_file = File.open(tempfile.path, "rb")
    source_file.read(7)
    part_source_file = File.open(tempfile.path, "rb")
    part_source_file.read(7)
    pipe_reader, pipe_writer = IO.pipe
    pipe_writer.write("pipe-body")
    pipe_writer.close
    pathname = Pathname(tempfile.path)
    string_io = StringIO.new("string-io-body").tap { _1.seek(5) }
    custom_part = OpenAI::FilePart.new(
      "custom-body",
      filename: "nested/custom.txt",
      content_type: "text/custom; charset=UTF-8; name=\"custom; file.txt\""
    )
    unnamed_part = OpenAI::FilePart.new("unnamed-body")
    file_part = OpenAI::FilePart.new(part_source_file)
    observed = []
    resource = FilesResource.new(capture_contents: false) do |file|
      observed << [file, self.class.file_contents(file)]
      UploadedFile.new("uploaded")
    end

    uploader(resource).upload(
      [
        "string-body",
        string_io,
        source_file,
        pipe_reader,
        custom_part,
        unnamed_part,
        file_part,
        pathname
      ]
    )

    string, io_string, io, pathless_io, part, unnamed, io_part, path = observed
    assert_equal(["upload", "text/plain", "string-body"], metadata_and_contents(string))
    assert_equal(
      ["upload", "application/octet-stream", "g-io-body"],
      metadata_and_contents(io_string)
    )
    assert_equal(5, string_io.pos)
    refute_predicate(string_io, :closed?)
    assert_equal(
      [File.basename(tempfile.path), "application/octet-stream", "file-body"],
      metadata_and_contents(io)
    )
    assert_equal(
      ["upload", "application/octet-stream", "pipe-body"],
      metadata_and_contents(pathless_io)
    )
    assert_equal(
      ["custom.txt", "text/custom; charset=UTF-8; name=\"custom; file.txt\"", "custom-body"],
      metadata_and_contents(part)
    )
    assert_equal([nil, "text/plain", "unnamed-body"], metadata_and_contents(unnamed))
    assert_equal(
      [File.basename(part_source_file.to_path), "application/octet-stream", "file-body"],
      metadata_and_contents(io_part)
    )
    assert_same(pathname, path.fetch(0))
    assert_equal("prefix-file-body", path.fetch(1))
  ensure
    pipe_reader&.close
    pipe_writer&.close unless pipe_writer&.closed?
    source_file&.close
    part_source_file&.close
    tempfile&.close!
  end

  def test_upload_stages_string_io_from_its_byte_cursor_without_consuming_it
    prefix = "π-prefix|".b
    payload = "payload-\x00\xFF".b
    bare = StringIO.new(prefix + payload).tap { _1.seek(prefix.bytesize) }
    wrapped = StringIO.new(prefix + payload).tap { _1.seek(prefix.bytesize) }
    eof = StringIO.new("complete").tap { _1.seek(_1.size) }
    beyond_eof = StringIO.new("complete").tap { _1.seek(_1.size + 4) }
    resource = FilesResource.new

    2.times do
      uploader(resource).upload(
        [
          bare,
          OpenAI::FilePart.new(wrapped, filename: "payload.bin", content_type: "application/custom"),
          eof,
          beyond_eof
        ]
      )
    end

    assert_equal([payload, payload, "", "", payload, payload, "", ""], resource.contents)
    assert_equal(prefix.bytesize, bare.pos)
    assert_equal(prefix.bytesize, wrapped.pos)
    assert_equal(eof.size, eof.pos)
    assert_equal(beyond_eof.size + 4, beyond_eof.pos)
    [bare, wrapped, eof, beyond_eof].each { refute_predicate(_1, :closed?) }
    wrapped_file = resource.calls.fetch(1).fetch(:file)
    assert_equal("payload.bin", wrapped_file.filename)
    assert_equal("application/custom", wrapped_file.content_type)
  end

  def test_staged_file_part_io_upload_omits_absolute_local_path
    bodies = []
    staged_paths = []
    resource = FilesResource.new(capture_contents: false) do |file|
      staged_paths << file.content.to_path
      _headers, stream = OpenAI::Internal::Util.encode_content(
        {"content-type" => "multipart/form-data"},
        {file: file}
      )
      bodies << stream.to_a.join
      UploadedFile.new("uploaded")
    end

    Tempfile.create(["upload-", ".txt"]) do |content|
      content.write("upload-body")
      content.rewind
      local_path = content.to_path
      uploader(resource).upload([OpenAI::FilePart.new(content)])

      body = bodies.fetch(0)
      assert_includes(body, "filename=\"#{File.basename(local_path)}\"")
      refute_includes(body, local_path)
      refute_predicate(content, :closed?)
      refute_path_exists(staged_paths.fetch(0))
    end
  end

  def test_upload_rejects_mutated_mime_header_injection_before_staging_metadata
    payloads = ["text/plain\r\nX-Injected: yes", "text/plain\r\n\r\ninjected-body"]
    original_tempfile_new = Tempfile.method(:new)

    payloads.each do |payload|
      resource = FilesResource.new { flunk("upload should not be called") }
      content_type = +"text/plain"
      file = OpenAI::FilePart.new(StringIO.new("contents"), content_type: content_type)
      content_type.replace(payload)
      staged_path = nil
      tempfile_factory = lambda do |*args|
        original_tempfile_new.call(*args).tap { staged_path = Pathname(_1.path) }
      end

      Tempfile.stub(:new, tempfile_factory) do
        assert_raises(ArgumentError, payload.inspect) { uploader(resource).upload([file]) }
      end

      refute_nil(staged_path)
      refute_predicate(staged_path, :exist?)
      assert_empty(resource.calls)
    end
  end

  def test_upload_removes_spooled_files_after_failure
    staged_path = nil
    resource = FilesResource.new(capture_contents: false) do |file|
      staged_path = file.content
      raise UploadError, "upload failed"
    end

    assert_raises(UploadError) { uploader(resource).upload(["body"]) }

    refute_predicate(staged_path, :exist?)
  end

  def test_upload_cleans_earlier_spools_when_staging_fails
    staged_path = nil
    original_tempfile_new = Tempfile.method(:new)
    calls = 0
    tempfile_factory = lambda do |*args|
      calls += 1
      raise IOError, "disk full" if calls == 2

      original_tempfile_new.call(*args).tap { staged_path = Pathname(_1.path) }
    end

    error = Tempfile.stub(:new, tempfile_factory) do
      assert_raises(IOError) { uploader(FilesResource.new).upload(%w[one two]) }
    end

    assert_equal("disk full", error.message)
    refute_predicate(staged_path, :exist?)
  end

  def test_upload_rejects_unsupported_inputs_before_requesting
    resource = FilesResource.new { flunk("upload should not be called") }

    error = assert_raises(ArgumentError) { uploader(resource).upload([Object.new]) }
    part_error = assert_raises(ArgumentError) do
      uploader(resource).upload([OpenAI::FilePart.new(Object.new)])
    end

    assert_match("unsupported file input", error.message)
    assert_match("unsupported file input", part_error.message)
    assert_empty(resource.calls)
  end

  def test_upload_ignores_temporary_file_cleanup_errors
    temporary_file = Class
      .new do
        attr_reader(:path)

        def initialize
          @path = File.join(Dir.tmpdir, "already-removed-vector-store-upload")
        end

        def binmode = nil
        def close = nil
        def write(_contents) = nil
        def close! = raise IOError, "already removed"
      end
      .new
    resource = FilesResource.new(capture_contents: false) { UploadedFile.new("uploaded") }

    result = Tempfile.stub(:new, -> (*) { temporary_file }) do
      uploader(resource).upload(["body"])
    end

    assert_equal(["uploaded"], result.map(&:id))
  end

  def test_upload_validates_max_files
    resource = FilesResource.new { flunk("upload should not be called") }
    instance = uploader(resource)

    assert_raises(ArgumentError) { instance.upload([], max_files: -1) }
    assert_raises(ArgumentError) { instance.upload([], max_files: 1.5) }
    assert_empty(resource.calls)
  end

  def test_upload_accepts_block_scoped_io
    contents = []
    resource = FilesResource.new(capture_contents: false) do |file|
      contents << file.content.read
      UploadedFile.new("uploaded")
    end

    tempfile = Tempfile.new("openai-ruby-upload")
    tempfile.write("contents")
    tempfile.close
    files = Enumerator.new do |yielder|
      File.open(tempfile.path, "rb") { yielder << _1 }
    end

    result = uploader(resource).upload(files)

    assert_equal(["uploaded"], result.map(&:id))
    assert_equal(["contents"], contents)
  ensure
    tempfile&.unlink
  end

  def test_upload_rejects_a_closed_file_part_stream
    resource = FilesResource.new { flunk("upload should not be called") }
    content = StringIO.new("contents")
    file = OpenAI::FilePart.new(content, filename: "file.txt")
    content.close

    error = assert_raises(ArgumentError) { uploader(resource).upload([file]) }

    assert_match("must be open", error.message)
    assert_empty(resource.calls)
  end

  def test_upload_propagates_enumeration_failure
    resource = FilesResource.new { flunk("upload should not be called") }
    files = Enumerator.new { raise "enumeration failed" }

    error = assert_raises(RuntimeError) { uploader(resource).upload(files) }

    assert_equal("enumeration failed", error.message)
    assert_empty(resource.calls)
  end

  def test_upload_accepts_each_that_requires_a_block
    resource = FilesResource.new
    files = Class
      .new do
        include(Enumerable)

        def initialize(values)
          @values = values
        end

        def each
          @values.each { yield(_1) }
        end
      end
      .new(%w[one two])

    result = uploader(resource).upload(files)

    assert_equal(%w[uploaded_one uploaded_two], result.map(&:id))
  end

  def test_upload_stops_queued_work_after_failure
    resource = FilesResource.new { raise UploadError, "upload failed" }

    error = assert_raises(UploadError) { uploader(resource).upload(%w[one two three]) }

    assert_equal("upload failed", error.message)
    assert_equal(["one"], resource.contents)
  end

  def test_upload_forwards_purpose_and_request_options
    resource = FilesResource.new
    request_options = {extra_headers: {"X-Test" => "yes"}}

    uploader(resource, request_options: request_options).upload(["one"])

    assert_equal(["one"], resource.contents)
    assert_equal(:assistants, resource.calls.fetch(0).fetch(:purpose))
    assert_equal(request_options, resource.calls.fetch(0).fetch(:request_options))
  end

  def self.file_contents(file)
    content = file.is_a?(OpenAI::FilePart) ? file.content : file
    case content
    in Pathname
      content.binread
    in StringIO
      content.string
    in IO
      content.read
    else
      content.to_s
    end
  end

  private def metadata_and_contents(observed)
    file, contents = observed
    [file.filename, file.content_type, contents]
  end

  private def uploader(resource, max_concurrency: 1, request_options: {})
    OpenAI::Internal::VectorStoreFileUploader.new(
      client: Client.new(resource),
      max_concurrency: max_concurrency,
      request_options: request_options
    )
  end
end
