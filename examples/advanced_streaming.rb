#!/usr/bin/env ruby
# frozen_string_literal: true
# typed: strong

require_relative "../lib/openai"

# gets API Key from environment variable `OPENAI_API_KEY`
client = OpenAI::Client.new

begin
  pp("----- streams are enumerable -----")

  stream = client.completions.create_streaming(
    model: :"gpt-3.5-turbo-instruct",
    prompt: "1,2,3,",
    max_tokens: 5,
    temperature: 0.0
  )

  # the `stream` itself is an `https://rubyapi.org/3.2/o/enumerable`
  #   which means that you can work with the stream almost as if it is an array
  all_choices =
    stream
    # calling any of the `enumerable` methods will block until the whole stream is consumed
    #   it will also clean up the stream.
    .select do |completion|
      completion.object == :text_completion
    end
    .flat_map do |completion|
      completion.choices
    end

  pp(all_choices)

  # once the stream has been consumed, it will become "empty"
  pp("this will print an empty array")
  pp(stream.to_a)
end

begin
  pp("----- streams can be lazy -----")

  stream = client.completions.create_streaming(
    model: :"gpt-3.5-turbo-instruct",
    prompt: "1,2,3,",
    max_tokens: 5,
    temperature: 0.0
  )

  stream_of_choices =
    stream
    # calling `#lazy` will return a deferred `https://rubyapi.org/3.2/o/enumerator/lazy`
    .lazy
    # each successive calls to methods that return another `enumerable` will not consume the stream
    #   but rather, return a transformed stream. (see link above)
    .select do |completion|
      completion.object == :text_completion
    end
    .flat_map do |completion|
      completion.choices
    end

  # prints the suspended intermediary stream
  pp(stream_of_choices)
  # beware that if the intermediary stream is not used, a call to `stream.close` is required
  #  to release the underlying connection

  # method calls that do not return another `enumerable` will consume the intermediary stream
  #   and perform cleanup
  stream_of_choices.each do |choice|
    pp(choice)
  end

  # at this point the stream has been consumed already, so it will return an empty array
  pp(stream_of_choices.to_a)
end
