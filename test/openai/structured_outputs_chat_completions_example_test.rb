# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::StructuredOutputsChatCompletionsExampleTest < Minitest::Test
  extend Minitest::Serial

  EXAMPLE_PATH = File.expand_path("../../examples/structured_outputs_chat_completions.rb", __dir__)

  def test_prints_parsed_calendar_event
    stdout, stderr, exit_error = run_example do |event_model|
      [choice(parsed: calendar_event(event_model))]
    end

    assert_nil(exit_error)
    assert_empty(stderr)
    assert_includes(stdout, "CalendarEvent")
    assert_includes(stdout, "Science fair")
  end

  def test_fails_clearly_when_completion_has_no_choices
    assert_missing_calendar_event { [] }
  end

  def test_fails_clearly_when_every_choice_is_refused
    assert_missing_calendar_event do |event_model|
      [choice(parsed: calendar_event(event_model), refusal: "I cannot help with that")]
    end
  end

  def test_fails_clearly_when_parsed_value_is_nil
    assert_missing_calendar_event { [choice(parsed: nil)] }
  end

  def test_fails_clearly_when_parsed_value_has_the_wrong_shape
    assert_missing_calendar_event { [choice(parsed: {name: "Science fair"})] }
  end

  def test_fails_clearly_when_parsed_value_is_another_model
    assert_missing_calendar_event do
      message = OpenAI::Models::Chat::ChatCompletionMessage.new(content: nil, refusal: nil)
      [choice(parsed: message)]
    end
  end

  def test_ignores_refused_and_invalid_choices_and_prints_each_calendar_event
    stdout, stderr, exit_error = run_example do |event_model|
      [
        choice(parsed: calendar_event(event_model, name: "Refused event"), refusal: "No"),
        choice(parsed: nil),
        choice(parsed: {name: "Wrong shape"}),
        choice(parsed: calendar_event(event_model, name: "Science fair")),
        choice(parsed: calendar_event(event_model, name: "Team lunch"))
      ]
    end

    assert_nil(exit_error)
    assert_empty(stderr)
    assert_equal(2, stdout.scan("CalendarEvent").length)
    assert_includes(stdout, "Science fair")
    assert_includes(stdout, "Team lunch")
    refute_includes(stdout, "Refused event")
    refute_includes(stdout, "Wrong shape")
  end

  def test_fails_clearly_when_mixed_choices_have_no_valid_calendar_event
    assert_missing_calendar_event do |event_model|
      [
        choice(parsed: calendar_event(event_model), refusal: "No"),
        choice(parsed: nil),
        choice(parsed: {name: "Wrong shape"})
      ]
    end
  end

  private

  def assert_missing_calendar_event(&choices)
    stdout, stderr, exit_error = run_example(&choices)

    assert_instance_of(SystemExit, exit_error)
    assert_equal(1, exit_error.status)
    assert_empty(stdout)
    assert_equal("The response did not contain a parsed CalendarEvent\n", stderr)
  end

  def run_example(&choices)
    mocks = []
    constructor = lambda do
      response = Minitest::Mock.new

      completions = Minitest::Mock.new
      completions.expect(:create, response) do |**params|
        response.expect(:choices, choices.call(params.fetch(:response_format)))
        true
      end

      chat = Minitest::Mock.new
      chat.expect(:completions, completions)

      client = Minitest::Mock.new
      client.expect(:chat, chat)
      mocks.push(response, completions, chat, client)
      client
    end

    exit_error = nil
    stdout, stderr = capture_io do
      OpenAI::Client.stub(:new, constructor) do
        load(EXAMPLE_PATH, true)
      rescue SystemExit => error
        exit_error = error
      end
    end

    mocks.each(&:verify)

    [stdout, stderr, exit_error]
  end

  def choice(parsed:, refusal: nil)
    OpenAI::Models::Chat::ParsedChoice.new(
      finish_reason: :stop,
      index: 0,
      logprobs: nil,
      message: OpenAI::Models::Chat::ChatCompletionMessage.new(
        content: nil,
        parsed: parsed,
        refusal: refusal
      )
    )
  end

  def calendar_event(event_model, name: "Science fair")
    event_model.new(
      name: name,
      date: "Friday",
      participants: [],
      optional_participants: nil,
      is_virtual: false,
      location: nil
    )
  end
end
