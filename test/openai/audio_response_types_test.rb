# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::AudioResponseTypesTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def before_all
    super
    WebMock.enable!
    WebMock.disable_net_connect!
  end

  def after_all
    WebMock.disable!
    super
  end

  def teardown
    WebMock.reset!
    super
  end

  def test_transcription_text_formats_are_readable_and_belong_to_the_declared_union
    [:text, :srt, :vtt].each do |format|
      stub_request(:post, "http://example.test/v1/audio/transcriptions").to_return(
        status: 200,
        headers: {"Content-Type" => "text/plain; charset=utf-8"},
        body: "hello\n"
      )
      result = client
        .audio
        .transcriptions
        .create(file: StringIO.new("audio"), model: "whisper-1", response_format: format)
      assert_kind_of(StringIO, result)
      assert(OpenAI::Models::Audio::TranscriptionCreateResponse === result)
      assert_equal("hello\n", result.read)
    end
  end

  def test_translation_text_formats_are_readable_and_belong_to_the_declared_union
    [:text, :srt, :vtt].each do |format|
      stub_request(:post, "http://example.test/v1/audio/translations").to_return(
        status: 200,
        headers: {"Content-Type" => "text/plain; charset=utf-8"},
        body: "hello\n"
      )
      result = client
        .audio
        .translations
        .create(file: StringIO.new("audio"), model: "whisper-1", response_format: format)
      assert_kind_of(StringIO, result)
      assert(OpenAI::Models::Audio::TranslationCreateResponse === result)
      assert_equal("hello\n", result.read)
    end
  end

  def test_json_transcriptions_remain_typed_models
    [:json, :verbose_json].each do |format|
      stub_request(:post, "http://example.test/v1/audio/transcriptions").to_return(
        status: 200,
        headers: {"Content-Type" => "application/json"},
        body: format == :json ? "{\"text\":\"hello\"}" : "{\"text\":\"hello\",\"duration\":1,\"language\":\"en\",\"task\":\"transcribe\"}"
      )
      result = client
        .audio
        .transcriptions
        .create(file: StringIO.new("audio"), model: "whisper-1", response_format: format)
      expected = format == :json ? OpenAI::Audio::Transcription : OpenAI::Audio::TranscriptionVerbose
      assert_kind_of(expected, result)
      assert_equal("hello", result.text)
    end
  end

  def test_json_translations_remain_typed_models
    [:json, :verbose_json].each do |format|
      stub_request(:post, "http://example.test/v1/audio/translations").to_return(
        status: 200,
        headers: {"Content-Type" => "application/json"},
        body: format == :json ? "{\"text\":\"hello\"}" : "{\"text\":\"hello\",\"duration\":1,\"language\":\"en\",\"task\":\"translate\"}"
      )
      result = client
        .audio
        .translations
        .create(file: StringIO.new("audio"), model: "whisper-1", response_format: format)
      assert_kind_of(OpenAI::Audio::Translation, result)
      assert_equal("hello", result.text)
      assert_equal(1, result.to_h[:duration]) if format == :verbose_json
    end
  end

  private

  def client
    OpenAI::Client.new(api_key: "synthetic-key", base_url: "http://example.test/v1", max_retries: 0)
  end
end
