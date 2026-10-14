# frozen_string_literal: true

require_relative "../test_helper"

require "aws-sdk-core"
require "fileutils"
require "tmpdir"

module OpenAI::Test::BedrockTestHelper
  include WebMock::API

  ENVIRONMENT_VARIABLES = %w[
    AWS_ACCESS_KEY_ID
    AWS_BEARER_TOKEN_BEDROCK
    AWS_BEDROCK_BASE_URL
    AWS_CONFIG_FILE
    AWS_DEFAULT_PROFILE
    AWS_DEFAULT_REGION
    AWS_EC2_METADATA_DISABLED
    AWS_PROFILE
    AWS_REGION
    AWS_SDK_CONFIG_OPT_OUT
    AWS_SECRET_ACCESS_KEY
    AWS_SESSION_TOKEN
    AWS_SHARED_CREDENTIALS_FILE
    OPENAI_ADMIN_KEY
    OPENAI_API_KEY
    OPENAI_BASE_URL
    OPENAI_CUSTOM_HEADERS
    OPENAI_ORG_ID
    OPENAI_PROJECT_ID
  ]
    .freeze

  def before_all
    super
    WebMock.enable!
  end

  def setup
    super
    @environment = ENVIRONMENT_VARIABLES.to_h { [_1, ENV[_1]] }
    ENVIRONMENT_VARIABLES.each { ENV.delete(_1) }
    @aws_dir = Dir.mktmpdir("openai-bedrock-test")
    ENV["AWS_SHARED_CREDENTIALS_FILE"] = File.join(@aws_dir, "credentials")
    ENV["AWS_CONFIG_FILE"] = File.join(@aws_dir, "config")
    ENV["AWS_EC2_METADATA_DISABLED"] = "true"
    File.write(ENV.fetch("AWS_SHARED_CREDENTIALS_FILE"), "")
    File.write(ENV.fetch("AWS_CONFIG_FILE"), "")
    reset_shared_config
  end

  def teardown
    Thread.current.thread_variable_set(:time_now, nil)
    WebMock.reset!
    FileUtils.rm_rf(@aws_dir)
    @environment.each { |name, value| value.nil? ? ENV.delete(name) : ENV[name] = value }
    reset_shared_config
    super
  end

  def after_all
    WebMock.disable!
    super
  end

  private def reset_shared_config
    Aws.instance_variable_set(:@shared_config, nil)
  end

  private def bedrock_request(url = "https://bedrock-mantle.us-east-1.api.aws/v1/models")
    {method: :get, url: URI(url), headers: {}, body: nil}
  end
end
