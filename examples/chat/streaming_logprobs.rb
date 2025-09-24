#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/openai"

# gets API Key from environment variable `OPENAI_API_KEY`
client = OpenAI::Client.new

stream = client.chat.completions.stream(
  model: "gpt-4o-mini",
  logprobs: true,
  top_logprobs: 3,
  messages: [
    {role: :user, content: "Finish the sentence: The capital of France is"}
  ]
)

stream.each do |event|
  case event
  when OpenAI::Streaming::ChatContentDeltaEvent
    print(event.delta)
  when OpenAI::Streaming::ChatLogprobsContentDeltaEvent
    # Print top logprobs for the last token in the delta
    tokens = event.content
    last = tokens.last
    next unless last
    alts = last.top_logprobs.map { |t| "#{t.token}=#{format('%.2f', t.logprob)}" }.join(", ")
    puts("\nlogprobs: [#{alts}]")
  when OpenAI::Streaming::ChatLogprobsContentDoneEvent
    puts("\n--- logprobs collection finished (#{event.content.length} tokens) ---")
  end
end
