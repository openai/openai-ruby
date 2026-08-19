# frozen_string_literal: true

require_relative "test_helper"
require "tempfile"

class OpenAI::Test::FilePartTest < Minitest::Test
  def test_to_json
    text = "gray"
    filepart = OpenAI::FilePart.new(StringIO.new(text))

    assert_equal(text.to_json, filepart.to_json)
    assert_equal(text.to_yaml, filepart.to_yaml)
  end

  def test_path_backed_io_filename_uses_basename
    File.open(__FILE__, "rb") do |content|
      assert_equal(File.basename(content.to_path), OpenAI::FilePart.new(content).filename)
    end
  end

  def test_path_backed_io_filename_preserves_platform_path_semantics
    paths = [
      "/nested/directory/document.txt",
      "relative/directory/document.txt",
      "C:/nested/directory/document.txt",
      "C:\\nested\\directory\\document.txt",
      "/nested/.hidden",
      "/nested/report with spaces.txt",
      ""
    ]

    File.open(__FILE__, "rb") do |content|
      paths.each do |path|
        content.stub(:to_path, path) do
          assert_equal(File.basename(path), OpenAI::FilePart.new(content).filename, path)
        end
      end
    end
  end

  def test_pathless_streams_have_no_filename
    reader, writer = IO.pipe

    assert_nil(OpenAI::FilePart.new(reader).filename)
    assert_nil(OpenAI::FilePart.new(StringIO.new("contents")).filename)
  ensure
    reader&.close
    writer&.close
  end

  def test_pathname_filename_uses_basename
    content = Pathname("/nested/directory/document.txt")

    assert_equal("document.txt", OpenAI::FilePart.new(content).filename)
  end

  def test_explicit_filename_takes_precedence_for_path_backed_io
    File.open(__FILE__, "rb") do |content|
      ["nested/override.txt", Pathname("nested/override.txt")].each do |filename|
        file = OpenAI::FilePart.new(content, filename: filename, content_type: "text/custom")

        assert_same(content, file.content)
        assert_equal("override.txt", file.filename)
        assert_equal("text/custom", file.content_type)
      end
    end
  end

  def test_generated_file_upload_preserves_public_api_and_omits_local_path
    Tempfile.create(["upload-", ".txt"]) do |content|
      content.write("upload-body")
      content.rewind
      local_path = content.to_path
      response = OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/json"},
        body: JSON.generate(
          id: "file_test",
          bytes: 11,
          created_at: 1,
          filename: File.basename(local_path),
          object: "file",
          purpose: "assistants",
          status: "processed"
        )
      )
      transport = Minitest::Mock.new(OpenAI::HTTPClient.new)
      transport.expect(:execute, response) do |request|
        assert_equal(:post, request.method)
        assert_equal("/v1/files", request.url.path)
        body = request.body.to_a.join
        assert_includes(body, "filename=\"#{File.basename(local_path)}\"")
        assert_includes(body, "upload-body")
        refute_includes(body, local_path)
        true
      end

      client = OpenAI::Client.new(
        api_key: "test-key",
        base_url: "http://example.test/v1",
        http_client: transport,
        max_retries: 1
      )
      file = OpenAI::FilePart.new(content)
      uploaded = client.files.create(file: file, purpose: :assistants)

      assert_instance_of(OpenAI::FileObject, uploaded)
      assert_equal("file_test", uploaded.id)
      refute(OpenAI::Internal::Transport::BaseClient.request_body_replayable?({file: file}))
      assert_mock(transport)
    end
  end

  def test_with_content_preserves_original_and_effective_multipart_metadata
    original = OpenAI::FilePart.new("contents")
    replacement = Pathname("replacement")

    copy = original.with_content(replacement)

    assert_equal("contents", original.content)
    assert_nil(original.content_type)
    assert_same(replacement, copy.content)
    assert_equal("text/plain", copy.content_type)
    assert_nil(copy.filename)
  end

  def test_with_content_preserves_inferred_filename_and_io_metadata
    File.open(__FILE__, "rb") do |content|
      original = OpenAI::FilePart.new(content)
      replacement = Pathname("replacement")

      copy = original.with_content(replacement)

      assert_same(content, original.content)
      assert_nil(original.content_type)
      assert_equal(File.basename(content.to_path), original.filename)
      assert_same(replacement, copy.content)
      assert_equal("application/octet-stream", copy.content_type)
      assert_equal(original.filename, copy.filename)
    end
  end
end
