# frozen_string_literal: true

require "open3"

require_relative "../test_helper"

class OpenAI::Test::ResponseStreamLoadingTest < Minitest::Test
  def test_direct_resource_loading_and_subclass_super
    source = <<~RUBY
      require "minitest/mock"
      require "openai/resources/responses"
      resource = OpenAI::Resources::Responses
      implementation = resource.instance_method(:stream)
      raise "stream must be public" unless resource.public_instance_methods(false).include?(:stream)
      require "openai"
      raise "root loading replaced stream" unless resource.instance_method(:stream) == implementation
      subclass = Class.new(resource) { def stream(...); super; end }
      marker = Object.new
      OpenAI::Helpers::Streaming::ResponseStream.stub(:new, marker) do
        [resource, subclass].each do |klass|
          client = Object.new
          def client.request(**); :raw; end
          actual = klass.new(client: client).stream(model: "gpt-4.1", input: "Synthetic")
          raise "stream dispatch changed" unless actual.equal?(marker)
        end
      end
    RUBY
    root = File.expand_path("../../..", __dir__)
    ["", "require \"openai\"\n"].each do |prefix|
      stdout, stderr, status = Open3.capture3(RbConfig.ruby, "-I#{root}/lib", "-e", prefix + source)
      assert_predicate(status, :success?, "#{stdout}\n#{stderr}")
    end
  end
end
