#!/usr/bin/env ruby
# frozen_string_literal: true
# typed: strong

require_relative "../lib/openai"

# gets API Key from environment variable `OPENAI_API_KEY`
client = OpenAI::Client.new

begin
  pp("----- named arguments in sorbet -----")

  # the method signature in sorbet has named arguments
  #   the following example type checks.
  completion = client.chat.completions.create(
    messages: [
      # Sorbet has excellent support for code that use `Class`es, and currently lacks
      #   sufficient support for code that uses `Hash`es
      OpenAI::Models::ChatCompletionUserMessageParam.new(content: "Say this is a test")
    ],
    model: "gpt-4"
  )

  content = completion.choices.first&.message&.content
  abort("The named-arguments request completed without content") if content.to_s.strip.empty?
  pp(content)
end

begin
  pp("----- trying to use params class in sorbet -----")

  _params = OpenAI::Models::Chat::CompletionCreateParams.new(
    # You can still use raw `Hash`es where sorbet expects `Class`es,
    #   but there is currently no way for the typechecker to verify the `Hash` contents
    messages: [{role: :user, content: "Say this is a test again"}],
    model: "gpt-4"
  )

  # if you have sorbet LSP enabled, and uncomment the two lines below
  #   you will see a red squiggly line on `_params` due to a quirk of the sorbet type system.
  #
  # this file will still, in fact, run correctly as uncommented.

  # completion = client.chat.completions.create(_params)
  # pp(completion.choices.first&.message&.content)
end

begin
  pp("----- using params class correctly in sorbet -----")

  params = OpenAI::Models::Chat::CompletionCreateParams.new(
    messages: [
      OpenAI::Models::ChatCompletionUserMessageParam.new(content: "Say this is a test yet again")
    ],
    model: "gpt-4"
  )

  # notice the `**` operator, it allows you to pass a parameter's class
  #   into compatible methods that have named arguments
  completion = client.chat.completions.create(**params)

  content = completion.choices.first&.message&.content
  abort("The params-class request completed without content") if content.to_s.strip.empty?
  pp(content)
end
