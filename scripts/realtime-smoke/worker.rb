# frozen_string_literal: true

# This worker is private to run.rb. Suppress all diagnostics even if invoked
# directly, before loading dependencies or reading credentials.
$stdout.reopen(File::NULL, "w")
$stderr.reopen(File::NULL, "w")

begin
  exit(2) unless ENV["OPENAI_REALTIME_LIVE_SMOKE"] == "1"
  exit(2) if ENV.fetch("OPENAI_API_KEY", "").strip.empty?

  require_relative "audio"
  client = OpenAI::Client.new(
    api_key: ENV.fetch("OPENAI_API_KEY"),
    base_url: "https://api.openai.com/v1",
    max_retries: 0,
    timeout: 10,
    log_level: :off
  )
  RealtimeSmoke::Audio.new(client: client).run
rescue StandardError, LoadError
  exit(1)
end
