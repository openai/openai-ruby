# frozen_string_literal: true

require_relative "../test_helper"
require "json"
require "yaml"
require "logger"
require "stringio"

class OpenAI::Test::RealtimeReconnectErrorTest < Minitest::Test
  def test_recovery_is_explicit_even_when_errors_are_serialized
    unsent = "{\"type\":\"response.create\",\"response\":{\"instructions\":\"FAKE_QUEUED_PROMPT_463\"}}"
    uncertain = "{\"type\":\"response.create\",\"response\":{\"instructions\":\"FAKE_UNCERTAIN_PROMPT_941\"}}"
    source = [unsent]
    error = OpenAI::Errors::RealtimeReconnectError.new(
      message: "Realtime connection could not recover.",
      unsent_messages: source,
      uncertain_message: uncertain
    )
    source.clear

    [error, error.dup, error.clone].each do |live_error|
      assert_equal([unsent], live_error.unsent_messages)
      assert_predicate(live_error.unsent_messages, :frozen?)
      assert_equal(uncertain, live_error.uncertain_message)
    end

    log = StringIO.new
    Logger.new(log).error(error)
    collected = error.instance_variables.to_h { |name| [name, error.instance_variable_get(name)] }
    renderings = {
      message: error.message,
      inspect: error.inspect,
      trace: error.full_message,
      log: log.string,
      json: JSON.generate(error),
      collected_inspect: collected.inspect,
      collected_json: JSON.generate(collected),
      yaml: YAML.dump(error),
      marshal: Marshal.dump(error)
    }
    renderings.each do |name, rendered|
      ["FAKE_QUEUED_PROMPT_463", "FAKE_UNCERTAIN_PROMPT_941"].each do |marker|
        refute_includes(rendered, marker, "#{name} should not expose recovery data")
      end
    end
  end

  def test_loaded_diagnostics_reject_recovery_even_if_the_live_queue_was_empty
    [
      OpenAI::Errors::RealtimeReconnectError.new(message: "Empty live recovery."),
      OpenAI::Errors::RealtimeReconnectError.new(
        message: "Pending live recovery.",
        unsent_messages: ["FAKE_QUEUED_FRAME_636"],
        uncertain_message: "FAKE_UNCERTAIN_FRAME_282"
      )
    ].each do |error|
      error.set_backtrace(["realtime_example.rb:37:in 'send'"])
      assert_empty(error.unsent_messages) if error.message == "Empty live recovery."
      assert_nil(error.uncertain_message) if error.message == "Empty live recovery."
      # Both strings below are produced from synthetic test values, not untrusted data.
      copies = [Marshal.load(Marshal.dump(error)), YAML.unsafe_load(YAML.dump(error))]
      copies.each do |copy|
        assert_instance_of(OpenAI::Errors::RealtimeReconnectError, copy)
        assert_equal(error.message, copy.message)
        assert_equal(error.backtrace, copy.backtrace)
        [:unsent_messages, :uncertain_message].each do |accessor|
          failure = assert_raises(OpenAI::Errors::Error) { copy.public_send(accessor) }
          assert_match(/recovery data is unavailable/i, failure.message)
        end
      end
    end
  end

  def test_original_and_serialized_exception_metadata_keeps_ruby_behavior
    begin
      begin
        raise ArgumentError, "sanitized transport failure"
      rescue ArgumentError
        raise OpenAI::Errors::RealtimeReconnectError.new(message: "Recovery failed.", unsent_messages: ["FAKE_FRAME"])
      end

    rescue OpenAI::Errors::RealtimeReconnectError => error
      [error, error.dup, error.clone, Marshal.load(Marshal.dump(error))].each do |copy|
        assert_equal(error.message, copy.message)
        assert_equal(error.backtrace, copy.backtrace)
        assert_instance_of(ArgumentError, copy.cause)
        assert_equal("sanitized transport failure", copy.cause.message)
        assert_equal(error.cause.backtrace, copy.cause.backtrace)
      end

      # Psych does not retain native Exception#cause, before or after this change.
      diagnostic = YAML.unsafe_load(YAML.dump(error))
      assert_equal(error.message, diagnostic.message)
      assert_equal(error.backtrace, diagnostic.backtrace)
      assert_nil(diagnostic.cause)
      assert_equal(["FAKE_FRAME"], error.unsent_messages)
    end
  end
end
