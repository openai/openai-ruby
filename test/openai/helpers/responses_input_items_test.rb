# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::ResponsesInputItemsTest < Minitest::Test
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

  def setup
    super
    @client = OpenAI::Client.new(base_url: "http://localhost", api_key: "test-key")
  end

  def teardown
    WebMock.reset!
    super
  end

  def test_preserves_existing_input_models_and_response_context
    user = OpenAI::Responses::EasyInputMessage.new(role: :user, content: "Hello")
    message = OpenAI::Responses::ResponseOutputMessage.new(
      id: "msg_123",
      content: [{type: :output_text, text: "Hello", annotations: []}],
      status: :completed,
      phase: :final_answer,
      signature: "future-signature"
    )
    reasoning = OpenAI::Responses::ResponseReasoningItem.new(
      id: "rs_123",
      summary: [],
      encrypted_content: "encrypted-reasoning"
    )

    normalized = OpenAI::Responses.to_input_items([user, message, reasoning].each)

    assert_equal([user, message, reasoning], normalized)
    assert_same(user, normalized.fetch(0))
    assert_same(message, normalized.fetch(1))
    assert_same(reasoning, normalized.fetch(2))
    assert_equal(:final_answer, normalized.fetch(1).phase)
    assert_equal("future-signature", normalized.fetch(1)[:signature])
    assert_equal("encrypted-reasoning", normalized.fetch(2).encrypted_content)
  end

  def test_converts_output_only_function_and_program_items_into_input_models
    function_output = OpenAI::Responses::ResponseFunctionToolCallOutputItem.new(
      id: "fco_123",
      call_id: "call_123",
      output: "done",
      status: :completed,
      created_by: "assistant",
      caller_: {type: :program, caller_id: "program_123"}
    )
    program = OpenAI::Responses::ResponseOutputItem::Program.new(
      id: "program_123",
      call_id: "program_call_123",
      code: "return 42",
      fingerprint: "opaque-fingerprint"
    )
    program_output = OpenAI::Responses::ResponseOutputItem::ProgramOutput.new(
      id: "program_output_123",
      call_id: "program_call_123",
      result: "42",
      status: :completed
    )

    normalized = OpenAI::Responses.to_input_items([function_output, program, program_output])

    assert_instance_of(OpenAI::Responses::ResponseInputItem::FunctionCallOutput, normalized.fetch(0))
    assert_instance_of(OpenAI::Responses::ResponseInputItem::Program, normalized.fetch(1))
    assert_instance_of(OpenAI::Responses::ResponseInputItem::ProgramOutput, normalized.fetch(2))
    assert_equal("call_123", normalized.fetch(0).call_id)
    assert_equal("program_123", normalized.fetch(0).caller_.caller_id)
    assert_equal("opaque-fingerprint", normalized.fetch(1).fingerprint)
    refute_includes(normalized.fetch(0).to_h, :created_by)
    assert_equal("assistant", function_output.created_by)
  end

  def test_preserves_compaction_content_while_removing_server_metadata
    item = OpenAI::Responses::ResponseCompactionItem.new(
      id: "compaction_123",
      encrypted_content: "encrypted-compaction",
      created_by: "assistant"
    )

    normalized = OpenAI::Responses.to_input_item(item)

    assert_instance_of(OpenAI::Responses::ResponseCompactionItemParam, normalized)
    assert_equal("compaction_123", normalized.id)
    assert_equal("encrypted-compaction", normalized.encrypted_content)
    refute_includes(normalized.to_h, :created_by)
    assert_equal("assistant", item.created_by)
  end

  def test_preserves_valid_explicit_nulls
    reasoning = OpenAI::Responses::ResponseReasoningItem.new(
      id: "rs_123",
      summary: [],
      content: nil,
      encrypted_content: "encrypted-reasoning"
    )
    text = OpenAI::Responses::ResponseOutputText.new(
      text: "Hello",
      annotations: [],
      logprobs: nil
    )
    message = OpenAI::Responses::ResponseOutputMessage.new(
      id: "msg_123",
      content: [text],
      status: :completed
    )

    assert_same(reasoning, OpenAI::Responses.to_input_item(reasoning))
    assert_same(message, OpenAI::Responses.to_input_item(message))
    assert_nil(reasoning[:content])
    assert_nil(text[:logprobs])
  end

  def test_preserves_required_nullable_response_fields
    image_call = OpenAI::Responses.to_input_item(
      type: :image_generation_call,
      id: "image_123",
      result: nil,
      status: :completed
    )

    assert_nil(image_call[:result])
  end

  def test_removes_server_metadata_from_nested_shell_output_without_mutation
    item = OpenAI::Responses::ResponseFunctionShellToolCallOutput.new(
      id: "shell_output_123",
      call_id: "shell_call_123",
      max_output_length: nil,
      status: :completed,
      created_by: "assistant",
      caller_: {type: :program, caller_id: "program_123"},
      output: [
        {
          outcome: {type: :exit, exit_code: 0},
          stdout: "ok",
          stderr: "",
          created_by: "assistant"
        }
      ]
    )

    normalized = OpenAI::Responses.to_input_item(item)

    assert_instance_of(OpenAI::Responses::ResponseInputItem::ShellCallOutput, normalized)
    assert_equal("program_123", normalized.caller_.caller_id)
    assert_equal("ok", normalized.output.fetch(0).stdout)
    refute_includes(normalized.to_h, :created_by)
    refute_includes(normalized.output.fetch(0).to_h, :created_by)
    assert_equal("assistant", item.created_by)
    assert_equal("assistant", item.output.fetch(0).fetch(:created_by))
    assert_nil(normalized.max_output_length)
  end

  def test_filters_nonreplayable_computer_and_custom_tool_output_states
    screenshot = {type: :computer_screenshot, image_url: "https://example.com/screenshot.png"}
    failed_computer = OpenAI::Responses::ResponseComputerToolCallOutputItem.new(
      id: "computer_failed",
      call_id: "computer_call_failed",
      output: screenshot,
      status: :failed
    )
    complete_computer = OpenAI::Responses::ResponseComputerToolCallOutputItem.new(
      id: "computer_completed",
      call_id: "computer_call_completed",
      output: screenshot,
      status: :completed,
      created_by: "assistant"
    )
    incomplete_custom = custom_output(status: :incomplete)
    completed_custom = custom_output(status: :completed, created_by: "assistant")

    normalized = OpenAI::Responses.to_input_items(
      [failed_computer, complete_computer, incomplete_custom, completed_custom]
    )

    assert_nil(OpenAI::Responses.to_input_item(failed_computer))
    assert_nil(OpenAI::Responses.to_input_item(incomplete_custom))
    assert_instance_of(OpenAI::Responses::ResponseInputItem::ComputerCallOutput, normalized.fetch(0))
    assert_instance_of(OpenAI::Responses::ResponseCustomToolCallOutput, normalized.fetch(1))
    assert_equal(:completed, normalized.fetch(0).status)
    refute_includes(normalized.fetch(1).to_h, :status)
    refute_includes(normalized.fetch(1).to_h, :created_by)
    assert_equal(:completed, completed_custom.status)
    assert_equal("assistant", completed_custom.created_by)
  end

  def test_defaults_custom_tool_image_output_detail
    item = {
      type: :custom_tool_call_output,
      call_id: "custom_call_123",
      output: [{type: :input_image, image_url: "https://example.com/image.png"}]
    }

    normalized = OpenAI::Responses.to_input_item(item)

    assert_equal(:auto, normalized.output.fetch(0).detail)
    refute_includes(item.fetch(:output).fetch(0), :detail)
  end

  def test_removes_response_only_custom_tool_call_status_without_mutation
    model = OpenAI::Responses::ResponseCustomToolCallItem.new(
      id: "custom_123",
      call_id: "call_123",
      input: "{}",
      name: "lookup",
      status: :completed
    )
    hash = {
      type: :custom_tool_call,
      id: "custom_456",
      call_id: "call_456",
      input: "{}",
      name: "lookup",
      status: :completed
    }

    normalized_model = OpenAI::Responses.to_input_item(model)
    normalized_hash = OpenAI::Responses.to_input_item(hash)

    assert_instance_of(OpenAI::Responses::ResponseCustomToolCall, normalized_model)
    assert_instance_of(OpenAI::Responses::ResponseCustomToolCall, normalized_hash)
    refute_includes(normalized_model.to_h, :status)
    refute_includes(normalized_hash.to_h, :status)
    assert_equal(:completed, model.status)
    assert_equal(:completed, hash.fetch(:status))
  end

  def test_keeps_only_developer_additional_tools
    assistant_tools = OpenAI::Responses::ResponseOutputItem::AdditionalTools.new(
      id: "assistant_tools",
      role: :assistant,
      tools: []
    )
    developer_tools = OpenAI::Responses::ResponseOutputItem::AdditionalTools.new(
      id: "developer_tools",
      role: :developer,
      tools: []
    )

    assert_nil(OpenAI::Responses.to_input_item(assistant_tools))

    normalized = OpenAI::Responses.to_input_item(developer_tools)

    assert_instance_of(OpenAI::Responses::ResponseInputItem::AdditionalTools, normalized)
    assert_equal(:developer, normalized.role)
    assert_equal("developer_tools", normalized.id)
  end

  def test_rejects_malformed_filtered_item_states
    invalid_items = [
      {type: :additional_tools, tools: []},
      {type: :additional_tools, role: :bogus, tools: []},
      {type: :additional_tools, role: :assistant, tools: []},
      {type: :computer_call_output, status: :failed},
      {
        type: :computer_call_output,
        call_id: "call_123",
        output: {type: :computer_screenshot, image_url: "https://example.com/screenshot.png"},
        status: :failed,
        created_by: 7
      },
      {
        type: :computer_call_output,
        call_id: 7,
        output: {type: :computer_screenshot, image_url: "https://example.com/screenshot.png"},
        status: :failed,
        future_extension: nil
      },
      {type: :custom_tool_call_output, call_id: "call_123", output: "done", status: :bogus},
      {type: :custom_tool_call_output, status: :in_progress},
      {
        type: :custom_tool_call_output,
        call_id: "call_123",
        output: "done",
        status: :in_progress,
        created_by: 7
      }
    ]

    invalid_items.each do |item|
      error = assert_raises(TypeError) { OpenAI::Responses.to_input_item(item) }

      assert_match(/invalid response item type/i, error.message)
    end
  end

  def test_converts_persisted_string_key_hashes_without_mutating_them
    stored = {
      "type" => "function_call_output",
      "id" => "output_123",
      "call_id" => "call_123",
      "output" => "done",
      "status" => "completed",
      "created_by" => "assistant",
      "caller" => {"type" => "program", "caller_id" => "program_123"},
      "future_extension" => {"signature" => "opaque"}
    }

    normalized = OpenAI::Responses.to_input_item(stored)

    assert_instance_of(OpenAI::Responses::ResponseInputItem::FunctionCallOutput, normalized)
    assert_equal("program_123", normalized.caller_.caller_id)
    assert_equal({signature: "opaque"}, normalized[:future_extension])
    refute_includes(normalized.to_h, :created_by)
    assert_equal("assistant", stored.fetch("created_by"))
    assert_equal({"signature" => "opaque"}, stored.fetch("future_extension"))
  end

  def test_canonicalizes_sdk_style_caller_hashes_and_preserves_parsed_extensions
    item = {
      type: :function_call_output,
      output: "done",
      caller_: {type: :program, caller_id: "program_123"},
      future_extension: {type: :function_call, parsed: {opaque: true}, keep: nil}
    }

    normalized = OpenAI::Responses.to_input_item(item)
    program = OpenAI::Responses.to_input_item(
      type: :program,
      id: "program_123",
      call_id: "call_123",
      code: "return 42",
      fingerprint: "opaque",
      caller: "opaque-extension"
    )

    assert_instance_of(OpenAI::Responses::ResponseInputItem::FunctionCallOutput, normalized)
    assert_equal("program_123", normalized.caller_.caller_id)
    assert_equal({type: :function_call, parsed: {opaque: true}, keep: nil}, normalized[:future_extension])
    assert_equal({type: :program, caller_id: "program_123"}, item.fetch(:caller_))
    assert_equal("opaque-extension", program[:caller])
  end

  def test_accepts_user_message_hashes_without_a_type
    normalized = OpenAI::Responses.to_input_item(role: "user", content: "Continue")

    assert_instance_of(OpenAI::Responses::EasyInputMessage, normalized)
    assert_equal(:user, normalized.role)
    assert_equal("Continue", normalized.content)
  end

  def test_accepts_defaulted_input_image_detail
    model = OpenAI::Responses::EasyInputMessage.new(
      role: :user,
      content: [{type: :input_image, image_url: "https://example.com/image.png"}]
    )
    stored = {
      type: :message,
      role: :user,
      content: [{type: :input_image, image_url: "https://example.com/image.png"}]
    }

    normalized_model = OpenAI::Responses.to_input_item(model)
    refute_same(model, normalized_model)
    assert_equal(:auto, normalized_model.content.fetch(0).detail)
    normalized = OpenAI::Responses.to_input_item(stored)
    assert_instance_of(OpenAI::Responses::EasyInputMessage, normalized)
    assert_equal(:auto, normalized.content.fetch(0).detail)
    assert_equal("https://example.com/image.png", normalized.content.fetch(0).image_url)
  end

  def test_preserves_explicit_null_input_image_detail
    model = OpenAI::Responses::EasyInputMessage.new(
      role: :user,
      content: [{type: :input_image, detail: nil, image_url: "https://example.com/image.png"}]
    )
    stored = {
      type: :message,
      role: :user,
      content: [{type: :input_image, detail: nil, image_url: "https://example.com/image.png"}]
    }

    assert_same(model, OpenAI::Responses.to_input_item(model))
    normalized = OpenAI::Responses.to_input_item(stored)
    assert_nil(normalized[:content].fetch(0).fetch(:detail))
  end

  def test_rejects_hashes_without_a_type_or_easy_message_shape
    error = assert_raises(TypeError) { OpenAI::Responses.to_input_item(foo: "bar") }

    assert_equal("Unsupported response item without a type", error.message)
  end

  def test_rejects_non_enumerable_item_collections
    [nil, "bad", 7].each do |items|
      error = assert_raises(TypeError) { OpenAI::Responses.to_input_items(items) }

      assert_equal("Response items must be enumerable or a response item list", error.message)
    end
  end

  def test_redacts_hostile_scalar_and_collection_types_from_errors
    secret = "sk-do-not-echo"
    metadata = Object.new
    metadata.define_singleton_method(:name) { secret }
    scalar = Object.new
    collection = Object.new
    scalar.define_singleton_method(:class) { metadata }
    collection.define_singleton_method(:class) { metadata }

    scalar_error = assert_raises(TypeError) { OpenAI::Responses.to_input_item(scalar) }
    collection_error = assert_raises(TypeError) { OpenAI::Responses.to_input_items(collection) }

    assert_equal("Response item must be a model or hash", scalar_error.message)
    assert_equal("Response items must be enumerable or a response item list", collection_error.message)
    refute_includes(scalar_error.message, secret)
    refute_includes(collection_error.message, secret)
  end

  def test_rejects_hostile_discriminator_conversions_without_leaking
    secret = "sk-do-not-echo"
    calls = 0
    role = Object.new
    nested_type = Object.new
    execution = Object.new
    [role, nested_type, execution].each do |value|
      value.define_singleton_method(:nil?) do
        calls += 1
        raise secret
      end

      value.define_singleton_method(:to_s) do
        calls += 1
        raise secret
      end

      value.define_singleton_method(:to_sym) do
        calls += 1
        raise secret
      end
    end

    role_error = assert_raises(TypeError) do
      OpenAI::Responses.to_input_item(role: role, content: "Continue")
    end

    nested_error = assert_raises(TypeError) do
      OpenAI::Responses.to_input_item(type: :function_call_output, output: [{type: nested_type}])
    end

    execution_error = assert_raises(TypeError) do
      OpenAI::Responses.to_input_item(type: :tool_search_call, arguments: {}, execution: execution)
    end

    assert_equal("Invalid response item type", role_error.message)
    assert_equal("Invalid response item type", nested_error.message)
    assert_equal("Invalid response item type", execution_error.message)
    refute_includes(role_error.message, secret)
    refute_includes(nested_error.message, secret)
    refute_includes(execution_error.message, secret)

    fatal_secret = Class.new(NoMemoryError)
    fatal_calls = 0
    fatal_execution = Object.new
    fatal_execution.define_singleton_method(:class) do
      fatal_calls += 1
      raise fatal_secret, secret
    end

    fatal_execution.define_singleton_method(:nil?) do
      fatal_calls += 1
      raise fatal_secret, secret
    end

    fatal_execution_error = assert_raises(TypeError) do
      OpenAI::Responses.to_input_item(type: :tool_search_call, arguments: {}, execution: fatal_execution)
    end

    assert_equal("Invalid response item type", fatal_execution_error.message)
    assert_equal(0, fatal_calls)
    refute_includes(fatal_execution_error.message, secret)

    hostile_status = Object.new
    hostile_status.define_singleton_method(:class) { raise secret }
    hostile_status.define_singleton_method(:to_s) { raise secret }
    hostile_status.define_singleton_method(:to_sym) { raise secret }
    status_error = assert_raises(TypeError) do
      OpenAI::Responses.to_input_item(
        type: :computer_call_output,
        call_id: "call_123",
        output: {type: :computer_screenshot, image_url: "https://example.test/image.png"},
        status: hostile_status
      )
    end

    assert_equal("Invalid response item type", status_error.message)
    refute_includes(status_error.message, secret)

    hostile_action = Object.new
    hostile_action.define_singleton_method(:class) { raise secret }
    hostile_action.define_singleton_method(:to_sym) { raise secret }
    action_error = assert_raises(TypeError) do
      OpenAI::Responses.to_input_item(
        type: :additional_tools,
        role: :developer,
        tools: [{type: :image_generation, action: hostile_action}]
      )
    end

    assert_equal("Invalid response item type", action_error.message)
    refute_includes(action_error.message, secret)

    hostile_inspect = Object.new
    hostile_inspect.define_singleton_method(:inspect) { raise secret }
    structured_type_error = assert_raises(TypeError) do
      OpenAI::Responses.to_input_item(
        type: :code_interpreter_call,
        id: "ci_123",
        code: nil,
        container_id: "cntr_123",
        outputs: [{type: {secret: hostile_inspect}, logs: "ok"}],
        status: :completed
      )
    end

    assert_equal("Invalid response item type", structured_type_error.message)
    refute_includes(structured_type_error.message, secret)

    content_calls = 0
    hostile_content = Object.new
    hostile_content.define_singleton_method(:==) do |_other|
      content_calls += 1
      raise secret
    end

    content_error = assert_raises(TypeError) do
      OpenAI::Responses.to_input_item(type: :message, role: :user, content: hostile_content)
    end

    assert_equal("Unsupported response message content", content_error.message)
    assert_equal(0, content_calls)

    annotations_calls = 0
    hostile_annotations = Class.new(Array).new([Object.new])
    hostile_annotations.define_singleton_method(:all?) do |&_block|
      annotations_calls += 1
      raise secret
    end

    annotations_error = assert_raises(TypeError) do
      OpenAI::Responses.to_input_item(
        type: :message,
        role: :assistant,
        content: [
          {
            type: :output_text,
            text: "Answer",
            input_schema: {},
            annotations: hostile_annotations
          }
        ]
      )
    end

    assert_equal("Unsupported response message content", annotations_error.message)
    assert_equal(0, annotations_calls)
    refute_includes(annotations_error.message, secret)

    calls = 0
    hostile_array = Class.new(Array).new
    hostile_hash = Class.new(Hash).new
    hostile_array.define_singleton_method(:each) do |&_block|
      calls += 1
      raise secret
    end

    hostile_array.define_singleton_method(:map) do |&_block|
      calls += 1
      raise secret
    end

    hostile_hash.define_singleton_method(:each) do |&_block|
      calls += 1
      raise secret
    end

    hostile_hash.define_singleton_method(:each_with_object) do |_memo, &_block|
      calls += 1
      raise secret
    end

    hostile_hash.define_singleton_method(:[]) do |_key|
      calls += 1
      raise secret
    end

    hostile_hash.define_singleton_method(:key?) do |_key|
      calls += 1
      raise secret
    end

    array_error = assert_raises(TypeError) do
      OpenAI::Responses.to_input_item(role: hostile_array, content: "Continue")
    end

    hash_error = assert_raises(TypeError) do
      OpenAI::Responses.to_input_item(role: hostile_hash, content: "Continue")
    end

    assert_equal("Invalid response item type", array_error.message)
    assert_equal("Invalid response item type", hash_error.message)
    assert_equal(0, calls)

    default_calls = 0
    message_with_default = Hash.new do
      default_calls += 1
      raise secret
    end

    message_with_default[:role] = :user
    message_with_default[:content] = "Continue"
    tool_search_with_default = Hash.new do
      default_calls += 1
      raise secret
    end

    tool_search_with_default["type"] = "tool_search_call"
    tool_search_with_default[:arguments] = {}

    normalized_message = OpenAI::Responses.to_input_item(message_with_default)
    normalized_tool_search = OpenAI::Responses.to_input_item(tool_search_with_default)

    assert_instance_of(OpenAI::Responses::EasyInputMessage, normalized_message)
    assert_equal(:tool_search_call, normalized_tool_search.type)
    assert_equal(0, default_calls)
  end

  def test_normalizes_hostile_string_discriminators_without_dispatch
    secret = "sk-do-not-echo"
    discriminator = Class.new(String)
    type = discriminator.new("message")
    role = discriminator.new("user")
    nested_type = discriminator.new("input_text")
    [type, role, nested_type].each do |value|
      value.define_singleton_method(:==) { raise secret }
      value.define_singleton_method(:nil?) { raise secret }
      value.define_singleton_method(:to_s) { raise secret }
      value.define_singleton_method(:to_sym) { raise secret }
    end

    normalized = OpenAI::Responses.to_input_item(
      type: type,
      role: role,
      content: [{type: nested_type, text: "Continue"}]
    )

    assert_instance_of(OpenAI::Responses::EasyInputMessage, normalized)
    assert_equal(:user, normalized.role)
    assert_equal(:input_text, normalized.content.fetch(0).type)

    execution = discriminator.new("server")
    execution.define_singleton_method(:==) { raise secret }
    execution.define_singleton_method(:nil?) { raise secret }
    execution.define_singleton_method(:to_s) { raise secret }
    execution.define_singleton_method(:to_sym) { raise secret }

    normalized_tool_search = OpenAI::Responses.to_input_item(
      type: :tool_search_call,
      arguments: {},
      execution: execution
    )

    assert_equal(:server, normalized_tool_search.execution)

    output_type = discriminator.new("logs")
    container_type = discriminator.new("auto")
    network_policy_type = discriminator.new("disabled")
    [output_type, container_type, network_policy_type].each do |value|
      value.define_singleton_method(:==) { raise secret }
      value.define_singleton_method(:nil?) { raise secret }
      value.define_singleton_method(:to_s) { raise secret }
      value.define_singleton_method(:to_sym) { raise secret }
    end

    normalized_code_interpreter = OpenAI::Responses.to_input_item(
      type: :code_interpreter_call,
      id: "ci_123",
      code: nil,
      container_id: "cntr_123",
      outputs: [{type: output_type, logs: "ok"}],
      status: :completed
    )
    normalized_additional_tools = OpenAI::Responses.to_input_item(
      type: :additional_tools,
      role: :developer,
      tools: [
        {
          type: :code_interpreter,
          container: {
            type: container_type,
            network_policy: {type: network_policy_type}
          }
        }
      ]
    )

    assert_equal(:logs, normalized_code_interpreter.outputs.fetch(0).type)
    assert_equal(:auto, normalized_additional_tools.tools.fetch(0).container.type)
    assert_equal(:disabled, normalized_additional_tools.tools.fetch(0).container.network_policy.type)

    image_action = discriminator.new("auto")
    image_model = discriminator.new("gpt-image-1")
    image_size = discriminator.new("1024x1024")
    skill_type = discriminator.new("skill_reference")
    format_type = discriminator.new("text")
    filter_type = discriminator.new("eq")
    source_type = discriminator.new("base64")
    media_type = discriminator.new("application/zip")
    user_location_type = discriminator.new("approximate")
    memory_limit = discriminator.new("1g")
    ranker = discriminator.new("auto")
    breakpoint_mode = discriminator.new("explicit")
    [
      image_action,
      image_model,
      image_size,
      skill_type,
      format_type,
      filter_type,
      source_type,
      media_type,
      user_location_type,
      memory_limit,
      ranker,
      breakpoint_mode
    ].each do |value|
      value.define_singleton_method(:==) { raise secret }
      value.define_singleton_method(:nil?) { raise secret }
      value.define_singleton_method(:to_s) { raise secret }
      value.define_singleton_method(:to_sym) { raise secret }
    end

    normalized_nested_tools = OpenAI::Responses.to_input_item(
      type: :additional_tools,
      role: :developer,
      tools: [
        {type: :image_generation, action: image_action, model: image_model, size: image_size},
        {
          type: :shell,
          environment: {
            type: :container_auto,
            network_policy: {type: network_policy_type},
            skills: [
              {type: skill_type, skill_id: "skill_123"},
              {
                type: :inline,
                name: "inline",
                description: "Inline skill",
                source: {type: source_type, media_type: media_type, data: "UEsDBA=="}
              }
            ]
          }
        },
        {
          type: :code_interpreter,
          container: {type: :auto, memory_limit: memory_limit}
        },
        {type: :custom, name: "lookup", format: {type: format_type}},
        {
          type: :file_search,
          vector_store_ids: ["vs_123"],
          ranking_options: {type: "opaque-extension", ranker: ranker},
          filters: {
            type: :and,
            filters: [{type: filter_type, key: "kind", value: "reference"}]
          }
        },
        {type: :web_search, user_location: {type: user_location_type}},
        {type: :web_search_2025_08_26, user_location: {type: user_location_type}},
        {type: :web_search_preview_2025_03_11, user_location: {type: user_location_type}}
      ]
    )

    assert_equal(:auto, normalized_nested_tools.tools.fetch(0).action)
    assert_equal("gpt-image-1", normalized_nested_tools.tools.fetch(0).model)
    assert_equal("1024x1024", normalized_nested_tools.tools.fetch(0).size)
    assert_equal(:skill_reference, normalized_nested_tools.tools.fetch(1).environment.skills.fetch(0).type)
    assert_equal(:disabled, normalized_nested_tools.tools.fetch(1).environment.network_policy.type)
    assert_equal(:base64, normalized_nested_tools.tools.fetch(1).environment.skills.fetch(1).source.type)
    assert_equal(
      :"application/zip",
      normalized_nested_tools.tools.fetch(1).environment.skills.fetch(1).source.media_type
    )
    assert_equal(:"1g", normalized_nested_tools.tools.fetch(2).container.memory_limit)
    assert_equal(:text, normalized_nested_tools.tools.fetch(3).format_.type)
    assert_equal(:auto, normalized_nested_tools.tools.fetch(4).ranking_options.ranker)
    assert_equal(:eq, normalized_nested_tools.tools.fetch(4).filters.filters.fetch(0).type)
    assert_equal(:approximate, normalized_nested_tools.tools.fetch(5).user_location.type)
    assert_equal(:approximate, normalized_nested_tools.tools.fetch(6).user_location.type)
    assert_equal(:approximate, normalized_nested_tools.tools.fetch(7).user_location.type)

    normalized_breakpoint = OpenAI::Responses.to_input_item(
      type: :message,
      role: :user,
      content: [
        {
          type: :input_text,
          text: "Continue",
          prompt_cache_breakpoint: {type: "opaque-extension", mode: breakpoint_mode}
        }
      ]
    )

    assert_equal(:explicit, normalized_breakpoint.content.fetch(0).prompt_cache_breakpoint.mode)

    namespace_tool_type = discriminator.new("function")
    tool_search_output_type = discriminator.new("function")
    web_action_type = discriminator.new("search")
    web_source_type = discriminator.new("url")
    [namespace_tool_type, tool_search_output_type, web_action_type, web_source_type].each do |value|
      value.define_singleton_method(:to_s) { raise secret }
      value.define_singleton_method(:to_sym) { raise secret }
    end

    normalized_namespace = OpenAI::Responses.to_input_item(
      type: :additional_tools,
      role: :developer,
      tools: [
        {
          type: :namespace,
          name: "crm",
          description: "CRM tools",
          tools: [{type: namespace_tool_type, name: "lookup"}]
        }
      ]
    )
    normalized_tool_search_output = OpenAI::Responses.to_input_item(
      type: :tool_search_output,
      tools: [{type: tool_search_output_type, name: "lookup", parameters: {}, strict: true}]
    )
    normalized_web_search = OpenAI::Responses.to_input_item(
      type: :web_search_call,
      id: "ws_123",
      status: :completed,
      action: {
        type: web_action_type,
        sources: [{type: web_source_type, url: "https://example.test"}]
      }
    )

    assert_equal(:function, normalized_namespace.tools.fetch(0).tools.fetch(0).type)
    assert_equal(:function, normalized_tool_search_output.tools.fetch(0).type)
    assert_equal(:search, normalized_web_search.action.type)
    assert_equal(:url, normalized_web_search.action.sources.fetch(0).type)

    shell_environment_type = discriminator.new("local")
    shell_environment_type.define_singleton_method(:to_s) { raise secret }
    shell_environment_type.define_singleton_method(:to_sym) { raise secret }
    normalized_shell_call = OpenAI::Responses.to_input_item(
      type: :shell_call,
      call_id: "call_123",
      action: {commands: ["pwd"]},
      status: :completed,
      environment: {type: shell_environment_type}
    )

    assert_equal(:local, normalized_shell_call.environment.type)

    malformed_source_type = discriminator.new("url")
    malformed_source_type.define_singleton_method(:to_s) { raise secret }
    malformed_source_type.define_singleton_method(:to_sym) { raise secret }
    malformed_web_search_error = assert_raises(TypeError) do
      OpenAI::Responses.to_input_item(
        type: :web_search_call,
        id: "ws_123",
        status: :completed,
        action: {sources: [{type: malformed_source_type, url: "https://example.test"}]}
      )
    end

    refute_includes(malformed_web_search_error.message, secret)

    outcome_type = discriminator.new("exit")
    outcome_type.define_singleton_method(:to_s) { raise secret }
    outcome_type.define_singleton_method(:to_sym) { raise secret }
    normalized_shell_output = OpenAI::Responses.to_input_item(
      type: :shell_call_output,
      call_id: "call_123",
      output: [
        {
          stdout: "done",
          stderr: "",
          outcome: {type: outcome_type, exit_code: 0}
        }
      ]
    )

    assert_equal(:exit, normalized_shell_output.output.fetch(0).outcome.type)

    malformed_outcome_type = discriminator.new("exit")
    malformed_outcome_type.define_singleton_method(:to_s) { raise secret }
    malformed_outcome_type.define_singleton_method(:to_sym) { raise secret }
    malformed_outcome_error = assert_raises(TypeError) do
      OpenAI::Responses.to_input_item(
        type: :shell_call_output,
        call_id: "call_123",
        output: [{type: "opaque-extension", stdout: "", outcome: {type: malformed_outcome_type, exit_code: 0}}]
      )
    end

    refute_includes(malformed_outcome_error.message, secret)

    allowed_caller = discriminator.new("direct")
    allowed_caller.define_singleton_method(:to_s) { raise secret }
    allowed_caller.define_singleton_method(:to_sym) { raise secret }
    normalized_allowed_callers = OpenAI::Responses.to_input_item(
      type: :additional_tools,
      role: :developer,
      tools: [
        {
          type: :function,
          name: "lookup",
          parameters: {},
          strict: true,
          allowed_callers: [allowed_caller]
        }
      ]
    )

    assert_equal([:direct], normalized_allowed_callers.tools.fetch(0).allowed_callers)

    hostile_caller = Object.new
    hostile_caller.define_singleton_method(:to_s) { raise secret }
    hostile_caller.define_singleton_method(:to_sym) { raise secret }
    caller_error = assert_raises(TypeError) do
      OpenAI::Responses.to_input_item(
        type: :additional_tools,
        role: :developer,
        tools: [
          {
            type: :function,
            name: "lookup",
            parameters: {},
            strict: true,
            allowed_callers: [hostile_caller]
          }
        ]
      )
    end

    assert_equal("Invalid response item type", caller_error.message)
    refute_includes(caller_error.message, secret)

    hostile_caller_collection = Object.new
    hostile_caller_collection.define_singleton_method(:is_a?) { raise secret }
    hostile_caller_collection.define_singleton_method(:map) { raise secret }
    hostile_caller_collection.define_singleton_method(:class) { raise secret }
    caller_collection_error = assert_raises(TypeError) do
      OpenAI::Responses.to_input_item(
        type: :additional_tools,
        role: :developer,
        tools: [
          {
            type: :function,
            name: "lookup",
            parameters: {},
            strict: true,
            allowed_callers: hostile_caller_collection
          }
        ]
      )
    end

    assert_equal("Invalid response item type", caller_collection_error.message)
    refute_includes(caller_collection_error.message, secret)

    invalid_type = "sk-secret".b.prepend(0xFF.chr).force_encoding(Encoding::UTF_8)
    invalid_type_error = assert_raises(TypeError) do
      OpenAI::Responses.to_input_item(
        type: :code_interpreter_call,
        id: "ci_123",
        code: nil,
        container_id: "cntr_123",
        outputs: [{type: invalid_type, logs: "ok"}],
        status: :completed
      )
    end

    assert_equal("Invalid response item type", invalid_type_error.message)
    refute_includes(invalid_type_error.message, "sk-secret")

    summary_type = discriminator.new("summary_text")
    summary_type.define_singleton_method(:to_s) { raise secret }
    summary_type.define_singleton_method(:to_sym) { raise secret }
    normalized_reasoning = OpenAI::Responses.to_input_item(
      type: :reasoning,
      id: "rs_123",
      summary: [{type: summary_type, text: "Continue"}]
    )

    assert_equal(:summary_text, normalized_reasoning.summary.fetch(0).type)

    exact_role = String.new("user")
    exact_role.define_singleton_method(:to_s) { raise secret }
    exact_role.define_singleton_method(:to_sym) { raise secret }
    discriminator.define_singleton_method(:==) { |_other| raise secret }
    class_role = discriminator.new("user")

    normalized_exact_role = OpenAI::Responses.to_input_item(role: exact_role, content: "Continue")
    normalized_class_role = OpenAI::Responses.to_input_item(role: class_role, content: "Continue")

    assert_equal(:user, normalized_exact_role.role)
    assert_equal(:user, normalized_class_role.role)
  end

  def test_rejects_unrelated_sdk_models
    item = OpenAI::Chat::ChatCompletionUserMessageParam.new(content: "Hello")

    error = assert_raises(TypeError) { OpenAI::Responses.to_input_item(item) }

    assert_equal("Response item must be a Responses model or hash", error.message)
  end

  def test_rejects_ambiguous_type_less_references_and_key_collisions
    invalid_items = [
      {id: "item_123", call_id: "call_123", output: "done"},
      {id: "item_123", encrypted_content: "cipher"},
      {:id => "item_123", 1 => "bad"},
      {:role => "user", :content => "Continue", 1 => "bad"},
      {"type" => "future_response_item", :type => :function_call_output, :output => "done"}
    ]

    invalid_items.each do |item|
      assert_raises(TypeError) { OpenAI::Responses.to_input_item(item) }
    end
  end

  def test_redacts_unsupported_hash_keys_from_errors
    secret = "sk-do-not-echo"
    key = Object.new
    metadata = Object.new
    key.define_singleton_method(:inspect) { secret }
    metadata.define_singleton_method(:name) { secret }
    key.define_singleton_method(:class) { metadata }

    error = assert_raises(TypeError) {
      OpenAI::Responses.to_input_item(:role => "user", :content => "Continue", key => "bad")
    }

    assert_equal("Unsupported response item hash key type", error.message)
    refute_includes(error.message, secret)
  end

  def test_redacts_recursive_conflicting_hash_keys_from_errors
    secret = "sk-do-not-echo"
    item = {
      role: "user",
      content: "Continue",
      metadata: [{secret => "string", secret.to_sym => "symbol"}]
    }

    error = assert_raises(TypeError) { OpenAI::Responses.to_input_item(item) }

    assert_equal("Conflicting response item hash keys", error.message)
    refute_includes(error.message, secret)

    key = Class.new(String).new(secret)
    key.define_singleton_method(:to_sym) { raise secret }
    hostile_item = {
      role: "user",
      content: "Continue",
      metadata: [{key => "string", secret.to_sym => "symbol"}]
    }

    hostile_error = assert_raises(TypeError) { OpenAI::Responses.to_input_item(hostile_item) }

    assert_equal("Conflicting response item hash keys", hostile_error.message)
    refute_includes(hostile_error.message, secret)
  end

  def test_preserves_type_less_item_references
    model = OpenAI::Responses::ResponseInputItem::ItemReference.new(id: "item_123")

    normalized_model = OpenAI::Responses.to_input_item(model)
    normalized_hash = OpenAI::Responses.to_input_item("id" => "item_456")
    normalized_null_type = OpenAI::Responses.to_input_item(id: "item_789", type: nil)

    assert_same(model, normalized_model)
    assert_instance_of(OpenAI::Responses::ResponseInputItem::ItemReference, normalized_hash)
    assert_equal("item_456", normalized_hash.id)
    assert_instance_of(OpenAI::Responses::ResponseInputItem::ItemReference, normalized_null_type)
    assert_equal("item_789", normalized_null_type.id)
    assert_nil(normalized_null_type[:type])
  end

  def test_rejects_invalid_type_less_message_hashes
    invalid_items = [
      {role: "bogus", content: "Continue"},
      {role: "user", content: [{type: "input_text"}]},
      {role: "user", content: [{type: "input_image"}]},
      {
        role: "user",
        content: [{type: "input_image", file_id: "file_123", image_url: "https://example.com/image.png"}]
      },
      {role: "user", content: [{type: "input_file"}]},
      {role: "user", content: [{type: "input_file", file_id: "file_123", file_url: "https://example.com/a"}]},
      {role: "user", id: 7, content: "Continue"},
      {role: "user", status: :bogus, content: "Continue"},
      {role: "assistant", content: [{type: "output_text", text: "Previous answer", annotations: []}]}
    ]

    invalid_items.each do |item|
      error = assert_raises(TypeError) { OpenAI::Responses.to_input_item(item) }

      assert_equal("Unsupported response item without a type", error.message)
    end
  end

  def test_preserves_empty_input_messages
    type_less = {role: "user", content: []}
    typed = {type: :message, role: :user, content: []}

    normalized_type_less = OpenAI::Responses.to_input_item(type_less)
    normalized_typed = OpenAI::Responses.to_input_item(typed)

    assert_instance_of(OpenAI::Responses::EasyInputMessage, normalized_type_less)
    assert_instance_of(OpenAI::Responses::EasyInputMessage, normalized_typed)
    assert_empty(normalized_type_less.content)
    assert_empty(normalized_typed.content)
  end

  def test_preserves_persisted_assistant_output_phase_and_extensions
    item = {
      "type" => "message",
      "id" => "msg_123",
      "role" => "assistant",
      "status" => "completed",
      "phase" => "commentary",
      "signature" => "future-signature",
      "content" => [{"type" => "output_text", "text" => "Working", "annotations" => []}]
    }

    normalized = OpenAI::Responses.to_input_item(item)

    assert_instance_of(OpenAI::Responses::ResponseOutputMessage, normalized)
    assert_equal(:commentary, normalized.phase)
    assert_equal("future-signature", normalized[:signature])
    assert_equal("Working", normalized.content.fetch(0).text)
  end

  def test_preserves_empty_output_messages
    model = OpenAI::Responses::ResponseOutputMessage.new(id: "msg_123", status: :completed, content: [])
    stored = {type: :message, id: "msg_456", role: :assistant, status: :completed, content: []}

    assert_same(model, OpenAI::Responses.to_input_item(model))
    normalized = OpenAI::Responses.to_input_item(stored)
    assert_instance_of(OpenAI::Responses::ResponseOutputMessage, normalized)
    assert_empty(normalized.content)
  end

  def test_preserves_assistant_input_message_content_types
    item = {
      type: :message,
      role: :assistant,
      content: [{type: :input_text, text: "Previous answer"}]
    }

    normalized = OpenAI::Responses.to_input_item(item)

    assert_instance_of(OpenAI::Responses::EasyInputMessage, normalized)
    assert_equal(:assistant, normalized.role)
    assert_equal("Previous answer", normalized.content.fetch(0).text)
  end

  def test_rejects_unknown_or_mixed_typed_message_content
    invalid_content = [
      ["bad"],
      [{type: :future_output, value: "unknown"}],
      [{type: :input_text, text: "Question"}, {type: :output_text, text: "Answer", annotations: []}]
    ]

    invalid_content.each do |content|
      error = assert_raises(TypeError) do
        OpenAI::Responses.to_input_item(type: :message, role: :assistant, content: content)
      end

      assert_equal("Unsupported response message content", error.message)
    end
  end

  def test_rejects_invalid_typed_message_metadata_or_missing_content
    invalid_items = [
      {type: :message, role: :bogus, content: [{type: :input_text, text: "Question"}]},
      {
        type: :message,
        role: :assistant,
        phase: :bogus,
        content: [{type: :output_text, text: "Answer", annotations: []}]
      },
      {
        type: :message,
        role: :assistant,
        content: [{type: :output_text, text: "Answer", annotations: []}]
      },
      {
        type: :message,
        role: :assistant,
        id: "msg_123",
        status: :bogus,
        content: [{type: :output_text, text: "Answer", annotations: []}]
      },
      {
        type: :message,
        role: :assistant,
        id: "msg_123",
        status: :completed,
        content: [{type: :output_text}]
      },
      {type: :message, role: :user, id: 7, content: [{type: :input_text, text: "Question"}]},
      {type: :message, role: :user, status: :bogus, content: [{type: :input_text, text: "Question"}]},
      {type: :message, role: :user}
    ]

    invalid_items.each do |item|
      error = assert_raises(TypeError) { OpenAI::Responses.to_input_item(item) }

      assert_match(/unsupported response message/, error.message.downcase)
    end
  end

  def test_rejects_unsupported_nested_replay_discriminators
    invalid_items = [
      {
        type: :function_call_output,
        output: "done",
        caller: {type: :future, caller_id: "program_123"}
      },
      {
        type: :function_call_output,
        output: "done",
        caller_: {type: :future, caller_id: "program_123"}
      },
      {type: :function_call_output, output: [{type: :future_content, value: "unknown"}]},
      {type: :function_call_output, output: [{type: :input_image}]},
      {type: :custom_tool_call_output, call_id: "call_123", output: [{type: :input_file}]},
      {
        type: :computer_call,
        id: "computer_123",
        call_id: "call_123",
        pending_safety_checks: [],
        status: :completed,
        action: {button: :left, x: 1, y: 2}
      },
      {
        type: :message,
        role: :user,
        content: [
          {
            type: :input_image,
            image_url: "https://example.com/image.png",
            prompt_cache_breakpoint: {}
          }
        ]
      },
      {type: :computer_call_output, call_id: "call_123", output: {type: :future_screenshot}},
      {type: :computer_call_output, call_id: "call_123", output: {image_url: "https://example.com/screenshot.png"}},
      {type: :computer_call_output, call_id: "call_123", output: {type: :computer_screenshot}},
      {
        type: :web_search_call,
        id: "web_123",
        status: :completed,
        action: {query: "ruby"}
      },
      {
        type: :code_interpreter_call,
        id: "code_123",
        code: "puts 1",
        container_id: "container_123",
        outputs: [{logs: "1"}],
        status: :completed
      },
      {
        type: :local_shell_call,
        id: "shell_123",
        call_id: "call_123",
        status: :completed,
        action: {command: ["pwd"], env: {}}
      },
      {
        type: :shell_call,
        call_id: "call_123",
        action: {commands: ["pwd"]},
        environment: {container_id: "container_123"}
      },
      {
        type: :mcp_call,
        id: "mcp_123",
        arguments: "{}",
        name: "lookup",
        server_label: "server",
        error: {code: 1, message: "failed"}
      },
      {type: :reasoning, id: "reasoning_123", summary: [{text: "Summary"}]},
      {
        type: :reasoning,
        id: "reasoning_123",
        summary: [],
        content: [{text: "Reasoning"}]
      },
      {type: :additional_tools, role: :developer, tools: [{name: "lookup"}]},
      {
        type: :apply_patch_call,
        call_id: "call_123",
        status: :completed,
        operation: {path: "lib/a.rb", diff: "+change"}
      },
      {
        type: :apply_patch_call,
        call_id: "call_123",
        status: :completed,
        operation: {type: :future_operation}
      },
      {
        type: :shell_call_output,
        call_id: "call_123",
        output: [{stdout: "", stderr: "", outcome: {type: :future}}]
      }
    ]

    invalid_items.each do |item|
      error = assert_raises(TypeError) { OpenAI::Responses.to_input_item(item) }

      assert_equal("Unsupported nested response item discriminator", error.message)
    end
  end

  def test_rejects_unsupported_output_annotation_discriminators
    error = assert_raises(TypeError) do
      OpenAI::Responses.to_input_item(
        type: :message,
        id: "msg_123",
        role: :assistant,
        status: :completed,
        content: [{type: :output_text, text: "Answer", annotations: [{type: :future_annotation}]}]
      )
    end

    assert_equal("Unsupported response message content", error.message)
  end

  def test_rejects_unsupported_item_types
    error = assert_raises(TypeError) do
      OpenAI::Responses.to_input_item(type: "future_response_item", value: "unknown")
    end

    assert_equal("Unsupported response item type", error.message)
  end

  def test_redacts_unsupported_item_types_from_errors
    secret = "sk-do-not-echo"

    error = assert_raises(TypeError) do
      OpenAI::Responses.to_input_item(type: secret, value: "unknown")
    end

    assert_equal("Unsupported response item type", error.message)
    refute_includes(error.message, secret)
  end

  def test_redacts_invalid_encoding_unsupported_item_types_from_errors
    secret = [0xFF].pack("C").force_encoding(Encoding::UTF_8) + "sk-do-not-echo"

    error = assert_raises(TypeError) do
      OpenAI::Responses.to_input_item(type: secret, value: "unknown")
    end

    assert_equal("Invalid response item type", error.message)
    refute_includes(error.message, "sk-do-not-echo")
  end

  def test_rejects_false_item_type
    error = assert_raises(TypeError) do
      OpenAI::Responses.to_input_item(type: false, role: "user", content: "Continue")
    end

    assert_equal("Unsupported response item type", error.message)
  end

  def test_normalizes_input_items_list_models
    item = OpenAI::Responses::ResponseInputMessageItem.new(
      id: "msg_123",
      role: :user,
      content: [{type: :input_text, text: "Continue"}],
      status: :completed
    )
    list = OpenAI::Responses::ResponseItemList.new(
      data: [item],
      first_id: "msg_123",
      last_id: "msg_123",
      has_more: false
    )

    normalized = OpenAI::Responses.to_input_item(item)
    normalized_list = OpenAI::Responses.to_input_items(list)

    assert_instance_of(OpenAI::Responses::EasyInputMessage, normalized)
    assert_equal("msg_123", normalized[:id])
    assert_equal(:completed, normalized[:status])
    assert_equal([normalized], normalized_list)
  end

  def test_normalizes_resource_cursor_pages
    stub_request(:get, "http://localhost/responses/response_123/input_items").to_return_json(
      status: 200,
      body: {
        data: [
          {
            type: "message",
            id: "msg_123",
            role: "user",
            content: [{type: "input_text", text: "Continue"}],
            status: "completed"
          }
        ],
        first_id: "msg_123",
        last_id: "msg_123",
        has_more: false
      }
    )
    page = @client.responses.input_items.list("response_123")

    normalized = OpenAI::Responses.to_input_items(page)

    assert_instance_of(OpenAI::Internal::CursorPage, page)
    assert_equal(1, normalized.length)
    assert_instance_of(OpenAI::Responses::EasyInputMessage, normalized.fetch(0))
    assert_equal("msg_123", normalized.fetch(0)[:id])
  end

  def test_preserves_opaque_unknown_payloads
    schema = {
      "type" => "object",
      "properties" => {"status" => {"type" => "string"}}
    }
    annotations = {"status" => {"type" => "string"}}
    mcp_list = {
      type: :mcp_list_tools,
      id: "mcp_list_123",
      server_label: "server",
      tools: [{name: "lookup", input_schema: schema, annotations: annotations}]
    }
    tool_search = {type: :tool_search_call, arguments: schema}

    normalized_mcp_list = OpenAI::Responses.to_input_item(mcp_list)
    normalized_tool_search = OpenAI::Responses.to_input_item(tool_search)

    assert_equal(schema, normalized_mcp_list.tools.fetch(0).input_schema)
    assert_equal(annotations, normalized_mcp_list.tools.fetch(0).annotations)
    assert_equal(schema, normalized_tool_search.arguments)

    mcp_extension_role = Object.new
    mcp_extension_content_type = Object.new
    mcp_list_with_extensions = {
      type: :mcp_list_tools,
      id: "mcp_list_456",
      server_label: "server",
      tools: [
        {
          name: "lookup",
          input_schema: schema,
          type: :additional_tools,
          role: mcp_extension_role
        },
        {
          name: "search",
          input_schema: schema,
          type: :message,
          content: [{type: mcp_extension_content_type}]
        }
      ]
    }
    normalized_mcp_extensions = OpenAI::Responses.to_input_item(mcp_list_with_extensions)

    assert_same(mcp_extension_role, normalized_mcp_extensions.tools.fetch(0)[:role])
    assert_same(mcp_extension_content_type, normalized_mcp_extensions.tools.fetch(1)[:content].fetch(0).fetch(:type))

    mcp_call = {
      type: :mcp_call,
      id: "mcp_call_123",
      arguments: "{}",
      name: "lookup",
      server_label: "server",
      error: {type: :mcp_tool_execution_error, content: schema}
    }
    additional_tools = {
      type: :additional_tools,
      role: :developer,
      tools: [
        {
          type: :function,
          name: "lookup",
          parameters: schema,
          strict: true,
          output_schema: schema
        }
      ]
    }

    normalized_mcp_call = OpenAI::Responses.to_input_item(mcp_call)
    normalized_additional_tools = OpenAI::Responses.to_input_item(additional_tools)
    tool_schema = {type: "object", properties: {"status" => {"type" => "string"}}}

    assert_equal(schema, normalized_mcp_call.error.content)
    assert_equal(tool_schema, normalized_additional_tools.tools.fetch(0).parameters)
    assert_equal(tool_schema, normalized_additional_tools.tools.fetch(0).output_schema)

    local_shell = {
      type: :local_shell_call,
      id: "shell_123",
      call_id: "call_123",
      status: :completed,
      action: {type: :exec, command: ["pwd"], env: {"type" => "production"}}
    }
    mcp_tools = {
      type: :additional_tools,
      role: :developer,
      tools: [{type: :mcp, server_label: "server", headers: {"status" => "ok"}}]
    }

    normalized_local_shell = OpenAI::Responses.to_input_item(local_shell)
    normalized_mcp_tools = OpenAI::Responses.to_input_item(mcp_tools)

    assert_equal("production", normalized_local_shell.action.env.fetch(:type))
    assert_equal("ok", normalized_mcp_tools.tools.fetch(0).headers.fetch(:status))

    opaque_object = Object.new
    opaque_arguments = OpenAI::Responses.to_input_item(type: :tool_search_call, arguments: opaque_object)
    extension_item = {
      type: :function_call_output,
      call_id: "call_123",
      output: "done",
      future_extension: opaque_object
    }
    normalized_extension = OpenAI::Responses.to_input_item(extension_item)

    assert_same(opaque_object, opaque_arguments.arguments)
    assert_same(opaque_object, normalized_extension[:future_extension])

    hostile_argument = Object.new
    hostile_argument.define_singleton_method(:nil?) { raise "sk-opaque-arguments" }
    normalized_hostile_argument = OpenAI::Responses.to_input_item(
      type: :tool_search_call,
      arguments: hostile_argument
    )

    assert_same(hostile_argument, normalized_hostile_argument.arguments)

    opaque_string = Class.new(String).new("opaque")
    string_arguments = OpenAI::Responses.to_input_item(type: :tool_search_call, arguments: opaque_string)
    string_extension = extension_item.merge(future_extension: opaque_string)
    normalized_string_extension = OpenAI::Responses.to_input_item(string_extension)

    assert_same(opaque_string, string_arguments.arguments)
    assert_same(opaque_string, normalized_string_extension[:future_extension])

    nested_parameters_extension = extension_item.merge(future_extension: {parameters: opaque_object})
    normalized_nested_parameters_extension = OpenAI::Responses.to_input_item(nested_parameters_extension)

    assert_same(opaque_object, normalized_nested_parameters_extension[:future_extension].fetch(:parameters))

    opaque_array = Class.new(Array).new([{type: "opaque"}])
    opaque_array.define_singleton_method(:zip) { raise "sk-opaque-zip" }
    array_arguments = OpenAI::Responses.to_input_item(type: :tool_search_call, arguments: opaque_array)

    assert_same(opaque_array, array_arguments.arguments)

    hostile_schema_key = Class.new(String).new("type")
    hostile_schema_key.define_singleton_method(:to_sym) { raise "sk-schema-key" }
    schema_key_item = {
      type: :additional_tools,
      role: :developer,
      tools: [
        {
          type: :function,
          name: "lookup",
          parameters: {hostile_schema_key => "object"},
          strict: true
        }
      ]
    }
    normalized_schema_key = OpenAI::Responses.to_input_item(schema_key_item)

    assert_equal("object", normalized_schema_key.tools.fetch(0).parameters.fetch(:type))

    tool_search_schema = {properties: {7 => "opaque"}}
    normalized_tool_search_schema = OpenAI::Responses.to_input_item(
      type: :tool_search_output,
      tools: [{type: :function, name: "lookup", parameters: tool_search_schema, strict: true}]
    )

    assert_equal(
      "opaque",
      normalized_tool_search_schema.tools.fetch(0).parameters.fetch(:properties).fetch(7)
    )

    conflicting_schema_keys = schema_key_item.merge(
      tools: [
        {
          type: :function,
          name: "lookup",
          parameters: {"type" => "first", :type => "second"},
          strict: true
        }
      ]
    )
    conflicting_schema_error = assert_raises(TypeError) do
      OpenAI::Responses.to_input_item(conflicting_schema_keys)
    end

    assert_equal("Conflicting response item hash keys", conflicting_schema_error.message)
  end

  def test_preserves_unknown_extension_discriminator_looking_values
    extension = {
      type: "future_kind",
      status: "opaque",
      summary: {type: "future_summary", status: "opaque"}
    }
    item = {type: :function_call_output, call_id: "call_123", output: "done", future_extension: extension}

    normalized = OpenAI::Responses.to_input_item(item)

    assert_equal(extension, normalized[:future_extension])

    opaque_type = Class.new(String).new("future_kind")
    opaque_extension = {type: opaque_type, status: "opaque"}
    opaque_item = item.merge(future_extension: opaque_extension)
    normalized_opaque = OpenAI::Responses.to_input_item(opaque_item)

    assert_same(opaque_type, normalized_opaque[:future_extension].fetch(:type))

    colliding_extension = {type: "future_summary", status: "opaque"}
    colliding_item = {
      type: :function_call_output,
      call_id: "call_123",
      output: "done",
      summary: colliding_extension
    }

    normalized_colliding = OpenAI::Responses.to_input_item(colliding_item)

    assert_equal(colliding_extension, normalized_colliding[:summary])

    opaque_role = Class.new(String).new("opaque-role")
    opaque_status = Class.new(String).new("opaque-status")
    message_with_extension = {
      type: :message,
      role: :user,
      content: [{type: :input_text, text: "Continue", role: opaque_role, status: opaque_status}]
    }
    normalized_message = OpenAI::Responses.to_input_item(message_with_extension)

    assert_same(opaque_role, normalized_message.content.fetch(0)[:role])
    assert_same(opaque_status, normalized_message.content.fetch(0)[:status])

    function_status = Class.new(String).new("opaque-status")
    additional_tools_with_extension = {
      type: :additional_tools,
      role: :developer,
      tools: [
        {
          type: :function,
          name: "lookup",
          parameters: {},
          strict: true,
          status: function_status
        }
      ]
    }
    normalized_additional_tools = OpenAI::Responses.to_input_item(additional_tools_with_extension)

    assert_same(function_status, normalized_additional_tools.tools.fetch(0)[:status])

    opaque_source_type = Class.new(String).new("opaque-source")
    file_search_with_extension = {
      type: :additional_tools,
      role: :developer,
      tools: [
        {
          type: :file_search,
          vector_store_ids: ["vs_123"],
          ranking_options: {sources: {type: opaque_source_type}}
        }
      ]
    }
    normalized_file_search = OpenAI::Responses.to_input_item(file_search_with_extension)

    assert_same(opaque_source_type, normalized_file_search.tools.fetch(0).ranking_options[:sources].fetch(:type))

    opaque_ranking_type = Class.new(String).new("opaque-ranking")
    ranking_type_extension = {
      type: :additional_tools,
      role: :developer,
      tools: [
        {
          type: :file_search,
          vector_store_ids: ["vs_123"],
          ranking_options: {type: opaque_ranking_type}
        }
      ]
    }
    normalized_ranking_type = OpenAI::Responses.to_input_item(ranking_type_extension)

    assert_same(opaque_ranking_type, normalized_ranking_type.tools.fetch(0).ranking_options[:type])

    opaque_nested_type = Object.new
    typed_extension = item.merge(future_extension: {type: :message, content: [{type: opaque_nested_type}]})
    normalized_typed_extension = OpenAI::Responses.to_input_item(typed_extension)

    assert_same(opaque_nested_type, normalized_typed_extension[:future_extension].fetch(:content).fetch(0).fetch(:type))

    shell_action_type = Object.new
    shell_with_action_extension = {
      type: :shell_call,
      call_id: "call_123",
      action: {commands: ["pwd"], type: shell_action_type},
      environment: {type: :local}
    }
    normalized_shell_extension = OpenAI::Responses.to_input_item(shell_with_action_extension)

    assert_same(shell_action_type, normalized_shell_extension.action[:type])

    filter_status = Object.new
    web_search_with_filter_extension = {
      type: :additional_tools,
      role: :developer,
      tools: [
        {
          type: :web_search,
          filters: {allowed_domains: ["example.test"], type: :message, status: filter_status}
        }
      ]
    }
    normalized_web_filter_extension = OpenAI::Responses.to_input_item(web_search_with_filter_extension)

    assert_same(filter_status, normalized_web_filter_extension.tools.fetch(0).filters[:status])
  end

  def test_rejects_malformed_supported_item_shapes
    invalid_items = [
      {type: :compaction},
      {type: :function_call},
      {type: :function_call_output, output: "done", call_id: 7, id: nil},
      {type: :reasoning, summary: []},
      {type: :program_output, id: "program_123", call_id: "call_123", result: "done", status: :bogus},
      {
        type: :program,
        id: 7,
        call_id: "call_123",
        code: "return 42",
        fingerprint: "opaque",
        future_extension: nil
      },
      {type: :shell_call_output, call_id: "call_123"},
      {type: :shell_call_output, call_id: "call_123", output: "bad"},
      {type: :shell_call_output, call_id: "call_123", output: ["bad"]}
    ]

    invalid_items.each do |item|
      error = assert_raises(TypeError) { OpenAI::Responses.to_input_item(item) }

      assert_match(/invalid response item type/i, error.message)
    end
  end

  def test_rejects_non_model_non_hash_items
    error = assert_raises(TypeError) { OpenAI::Responses.to_input_item("not-an-item") }

    assert_match(/response item must be a model or hash/i, error.message)
  end

  def test_removes_sdk_only_parsed_fields_from_normalized_models
    tool_call = OpenAI::Responses::ResponseFunctionToolCall.new(
      arguments: "{}",
      call_id: "call_123",
      name: "lookup",
      parsed: {sdk_only: true}
    )
    message = OpenAI::Responses::ResponseOutputMessage.new(
      id: "msg_123",
      content: [{type: :output_text, text: "Hello", annotations: [], parsed: {sdk_only: true}}],
      status: :completed
    )
    typed_text = OpenAI::Responses::ResponseOutputText.new(
      text: "Hello",
      annotations: [],
      parsed: {sdk_only: true}
    )
    typed_message = OpenAI::Responses::ResponseOutputMessage.new(
      id: "msg_456",
      content: [typed_text],
      status: :completed
    )

    normalized_tool_call = OpenAI::Responses.to_input_item(tool_call)
    normalized_message = OpenAI::Responses.to_input_item(message)
    normalized_typed_message = OpenAI::Responses.to_input_item(typed_message)

    refute_same(tool_call, normalized_tool_call)
    refute_includes(normalized_tool_call.to_h, :parsed)
    refute_same(message, normalized_message)
    refute_includes(normalized_message.content.fetch(0).to_h, :parsed)
    refute_same(typed_message, normalized_typed_message)
    refute_includes(normalized_typed_message.content.fetch(0).to_h, :parsed)
    assert_equal({sdk_only: true}, tool_call.parsed)
    assert_equal({sdk_only: true}, message.content.fetch(0).fetch(:parsed))
    assert_equal({sdk_only: true}, typed_text.parsed)
  end

  def test_normalized_history_uses_wire_names_and_omits_sdk_only_fields
    tool_call = OpenAI::Responses::ResponseFunctionToolCall.new(
      arguments: "{}",
      call_id: "call_123",
      name: "lookup",
      parsed: {sdk_only: true},
      caller_: {type: :program, caller_id: "program_123"}
    )
    output = custom_output(status: :completed, created_by: "assistant")

    stub_request(:post, "http://localhost/responses").to_return_json(
      status: 200,
      body: {id: "resp_123", output: []}
    )

    @client.responses.create(model: "gpt-5.6", input: OpenAI::Responses.to_input_items([tool_call, output]))

    assert_requested(:post, "http://localhost/responses") do |request|
      items = JSON.parse(request.body).fetch("input")

      assert_equal({"type" => "program", "caller_id" => "program_123"}, items.fetch(0).fetch("caller"))
      refute_includes(items.fetch(0), "caller_")
      refute_includes(items.fetch(0), "parsed")
      refute_includes(items.fetch(1), "status")
      refute_includes(items.fetch(1), "created_by")
    end
  end

  private

  def custom_output(status:, created_by: nil)
    attributes = {
      id: "custom_output_#{status}",
      call_id: "custom_call_#{status}",
      output: "done",
      status: status
    }
    attributes.store(:created_by, created_by) if created_by

    OpenAI::Responses::ResponseCustomToolCallOutputItem.new(attributes)
  end
end
