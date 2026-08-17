#!/usr/bin/env ruby
# frozen_string_literal: true
# typed: strict

require_relative "../lib/openai"

# Use a key for a project eligible to call the EU endpoint. Selecting this URL
# does not grant residency access or bypass project/model restrictions.
client = OpenAI::Client.new
eu = client.with_options(base_url: "https://eu.api.openai.com/v1")

response = eu.responses.create(
  model: ENV.fetch("OPENAI_MODEL", "gpt-5.6-sol"),
  input: "Reply with a short greeting."
)

puts(response.output_text)
# `client` still uses its original endpoint and configuration.
