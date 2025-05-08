#!/usr/bin/env ruby
# frozen_string_literal: true
# typed: strong

require_relative "../lib/openai"

# gets API Key from environment variable `OPENAI_API_KEY`
client = OpenAI::Client.new

prompt = "An astronaut lounging in a tropical resort in space, pixel art"

# Generate an image based on the prompt
response = client.images.generate(prompt: prompt)

# Prints response containing a URL link to image
pp(response)
