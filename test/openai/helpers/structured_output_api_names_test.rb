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
