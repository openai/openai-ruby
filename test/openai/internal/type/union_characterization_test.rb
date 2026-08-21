# frozen_string_literal: true

require_relative "../../test_helper"
require_relative "union_characterization"

class OpenAI::Test::UnionCharacterizationTest < Minitest::Test
  EXPECTED_PATH = File.expand_path("../../../fixtures/union_characterization/main.json", __dir__)

  def test_current_union_characterization_matches_the_recorded_main_baseline
    expected = JSON.parse(File.read(EXPECTED_PATH))

    assert_equal(expected, OpenAI::Test::UnionCharacterization.observe)
  end

  def test_ambiguous_and_unknown_values_are_not_labeled_uniquely_resolvable
    observations = OpenAI::Test::UnionCharacterization.observe
    ambiguous_ids = observations.keys.grep(/responses|beta/)
    ambiguous_ids.concat(%w[realtime_unknown_server_event realtime_unknown_server_event_symbols])

    ambiguous_ids.each { refute(observations.fetch(_1).fetch("uniquely_resolvable"), _1) }
    %w[realtime_known_unique_server_event realtime_known_unique_server_event_symbols].each do |id|
      assert(observations.fetch(id).fetch("uniquely_resolvable"), id)
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
end
