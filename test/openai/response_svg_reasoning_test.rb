# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::ResponseSvgReasoningTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def setup
    super
    WebMock.enable!
    WebMock.disable_net_connect!
  end

  def teardown
    WebMock.reset!
    WebMock.disable!
    super
  end

  def test_reads_svg_reasoning
    client = OpenAI::Client.new(api_key: "test-key", base_url: "https://example.test/v1")
    [{reasoning: {effort: "high"}}, {reasoning: nil}, {}].each_with_index do |svg, index|
      id = "resp_fixture_#{index}"
      request = stub_request(:get, "https://example.test/v1/responses/#{id}")
        .to_return(
          headers: {"Content-Type" => "application/json"},
          body: {tools: [{type: "image_generation", svg: svg}]}.to_json
        )

      reasoning = client.responses.retrieve(id).tools.fetch(0).svg.reasoning
      if svg[:reasoning]
        assert_equal(:high, reasoning&.effort)
      else
        assert_nil(reasoning)
      end

      assert_requested(request, times: 1)
    end
  end
end
