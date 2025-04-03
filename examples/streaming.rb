#!/usr/bin/env -S -- ruby
# frozen_string_literal: true
# typed: strong

require_relative "../lib/openai"

# gets API Key from environment variable `OPENAI_API_KEY`
client = OpenAI::Client.new

begin
  pp("----- streaming 101 -----")

  stream = client.completions.create_streaming(
    model: :"gpt-3.5-turbo-instruct",
    prompt: "1,2,3,",
    max_tokens: 5,
    temperature: 0.0
  )

  # calling `#each` will always clean up the stream, even if an error is thrown inside the `#each` block.
  stream.each do |data|
    pp(data)

    # it is possible to exit out of the `#each` loop early, this will also clean up the stream for you.
    if data.choices.size > 2
      pp("too many choices")
      break
    end
  end

  # once the stream has been exhausted, no more chunks will be produced.
  stream.each do
    pp("This will never run")
  end
end

begin
  pp("----- manual closing of stream -----")

  stream = client.completions.create_streaming(
    model: :"gpt-3.5-turbo-instruct",
    prompt: "1,2,3,",
    max_tokens: 5,
    temperature: 0.0
  )

  # `stream` need to be manually closed if it is not consumed
  stream.close
end
