# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::RequestOptionsScopeTest < Minitest::Test
  def test_child_preserves_options_without_an_idempotency_key
    original = {max_retries: 2, extra_headers: {"X-Test" => "yes"}}
    child = OpenAI::Internal::RequestOptionsScope.new(original).child("upload-0")

    assert_equal(original, child)
    refute_same(original, child)
    assert_equal({max_retries: 2, extra_headers: {"X-Test" => "yes"}}, original)
  end

  def test_child_derives_stable_distinct_model_and_header_keys
    original = OpenAI::RequestOptions.new(
      idempotency_key: "model-key",
      extra_headers: {"IDEMPOTENCY-KEY" => "header-key"}
    )
    scope = OpenAI::Internal::RequestOptionsScope.new(original)

    first = scope.child("upload-0")
    repeated = scope.child("upload-0")
    second = scope.child("upload-1")

    assert_equal(first, repeated)
    refute_equal(first[:idempotency_key], second[:idempotency_key])
    refute_equal(
      first.fetch(:extra_headers).fetch("IDEMPOTENCY-KEY"),
      second.fetch(:extra_headers).fetch("IDEMPOTENCY-KEY")
    )
    assert_match(/\Astainless-ruby-[0-9a-f]{64}\z/, first[:idempotency_key])
    assert_equal("model-key", original.idempotency_key)
    assert_equal({"IDEMPOTENCY-KEY" => "header-key"}, original.extra_headers)
  end

  def test_child_ignores_a_nil_idempotency_header
    child = OpenAI::Internal::RequestOptionsScope.new(
      extra_headers: {"Idempotency-Key" => nil}
    ).child("upload-0")

    assert_equal({extra_headers: {"Idempotency-Key" => nil}}, child)
  end

  def test_child_accepts_nil_options
    assert_empty(OpenAI::Internal::RequestOptionsScope.new(nil).child("upload-0"))
  end

  def test_scope_snapshots_extra_headers
    headers = {"Idempotency-Key" => "original"}
    scope = OpenAI::Internal::RequestOptionsScope.new(extra_headers: headers)
    headers["Idempotency-Key"] = "mutated"

    child = scope.child("upload-0")

    expected = OpenAI::Internal::RequestOptionsScope.new(
      extra_headers: {"Idempotency-Key" => "original"}
    ).child("upload-0")
    assert_equal(expected, child)
  end
end
