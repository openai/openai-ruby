# frozen_string_literal: true

require "tmpdir"

require_relative "test_helper"

class OpenAI::Test::FileInputReadbackTest < Minitest::Test
  def test_constructor_and_setter_read_back_documented_inputs
    with_documented_inputs do |input|
      params = OpenAI::FileCreateParams.new(file: input, purpose: :assistants)

      assert_same(input, params.file)
      assert_same(input, params.to_h.fetch(:file))

      replacement = OpenAI::FileCreateParams.new(file: StringIO.new("initial"), purpose: :assistants)
      replacement.file = input

      assert_same(input, replacement.file)
      assert_same(input, replacement.to_h.fetch(:file))
    end
  end

  def test_string_readback_still_materializes_binary_string_io
    state = OpenAI::Internal::Type::Converter.new_coerce_state
    file = OpenAI::Internal::Type::Converter.coerce(
      OpenAI::Internal::Type::FileInput,
      "synthetic bytes",
      state: state
    )

    assert_instance_of(StringIO, file)
    assert_equal("synthetic bytes", file.string)
  end

  def test_invalid_input_still_raises_on_readback
    params = OpenAI::FileCreateParams.new(file: Object.new, purpose: :assistants)

    assert_raises(OpenAI::Errors::ConversionError) { params.file }
  end

  def test_readback_preserves_native_upload_dump_and_retry_eligibility
    source = StringIO.new("synthetic bytes")
    params = OpenAI::FileCreateParams.new(file: source, purpose: :assistants)

    assert_same(source, params.file)

    dumped, options = OpenAI::FileCreateParams.dump_request(params)
    part = dumped.fetch(:file)

    assert_instance_of(OpenAI::FilePart, part)
    assert_same(source, part.content)
    assert_equal("synthetic bytes", part.content.string)
    refute_includes(options, :max_retries)

    Dir.mktmpdir("openai-file-input-readback") do |dir|
      path = File.join(dir, "synthetic.jsonl")
      File.binwrite(path, "synthetic bytes")

      File.open(path, "rb") do |file|
        file.pos = 3
        params = OpenAI::FileCreateParams.new(file: file, purpose: :assistants)

        assert_same(file, params.file)
        assert_equal(3, file.pos)
        refute_predicate(file, :closed?)

        dumped, options = OpenAI::FileCreateParams.dump_request(params)

        assert_same(file, dumped.fetch(:file))
        assert_equal(0, options.fetch(:max_retries))
        assert_equal(3, file.pos)
        refute_predicate(file, :closed?)
      end
    end
  end

  private def with_documented_inputs
    Dir.mktmpdir("openai-file-input-readback") do |dir|
      path = Pathname(File.join(dir, "synthetic.jsonl"))
      File.binwrite(path, "synthetic bytes")
      string_io = StringIO.new("synthetic bytes")
      file_part = OpenAI::FilePart.new(StringIO.new("synthetic bytes"), filename: "synthetic.jsonl")

      File.open(path, "rb") do |file|
        [path, string_io, file, "synthetic bytes", file_part].each { yield(_1) }
      end
    end
  end
end
