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

      assert_equal(
        "Response items must be enumerable or a response item list, got #{items.class}",
        error.message
      )
    end
  end

  def test_rejects_unrelated_sdk_models
    item = OpenAI::Chat::ChatCompletionUserMessageParam.new(content: "Hello")

    error = assert_raises(TypeError) { OpenAI::Responses.to_input_item(item) }

    assert_equal(
      "Response item must be a Responses model or hash, got OpenAI::Models::Chat::ChatCompletionUserMessageParam",
      error.message
    )
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

    assert_equal("Unsupported response item type: future_response_item", error.message)
  end

  def test_rejects_false_item_type
    error = assert_raises(TypeError) do
      OpenAI::Responses.to_input_item(type: false, role: "user", content: "Continue")
    end

    assert_equal("Unsupported response item type: false", error.message)
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
