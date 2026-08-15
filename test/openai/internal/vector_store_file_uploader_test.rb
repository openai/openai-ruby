# frozen_string_literal: true

require_relative "../test_helper"
require "tempfile"
require "timeout"

class OpenAI::Test::VectorStoreFileUploaderTest < Minitest::Test
  extend Minitest::Serial

  UploadedFile = Data.define(:id)
  UploadError = Class.new(StandardError)

  class FilesResource
    attr_reader :calls

    def initialize(&handler)
      @handler = handler || ->(file) { UploadedFile.new("uploaded_#{file}") }
      @calls = []
      @lock = Mutex.new
    end

    def create(file:, purpose:, request_options:)
      @lock.synchronize { @calls << {file: file, purpose: purpose, request_options: request_options} }
      @handler.call(file)
    end
  end

  Client = Data.define(:files)

  def test_upload_reuses_capacity_and_preserves_input_order
    slow_started = Queue.new
    release_slow = Queue.new
    third_started = Queue.new
    resource = FilesResource.new do |file|
      case file
      when "slow"
        slow_started << true
        release_slow.pop
      when "third"
        third_started << true
      end
      UploadedFile.new("uploaded_#{file}")
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
    assert_equal(%w[slow second third].sort, resource.calls.map { _1[:file] }.sort)
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
      if file == "one"
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
    assert_equal(["one"], resource.calls.map { _1[:file] })
    refute_predicate(runner, :alive?)
  end

  def test_upload_validates_max_files
    resource = FilesResource.new { flunk("upload should not be called") }
    instance = uploader(resource)

    assert_raises(ArgumentError) { instance.upload([], max_files: -1) }
    assert_raises(ArgumentError) { instance.upload([], max_files: 1.5) }
    assert_empty(resource.calls)
  end

  def test_upload_rejects_block_scoped_io
    resource = FilesResource.new { flunk("upload should not be called") }
    tempfile = Tempfile.new("openai-ruby-upload")
    tempfile.write("contents")
    tempfile.close
    files = Enumerator.new do |yielder|
      File.open(tempfile.path, "rb") { yielder << _1 }
    end

    error = assert_raises(ArgumentError) { uploader(resource).upload(files) }

    assert_match("must remain open", error.message)
    assert_empty(resource.calls)
  ensure
    tempfile&.unlink
  end

  def test_upload_rejects_a_closed_file_part_stream
    resource = FilesResource.new { flunk("upload should not be called") }
    content = StringIO.new("contents")
    file = OpenAI::FilePart.new(content, filename: "file.txt")
    content.close

    error = assert_raises(ArgumentError) { uploader(resource).upload([file]) }

    assert_match("must remain open", error.message)
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
    files = Class.new do
      include Enumerable

      def initialize(values)
        @values = values
      end

      def each
        @values.each { yield(_1) }
      end
    end.new(%w[one two])

    result = uploader(resource).upload(files)

    assert_equal(%w[uploaded_one uploaded_two], result.map(&:id))
  end

  def test_upload_stops_queued_work_after_failure
    resource = FilesResource.new { raise UploadError, "upload failed" }

    error = assert_raises(UploadError) { uploader(resource).upload(%w[one two]) }

    assert_equal("upload failed", error.message)
    assert_equal(["one"], resource.calls.map { _1[:file] })
  end

  def test_upload_forwards_purpose_and_request_options
    resource = FilesResource.new
    request_options = {extra_headers: {"X-Test" => "yes"}}

    uploader(resource, request_options: request_options).upload(["one"])

    assert_equal(
      [{file: "one", purpose: :assistants, request_options: request_options}],
      resource.calls
    )
  end

  private def uploader(resource, max_concurrency: 1, request_options: {})
    OpenAI::Internal::VectorStoreFileUploader.new(
      client: Client.new(resource),
      max_concurrency: max_concurrency,
      request_options: request_options
    )
  end
end
