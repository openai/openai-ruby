# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::ImageToolErrorTransportTest < Minitest::Test
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

  [:output, :instructions, :input_items, :beta_output, :beta_instructions, :beta_input_items, :conversation].each do |
      route
    |
    [:values, :nulls, :no_moderation, :no_error].each do |error_case|
      define_method("test_#{route}_#{error_case}") do
        item = {id: "img_synthetic", type: "image_generation_call", status: "failed", result: nil}
        unless error_case == :no_error
          item[:error] = {
            code: error_case == :nulls ? nil : "synthetic_code",
            param: error_case == :nulls ? nil : "synthetic_param",
            message: "synthetic blocked",
            type: "image_generation_error"
          }
          unless error_case == :no_moderation
            item[:error][:moderation_details] = {
              moderation_stage: "output",
              categories: ["synthetic_category"]
            }
          end
        end

        beta = [:beta_output, :beta_instructions, :beta_input_items].include?(route)
        path = case route
        when :conversation
          "/conversations/conv_synthetic/items/img_synthetic"
        when :input_items, :beta_input_items
          "/responses/resp_synthetic/input_items"
        else
          "/responses/resp_synthetic"
        end

        url = "http://localhost#{path}#{beta ? "?beta=true" : ""}"
        body = case route
        when :conversation
          item
        when :input_items, :beta_input_items
          {object: "list", data: [item], first_id: "img_synthetic", last_id: "img_synthetic", has_more: false}
        else
          {id: "resp_synthetic", object: "response", output: [item], instructions: [item]}
        end

        stub_request(:get, url)
          .with(headers: {"Authorization" => "Bearer synthetic-key"})
          .to_return_json(body: body)
        client = OpenAI::Client.new(base_url: "http://localhost", api_key: "synthetic-key", max_retries: 0)
        call = case route
        when :output
          client.responses.retrieve("resp_synthetic").output.first
        when :instructions
          client.responses.retrieve("resp_synthetic").instructions.first
        when :input_items
          client.responses.input_items.list("resp_synthetic").data.first
        when :beta_output
          client.beta.responses.retrieve("resp_synthetic").output.first
        when :beta_instructions
          client.beta.responses.retrieve("resp_synthetic").instructions.first
        when :beta_input_items
          client.beta.responses.input_items.list("resp_synthetic").data.first
        when :conversation
          client.conversations.items.retrieve("img_synthetic", conversation_id: "conv_synthetic")
        end

        assert_requested(:get, url, times: 1)
        assert_equal("img_synthetic", call.id)
        if error_case == :no_error
          assert_nil(call.error)
          refute(call.to_hash.key?(:error))
        else
          error = call.error
          if error_case == :nulls
            assert_nil(error.code)
            assert_nil(error.param)
            assert(error.to_hash.key?(:code))
            assert(error.to_hash.key?(:param))
          else
            assert_equal("synthetic_code", error.code)
            assert_equal("synthetic_param", error.param)
          end

          assert_equal("synthetic blocked", error.message)
          assert_equal("image_generation_error", error.type)
          if error_case == :no_moderation
            assert_nil(error.moderation_details)
            refute(error.to_hash.key?(:moderation_details))
          else
            assert_equal(:output, error.moderation_details.moderation_stage)
            assert_equal(["synthetic_category"], error.moderation_details.categories)
          end
        end
      end
    end
  end
end
