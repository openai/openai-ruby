# frozen_string_literal: true

require "open3"

require_relative "test_helper"

class OpenAI::Test::NamedGradersMapTest < Minitest::Test
  def test_public_entrypoint_sends_and_parses_named_graders
    script = <<~'RUBY'
      require "openai"
      PAYLOAD = {
       type: :multi, name: "combined", calculate_output: "0.5 * exact + 0.5 * script",
       graders: {
        exact: {type: :string_check, name: "exact", input: "{{sample.output_text}}", reference: "ok", operation: :eq},
        script: {type: :python, name: "script", source: "def grade(sample, item): return 1.0"}
       }
      }
      EXPECTED = JSON.parse(JSON.generate(PAYLOAD))
      class CaptureTransport < OpenAI::HTTPClient
       attr_reader :calls
       def initialize
        super()
        @calls = 0
       end
       def execute(request)
        raise "wrong URL" unless request.url.to_s == "http://sdk517.invalid/v1/fine_tuning/alpha/graders/validate"
        body = request.body
        body = body.to_a.join if body.respond_to?(:each) && !body.is_a?(String)
        decoded = JSON.parse(body)
        raise "wrong serialized payload: #{decoded}" unless decoded == {"grader" => EXPECTED}
        @calls += 1
        OpenAI::HTTPClient::Response.new(status: 200, headers: {"content-type"=>"application/json"}, body: [JSON.generate({"grader"=>EXPECTED})])
       end
      end
      def assert_map(model)
       raise "not MultiGrader" unless model.is_a?(OpenAI::Graders::MultiGrader)
       map = model.graders
       raise "wrong map keys" unless map.keys.map(&:to_s).sort == ["exact", "script"]
       exact = map[:exact] || map["exact"]
       script = map[:script] || map["script"]
       raise "not StringCheckGrader" unless exact.is_a?(OpenAI::Graders::StringCheckGrader)
       raise "not PythonGrader" unless script.is_a?(OpenAI::Graders::PythonGrader)
       raise "wrong formula" unless model.calculate_output == PAYLOAD[:calculate_output]
       raise "wrong roundtrip" unless JSON.parse(model.to_json) == EXPECTED
      end
      raw = OpenAI::Graders::MultiGrader.new(**PAYLOAD)
      raise "raw ownership changed" unless raw.graders.equal?(PAYLOAD[:graders])
      raise "raw serialization changed" unless JSON.parse(raw.to_json) == EXPECTED
      typed = PAYLOAD.merge(graders: {exact: OpenAI::Graders::StringCheckGrader.new(**PAYLOAD[:graders][:exact]), script: OpenAI::Graders::PythonGrader.new(**PAYLOAD[:graders][:script])})
      assert_map(OpenAI::Graders::MultiGrader.new(**typed))
      transport = CaptureTransport.new
      client = OpenAI::Client.new(api_key: "synthetic", base_url: "http://sdk517.invalid/v1", http_client: transport, max_retries: 0)
      result = client.fine_tuning.alpha.graders.validate(grader: PAYLOAD)
      assert_map(result.grader)
      raise "wrong call count" unless transport.calls == 1
      puts "PASS Ruby constructor + HTTP serialization + typed map response; both concrete variants and formula preserved"
    RUBY
    output, status = Open3.capture2e(
      RbConfig.ruby,
      "-I",
      File.expand_path("../../lib", __dir__),
      "-e",
      script
    )
    assert(status.success?, output)
    assert_includes(output, "PASS Ruby constructor + HTTP serialization + typed map response")
  end
end
