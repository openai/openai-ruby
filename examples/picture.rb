#!/usr/bin/env ruby
# frozen_string_literal: true
# typed: strong

require_relative "../lib/openai"

# gets API Key from environment variable `OPENAI_API_KEY`
client = OpenAI::Client.new

prompt = "An astronaut lounging in a tropical resort in space, pixel art"

# Generate an image based on the prompt
response = client.images.generate(model: "gpt-image-2", prompt: prompt)
image_data_received = response.data.to_a.any? { |image| !image.b64_json.to_s.empty? }
abort("The image request completed without image data") unless image_data_received

# Prints the generated image response.
pp(response)
