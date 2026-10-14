# frozen_string_literal: true

require "open3"

require_relative "../test_helper"

class OpenAI::Test::SessionStreamLoadingTest < Minitest::Test
  def test_direct_resource_loading_and_subclass_super
    source = <<~RUBY
      require "minitest/mock"
      require "openai/resources/beta/agents/sessions"
      resource = OpenAI::Resources::Beta::Agents::Sessions
      implementation = resource.instance_method(:stream)
      raise "stream must be public" unless resource.public_instance_methods(false).include?(:stream)
      require "openai"
      raise "root loading replaced stream" unless resource.instance_method(:stream) == implementation
      subclass = Class.new(resource) { def stream(...); super; end }
      marker = Object.new
      OpenAI::Helpers::Agents::SessionStream.stub(:new, marker) do
        [resource, subclass].each do |klass|
          actual = klass.new(client: Object.new).stream("session_fake", input: "Synthetic")
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
