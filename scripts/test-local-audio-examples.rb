#!/usr/bin/env ruby
# frozen_string_literal: true

# Opt-in live API test. Devices are synthetic; no microphone is opened.
require "openai"
require "openai/helpers/local_audio"
require "shellwords"

require_relative "examples-e2e"

begin
  raise "OPENAI_API_KEY is required" if ENV.fetch("OPENAI_API_KEY", "").empty?
  root = Pathname(__dir__).parent
  Dir.mktmpdir("openai-local-audio-examples-") do |directory|
    wav = File.join(directory, "speech.wav")
    client = OpenAI::Client.new(max_retries: 0, timeout: 30)
    speech = client.audio.speech.create(
      model: "gpt-4o-mini-tts",
      voice: "marin",
      response_format: :wav,
      input: "This is a local audio test. Please say: local audio test passed."
    )
    File.binwrite(wav, speech.read)
    ENV["OPENAI_AUDIO_TEST_WAV"] = wav
    preload = root.join("test/support/local_audio_example_devices.rb").to_s
    ENV["RUBYOPT"] = [ENV["RUBYOPT"], "-r#{Shellwords.escape(preload)}"].compact.join(" ")
    executor = OpenAIExamplesE2E::Executor.new(root: root, timeout: 90)
    examples = {
      "examples/audio/record_and_play.rb" => "local audio test"
    }
    failures = examples.filter_map do |path, expected|
      example = OpenAIExamplesE2E::Example.new(
        path: path,
        status: "covered",
        expected_output: expected,
        minimum_output_bytes: nil,
        reason: nil
      )
      result = executor.call(example)
      puts("#{path}: #{result.success ? "PASS" : "FAIL"} (#{result.duration_seconds}s)")
      # Captured output is deliberately not logged: failures may contain API context.
      warn(result.error) unless result.success
      unless result.success
        classes = result.stderr.scan(/OpenAI::(?:Errors|LocalAudio)::[A-Za-z]+/).uniq
        warn("Error classes: #{classes.join(", ")}") unless classes.empty?
      end

      path unless result.success
    end

    raise "Local audio examples failed" unless failures.empty?
    puts("Live API example E2E passed with synthetic input and simulated output devices.")
  end

rescue StandardError => error
  warn("Local audio example E2E failed (#{error.class}). No captured API output was logged.")
  exit(1)
end
