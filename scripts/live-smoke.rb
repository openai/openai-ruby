#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../lib/openai"

module OpenAILiveSmoke
  class Failure < StandardError
  end

  class Runner
    PROMPT = "Reply with exactly OK."

    def initialize(client:, model:, output:)
      @client = client
      @model = model
      @output = output
    end

    def run
      raise Failure, "model listing returned no accessible models" if @client.models.list.data.empty?
      @output.puts("[live-smoke] authenticated model listing succeeded")

      response = @client.responses.create(model: @model, input: PROMPT, max_output_tokens: 32)
      raise Failure, "response creation returned no output text" if response.output_text.to_s.strip.empty?
      @output.puts("[live-smoke] non-streaming response succeeded")

      stream = @client.responses.stream(model: @model, input: PROMPT, max_output_tokens: 32)
      raise Failure, "response stream returned no completed output text" if stream.get_output_text.to_s.strip.empty?
      @output.puts("[live-smoke] streaming response completed")

      nil
    end
  end

  def self.run_cli(model:, output:, error_output:, client: nil)
    client ||= OpenAI::Client.new(log_level: :off)
    Runner.new(client: client, model: model, output: output).run
    true
  rescue Failure => error
    error_output.puts("[live-smoke] #{error.message}")
    false
  rescue StandardError => error
    status = error.respond_to?(:status) && error.status ? " (HTTP #{error.status})" : ""
    error_output.puts("[live-smoke] #{error.class}#{status}")
    false
  end
end

if $PROGRAM_NAME == __FILE__
  success = OpenAILiveSmoke.run_cli(
    model: ENV.fetch("OPENAI_LIVE_SMOKE_MODEL", "gpt-4o-mini"),
    output: $stdout,
    error_output: $stderr
  )
  exit(1) unless success
end
