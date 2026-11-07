# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::AutomationsTransportTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def before_all
    super
    WebMock.enable!
    WebMock.disable_net_connect!
  end

  def after_all
    WebMock.disable!
    super
  end

  def teardown
    WebMock.reset!
    super
  end

  def automation
    {
      id: "auto_test",
      object: "agent.automation",
      type: "periodic",
      name: "offline schedule",
      expression: "0 9 * * *",
      timezone: "UTC",
      created_at: 1_700_000_000,
      created_by: {type: "developer"},
      status: "active",
      metadata: {marker: "preserved"},
      target: {type: "existing_session", session_id: "sess_target", instructions: "offline"}
    }
  end

  [:periodic, :once].product([false, true]).each do |schedule, typed|
    define_method("test_create_#{schedule}_#{typed ? "typed" : "hash"}_sends_root_union_body") do
      params = {type: schedule, name: "offline schedule", metadata: {marker: "request"}}
      if schedule == :periodic
        params.merge!(expression: "0 9 * * *", timezone: "UTC", target: automation[:target])
      else
        params.merge!(
          run_at: 1_800_000_000,
          target: {type: "new_session", environment: {type: "none"}, input: [], agent_id: "agent_test"}
        )
      end

      request = stub_request(:post, "https://example.test/agents/automations")
        .with(body: JSON.parse(JSON.generate(params)), headers: {"OpenAI-Beta" => "agents=v1"})
        .to_return(status: 200, body: JSON.generate(automation), headers: {"Content-Type" => "application/json"})
      client = OpenAI::Client.new(api_key: "test-key", base_url: "https://example.test")
      request_params = if typed
        schedule_class = schedule == :periodic ? OpenAI::Beta::Agents::AutomationScheduleParam::Periodic : OpenAI::Beta::Agents::AutomationScheduleParam::Once
        OpenAI::Beta::Agents::AutomationCreateParams.new(create_automation_params: schedule_class.new(**params))
      else
        {create_automation_params: params}
      end

      if typed
        assert_instance_of(schedule_class, request_params.create_automation_params)
        assert_equal(params[:name], request_params.create_automation_params.name)
      end

      # Explicit conversion exposes the typed keyword shape to RBS consumers too.
      result = client.beta.agents.automations.create(**request_params.to_hash)
      assert_equal({marker: "preserved"}, result.metadata)
      assert_requested(request)
    end
  end

  [false, true].each do |nulls|
    define_method("test_invocation_#{nulls ? "nulls" : "values"}_survive_transport") do
      invocation = {
        id: "inv_test",
        automation_id: "auto_test",
        object: "agent.automation.invocation",
        created_at: 1_700_000_001,
        status: "failed",
        source: {type: "manual"},
        scheduled_at: 1_700_000_123,
        session_id: "sess_preserved",
        skip_reason: "pending_delivery",
        error: {code: "synthetic_failure", message: "distinctive explanation"}
      }
      [:scheduled_at, :session_id, :skip_reason, :error].each { |key| invocation[key] = nil } if nulls
      request = stub_request(:get, "https://example.test/agents/automations/auto_test/invocations/inv_test")
        .to_return(status: 200, body: JSON.generate(invocation), headers: {"Content-Type" => "application/json"})
      client = OpenAI::Client.new(api_key: "test-key", base_url: "https://example.test")
      result = client.beta.agents.automations.invocations.retrieve("inv_test", automation_id: "auto_test")
      if nulls
        assert_nil(result.scheduled_at)
        assert_nil(result.session_id)
        assert_nil(result.skip_reason)
        assert_nil(result.error)
      else
        assert_equal(1_700_000_123, result.scheduled_at)
        assert_equal("sess_preserved", result.session_id)
        assert_equal(:pending_delivery, result.skip_reason)
        assert_equal("synthetic_failure", result.error.code)
        assert_equal("distinctive explanation", result.error.message)
      end

      assert_requested(request)
    end
  end
end
