#!/usr/bin/env ruby
# frozen_string_literal: true
# typed: strong

require_relative "../lib/openai"

# Set environment variables
# - `OPENAI_API_KEY` to your Azure OpenAI API key
# - `OPENAI_BASE_URL` to `https://{resource}.openai.azure.com/openai/v1/`
client = OpenAI::Client.new

# Chat Completion
chat_completion = client.chat.completions.create(
  messages: [
    {
      role: "user",
      content: "Tell me a joke."
    }
  ],
  model: :"gpt-4o",
  request_options: {
    extra_query: {"api-version": "preview"}
  }
)
pp(chat_completion)

# Image Generation
image_response = client.images.generate(
  model: "dall-e-3",
  size: "1024x1024",
  # quality: "medium",
  n: 1,
  prompt: "An astronaut lounging in a tropical resort in space, pixel art",
  request_options: {
    extra_query: {"api-version": "preview"}
  }
)
pp(image_response)
