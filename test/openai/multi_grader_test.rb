# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::MultiGraderTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def before_all
    super
    WebMock.enable!
  end

  def after_all
    WebMock.disable!
    super
  end

  def teardown
    WebMock.reset!
    super
  end

  def test_coerces_named_values_with_string_and_symbol_keys
    [grader_values, grader_values.transform_keys(&:to_s)].each do |graders|
      payload = multi_payload.merge(graders: graders)
      state = OpenAI::Internal::Type::Converter.new_coerce_state
      parsed = OpenAI::Internal::Type::Converter.coerce(OpenAI::Graders::MultiGrader, payload, state: state)

      assert_nil(state.fetch(:error))
      assert_named_graders(parsed)
      assert_equal(JSON.parse(JSON.generate(payload)), JSON.parse(parsed.to_json))
    end
  end

  def test_validate_and_run_send_named_graders
    raw_graders = JSON.parse(JSON.generate(grader_values))
    multi = OpenAI::Graders::MultiGrader.new(**multi_payload.merge(graders: raw_graders))
    wire = JSON.parse(JSON.generate(multi_payload))
    validate_request = stub_request(:post, "http://localhost/fine_tuning/alpha/graders/validate")
      .with { |request| JSON.parse(request.body) == {"grader" => wire} }
      .to_return_json(body: {grader: wire})
    run_request = stub_request(:post, "http://localhost/fine_tuning/alpha/graders/run")
      .with { |request| JSON.parse(request.body) == {"grader" => wire, "model_sample" => "synthetic"} }
      .to_return_json(body: {reward: 1.0, sub_rewards: {}, metadata: {}, model_grader_token_usage_per_model: {}})
    client = OpenAI::Client.new(base_url: "http://localhost", api_key: "synthetic", max_retries: 0)

    assert_same(raw_graders, multi.graders)

    response = client.fine_tuning.alpha.graders.validate(grader: multi)
    client.fine_tuning.alpha.graders.run(grader: multi, model_sample: "synthetic")

    assert_instance_of(OpenAI::Graders::MultiGrader, response.grader)
    assert_named_graders(response.grader)
    assert_equal(wire, JSON.parse(response.grader.to_json))
    assert_requested(validate_request, times: 1)
    assert_requested(run_request, times: 1)
  end

  def test_flat_and_array_graders_do_not_coerce_as_a_dictionary
    standalone = grader_values.fetch(:compliant)
    [standalone, [standalone]].each do |invalid|
      parsed = OpenAI::Internal::Type::Converter.coerce(
        OpenAI::Graders::MultiGrader,
        multi_payload.merge(graders: invalid)
      )

      assert_raises(OpenAI::Errors::ConversionError) { parsed.graders }
    end
  end

  private

  def assert_named_graders(multi)
    expected = {
      compliant: OpenAI::Graders::StringCheckGrader,
      similarity: OpenAI::Graders::TextSimilarityGrader,
      python_score: OpenAI::Graders::PythonGrader,
      model_score: OpenAI::Graders::ScoreModelGrader,
      label_score: OpenAI::Graders::LabelModelGrader
    }

    assert_equal(expected.keys.sort, multi.graders.keys.sort)
    expected.each { |key, model| assert_instance_of(model, multi.graders.fetch(key)) }
  end

  def multi_payload
    {type: "multi", name: "Combined", calculate_output: "0.5 * compliant", graders: grader_values}
  end

  def grader_values
    {
      compliant: {
        type: "string_check",
        name: "A display name, not the formula key",
        input: "{{sample.output_json.compliant}}",
        reference: "{{item.compliant}}",
        operation: "eq"
      },
      similarity: {
        type: "text_similarity",
        name: "Similarity",
        input: "text",
        reference: "text",
        evaluation_metric: "fuzzy_match"
      },
      python_score: {type: "python", name: "Python", source: "def grade(sample, item):\n    return 1.0"},
      model_score: {
        type: "score_model",
        name: "Score",
        model: "synthetic-model",
        input: [{role: "user", content: "Score the sample"}]
      },
      label_score: {
        type: "label_model",
        name: "Label",
        model: "synthetic-model",
        input: [{role: "user", content: "Label the sample"}],
        labels: ["pass", "fail"],
        passing_labels: ["pass"]
      }
    }
  end
end
