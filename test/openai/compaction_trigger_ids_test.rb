# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::CompactionTriggerIdsTest < Minitest::Test
  extend Minitest::Serial

  def test_compaction_ids_survive_transport_and_existing_construction
    [false, true].each do |beta|
      [{id: "msg_transport_compat"}, {}, {id: nil}, {id: ""}].each do |fields|
        trigger = {type: "compaction_trigger", **fields}
        trigger[:agent] = {agent_name: "assistant"} if beta
        payload = {
          id: "resp_compat",
          object: "response",
          instructions: [trigger],
          output: [],
          text: {format: {type: "text"}}
        }
        transport = OpenAI::HTTPClient.new
        calls = 0
        handler = lambda do |request|
          calls += 1
          if request.method == :post
            assert_equal("/v1/responses", request.url.path)
            assert_equal([trigger], JSON.parse(request.body, symbolize_names: true).fetch(:input))
          else
            assert_equal(:get, request.method)
            assert_equal("/v1/responses/resp_compat", request.url.path)
          end

          assert_equal(beta, request.url.query.to_s.include?("beta=true"))
          OpenAI::HTTPClient::Response.new(
            status: 200,
            headers: {"content-type" => "application/json"},
            body: [payload.to_json]
          )
        end

        transport.stub(:execute, handler) do
          client = OpenAI::Client.new(
            api_key: "synthetic-key",
            base_url: "https://example.invalid/v1",
            max_retries: 0,
            http_client: transport
          )
          resource = beta ? client.beta.responses : client.responses
          result = resource.retrieve("resp_compat")
          item = result.instructions.fetch(0)
          assert_equal(:compaction_trigger, item.type)
          if fields[:id].nil?
            assert_nil(item.id)
          else
            assert_equal(fields[:id], item.id)
          end

          assert_equal("assistant", item.agent.agent_name) if beta
          assert_equal(1, calls)
          resource.create(model: "gpt-4o", input: [trigger])
          assert_equal(2, calls)
        end
      end
    end

    stable = OpenAI::Models::Responses::ResponseInputItem::CompactionTrigger
    beta = OpenAI::Models::Beta::BetaResponseInputItem::CompactionTrigger
    [stable, beta].each do |model|
      assert_equal(:compaction_trigger, model.new.type)
      assert_nil(model.new.id)
      assert_equal("msg_constructor", model.new(id: "msg_constructor").id)
    end
  end
end
