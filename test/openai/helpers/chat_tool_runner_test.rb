# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::ChatToolRunnerTest < Minitest::Test
  class Lookup < OpenAI::BaseModel
    required :city, String
  end

  class Answer < OpenAI::BaseModel
    required :temperature, Integer
  end

  class Transport < OpenAI::HTTPClient
    attr_reader :requests

    def initialize(responses)
      super()
      @responses = responses.dup
      @requests = []
    end

    def execute(request)
      @requests << {body: JSON.parse(request.body), headers: request.headers}
      response = @responses.shift
      raise "Unexpected request" unless response
      raise response if response.is_a?(Exception)
      return response if response.is_a?(OpenAI::HTTPClient::Response)

      status, body = response.is_a?(Array) ? response : [200, response]
      OpenAI::HTTPClient::Response.new(
        status: status,
        headers: {"content-type" => "application/json"},
        body: JSON.generate(body)
      )
    end
  end

  def test_multiple_tools_and_rounds_preserve_history_and_return_typed_completion
    transport, client = client_for(
      completion(calls: [call("a"), call("b", arguments: "{\"city\":\"Portland\"}")]),
      completion(calls: [call("c")]),
      completion(content: "Done")
    )
    cities = []
    messages = [{role: :user, content: "Weather?"}.freeze].freeze
    result = run_tools(
      client,
      messages: messages,
      tool_handlers: {
        "lookup" => -> (args) {
          cities << args.fetch("city")
          {temperature: 20}
        }
      }
    )

    assert_instance_of(OpenAI::Chat::ChatCompletion, result)
    assert_equal("Done", result.choices.first.message.content)
    assert_equal(%w[Seattle Portland Seattle], cities)
    assert_equal(1, messages.length)
    assert_equal(3, transport.requests.length)
    history = transport.requests.last[:body].fetch("messages")
    assert_equal(%w[user assistant tool tool assistant tool], history.map { |m| m.fetch("role") })
    assert_equal(%w[a b c], history.select { |m| m["role"] == "tool" }.map { |m| m["tool_call_id"] })
    assert_equal("{\"temperature\":20}", history.last.fetch("content"))
    refute(transport.requests.first[:body].key?("tool_handlers"))
    refute(transport.requests.first[:body].key?("max_rounds"))
  end

  def test_no_tool_call_returns_immediately_including_refusal
    transport, client = client_for(completion(content: nil, refusal: "Cannot help"))
    result = run_tools(client, tool_handlers: {"lookup" => -> (_) { flunk("Unexpected callback") }})
    assert_equal("Cannot help", result.choices.first.message.refusal)
    assert_equal(1, transport.requests.length)
  end

  def test_complete_tool_calls_with_stop_finish_reason_are_dispatched
    transport, client = client_for(completion(calls: [call("a")], reason: :stop), completion)
    result = run_tools(client)
    assert_equal("Done", result.choices.first.message.content)
    assert_equal("Sunny", transport.requests.last[:body]["messages"].last["content"])
  end

  def test_typed_tool_schema_and_structured_final_output
    transport, client = client_for(
      completion(calls: [call("a", name: "Lookup")], content: nil),
      completion(content: "{\"temperature\":20}")
    )
    result = run_tools(
      client,
      tools: [Lookup],
      response_format: Answer,
      tool_handlers: {"Lookup" => -> (args) { args.fetch("city") }}
    )

    assert_instance_of(Answer, result.choices.first.message.parsed)
    assert_equal(20, result.choices.first.message.parsed.temperature)
    assert_equal("Seattle", transport.requests.last[:body]["messages"].last["content"])
    assistant_call = transport.requests.last[:body]["messages"][1]["tool_calls"].first
    assert_equal(%w[arguments name], assistant_call.fetch("function").keys.sort)
    assert_equal("Lookup", transport.requests.first[:body]["tools"].first["function"]["name"])
  end

  def test_forced_choice_becomes_auto_without_mutating_options
    transport, client = client_for(completion(calls: [call("a")]), completion)
    choice = {type: :function, function: {name: "lookup"}.freeze}.freeze
    run_tools(
      client,
      tool_choice: choice,
      temperature: 0.2,
      request_options: {extra_headers: {"x-test" => "synthetic"}, max_retries: 0}
    )

    assert_equal("function", transport.requests.first[:body]["tool_choice"]["type"])
    assert_equal("auto", transport.requests.last[:body]["tool_choice"])
    assert_equal(:function, choice[:type])
    transport.requests.each { |request| assert_in_delta(0.2, request[:body]["temperature"]) }
    assert(transport.requests.all? { |request| request[:headers]["x-test"] == "synthetic" })
  end

  def test_allowed_tools_restriction_survives_continuation
    choices = [
      {type: :allowed_tools, allowed_tools: {mode: :required, tools: [{type: :function, function: {name: "lookup"}}]}},
      OpenAI::Chat::ChatCompletionAllowedToolChoice.new(
        allowed_tools: OpenAI::Chat::ChatCompletionAllowedTools.new(
          mode: :required,
          tools: [{type: :function, function: {name: "lookup"}}]
        )
      ),
      {
        "type" => "allowed_tools",
        "allowed_tools" => {
          "mode" => "required",
          "tools" => [{"type" => "function", "function" => {"name" => "lookup"}}]
        }
      }
    ]
    choices.each do |choice|
      transport, client = client_for(completion(calls: [call("a")]), completion)
      original = JSON.generate(choice)
      run_tools(client, tool_choice: choice)
      first = transport.requests.first[:body].fetch("tool_choice")
      followup = transport.requests.last[:body].fetch("tool_choice")
      assert_equal("required", first.dig("allowed_tools", "mode"))
      assert_equal(first.merge("allowed_tools" => first.fetch("allowed_tools").merge("mode" => "auto")), followup)
      refute(followup.key?("mode"))
      assert_equal(original, JSON.generate(choice))
    end
  end

  def test_required_and_forced_choices_reject_final_answers_on_first_round
    choices = [
      :required,
      "required",
      {type: :function, function: {name: "lookup"}},
      {"type" => "function", "function" => {"name" => "lookup"}},
      OpenAI::Chat::ChatCompletionNamedToolChoice.new(function: {name: "lookup"}),
      {type: :allowed_tools, allowed_tools: {mode: :required, tools: [{type: :function, function: {name: "lookup"}}]}}
    ]
    choices.each do |choice|
      transport, client = client_for(completion)
      assert_raises(OpenAI::Helpers::Chat::ToolRunner::Error) do
        run_tools(client, tool_choice: choice)
      end

      assert_equal(1, transport.requests.length)
    end
  end

  def test_disabled_or_different_forced_tool_rejects_entire_batch_before_callbacks
    choices = [
      :none,
      "none",
      {type: :function, function: {name: "lookup"}},
      {"type" => "function", "function" => {"name" => "lookup"}},
      OpenAI::Chat::ChatCompletionNamedToolChoice.new(function: {name: "lookup"})
    ]
    choices.each do |choice|
      transport, client = client_for(completion(calls: [call("a"), call("b", name: "other")]))
      assert_raises(OpenAI::Helpers::Chat::ToolRunner::Error) do
        run_tools(
          client,
          tool_choice: choice,
          tools: [tool, tool.merge(function: tool.fetch(:function).merge(name: "other"))],
          tool_handlers: {
            "lookup" => -> (_) { flunk("Callback ran before the whole batch was validated") },
            "other" => -> (_) { flunk("Disallowed callback ran") }
          }
        )
      end

      assert_equal(1, transport.requests.length)
    end
  end

  def test_required_choice_allows_a_final_answer_after_tool_execution
    transport, client = client_for(completion(calls: [call("a")]), completion)
    result = run_tools(client, tool_choice: :required)
    assert_equal("Done", result.choices.first.message.content)
    assert_equal("auto", transport.requests.last[:body]["tool_choice"])
  end

  def test_disabled_tools_allow_a_final_answer
    transport, client = client_for(completion)
    result = run_tools(client, tool_choice: :none)
    assert_equal("Done", result.choices.first.message.content)
    assert_equal(1, transport.requests.length)
  end

  def test_allowed_tools_subset_rejects_entire_batch_before_callbacks
    [:auto, :required].each do |mode|
      transport, client = client_for(completion(calls: [call("a"), call("b", name: "excluded")]))
      definitions = [tool, tool.merge(function: tool.fetch(:function).merge(name: "excluded"))]
      error = assert_raises(OpenAI::Helpers::Chat::ToolRunner::Error) do
        run_tools(
          client,
          tools: definitions,
          tool_choice: {
            type: :allowed_tools,
            allowed_tools: {mode: mode, tools: [{type: :function, function: {name: "lookup"}}]}
          },
          tool_handlers: {
            "lookup" => -> (_) { flunk("Allowed callback ran before the whole batch was validated") },
            "excluded" => -> (_) { flunk("Excluded callback ran") }
          }
        )
      end

      assert_includes(error.message, "not allowed")
      assert_equal(1, transport.requests.length)
    end
  end

  def test_allowed_tools_subset_remains_enforced_on_later_rounds
    transport, client = client_for(
      completion(calls: [call("a")]),
      completion(calls: [call("b"), call("c", name: "excluded")])
    )
    executions = 0
    definitions = [tool, tool.merge(function: tool.fetch(:function).merge(name: "excluded"))]
    assert_raises(OpenAI::Helpers::Chat::ToolRunner::Error) do
      run_tools(
        client,
        tools: definitions,
        tool_choice: {
          type: :allowed_tools,
          allowed_tools: {mode: :required, tools: [{type: :function, function: {name: "lookup"}}]}
        },
        tool_handlers: {
          "lookup" => -> (_) { executions += 1 },
          "excluded" => -> (_) { flunk("Excluded callback ran") }
        }
      )
    end

    assert_equal(1, executions)
    assert_equal(2, transport.requests.length)
  end

  def test_invalid_allowed_tools_configurations_fail_before_network
    [
      nil,
      {mode: :auto},
      {mode: :auto, tools: [nil]},
      {mode: :auto, tools: [{type: :custom, custom: {name: "lookup"}}]},
      {mode: :auto, tools: [{type: :function, function: {name: "unregistered"}}]}
    ].each do |allowed|
      transport, client = client_for
      assert_raises(ArgumentError) do
        run_tools(client, tool_choice: {type: :allowed_tools, allowed_tools: allowed})
      end

      assert_empty(transport.requests)
    end
  end

  def test_entire_batch_validates_before_callbacks
    [call("b", name: "unknown"), call("b", arguments: "invalid secret"), call("a")].each do |invalid|
      transport, client = client_for(completion(calls: [call("a"), invalid]))
      error = assert_raises(OpenAI::Helpers::Chat::ToolRunner::Error) do
        run_tools(client, tool_handlers: {"lookup" => -> (_) { flunk("Batch was not validated") }})
      end

      refute_includes(error.message, "secret")
      assert_equal(1, transport.requests.length)
    end
  end

  def test_malformed_function_payloads_raise_runner_error_before_any_callback
    invalid_calls = [
      call("b").except(:function),
      call("b").merge(function: nil),
      call("b").merge(function: "synthetic-private"),
      call("b").merge(function: {}),
      call("b").merge(function: {name: 123, arguments: "{}"}),
      call("b").merge(function: {name: "lookup", arguments: {city: "synthetic-private"}})
    ]
    invalid_calls.each do |invalid|
      transport, client = client_for(completion(calls: [call("a"), invalid]))
      error = assert_raises(OpenAI::Helpers::Chat::ToolRunner::Error) do
        run_tools(client, tool_handlers: {"lookup" => -> (_) { flunk("Malformed batch dispatched") }})
      end

      assert_equal(1, transport.requests.length)
      refute_includes(error.full_message, "synthetic-private")
    end
  end

  def test_malformed_completion_fields_raise_runner_error_before_any_callback
    paths = [
      [:choices],
      [:choices, 0],
      [:choices, 0, :message],
      [:choices, 0, :finish_reason],
      [:choices, 0, :message, :role],
      [:choices, 0, :message, :tool_calls]
    ]
    paths.each do |path|
      [nil, "synthetic-private", 123, {}].each do |value|
        response = completion(calls: [call("a")])
        parent = path.length == 1 ? response : response.dig(*path[0...-1])
        parent[path.last] = value
        transport, client = client_for(response)
        error = assert_raises(OpenAI::Helpers::Chat::ToolRunner::Error, "Malformed #{path.inspect}") do
          run_tools(client, tool_handlers: {"lookup" => -> (_) { flunk("Malformed completion dispatched") }})
        end

        assert_equal(1, transport.requests.length)
        refute_includes(error.full_message, "synthetic-private")
      end
    end
  end

  def test_missing_required_completion_fields_raise_runner_error
    [[:choices], [:choices, 0, :message], [:choices, 0, :finish_reason], [:choices, 0, :message, :role]].each do |path|
      response = completion(calls: [call("a")])
      parent = path.length == 1 ? response : response.dig(*path[0...-1])
      parent.delete(path.last)
      _, client = client_for(response)
      assert_raises(OpenAI::Helpers::Chat::ToolRunner::Error) do
        run_tools(client, tool_handlers: {"lookup" => -> (_) { flunk("Malformed completion dispatched") }})
      end
    end
  end

  def test_missing_or_mistyped_assistant_text_fields_never_dispatch_or_return
    [:content, :refusal].each do |field|
      [nil, [call("a")]].each do |calls|
        [:missing, 123, false, {private: "synthetic-private"}, []].each do |value|
          response = completion(calls: calls)
          message = response[:choices].first[:message]
          if value == :missing
            message.delete(field)
          else
            message[field] = value
          end

          transport, client = client_for(response)
          error = assert_raises(OpenAI::Helpers::Chat::ToolRunner::Error) do
            run_tools(client, tool_handlers: {"lookup" => -> (_) { flunk("Malformed assistant message dispatched") }})
          end

          assert_equal(1, transport.requests.length)
          refute_includes(error.full_message, "synthetic-private")
        end
      end
    end
  end

  def test_raw_tool_call_identity_is_validated_before_any_callback
    invalid_calls = [
      call("b").except(:type),
      call("b").merge(type: nil),
      call("b").merge(type: "other"),
      call(123),
      call("b", name: 123)
    ]
    invalid_calls.each do |invalid|
      transport, client = client_for(completion(calls: [call("a"), invalid]))
      assert_raises(OpenAI::Helpers::Chat::ToolRunner::Error) do
        run_tools(
          client,
          tools: [tool, tool.merge(function: tool.fetch(:function).merge(name: "123"))],
          tool_handlers: {
            "lookup" => -> (_) { flunk("Malformed batch dispatched") },
            "123" => -> (_) { flunk("Coerced function name dispatched") }
          }
        )
      end

      assert_equal(1, transport.requests.length)
    end
  end

  def test_invalid_json_responses_are_sanitized
    ["", "{\"synthetic-private\":", "synthetic-private", "{\"choices\":[{\"message\":{\"content\":\"synthetic-private"].each do |
        body
      |
      response = OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/json"},
        body: body
      )
      transport, = client_for(response)
      log = StringIO.new
      client = OpenAI::Client.new(
        api_key: "synthetic-key",
        http_client: transport,
        max_retries: 0,
        logger: Logger.new(log),
        log_level: :debug
      )
      error = assert_raises(OpenAI::Helpers::Chat::ToolRunner::Error) do
        run_tools(client, tool_handlers: {"lookup" => -> (_) { flunk("Malformed JSON dispatched") }})
      end

      assert_nil(error.cause)
      refute_includes(error.full_message, "synthetic-private")
      refute_includes(log.string, "synthetic-private")
      assert_equal(1, transport.requests.length)
    end
  end

  def test_response_metadata_and_raw_body_opt_in_are_preserved
    [false, true].each do |include_raw_body|
      body = JSON.pretty_generate(completion)
      response = OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/json", "x-request-id" => "req_synthetic"},
        body: body
      )
      _, client = client_for(response)
      result = run_tools(client, request_options: {include_raw_body: include_raw_body})
      assert_equal(200, result.last_response.status)
      assert_equal("req_synthetic", result.last_response.request_id)
      if include_raw_body
        assert_equal(body, result.last_response.body)
      else
        assert_nil(result.last_response.body)
      end
    end
  end

  def test_arguments_must_be_json_objects_and_parse_errors_do_not_leak_content
    ["[1]", "null", "\"synthetic-private\"", "{\"synthetic-private\":"].each do |arguments|
      _, client = client_for(completion(calls: [call("a", arguments: arguments)]))
      error = assert_raises(OpenAI::Helpers::Chat::ToolRunner::Error) do
        run_tools(client, tool_handlers: {"lookup" => -> (_) { flunk("Invalid arguments dispatched") }})
      end

      refute_includes(error.full_message, "synthetic-private")
    end
  end

  def test_repeated_call_ids_do_not_execute_again
    transport, client = client_for(completion(calls: [call("a")]), completion(calls: [call("a")]))
    executions = 0
    assert_raises(OpenAI::Helpers::Chat::ToolRunner::Error) do
      run_tools(client, tool_handlers: {"lookup" => -> (_) { executions += 1 }})
    end

    assert_equal(1, executions)
    assert_equal(2, transport.requests.length)
  end

  def test_prior_history_call_ids_are_not_reexecuted
    _, client = client_for(completion(calls: [call("a")]))
    assert_raises(OpenAI::Helpers::Chat::ToolRunner::Error) do
      run_tools(
        client,
        messages: [
          {role: :assistant, content: nil, tool_calls: [call("a")]},
          {role: :tool, tool_call_id: "a", content: "Already executed"}
        ],
        tool_handlers: {"lookup" => -> (_) { flunk("Historical call executed again") }}
      )
    end
  end

  def test_max_rounds_stops_before_unusable_callback_side_effects
    transport, client = client_for(completion(calls: [call("a")]), completion(calls: [call("b")]))
    executions = 0
    assert_raises(OpenAI::Helpers::Chat::ToolRunner::MaxRoundsError) do
      run_tools(client, max_rounds: 2, tool_handlers: {"lookup" => -> (_) { executions += 1 }})
    end

    assert_equal(1, executions)
    assert_equal(2, transport.requests.length)
  end

  def test_one_round_can_return_a_final_answer
    _, client = client_for(completion)
    assert_instance_of(OpenAI::Chat::ChatCompletion, run_tools(client, max_rounds: 1))
  end

  def test_callback_error_propagates_without_followup_or_retry
    transport, client = client_for(completion(calls: [call("a"), call("b")]))
    failure = RuntimeError.new("synthetic callback failure")
    executions = 0
    raised = assert_raises(RuntimeError) do
      run_tools(
        client,
        tool_handlers: {
          "lookup" => -> (_) {
            executions += 1
            raise failure
          }
        }
      )
    end

    assert_same(failure, raised)
    assert_equal(1, executions)
    assert_equal(1, transport.requests.length)
  end

  def test_followup_http_retry_does_not_repeat_callback
    transport, client = client_for(
      completion(calls: [call("a")]),
      [500, {error: {message: "synthetic transient failure"}}],
      completion
    )
    executions = 0
    run_tools(client, request_options: {max_retries: 1}, tool_handlers: {"lookup" => -> (_) { executions += 1 }})
    assert_equal(1, executions)
    assert_equal(3, transport.requests.length)
    assert_equal(transport.requests[1][:body], transport.requests[2][:body])
  end

  def test_callback_type_errors_are_not_wrapped_as_malformed_responses
    transport, client = client_for(completion(calls: [call("a")]))
    failure = TypeError.new("synthetic callback failure")
    raised = assert_raises(TypeError) do
      run_tools(client, tool_handlers: {"lookup" => -> (_) { raise failure }})
    end

    assert_same(failure, raised)
    assert_equal(1, transport.requests.length)
  end

  def test_custom_transport_errors_propagate_unchanged
    [KeyError, NoMethodError, TypeError, JSON::ParserError].each do |error_class|
      failure = error_class.new("synthetic transport failure")
      transport, client = client_for(failure)
      raised = assert_raises(error_class) { run_tools(client) }
      assert_same(failure, raised)
      assert_equal(1, transport.requests.length)
    end
  end

  def test_idempotency_keys_are_distinct_per_round_and_stable_on_retry
    [
      {idempotency_key: "synthetic-operation"},
      {extra_headers: {"IDEMPOTENCY-KEY" => "synthetic-operation"}}
    ].each do |options|
      transport, client = client_for(
        completion(calls: [call("a")]),
        [500, {error: {message: "synthetic transient failure"}}],
        completion
      )
      original = Marshal.dump(options)
      run_tools(client, request_options: options.merge(max_retries: 1))
      keys = transport.requests.map { |request| request[:headers]["idempotency-key"] }
      refute_nil(keys.first)
      refute_equal(keys[0], keys[1])
      assert_equal(keys[1], keys[2])
      assert_equal(original, Marshal.dump(options))
    end
  end

  def test_mutable_string_outputs_are_snapshotted_per_call
    transport, client = client_for(completion(calls: [call("a"), call("b")]), completion)
    output = +""
    run_tools(client, tool_handlers: {"lookup" => -> (_) { output << "x" }})
    results = transport.requests.last[:body]["messages"].select { |message| message["role"] == "tool" }
    assert_equal(["x", "xx"], results.map { |message| message["content"] })
  end

  def test_unserializable_callback_output_stops_without_followup
    transport, client = client_for(completion(calls: [call("a")]))
    assert_raises(JSON::GeneratorError) do
      run_tools(client, tool_handlers: {"lookup" => -> (_) { {temperature: Float::NAN} }})
    end

    assert_equal(1, transport.requests.length)
  end

  def test_callback_argument_mutation_does_not_change_assistant_history
    transport, client = client_for(completion(calls: [call("a")]), completion)
    run_tools(
      client,
      tool_handlers: {
        "lookup" => -> (arguments) {
          arguments["city"].replace("Portland")
          "Rain"
        }
      }
    )
    arguments = transport.requests.last[:body]["messages"][1]["tool_calls"].first["function"]["arguments"]
    assert_equal("{\"city\":\"Seattle\"}", arguments)
  end

  def test_custom_and_empty_id_calls_are_rejected_before_execution
    [call(""), {id: "a", type: :custom, custom: {name: "lookup", input: "Seattle"}}].each do |invalid|
      _, client = client_for(completion(calls: [invalid]))
      assert_raises(OpenAI::Helpers::Chat::ToolRunner::Error) do
        run_tools(client, tool_handlers: {"lookup" => -> (_) { flunk("Invalid call dispatched") }})
      end
    end
  end

  def test_followup_http_failure_does_not_repeat_callback
    transport, client = client_for(
      completion(calls: [call("a")]),
      [400, {error: {message: "synthetic failure"}}]
    )
    executions = 0
    assert_raises(OpenAI::Errors::BadRequestError) do
      run_tools(client, tool_handlers: {"lookup" => -> (_) { executions += 1 }})
    end

    assert_equal(1, executions)
    assert_equal(2, transport.requests.length)
  end

  def test_truncated_filtered_and_malformed_completions_never_dispatch
    [:length, :content_filter, :function_call].each do |reason|
      _, client = client_for(completion(calls: [call("a")], reason: reason))
      assert_raises(OpenAI::Helpers::Chat::ToolRunner::Error) do
        run_tools(client, tool_handlers: {"lookup" => -> (_) { flunk("Incomplete call dispatched") }})
      end
    end

    [[], [completion[:choices].first] * 2].each do |choices|
      _, client = client_for(completion.merge(choices: choices))
      assert_raises(OpenAI::Helpers::Chat::ToolRunner::Error) { run_tools(client) }
    end
  end

  def test_invalid_configuration_fails_before_network
    invalid_options = [
      {max_rounds: 0},
      {max_rounds: 1.5},
      {n: 2},
      {stream: true},
      {functions: []},
      {tool_handlers: {}},
      {tool_handlers: {lookup: -> (_) { nil }}},
      {tool_handlers: {"lookup" => nil}},
      {tools: [tool, tool]},
      {tools: [{type: :custom, custom: {name: "lookup"}}]},
      {request_options: {extra_body: {"stream" => true}}},
      {request_options: {extra_body: {messages: []}}}
    ]
    invalid_options.each do |options|
      transport, client = client_for
      assert_raises(ArgumentError) { run_tools(client, **options) }
      assert_empty(transport.requests)
    end
  end

  private

  def client_for(*responses)
    transport = Transport.new(responses)
    [transport, OpenAI::Client.new(api_key: "synthetic-key", http_client: transport, max_retries: 0)]
  end

  def tool
    {
      type: :function,
      function: {
        name: "lookup",
        parameters: {
          type: :object,
          properties: {city: {type: :string}},
          required: ["city"]
        }
      }
    }
  end

  def run_tools(client, **options)
    client.chat.completions.run_tools(
      **{
        model: "gpt-4o-mini",
        messages: [{role: :user, content: "Weather?"}],
        tools: [tool],
        tool_handlers: {"lookup" => -> (_) { "Sunny" }}
      }.merge(options)
    )
  end

  def call(id, name: "lookup", arguments: "{\"city\":\"Seattle\"}")
    {id: id, type: :function, function: {name: name, arguments: arguments}}
  end

  def completion(calls: nil, content: "Done", refusal: nil, reason: nil)
    {
      id: "synthetic-completion",
      object: "chat.completion",
      created: 0,
      model: "gpt-4o-mini",
      choices: [
        {
          index: 0,
          finish_reason: reason || (calls ? :tool_calls : :stop),
          logprobs: nil,
          message: {role: :assistant, content: content, refusal: refusal, tool_calls: calls}
        }
      ]
    }
  end
end
