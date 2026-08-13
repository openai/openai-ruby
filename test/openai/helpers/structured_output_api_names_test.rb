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
            message: {content: '{"displayName":"Ada","middleName":null}', role: "assistant"}
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
                text: '{"displayName":"Ada","middleName":null}',
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
      model: "gpt-4o-mini", input: "Generate a profile", text: AliasedProfile
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
end
