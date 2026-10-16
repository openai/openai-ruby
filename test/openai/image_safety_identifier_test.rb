# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::ImageSafetyIdentifierTest < Minitest::Test
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

  [:generate, :edit].each do |operation|
    [false, true].each do |streaming|
      ["synthetic-image-safety-user", nil, :omitted].each do |value|
        define_method("test_#{operation}_#{streaming}_#{value.inspect}") do
          field = value == :omitted ? {} : {safety_identifier: value}
          expected = value == :omitted ? nil : value
          type = operation == :generate ? "image_generation.completed" : "image_edit.completed"
          payload = if streaming
            {
              type: type,
              b64_json: "c3ludGhldGlj",
              created_at: 1_620_000_000,
              size: "1024x1024",
              quality: "high",
              background: "transparent",
              output_format: "png",
              usage: {
                total_tokens: 100,
                input_tokens: 50,
                output_tokens: 50,
                input_tokens_details: {text_tokens: 10, image_tokens: 40}
              },
              **field
            }
          else
            {created: 1_620_000_000, data: [{b64_json: "c3ludGhldGlj"}], **field}
          end

          endpoint = operation == :generate ? "generations" : "edits"
          url = "http://localhost/images/#{endpoint}"
          request = stub_request(:post, url).with do |sent|
            if operation == :generate
              body = JSON.parse(sent.body)
              assert_equal("synthetic-request-user", body.fetch("safety_identifier"))
              assert_equal("legacy-user", body.fetch("user"))
            else
              assert_match(/name="safety_identifier"\r\n(?:[^\r\n]+\r\n)*\r\nsynthetic-request-user\r\n/, sent.body)
              assert_match(/name="user"\r\n(?:[^\r\n]+\r\n)*\r\nlegacy-user\r\n/, sent.body)
            end

            true
          end

          request.to_return(
            status: 200,
            headers: {"content-type" => streaming ? "text/event-stream" : "application/json"},
            body: streaming ? "data: #{JSON.generate(payload)}\n\n" : JSON.generate(payload)
          )
          client = OpenAI::Client.new(base_url: "http://localhost", api_key: "synthetic-key", max_retries: 0)
          params = {prompt: "A synthetic image", safety_identifier: "synthetic-request-user", user: "legacy-user"}
          response = if operation == :generate
            streaming ? client.images.generate_stream_raw(params).to_a : client.images.generate(params)
          else
            params[:image] = StringIO.new("synthetic image")
            streaming ? client.images.edit_stream_raw(params).to_a : client.images.edit(params)
          end

          if streaming
            assert_equal(1, response.length)
            response = response.fetch(0)
          end

          if expected.nil?
            assert_nil(response.safety_identifier)
          else
            assert_equal(expected, response.safety_identifier)
          end

          assert_equal(type, response.type.to_s) if streaming
          assert_requested(request, times: 1)
        end
      end
    end
  end
end
