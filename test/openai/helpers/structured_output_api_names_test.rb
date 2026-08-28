# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::StructuredOutputAPINamesTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  class AliasedProfile < OpenAI::BaseModel
    required :display_name, String, api_name: :displayName, doc: "Public display name"
    required :middle_name, String, api_name: :middleName, nil?: true, doc: "Optional middle name"
  end

  class AliasedEnvelope < OpenAI::BaseModel
    required :primary_profile, AliasedProfile, api_name: :primaryProfile
    required :backup_profile, AliasedProfile, api_name: :backupProfile
  end

  class AliasedProfileCollection < OpenAI::BaseModel
    required :primary_profile, AliasedProfile, api_name: :primaryProfile
    required :profiles, OpenAI::ArrayOf[AliasedProfile]
  end

  class AliasedLookup < OpenAI::BaseModel
    required :profile_id, Integer, api_name: :profileId
  end

  class AliasedNameCollision < OpenAI::BaseModel
    required :display_name, String, api_name: :displayName
    required :displayName, String, api_name: :legacyDisplayName
  end

  class DuplicateAPINames < OpenAI::BaseModel
    required :display_name, String, api_name: :displayName
    required :legacy_name, String, api_name: :displayName
  end

  class EscapedAliasEnvelope < OpenAI::BaseModel
    required :primary_profile, AliasedProfile, api_name: :"primary/name~value"
    required :backup_profile, AliasedProfile, api_name: :"backup~name/value"
  end

  class DeepAliasedEnvelope < OpenAI::BaseModel
    required :nested_profiles, AliasedEnvelope, api_name: :"nested/profiles~value"
  end

  class FragmentAliasEnvelope < OpenAI::BaseModel
    required :primary_profile, AliasedProfile, api_name: :"primary#name ?%é"
    required :backup_profile, AliasedProfile, api_name: :backupProfile
  end

  class NestedCollisionProfile < OpenAI::BaseModel
    required :employee_id, Integer, api_name: :employeeId
  end

  class NestedCollisionContainer < OpenAI::BaseModel
    required :profile, NestedCollisionProfile, api_name: :b
    required :backup_profile, NestedCollisionProfile, api_name: :backup
  end

  class DefinitionPathCollisionEnvelope < OpenAI::BaseModel
    required :direct_profile, AliasedProfile, api_name: :"a/.b"
    required :backup_profile, AliasedProfile, api_name: :directBackup
    required :nested_profiles, NestedCollisionContainer, api_name: :a
  end

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

  def test_schema_uses_api_names_without_exposing_internal_metadata
    assert_equal(
      {
        type: "object",
        properties: {
          displayName: {type: "string", description: "Public display name"},
          middleName: {type: %w[string null], description: "Optional middle name"}
        },
        required: %w[displayName middleName],
        additionalProperties: false
      },
      AliasedProfile.to_json_schema
    )
  end

  def test_nested_aliases_preserve_reused_definitions
    assert_equal(
      {
        :$defs => {".primaryProfile" => AliasedProfile.to_json_schema},
        :type => "object",
        :properties => {
          primaryProfile: {:$ref => "#/$defs/.primaryProfile"},
          backupProfile: {:$ref => "#/$defs/.primaryProfile"}
        },
        :required => %w[primaryProfile backupProfile],
        :additionalProperties => false
      },
      AliasedEnvelope.to_json_schema
    )
  end

  def test_ruby_name_matching_another_api_name_does_not_replace_a_property
    schema = AliasedNameCollision.to_json_schema

    assert_equal([:displayName, :legacyDisplayName], schema.fetch(:properties).keys)
    assert_equal(%w[displayName legacyDisplayName], schema.fetch(:required))
  end

  def test_duplicate_api_names_are_rejected
    error = assert_raises(ArgumentError) { DuplicateAPINames.to_json_schema }

    assert_match(/displayName/, error.message)
  end

  def test_api_names_are_escaped_as_json_pointer_tokens
    schema = EscapedAliasEnvelope.to_json_schema
    expected_ref = "#/$defs/.primary~01name~00value"

    assert_equal([".primary~1name~0value"], schema.fetch(:$defs).keys)
    assert_equal(expected_ref, schema.dig(:properties, :"primary/name~value", :$ref))
    assert_equal(expected_ref, schema.dig(:properties, :"backup~name/value", :$ref))
    assert_equal(["primary/name~value", "backup~name/value"], schema.fetch(:required))
  end

  def test_nested_definition_paths_are_single_json_pointer_tokens
    schema = DeepAliasedEnvelope.to_json_schema
    expected_name = ".nested~1profiles~0value/.primaryProfile"
    expected_ref = "#/$defs/.nested~01profiles~00value~1.primaryProfile"
    nested = schema.dig(:properties, :"nested/profiles~value")

    assert_equal([expected_name], schema.fetch(:$defs).keys)
    assert_equal(expected_ref, nested.dig(:properties, :primaryProfile, :$ref))
    assert_equal(expected_ref, nested.dig(:properties, :backupProfile, :$ref))
  end

  def test_definition_references_percent_encode_uri_fragments
    schema = FragmentAliasEnvelope.to_json_schema
    expected_ref = "#/$defs/.primary%23name%20%3F%25%C3%A9"

    assert_equal([".primary#name ?%é"], schema.fetch(:$defs).keys)
    assert_equal(expected_ref, schema.dig(:properties, :"primary#name ?%é", :$ref))
    assert_equal(expected_ref, schema.dig(:properties, :backupProfile, :$ref))
  end

  def test_alias_delimiters_cannot_collide_with_nested_definition_paths
    schema = DefinitionPathCollisionEnvelope.to_json_schema
    definitions = schema.fetch(:$defs)
    nested = schema.dig(:properties, :a)

    assert_equal([".a/.b", ".a~1.b"], definitions.keys.sort)
    assert_equal(AliasedProfile.to_json_schema, definitions.fetch(".a~1.b"))
    assert_equal(NestedCollisionProfile.to_json_schema, definitions.fetch(".a/.b"))
    assert_equal("#/$defs/.a~01.b", schema.dig(:properties, :"a/.b", :$ref))
    assert_equal("#/$defs/.a~01.b", schema.dig(:properties, :directBackup, :$ref))
    assert_equal("#/$defs/.a~1.b", nested.dig(:properties, :b, :$ref))
    assert_equal("#/$defs/.a~1.b", nested.dig(:properties, :backup, :$ref))
  end

  def test_converter_round_trips_ruby_and_api_names
    profile = AliasedProfile.new(display_name: "Ada", middle_name: nil)
    api_value = OpenAI::Internal::Type::Converter.dump(AliasedProfile, profile)

    assert_equal({displayName: "Ada", middleName: nil}, api_value)

    parsed = OpenAI::Internal::Type::Converter.coerce(AliasedProfile, api_value)

    assert_instance_of(AliasedProfile, parsed)
    assert_equal("Ada", parsed.display_name)
    assert_nil(parsed.middle_name)
  end

  def test_chat_completion_round_trips_api_named_structured_output
    stub_request(:post, "http://localhost/chat/completions").to_return_json(
      status: 200,
      body: {
        id: "chatcmpl_alias",
        choices: [
          {
            finish_reason: "stop",
            index: 0,
            message: {content: "{\"displayName\":\"Ada\",\"middleName\":null}", role: "assistant"}
          }
        ],
        created: 1_700_000_000,
        model: "gpt-4o-mini",
        object: "chat.completion"
      }
    )

    response = @client.chat.completions.create(
      messages: [{content: "Generate a profile", role: :user}],
      model: "gpt-4o-mini",
      response_format: AliasedProfile
    )

    assert_requested(:post, "http://localhost/chat/completions") do |request|
      schema = JSON.parse(request.body).dig("response_format", "json_schema", "schema")
      assert_equal(%w[displayName middleName], schema.fetch("properties").keys)
      assert_equal(%w[displayName middleName], schema.fetch("required"))
      refute_includes(request.body, "api_name")
    end

    parsed = response.choices.first.message.parsed

    assert_instance_of(AliasedProfile, parsed)
    assert_equal("Ada", parsed.display_name)
    assert_nil(parsed.middle_name)
  end

  def test_responses_round_trips_api_named_structured_output
    stub_request(:post, "http://localhost/responses").to_return_json(
      status: 200,
      body: {
        id: "resp_alias",
        output: [
          {
            id: "msg_alias",
            content: [
              {
                annotations: [],
                text: "{\"displayName\":\"Ada\",\"middleName\":null}",
                type: "output_text"
              }
            ],
            role: "assistant",
            status: "completed",
            type: "message"
          }
        ]
      }
    )

    response = @client.responses.create(
      model: "gpt-4o-mini",
      input: "Generate a profile",
      text: AliasedProfile
    )

    assert_requested(:post, "http://localhost/responses") do |request|
      schema = JSON.parse(request.body).dig("text", "format", "schema")
      assert_equal(%w[displayName middleName], schema.fetch("properties").keys)
      assert_equal(%w[displayName middleName], schema.fetch("required"))
      refute_includes(request.body, "api_name")
    end

    parsed = response.output.first.content.first.parsed

    assert_instance_of(AliasedProfile, parsed)
    assert_equal("Ada", parsed.display_name)
    assert_nil(parsed.middle_name)
  end

  def test_background_retrieve_parses_text_and_tool_models_locally
    stub_request(:get, "http://localhost/responses/resp_background").to_return_json(
      status: 200,
      body: {
        id: "resp_background",
        status: "completed",
        output: [
          {
            id: "msg_background",
            content: [
              {
                annotations: [],
                text: "{\"displayName\":\"Ada\",\"middleName\":null}",
                type: "output_text"
              }
            ],
            role: "assistant",
            status: "completed",
            type: "message"
          },
          {
            arguments: "{\"profileId\":7}",
            call_id: "call_background",
            name: "AliasedLookup",
            type: "function_call"
          }
        ]
      }
    )

    tools = [AliasedLookup]
    response = @client.responses.retrieve(
      "resp_background",
      text: AliasedProfile,
      tools: tools
    )

    assert_requested(:get, "http://localhost/responses/resp_background") do |request|
      assert_nil(request.uri.query)
    end

    parsed_text = response.output.fetch(0).content.fetch(0).parsed
    parsed_tool = response.output.fetch(1).parsed

    assert_instance_of(AliasedProfile, parsed_text)
    assert_equal("Ada", parsed_text.display_name)
    assert_nil(parsed_text.middle_name)
    assert_instance_of(AliasedLookup, parsed_tool)
    assert_equal(7, parsed_tool.profile_id)
    assert_equal([AliasedLookup], tools)
  end

  def test_background_retrieve_parses_completed_text_when_response_status_is_omitted
    stub_request(:get, "http://localhost/responses/resp_without_status").to_return_json(
      status: 200,
      body: {
        id: "resp_without_status",
        output: [
          {
            id: "msg_without_status",
            content: [
              {
                annotations: [],
                text: "{\"displayName\":\"Ada\",\"middleName\":null}",
                type: "output_text"
              }
            ],
            role: "assistant",
            status: "completed",
            type: "message"
          }
        ]
      }
    )

    response = @client.responses.retrieve("resp_without_status", text: AliasedProfile)

    assert_nil(response.status)
    assert_instance_of(AliasedProfile, response.output.fetch(0).content.fetch(0).parsed)
  end

  def test_background_retrieve_parses_explicitly_named_tool_models_locally
    stub_request(:get, "http://localhost/responses/resp_named_tool").to_return_json(
      status: 200,
      body: {
        id: "resp_named_tool",
        status: "completed",
        output: [
          {
            arguments: "{\"profileId\":7}",
            call_id: "call_named_tool",
            name: "custom_lookup",
            type: "function_call"
          }
        ]
      }
    )

    tools = [{type: :function, function: {name: "custom_lookup", parameters: AliasedLookup}}]
    response = @client.responses.retrieve("resp_named_tool", tools: tools)

    assert_requested(:get, "http://localhost/responses/resp_named_tool") do |request|
      assert_nil(request.uri.query)
    end

    parsed = response.output.fetch(0).parsed

    assert_instance_of(AliasedLookup, parsed)
    assert_equal(7, parsed.profile_id)
    assert_equal(AliasedLookup, tools.dig(0, :function, :parameters))
  end

  def test_background_retrieve_defers_partial_text_parsing_while_in_progress
    stub_request(:get, "http://localhost/responses/resp_pending").to_return_json(
      status: 200,
      body: {
        id: "resp_pending",
        status: "in_progress",
        output: [
          {
            id: "msg_pending",
            content: [{annotations: [], text: "{\"displayName\":", type: "output_text"}],
            role: "assistant",
            status: "in_progress",
            type: "message"
          }
        ]
      }
    )

    response = @client.responses.retrieve("resp_pending", text: AliasedProfile)

    assert_requested(:get, "http://localhost/responses/resp_pending") do |request|
      assert_nil(request.uri.query)
    end

    content = response.output.fetch(0).content.fetch(0)

    assert_equal("{\"displayName\":", content.text)
    assert_nil(content.parsed)
  end

  def test_background_retrieve_defers_partial_tool_parsing_while_queued
    stub_request(:get, "http://localhost/responses/resp_queued").to_return_json(
      status: 200,
      body: {
        id: "resp_queued",
        status: "queued",
        output: [
          {
            arguments: "{\"profileId\":",
            call_id: "call_queued",
            name: "AliasedLookup",
            type: "function_call"
          }
        ]
      }
    )

    response = @client.responses.retrieve("resp_queued", tools: [AliasedLookup])
    tool_call = response.output.fetch(0)

    assert_equal("{\"profileId\":", tool_call.arguments)
    assert_nil(tool_call.parsed)
  end

  def test_background_retrieve_defers_partial_outputs_when_incomplete
    stub_request(:get, "http://localhost/responses/resp_incomplete").to_return_json(
      status: 200,
      body: {
        id: "resp_incomplete",
        status: "incomplete",
        output: [
          {
            id: "msg_incomplete",
            content: [{annotations: [], text: "{\"displayName\":", type: "output_text"}],
            role: "assistant",
            status: "incomplete",
            type: "message"
          },
          {
            arguments: "{\"profileId\":",
            call_id: "call_incomplete",
            name: "AliasedLookup",
            type: "function_call"
          }
        ]
      }
    )

    response = @client.responses.retrieve(
      "resp_incomplete",
      text: AliasedProfile,
      tools: [AliasedLookup]
    )

    content = response.output.fetch(0).content.fetch(0)
    tool_call = response.output.fetch(1)

    assert_equal("{\"displayName\":", content.text)
    assert_nil(content.parsed)
    assert_equal("{\"profileId\":", tool_call.arguments)
    assert_nil(tool_call.parsed)
  end

  def test_background_retrieve_defers_unfinished_tool_items_with_a_text_hint
    stub_request(:get, "http://localhost/responses/resp_unfinished_tool").to_return_json(
      status: 200,
      body: {
        id: "resp_unfinished_tool",
        status: "in_progress",
        output: [{type: "function_call"}]
      }
    )

    response = @client.responses.retrieve("resp_unfinished_tool", text: AliasedProfile)

    assert_equal(1, response.output.length)
    assert_equal(:function_call, response.output.fetch(0).type)
  end

  def test_background_retrieve_keeps_string_keyed_parsing_hints_local
    stub_request(:get, "http://localhost/responses/resp_string_hints").to_return_json(
      status: 200,
      body: {
        id: "resp_string_hints",
        status: "completed",
        output: [
          {
            id: "msg_string_hints",
            content: [
              {
                annotations: [],
                text: "{\"displayName\":\"Ada\",\"middleName\":null}",
                type: "output_text"
              }
            ],
            role: "assistant",
            status: "completed",
            type: "message"
          },
          {
            arguments: "{\"profileId\":7}",
            call_id: "call_string_hints",
            name: "custom_lookup",
            type: "function_call"
          }
        ]
      }
    )

    tools = [
      {"type" => "function", "function" => {"name" => "custom_lookup", "parameters" => AliasedLookup}}
    ]
    response = @client.responses.retrieve(
      "resp_string_hints",
      {"text" => AliasedProfile, "tools" => tools}
    )

    assert_requested(:get, "http://localhost/responses/resp_string_hints") do |request|
      assert_nil(request.uri.query)
    end

    assert_instance_of(AliasedProfile, response.output.fetch(0).content.fetch(0).parsed)
    assert_instance_of(AliasedLookup, response.output.fetch(1).parsed)
    assert_equal(AliasedLookup, tools.dig(0, "function", "parameters"))
  end

  def test_background_retrieve_accepts_response_retrieve_params
    stub_request(:get, "http://localhost/responses/resp_params").to_return_json(
      status: 200,
      body: {id: "resp_params", status: "in_progress", output: []}
    )

    params = OpenAI::Responses::ResponseRetrieveParams.new
    response = @client.responses.retrieve("resp_params", params)

    assert_requested(:get, "http://localhost/responses/resp_params") do |request|
      assert_nil(request.uri.query)
    end

    assert_empty(response.output)
  end

  def test_typed_text_config_has_create_and_retrieve_parity
    output = [
      {
        id: "msg_text_config",
        content: [
          {
            annotations: [],
            text: "{\"displayName\":\"Ada\",\"middleName\":null}",
            type: "output_text"
          }
        ],
        role: "assistant",
        status: "completed",
        type: "message"
      }
    ]
    stub_request(:post, "http://localhost/responses").to_return_json(
      status: 200,
      body: {id: "resp_created_text_config", status: "completed", output: output}
    )
    stub_request(:get, "http://localhost/responses/resp_text_config").to_return_json(
      status: 200,
      body: {id: "resp_text_config", status: "completed", output: output}
    )

    config = OpenAI::Responses::ResponseTextConfig.new(format_: AliasedProfile)
    created = @client.responses.create(input: "Create a profile", model: "gpt-4o-mini", text: config)
    retrieved = @client.responses.retrieve("resp_text_config", text: config)

    created_parsed = created.output.fetch(0).content.fetch(0).parsed
    retrieved_parsed = retrieved.output.fetch(0).content.fetch(0).parsed

    assert_instance_of(AliasedProfile, created_parsed)
    assert_instance_of(AliasedProfile, retrieved_parsed)
    assert_equal(created_parsed.display_name, retrieved_parsed.display_name)
  end

  def test_background_retrieve_without_hints_skips_structured_output_parsing
    stub_request(:get, "http://localhost/responses/resp_partial_tool").to_return_json(
      status: 200,
      body: {
        id: "resp_partial_tool",
        status: "in_progress",
        output: [{type: "function_call"}]
      }
    )

    response = @client.responses.retrieve("resp_partial_tool")

    assert_equal(1, response.output.length)
  end

  def test_public_structured_output_endpoints_materialize_nested_models
    profile = {displayName: "Ada", middleName: nil}
    content = {primaryProfile: profile, profiles: [profile]}.to_json

    stub_request(:post, "http://localhost/chat/completions").to_return_json(
      status: 200,
      body: {
        id: "chatcmpl_nested",
        choices: [{finish_reason: "stop", index: 0, message: {content: content, role: "assistant"}}],
        created: 1_700_000_000,
        model: "gpt-4o-mini",
        object: "chat.completion"
      }
    )
    stub_request(:post, "http://localhost/responses").to_return_json(
      status: 200,
      body: {
        id: "resp_nested",
        output: [
          {
            id: "msg_nested",
            content: [{annotations: [], text: content, type: "output_text"}],
            role: "assistant",
            status: "completed",
            type: "message"
          }
        ]
      }
    )

    chat = @client.chat.completions.create(
      messages: [{content: "Generate profiles", role: :user}],
      model: "gpt-4o-mini",
      response_format: AliasedProfileCollection
    )
    response = @client.responses.create(
      model: "gpt-4o-mini",
      input: "Generate profiles",
      text: AliasedProfileCollection
    )

    [chat.choices.first.message.parsed, response.output.first.content.first.parsed].each do |parsed|
      assert_instance_of(AliasedProfileCollection, parsed)
      assert_instance_of(AliasedProfile, parsed.primary_profile)
      assert_instance_of(AliasedProfile, parsed.profiles.fetch(0))
      assert_equal("Ada", parsed.primary_profile.display_name)
      assert_equal("Ada", parsed.profiles.fetch(0).display_name)
    end
  end
end
