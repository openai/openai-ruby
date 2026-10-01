# frozen_string_literal: true

require "tmpdir"
require "socket"
require "timeout"

require_relative "../test_helper"

class OpenAI::Test::AgentFilesTest < Minitest::Test
  extend Minitest::Serial

  class Body
    attr_reader :closed, :reads
    attr_accessor :error, :chunks

    def initialize
      @reads = 0
      @chunks = ["first", "second"]
    end

    def each
      @chunks.each do |chunk|
        @reads += 1
        yield chunk
        raise @error if @error
      end
    end

    def close = @closed = true
  end

  class Server < OpenAI::HTTPClient
    attr_reader :requests, :body, :upload_bodies
    attr_accessor :artifacts, :upload_failure, :stage_failure, :content_status, :before_upload, :upload_status

    def initialize
      super
      @requests = []
      @body = Body.new
      @artifacts = []
      @uploads = 0
      @upload_bodies = []
      @content_status = 200
    end

    def execute(request)
      @requests << request
      if request.method == :post && request.url.path.end_with?("/files")
        if request.url.path.include?("/environments/")
          raise IOError, "stage failed" if @stage_failure
          return response(200, {environment_id: "env", path: "/workspace/source.txt", size_bytes: 3})
        end

        @uploads += 1
        @before_upload&.call
        @upload_bodies << request.body.to_a.join
        status = @upload_status.is_a?(Array) ? @upload_status.shift : @upload_status
        return response(status, {error: {message: "retry", type: "server_error"}}) if status && status != 200
        raise IOError, "upload failed" if @upload_failure == @uploads
        return response(
          200,
          {
            id: "file_#{@uploads}",
            bytes: 3,
            created_at: 1,
            filename: "source.txt",
            purpose: "user_data",
            object: "file"
          }
        )
      end

      if request.url.path.end_with?("/artifacts")
        after = URI.decode_www_form(request.url.query.to_s).to_h["after"]
        offset = after ? @artifacts.index { _1[:id] == after } + 1 : 0
        return response(200, {data: @artifacts.slice(offset, 1) || [], has_more: offset + 1 < @artifacts.length})
      end

      status = @content_status.is_a?(Array) ? @content_status.shift : @content_status
      if status != 200
        return response(status, {error: {message: "unavailable", type: "invalid_request_error"}})
      end

      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/octet-stream"},
        body: @body
      )
    end

    def response(status, value)
      OpenAI::HTTPClient::Response.new(
        status: status,
        headers: {"content-type" => "application/json"},
        body: JSON.generate(value)
      )
    end
  end

  def setup
    super
    @directory = Pathname(Dir.mktmpdir("agent-files"))
    @first = @directory.join("first.txt")
    @first.write("one")
    @second = @directory.join("second.txt")
    @second.write("two")
    @server = Server.new
    @client = client
    @files = @client.beta.agents.environments.files
  end

  def teardown
    FileUtils.remove_entry(@directory) if @directory&.exist?
    super
  end

  def client(**options)
    OpenAI::Client.new(
      api_key: "fake-key",
      base_url: "https://sdk-test.example/v1",
      http_client: @server,
      max_retries: 0,
      **options
    )
  end

  def mapping = {"/workspace/first.txt" => @first, "/workspace/second.txt" => @second}

  def artifact(id = "artifact", turn: "turn", path: "/workspace/outputs/report.txt")
    {
      id: id,
      turn_id: turn,
      session_id: "session",
      path: path,
      environment_id: "env",
      created_at: 1,
      size_bytes: 11,
      object: "agent.session.artifact"
    }
  end

  def downloads
    turn = OpenAI::Models::Beta::Agents::Sessions::Turn.new(id: "turn", session_id: "session", status: :completed)
    result = OpenAI::Helpers::Beta::Agents::TurnResult.new(turn: turn, messages: [])
    @client.beta.agents.sessions.artifacts.for_result(result)
  end

  def test_prepare_uploads_selected_files_and_exposes_explicit_cleanup_ids
    result = @files.prepare(mapping, request_options: {extra_headers: {"x-test" => "preserved"}})
    assert_equal(%w[file_1 file_2], result.upload_ids)
    assert_equal(mapping.keys, result.files.map(&:path))
    assert(result.files.all? { _1.type == :file_id })
    assert(@server.requests.all? { _1.headers["x-test"] == "preserved" })
    assert_equal(2, @server.requests.length)
  end

  def test_prepared_snapshots_preserve_bytes_and_filenames_across_upload_retries
    @server.upload_status = [503, 200]
    @server.before_upload = -> { @first.write("changed after snapshot") }
    client(max_retries: 1).beta.agents.environments.files.prepare({"/workspace/first.txt" => @first})

    assert_equal(2, @server.upload_bodies.length)
    @server.upload_bodies.each do |body|
      assert_includes(body, "filename=\"first.txt\"")
      assert_includes(body, "\r\n\r\none\r\n")
      refute_includes(body, "changed after snapshot")
    end
  end

  def test_all_selected_files_are_snapshotted_before_the_first_upload
    @server.before_upload = lambda do
      @second.delete
      File.symlink(@first, @second)
    end
    @files.prepare(mapping)

    assert_includes(@server.upload_bodies.first, "\r\n\r\none\r\n")
    assert_includes(@server.upload_bodies.last, "\r\n\r\ntwo\r\n")
  end

  def test_source_growth_during_snapshot_fails_before_upload_and_removes_temporary_copy
    copy = IO.method(:copy_stream)
    snapshot_path = nil
    copying = lambda do |input, output, length|
      snapshot_path = output.path
      @first.write("grew after preflight")
      copy.call(input, output, length)
    end

    error = IO.stub(:copy_stream, copying) do
      assert_raises(OpenAI::Helpers::Beta::Agents::FilePreparationError) do
        @files.prepare({"/workspace/first.txt" => @first})
      end
    end

    assert_empty(error.prepared.upload_ids)
    assert_empty(@server.requests)
    refute(File.exist?(snapshot_path))
  end

  def test_replaced_source_is_rejected_before_snapshot_and_upload
    temporary = Dir.method(:mktmpdir)
    creating = lambda do |*args, &block|
      temporary.call(*args) do |directory|
        @first.delete
        File.symlink(@second, @first)
        block.call(directory)
      end
    end

    Dir.stub(:mktmpdir, creating) do
      assert_raises(OpenAI::Helpers::Beta::Agents::FilePreparationError) do
        @files.prepare({"/workspace/first.txt" => @first})
      end
    end

    assert_empty(@server.requests)
  end

  def test_singleton_preparation_materializes_structured_idempotency
    directory = @directory.join("one")
    directory.mkpath
    directory.join("first.txt").write("one")
    options = {idempotency_key: "prepare-operation", extra_headers: {"x-extra" => "retained"}}
    expected = OpenAI::Internal::RequestOptionsScope.new(options).child("file-upload")[:extra_headers][
      "Idempotency-Key"
    ]
    @files.prepare({"/workspace/first.txt" => @first}, request_options: options)
    @files.prepare_directory(directory, destination: "/workspace", include: ["*.txt"], request_options: options)
    assert_equal([expected, expected], @server.requests.map { _1.headers["idempotency-key"] })
    assert(@server.requests.all? { _1.headers["x-extra"] == "retained" })
  end

  def test_destinations_are_normalized_to_valid_utf8_before_uploads
    invalid = "/workspace/".b + [255].pack("C")
    [invalid, invalid.dup.force_encoding(Encoding::UTF_8)].each do |path|
      assert_raises(ArgumentError) { @files.prepare({path => @first}) }
    end

    assert_empty(@server.requests)
    destination = "/workspace/café.txt"
    [destination.b, destination.encode(Encoding::ISO_8859_1)].each do |path|
      prepared = @files.prepare({path => @first})
      assert_equal(destination, prepared.files.first.path)
      assert_equal(Encoding::UTF_8, prepared.files.first.path.encoding)
      assert(JSON.generate(prepared.files))
    end
  end

  def test_destination_length_is_left_to_the_api
    destination = "/workspace/" + ("😀" * 4096)
    prepared = @files.upload("env", file: @first, path: destination)
    assert_equal(destination, prepared.files.first.path)
    assert_equal(destination, JSON.parse(@server.requests.last.body).fetch("path"))
  end

  def test_upload_and_stage_scope_keys_without_losing_request_options
    [
      [{idempotency_key: "operation"}, {}],
      [{extra_headers: {"Idempotency-Key" => "operation"}}, {}],
      [{}, {default_headers: {"Idempotency-Key" => "operation"}}]
    ].each do |options, defaults|
      options = options.merge(
        timeout: 12,
        extra_headers: options.fetch(:extra_headers, {}).merge("x-extra" => "retained")
      )
      @server = Server.new
      service = client(**defaults).beta.agents.environments.files
      2.times { service.upload("env", file: @first, path: "/workspace/source.txt", request_options: options) }
      keys = @server.requests.map { _1.headers["idempotency-key"] }
      refute_equal(keys[0], keys[1])
      assert_equal(keys.take(2), keys.drop(2))
      assert(@server.requests.all? { _1.headers["x-extra"] == "retained" })
      assert(keys.all? { _1.start_with?("stainless-ruby-") })
    end
  end

  def test_failed_status_preserves_destination_and_successful_empty_body_creates_empty_file
    @server.artifacts = [artifact]
    target = @directory.join("report.txt")
    target.write("existing")
    @server.content_status = 404
    assert_raises(OpenAI::Errors::NotFoundError) do
      downloads.download(path: "/workspace/outputs/report.txt", to: target)
    end

    assert_equal("existing", target.read)
    @server.content_status = 200
    @server.body.chunks = []
    @server.artifacts.first[:size_bytes] = 0
    downloads.download(path: "/workspace/outputs/report.txt", to: target)
    assert_equal("", target.read)
    assert_predicate(@server.body, :closed)
  end

  def test_invalid_destinations_and_collisions_fail_before_uploads
    [
      "/elsewhere/a",
      "/workspace/../a",
      "/workspace/a//b",
      "/workspace/.codex/a",
      "/workspace/.managed-agents-secret/a",
      "/workspace/outputs",
      "/workspace/a\\b"
    ].each do |path|
      assert_raises(ArgumentError) { @files.prepare({path => @first}) }
    end

    assert_raises(ArgumentError) do
      @files.prepare({"/workspace/a" => @first, "/workspace/a-b" => @first, "/workspace/a/b" => @second})
    end

    assert_empty(@server.requests)
  end

  def test_selected_symlinks_are_checked_before_uploads
    link = @directory.join("link.txt")
    File.symlink(@first, link)
    assert_raises(ArgumentError) { @files.prepare({"/workspace/link.txt" => link}) }
    assert_empty(@server.requests)
  end

  def test_file_size_limits_are_left_to_the_api
    File.truncate(@first, 51 * 1024 * 1024)
    @server.upload_status = 400
    error = assert_raises(OpenAI::Helpers::Beta::Agents::FilePreparationError) do
      @files.prepare(mapping)
    end

    assert_instance_of(OpenAI::Errors::BadRequestError, error.cause)
    assert_empty(error.prepared.upload_ids)
    assert_equal(1, @server.requests.length)
    assert_operator(@server.upload_bodies.first.bytesize, :>, @first.size)
  end

  def test_explicit_sources_allow_aliased_ancestors_but_not_selected_symlinks
    actual = @directory.join("actual")
    actual.join("nested").mkpath
    actual.join("nested", "source.txt").write("one")
    aliased = @directory.join("alias")
    File.symlink(actual, aliased)
    prepared = @files.prepare({"/workspace/source.txt" => aliased.join("nested", "source.txt")})
    assert_equal(1, prepared.files.length)
    assert_raises(ArgumentError) do
      @files.prepare_directory(aliased, destination: "/workspace/docs", include: ["**/*.txt"])
    end

    prepared = @files.prepare_directory(aliased.join("nested"), destination: "/workspace/docs", include: ["**/*.txt"])
    assert_equal(["/workspace/docs/source.txt"], prepared.files.map(&:path))
  end

  def test_selected_directory_replacement_during_resolution_fails_before_upload
    root = @directory.join("selected")
    root.mkpath
    root.join("source.txt").write("selected")
    outside = @directory.join("outside")
    outside.mkpath
    outside.join("source.txt").write("not selected")
    resolve = File.method(:realpath)
    replaced = false
    replacing = lambda do |*args|
      if args.first.to_s == root.to_s && !replaced
        root.rename(@directory.join("original"))
        File.symlink(outside, root)
        replaced = true
      end

      resolve.call(*args)
    end

    File.stub(:realpath, replacing) do
      assert_raises(ArgumentError) do
        @files.prepare_directory(root, destination: "/workspace/docs", include: ["**/*.txt"])
      end
    end

    assert(replaced)
    assert_empty(@server.requests)
  end

  def test_directory_replacement_after_enumeration_cannot_select_outside_files
    root = @directory.join("selected")
    root.join("child").mkpath
    root.join("child", "source.txt").write("selected")
    outside = @directory.join("outside")
    outside.mkpath
    outside.join("source.txt").write("not selected")
    glob = Dir.method(:glob)
    enumerate = lambda do |*args, **kwargs|
      entries = glob.call(*args, **kwargs)
      root.join("child").rename(root.join("old-child"))
      File.symlink(outside, root.join("child"))
      entries
    end

    Dir.stub(:glob, enumerate) do
      assert_raises(ArgumentError) do
        @files.prepare_directory(root, destination: "/workspace/docs", include: ["**/*.txt"])
      end
    end

    assert_empty(@server.requests)
  end

  def test_multi_upload_effective_idempotency_key_is_rejected_before_network
    [
      [@files, {idempotency_key: "one-key"}],
      [@files, {extra_headers: {"Idempotency-Key" => "one-key"}}],
      [client(default_headers: {"Idempotency-Key" => "one-key"}).beta.agents.environments.files, {}]
    ].each do |files, options|
      assert_raises(ArgumentError) { files.prepare(mapping, request_options: options) }
    end

    assert_empty(@server.requests)
    with_default = client(default_headers: {"Idempotency-Key" => "one-key"}).beta.agents.environments.files
    result = with_default.prepare(mapping, request_options: {extra_headers: {"idempotency-key" => nil}})
    assert_equal(2, result.upload_ids.length)
  end

  def test_partial_upload_and_stage_failures_preserve_created_ids
    @server.upload_failure = 2
    error = assert_raises(OpenAI::Helpers::Beta::Agents::FilePreparationError) { @files.prepare(mapping) }
    assert_equal(["file_1"], error.prepared.upload_ids)
    @server.stage_failure = true
    error = assert_raises(OpenAI::Helpers::Beta::Agents::FilePreparationError) do
      @files.upload("env", file: @first, path: "/workspace/source.txt")
    end

    assert_equal(["file_3"], error.prepared.upload_ids)
    refute(@server.requests.any? { _1.method == :delete })
  end

  def test_live_upload_stages_a_file_reference_and_returns_upload_ownership
    prepared = @files.upload("env", file: @first, path: "/workspace/source.txt")
    assert_equal(["file_1"], prepared.upload_ids)
    assert_equal(
      prepared.files.first.to_h.transform_keys(&:to_s).merge("type" => "file_id"),
      JSON.parse(@server.requests.last.body)
    )
  end

  def test_directory_preparation_is_explicit_selected_staging
    @directory.join("skip.log").write("skip")
    result = @files.prepare_directory(@directory, destination: "/workspace/docs", include: ["**/*.txt"])
    assert_equal(["/workspace/docs/first.txt", "/workspace/docs/second.txt"], result.files.map(&:path).sort)
  end

  def test_directory_preparation_globs_only_requested_patterns_and_deduplicates_matches
    @directory.join("nested").mkpath
    @directory.join("nested", "third.md").write("three")
    patterns = ["./*.txt", "{first.txt,nested/./*.md}"]
    glob = Dir.method(:glob)
    requested = []
    enumerate = lambda do |pattern, **options|
      requested << pattern
      glob.call(pattern, **options)
    end

    result = Dir.stub(:glob, enumerate) do
      @files.prepare_directory(@directory, destination: "/workspace/docs", include: patterns)
    end

    assert_equal([patterns], requested)
    assert_equal(
      %w[/workspace/docs/first.txt /workspace/docs/nested/third.md /workspace/docs/second.txt],
      result.files.map(&:path).sort
    )
  end

  def test_directory_globs_exclude_hidden_files_unless_explicitly_selected
    @directory.join(".env").write("fake private setting")
    @directory.join(".git").mkpath
    @directory.join(".git", "config").write("fake private repository config")
    prepared = @files.prepare_directory(@directory, destination: "/workspace/docs", include: ["**/*"])
    assert_equal(%w[/workspace/docs/first.txt /workspace/docs/second.txt], prepared.files.map(&:path))
    refute(@server.upload_bodies.any? { _1.include?("fake private") })

    selected = @files.prepare_directory(@directory, destination: "/workspace/docs", include: [".env", ".git/*"])
    assert_equal(%w[/workspace/docs/.env /workspace/docs/.git/config], selected.files.map(&:path))
    assert_includes(@server.upload_bodies[-2], "fake private setting")
    assert_includes(@server.upload_bodies[-1], "fake private repository config")
  end

  def test_artifact_lookup_is_lazy_paginated_and_turn_scoped
    @server.artifacts = [
      artifact("old", turn: "older"),
      artifact("other", path: "/workspace/outputs/other.txt"),
      artifact
    ]
    helper = downloads
    assert_empty(@server.requests)
    target = StringIO.new
    record = helper.download(
      path: "/workspace/outputs/report.txt",
      to: target,
      request_options: {extra_headers: {"x-test" => "preserved"}}
    )
    assert_equal("artifact", record.id)
    assert_equal("firstsecond", target.string)
    assert_equal(4, @server.requests.length)
    assert(@server.requests.all? { _1.headers["x-test"] == "preserved" })
    assert_equal("agents=v1", @server.requests.last.headers["openai-beta"])
    assert_predicate(@server.body, :closed)
  end

  def test_missing_or_ambiguous_artifact_does_not_open_destination
    target = @directory.join("download.txt")
    [[], [artifact("one"), artifact("two")]].each do |artifacts|
      @server.artifacts = artifacts
      assert_raises(ArgumentError) { downloads.download(path: "/workspace/outputs/report.txt", to: target) }
      refute(target.exist?)
    end
  end

  def test_http_errors_never_write_error_payload_as_artifact_bytes
    @server.artifacts = [artifact]
    @server.content_status = 404
    target = StringIO.new
    assert_raises(OpenAI::Errors::NotFoundError) do
      downloads.download(path: "/workspace/outputs/report.txt", to: target)
    end

    assert_empty(target.string)
  end

  def test_transient_http_errors_use_normal_retries_without_writing_error_bytes
    @server.artifacts = [artifact]
    @server.content_status = [503, 200]
    @client = client(max_retries: 1)
    target = StringIO.new
    downloads.download(path: "/workspace/outputs/report.txt", to: target)
    assert_equal("firstsecond", target.string)
    assert_equal(2, @server.requests.count { _1.url.path.end_with?("/content") })
    refute_predicate(target, :closed?)
  end

  def test_file_count_limits_are_left_to_the_api
    files = 1001.times.to_h { |i| ["/workspace/file#{i}", @first] }
    prepared = @files.prepare(files)
    assert_equal(files.keys, prepared.files.map(&:path))
    assert_equal(files.length, @server.requests.length)
  end

  def test_truncated_artifact_body_fails_and_closes_the_response
    @server.artifacts = [artifact]
    @server.body.chunks = ["first"]
    target = @directory.join("report.txt")
    error = assert_raises(IOError) do
      downloads.download(path: "/workspace/outputs/report.txt", to: target)
    end

    assert_match(/size does not match/, error.message)
    assert_equal("first", target.read)
    assert_predicate(@server.body, :closed)
  end

  def test_artifact_size_counts_bytes_not_characters_or_writer_return_values
    content = "😀"
    @server.artifacts = [artifact.merge(size_bytes: content.bytesize)]
    @server.body.chunks = [content]
    writer = Object.new
    received = +""
    writer.define_singleton_method(:write) { |chunk| received << chunk }
    downloads.download(path: "/workspace/outputs/report.txt", to: writer)
    assert_equal(content, received)
    assert_predicate(@server.body, :closed)
  end

  def test_raw_body_option_is_rejected_before_binary_request
    assert_raises(ArgumentError) do
      @client.request_streaming_body(method: :get, path: "binary", options: {include_raw_body: true}) { |_chunk| nil }
    end

    assert_empty(@server.requests)
  end

  def test_writer_and_chunk_failures_close_the_body
    @server.artifacts = [artifact]
    writer = Object.new
    writer.define_singleton_method(:write) { |_chunk| raise IOError, "writer failed" }
    assert_raises(IOError) { downloads.download(path: "/workspace/outputs/report.txt", to: writer) }
    assert_predicate(@server.body, :closed)
    @server = Server.new
    @client = client
    @server.artifacts = [artifact]
    @server.body.error = IOError.new("read failed")
    assert_raises(IOError) { downloads.download(path: "/workspace/outputs/report.txt", to: StringIO.new) }
    assert_predicate(@server.body, :closed)
  end

  def test_private_binary_stream_closes_after_early_break_and_preserves_buffered_content
    @client.request_streaming_body(method: :get, path: "binary") { |_chunk| break }
    assert_equal(1, @server.body.reads)
    assert_predicate(@server.body, :closed)
    @server = Server.new
    @client = client
    content = @client.beta.agents.sessions.artifacts.content("artifact", session_id: "session")
    assert_instance_of(StringIO, content)
    assert_equal("firstsecond", content.read)
  end

  def test_real_transport_delivers_first_chunk_before_server_sends_the_second
    server = TCPServer.new("127.0.0.1", 0)
    acknowledged = Queue.new
    worker = Thread.new do
      socket = server.accept
      loop { break if socket.gets == "\r\n" }
      socket.write(
        "HTTP/1.1 200 OK\r\nContent-Type: application/octet-stream\r\nTransfer-Encoding: chunked\r\nConnection: close\r\n\r\n3\r\nabc\r\n"
      )
      Timeout.timeout(5) { acknowledged.pop }
      socket.write("3\r\ndef\r\n0\r\n\r\n")
    ensure
      socket&.close
    end

    network = OpenAI::Client.new(
      api_key: "fake-key",
      base_url: "http://127.0.0.1:#{server.local_address.ip_port}/v1",
      max_retries: 0,
      timeout: 5
    )
    output = +""
    network.request_streaming_body(method: :get, path: "binary") do |chunk|
      output << chunk
      acknowledged << true if output == "abc"
    end

    assert_equal("abcdef", output)
    worker.value
  ensure
    server&.close
    worker&.kill if worker&.alive?
    worker&.join
  end
end
