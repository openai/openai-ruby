# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::MultipartContentTypeTest < Minitest::Test
  def test_direct_uploads_and_upload_parts_reject_mutated_mime_header_injection
    inputs = {
      "String" => -> { "contents" },
      "StringIO" => -> { StringIO.new("contents") },
      "IO" => -> { File.open(__FILE__, "rb") },
      "pathless IO" => -> { pathless_io },
      "Pathname" => -> { Pathname(__FILE__) }
    }
    payloads = [
      "text/plain\r\nX-Injected: yes",
      "text/plain\r\n\r\ninjected-body",
      "text/plain;\r\nX-Injected: yes",
      "text/plain;;charset=UTF-8\r\n\r\ninjected-body"
    ]

    inputs.each do |input_name, input_factory|
      [:files, :upload_parts].each do |endpoint|
        payloads.each do |payload|
          input = nil
          input = input_factory.call
          content_type = +"text/plain"
          file = OpenAI::FilePart.new(input, filename: "safe.txt", content_type: content_type)
          content_type.replace(payload)
          chunks = []

          assert_raises(ArgumentError, "#{endpoint} #{input_name}: #{payload.inspect}") do
            body = multipart_upload_body(file, endpoint: endpoint)
            _headers, stream = OpenAI::Internal::Util.encode_content(
              {"content-type" => "multipart/form-data"},
              body
            )
            stream.each { chunks << _1 }
          end

          refute_includes(chunks.join, "\r\nX-Injected:")
          refute_includes(chunks.join, "\r\n\r\ninjected-body")
        ensure
          input&.close if input.is_a?(IO) && !input.closed?
        end
      end
    end
  end

  def test_direct_uploads_and_upload_parts_preserve_parameterized_content_types
    content_type = "text/plain; charset=UTF-8; name=\"report; final.txt\""

    [:files, :upload_parts].each do |endpoint|
      file = OpenAI::FilePart.new(
        StringIO.new("contents"),
        filename: "a \"b\"\r\nEvil: 1.md",
        content_type: content_type
      )
      body = multipart_upload_body(file, endpoint: endpoint)
      _headers, stream = OpenAI::Internal::Util.encode_content(
        {"content-type" => "multipart/form-data"},
        body
      )
      encoded = stream.to_a.join

      assert_includes(encoded, "Content-Type: #{content_type}\r\n\r\ncontents")
      assert_includes(encoded, "filename=\"a \\\"b\\\"Evil: 1.md\"")
      refute_includes(encoded, "\r\nEvil:")
    end
  end

  def test_uploads_preserve_default_media_types_and_raw_or_wrapped_filenames
    inputs = {
      "String" => [-> { "contents" }, "text/plain"],
      "StringIO" => [-> { StringIO.new("contents") }, "application/octet-stream"],
      "IO" => [-> { File.open(__FILE__, "rb") }, "application/octet-stream"],
      "pathless IO" => [-> { pathless_io }, "application/octet-stream"],
      "Pathname" => [-> { Pathname(__FILE__) }, "application/octet-stream"]
    }

    inputs.each do |input_name, (input_factory, expected_content_type)|
      [:files, :upload_parts].each do |endpoint|
        [false, true].each do |wrapped|
          input = nil
          input = input_factory.call
          file = wrapped ? OpenAI::FilePart.new(input) : input
          body = multipart_upload_body(file, endpoint: endpoint)
          _headers, stream = OpenAI::Internal::Util.encode_content(
            {"content-type" => "multipart/form-data"},
            body
          )
          encoded = stream.to_a.join
          field = endpoint == :files ? "file" : "data"
          disposition = "Content-Disposition: form-data; name=\"#{field}\""
          filename = expected_filename(input, wrapped: wrapped)
          disposition += "; filename=\"#{filename}\"" unless filename.nil?

          assert_includes(
            encoded,
            "#{disposition}\r\nContent-Type: #{expected_content_type}\r\n\r\n",
            "#{endpoint} #{input_name} wrapped=#{wrapped}"
          )
        ensure
          input&.close if input.is_a?(IO) && !input.closed?
        end
      end
    end
  end

  def test_direct_uploads_and_upload_parts_preserve_empty_content_type_parameter_slots
    content_types = ["text/plain;", "text/plain;;charset=UTF-8", "text/plain; ;charset=UTF-8; "]

    content_types.each do |content_type|
      [:files, :upload_parts].each do |endpoint|
        file = OpenAI::FilePart.new(StringIO.new("contents"), content_type: content_type)
        body = multipart_upload_body(file, endpoint: endpoint)
        _headers, stream = OpenAI::Internal::Util.encode_content(
          {"content-type" => "multipart/form-data"},
          body
        )

        assert_includes(stream.to_a.join, "Content-Type: #{content_type}\r\n\r\ncontents")
      end
    end
  end

  private def multipart_upload_body(file, endpoint:)
    case endpoint
    when :files
      OpenAI::FileCreateParams.dump_request(file: file, purpose: :assistants).first
    when :upload_parts
      OpenAI::Uploads::PartCreateParams.dump_request(data: file).first
    end
  end

  private def expected_filename(input, wrapped:)
    if input.is_a?(IO)
      return input.to_path&.then { File.basename(_1) } if wrapped

      return input.to_path.nil? ? "upload" : File.basename(input.to_path)
    end

    return File.basename(input.to_path) if input.is_a?(Pathname)

    "upload" unless wrapped
  end

  private def pathless_io
    reader, writer = IO.pipe
    writer.write("contents")
    writer.close
    reader
  end
end
