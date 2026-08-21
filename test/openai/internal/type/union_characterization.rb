# frozen_string_literal: true

require "json"
require "uri"

module OpenAI
  module Test
  end
end

module OpenAI::Test::UnionCharacterization
  FIXTURE_PATH = File.expand_path("../../../fixtures/union_characterization/cases.json", __dir__)
  SYMBOL_VALUE_KEYS = %w[role type].freeze
  UNION_TARGETS = {
    "responses_input_item" => OpenAI::Responses::ResponseInputItem,
    "beta_response_input_item" => OpenAI::Beta::BetaResponseInputItem,
    "responses_stream_event" => OpenAI::Responses::ResponseStreamEvent,
    "beta_response_stream_event" => OpenAI::Beta::BetaResponseStreamEvent,
    "realtime_server_event" => OpenAI::Realtime::RealtimeServerEvent
  }.freeze

  module_function

  def observe = fixtures.to_h { |fixture| [fixture.fetch("id"), observe_case(fixture)] }

  def fixtures = JSON.parse(File.read(FIXTURE_PATH))

  def observe_case(fixture)
    union = UNION_TARGETS.fetch(fixture.fetch("union"))
    input = fixture_input(fixture)
    candidates = union.variants.map { observe_candidate(_1, input) }
    exact_candidates = candidates.filter_map do |candidate|
      candidate.fetch("target") if candidate.fetch("exactness").values_at("no", "maybe") == [0, 0]
    end

    structural_candidates = candidates.filter_map do |candidate|
      candidate.fetch("target") if candidate.fetch("exactness").fetch("no").zero?
    end

    evidence = discriminator_evidence(fixture.fetch("discriminator"), input)

    state = OpenAI::Internal::Type::Converter.new_coerce_state
    selected = OpenAI::Internal::Type::Converter.coerce(union, duplicate(input), state: state)

    {
      "context" => fixture.fetch("context"),
      "input_form" => fixture.fetch("input_form"),
      "discriminator_evidence" => evidence,
      "exact_candidates" => exact_candidates,
      "structural_candidates" => structural_candidates,
      "best_ranked_fallbacks" => exact_candidates.empty? ? best_ranked_fallbacks(candidates) : [],
      "uniquely_resolvable" => fixture.fetch("uniquely_resolvable"),
      "compatibility_selected" => target_name(selected.class),
      "selected_error" => state.fetch(:error)&.class&.name,
      "selected_exactness" => stringify_keys(state.fetch(:exactness)),
      "serialized_body" => normalize(serialize(fixture, union, selected, input)),
      "public_boundary" => observe_public_boundary(fixture, input)
    }.compact
  end

  def observe_candidate(target, input)
    state = OpenAI::Internal::Type::Converter.new_coerce_state
    OpenAI::Internal::Type::Converter.coerce(target, duplicate(input), state: state)
    {
      "target" => target_name(target),
      "exactness" => stringify_keys(state.fetch(:exactness)),
      "error" => state.fetch(:error)&.class&.name
    }
  end

  def discriminator_evidence(expected, input)
    property = expected.fetch("property")
    value = input.fetch(property.to_sym) { input.fetch(property, OpenAI::Internal::OMIT) }
    evidence = {"property" => property, **expected.except("property")}
    if expected.fetch("state") == "missing"
      raise ArgumentError.new(expected) unless value == OpenAI::Internal::OMIT

      return evidence
    end

    raise ArgumentError.new(expected) if value == OpenAI::Internal::OMIT

    normalized = value.is_a?(Symbol) ? value.to_s : value
    {**evidence, "value" => normalized}
  end

  def best_ranked_fallbacks(candidates)
    alternatives = candidates.select { _1.fetch("exactness").fetch("maybe").positive? }
    return [] if alternatives.empty?

    best_score = alternatives.map { fallback_score(_1) }.min
    alternatives.filter_map { _1.fetch("target") if fallback_score(_1) == best_score }
  end

  def fallback_score(candidate)
    yes, no, maybe = candidate.fetch("exactness").values_at("yes", "no", "maybe")
    [-yes, -maybe, no]
  end

  def serialize(fixture, union, selected, input)
    case fixture.fetch("serialization")
    when "responses_request"
      params = OpenAI::Responses::ResponseCreateParams.new(input: [duplicate(input)], model: "gpt-4o")
      OpenAI::Responses::ResponseCreateParams.dump_request(params).first
    when "beta_responses_request"
      params = OpenAI::Beta::ResponseCreateParams.new(input: [duplicate(input)], model: "gpt-4o")
      OpenAI::Beta::ResponseCreateParams.dump_request(params).first
    when "union"
      OpenAI::Internal::Type::Converter.dump(union, selected)
    else
      raise ArgumentError.new(fixture)
    end
  end

  def observe_public_boundary(fixture, input)
    return unless fixture["public_boundary"] == "realtime_connection"
    return {"available" => false} unless defined?(OpenAI::Realtime::Connection)

    connection = OpenAI::Realtime::Connection.new(socket: nil, url: URI("wss://example.test"))
    event = connection.parse_event(JSON.generate(input))
    {
      "available" => true,
      "selected" => target_name(event.class),
      "body" => normalize(event.to_h)
    }
  end

  def fixture_input(fixture)
    input = duplicate(fixture.fetch("input"))
    case fixture.fetch("input_form")
    when "ruby_symbols"
      symbolize_ruby_input(input)
    when "wire"
      input
    else
      raise ArgumentError.new(fixture)
    end
  end

  def symbolize_ruby_input(value, parent_key: nil)
    case value
    in Hash
      value.to_h { |key, item| [key.to_sym, symbolize_ruby_input(item, parent_key: key)] }
    in Array
      value.map { symbolize_ruby_input(_1, parent_key: parent_key) }
    in String if SYMBOL_VALUE_KEYS.include?(parent_key)
      value.to_sym
    else
      value
    end
  end

  def duplicate(value)
    case value
    in Hash
      value.to_h { |key, item| [key, duplicate(item)] }
    in Array
      value.map { duplicate(_1) }
    else
      value
    end
  end

  def normalize(value)
    case value
    in Hash
      value.to_h { |key, item| [key.to_s, normalize(item)] }
    in Array
      value.map { normalize(_1) }
    in Symbol
      value.to_s
    else
      value
    end
  end

  def stringify_keys(value) = value.to_h { |key, item| [key.to_s, item] }

  def target_name(target) = target.name || target.inspect
end
