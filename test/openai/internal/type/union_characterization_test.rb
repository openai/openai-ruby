# frozen_string_literal: true

require_relative "../../test_helper"
require_relative "union_characterization"

class OpenAI::Test::UnionCharacterizationTest < Minitest::Test
  def test_ambiguous_and_unknown_values_are_not_labeled_uniquely_resolvable
    observations = OpenAI::Test::UnionCharacterization.observe
    ambiguous_ids = observations.keys.grep(/responses|beta/)
    ambiguous_ids.concat(%w[realtime_unknown_server_event realtime_unknown_server_event_symbols])

    ambiguous_ids.each { refute(observations.fetch(_1).fetch("uniquely_resolvable"), _1) }
    %w[realtime_known_unique_server_event realtime_known_unique_server_event_symbols].each do |id|
      assert(observations.fetch(id).fetch("uniquely_resolvable"), id)
    end
  end

  def test_valid_responses_message_has_multiple_exact_candidates
    observation = OpenAI::Test::UnionCharacterization.observe.fetch(
      "responses_typed_message_without_type_symbols"
    )

    assert_equal("missing", observation.dig("discriminator_evidence", "state"))
    assert_equal(
      [
        "OpenAI::Models::Responses::EasyInputMessage",
        "OpenAI::Models::Responses::ResponseInputItem::Message",
        "OpenAI::Models::Responses::ResponseInputItem::CompactionTrigger"
      ],
      observation.fetch("exact_candidates")
    )
    assert_equal("OpenAI::Models::Responses::EasyInputMessage", observation.fetch("compatibility_selected"))
  end

  def test_duplicate_message_tag_does_not_make_the_responses_message_unique
    observation = OpenAI::Test::UnionCharacterization.observe.fetch(
      "responses_typed_message_with_duplicate_tag_symbols"
    )

    assert_equal("known_duplicate", observation.dig("discriminator_evidence", "state"))
    assert_equal(3, observation.dig("discriminator_evidence", "matching_variants"))
    assert_equal(2, observation.fetch("exact_candidates").length)
    refute(observation.fetch("uniquely_resolvable"))
  end

  def test_request_shorthand_and_unknown_fields_retain_their_wire_representation
    observations = OpenAI::Test::UnionCharacterization.observe
    responses_body = observations.fetch("responses_typed_message_without_type_symbols").fetch("serialized_body")
    beta_body = observations.fetch("beta_typed_message_without_type").fetch("serialized_body")
    unknown_field_body = observations.fetch("responses_typed_message_with_unknown_field").fetch("serialized_body")

    expected_message = {
      "role" => "user",
      "content" => [{"type" => "input_text", "text" => "hello"}]
    }
    assert_equal({"input" => [expected_message], "model" => "gpt-4o"}, responses_body)
    assert_equal(responses_body, beta_body)
    assert_equal({"preserved" => true}, unknown_field_body.dig("input", 0, "future_field"))
  end

  def test_explicitly_unknown_stream_tags_retain_current_fallbacks
    expected_selections = {
      "responses_unknown_stream_event" => "OpenAI::Models::Responses::ResponseErrorEvent",
      "responses_unknown_stream_event_symbols" => "OpenAI::Models::Responses::ResponseImageGenCallPartialImageEvent",
      "beta_unknown_stream_event" => "OpenAI::Models::Beta::BetaResponseErrorEvent",
      "beta_unknown_stream_event_symbols" => "OpenAI::Models::Beta::BetaResponseImageGenCallPartialImageEvent"
    }
    observations = OpenAI::Test::UnionCharacterization.observe

    expected_selections.each do |id, selected|
      observation = observations.fetch(id)

      assert_equal("explicitly_unknown", observation.dig("discriminator_evidence", "state"), id)
      assert_empty(observation.fetch("exact_candidates"), id)
      assert_equal([selected], observation.fetch("best_ranked_fallbacks"), id)
      assert_equal(selected, observation.fetch("compatibility_selected"), id)
      assert_equal(
        {"type" => "future.unmodeled.event", "sequence_number" => 9},
        observation.fetch("serialized_body"),
        id
      )
    end
  end

  def test_realtime_boundary_preserves_an_explicitly_unknown_event
    cases = OpenAI::Test::UnionCharacterization.observe

    %w[realtime_unknown_server_event realtime_unknown_server_event_symbols].each do |id|
      boundary = cases.fetch(id).fetch("public_boundary")

      assert_equal(true, boundary.fetch("available"))
      assert_equal("OpenAI::Models::Realtime::UnknownServerEvent", boundary.fetch("selected"))
      assert_equal("future.unmodeled.event", boundary.dig("body", "type"))
    end
  end

  def test_known_realtime_tag_selects_the_unique_discriminator_variant
    observations = OpenAI::Test::UnionCharacterization.observe
    expected_exact_candidates = {
      "realtime_known_unique_server_event" => [],
      "realtime_known_unique_server_event_symbols" => ["OpenAI::Models::Realtime::ConversationCreatedEvent"]
    }

    expected_exact_candidates.each do |id, exact_candidates|
      observation = observations.fetch(id)

      assert_equal("known_unique", observation.dig("discriminator_evidence", "state"), id)
      assert_equal(exact_candidates, observation.fetch("exact_candidates"), id)
      assert_equal(
        "OpenAI::Models::Realtime::ConversationCreatedEvent",
        observation.fetch("compatibility_selected"),
        id
      )
    end
  end
end
