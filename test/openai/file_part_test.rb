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

  def test_public_constructor_and_accessor_contracts_remain_unchanged
    assert_equal(
      [[:req, :content], [:key, :filename], [:key, :content_type]],
      OpenAI::FilePart.instance_method(:initialize).parameters
    )
    assert(OpenAI::FilePart.private_method_defined?(:initialize))

    [:content, :content_type, :filename, :with_content].each do |name|
      assert(OpenAI::FilePart.public_method_defined?(name), "#{name} must remain public")
    end

    [:content=, :content_type=].each do |name|
      assert(OpenAI::FilePart.protected_method_defined?(name), "#{name} must remain protected")
    end
  end

  def test_constructor_preserves_file_inputs_and_filename_derivation
    io = File.open(__FILE__, "rb")
    pathname = Pathname(__FILE__)
    string_io = StringIO.new("contents")
    inputs = {
      "contents" => nil,
      string_io => nil,
      io => File.basename(io.to_path),
      pathname => pathname.basename.to_path
    }

    inputs.each do |content, filename|
      file = OpenAI::FilePart.new(content)

      assert_same(content, file.content)
      if filename.nil?
        assert_nil(file.filename)
      else
        assert_equal(filename, file.filename)
      end

      assert_nil(file.content_type)
    end

    explicit = OpenAI::FilePart.new(string_io, filename: Pathname("nested/custom.txt"))
    assert_equal("custom.txt", explicit.filename)

  ensure
    io&.close
  end

  def test_constructor_does_not_call_overridden_accessors_before_initialization
    subclass = Class.new(OpenAI::FilePart) do
      def content_type
        raise "content was not initialized" if content.nil?

        super
      end
    end

    file = subclass.new("contents", filename: "safe.txt", content_type: "text/plain")

    assert_equal("contents", file.content)
    assert_equal("safe.txt", file.filename)
    assert_equal("text/plain", file.content_type)
  end

  def test_content_type_rejects_multipart_header_injection_for_every_file_input
    io = File.open(__FILE__, "rb")
    inputs = ["contents", StringIO.new("contents"), io, Pathname(__FILE__)]
    content_types = [
      "text/plain\r\nX-Injected: yes",
      "text/plain\nX-Injected: yes",
      "text/plain\rX-Injected: yes",
      "text/plain\r\n\r\ninjected-body"
    ]

    inputs.each do |input|
      content_types.each do |content_type|
        error = assert_raises(ArgumentError, "#{input.class}: #{content_type.inspect}") do
          OpenAI::FilePart.new(input, filename: "safe.txt", content_type: content_type)
        end

        assert_match("valid MIME media type", error.message)
      end
    end

  ensure
    io&.close
  end

  def test_content_type_rejects_every_forbidden_ascii_control_character
    forbidden = (0..31).reject { _1 == 9 }.append(127)

    forbidden.each do |byte|
      content_types = [
        "text/plain; name=before#{byte.chr}after",
        "text/plain; name=\"before#{byte.chr}after\"",
        "text/plain; name=\"before\\#{byte.chr}after\""
      ]

      content_types.each do |content_type|
        assert_raises(ArgumentError, "control byte #{byte}: #{content_type.inspect}") do
          OpenAI::FilePart.new("contents", content_type: content_type)
        end
      end
    end
  end

  def test_content_type_requires_a_complete_media_type_and_valid_parameters
    invalid = [
      "",
      "text",
      "/plain",
      "text/",
      "text/plain/extra",
      " text/plain",
      "text /plain",
      "text/plain header",
      "text/plain: header",
      "text/plain;",
      "text/plain; charset",
      "text/plain; =UTF-8",
      "text/plain; charset=",
      "text/plain; charset=two words",
      "text/plain; charset=UT\tF-8",
      "text/plain; name=\"unterminated",
      "text/plain; name=\"closed\"trailing"
    ]

    invalid.each do |content_type|
      assert_raises(ArgumentError, content_type.inspect) do
        OpenAI::FilePart.new("contents", content_type: content_type)
      end
    end
  end

  def test_content_type_preserves_valid_media_types_and_parameters
    valid = [
      "text/plain",
      "TEXT/PLAIN",
      "application/vnd.openai.result+json",
      "application/x-custom_type.v2",
      "multipart/form-data; boundary=----safe-boundary",
      "text/plain; charset=UTF-8; format=flowed",
      "text/plain;\tcharset = \tUTF-8\t",
      "text/plain; name=\"report; final.txt\"; title=\"draft \\\"one\\\"\"",
      "text/plain; title=\"caf\u00e9\"",
      "text/plain; title=\"\"",
      "text/plain; title=\"a\tb\"",
      "text/plain; filename*=UTF-8''report%20final.txt",
      "Text/Plain; CHARSET=Utf-8 \t"
    ]

    valid.each do |content_type|
      file = OpenAI::FilePart.new("contents", content_type: content_type)

      assert_equal(content_type, file.content_type)
      assert_equal(content_type, file.with_content(Pathname("replacement")).content_type)
    end

    assert_nil(OpenAI::FilePart.new("contents").content_type)
  end

  def test_content_type_revalidates_metadata_mutated_after_construction
    content_type = +"text/plain"
    file = OpenAI::FilePart.new("contents", content_type: content_type)

    content_type << "\r\nX-Injected: yes"

    assert_raises(ArgumentError) { file.content_type }
    assert_raises(ArgumentError) { file.with_content(Pathname("replacement")) }
  end

  def test_content_type_preserves_string_identity_and_safe_mutation
    content_type = +"text/plain"
    file = OpenAI::FilePart.new("contents", content_type: content_type)

    assert_same(content_type, file.content_type)

    content_type.replace("application/json; charset=UTF-8")
    assert_same(content_type, file.content_type)
    assert_equal("application/json; charset=UTF-8", file.content_type)

    frozen_content_type = "image/jpeg".freeze
    frozen_file = OpenAI::FilePart.new("contents", content_type: frozen_content_type)

    assert_same(frozen_content_type, frozen_file.content_type)
    assert_equal("image/jpeg", frozen_file.freeze.content_type)
  end
end
