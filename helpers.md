# Streaming Helpers

## Responses API

```ruby
stream = client.responses.stream(
  input: "Tell me a story about programming",
  model: "gpt-4o"
)

stream.each do |event|
  case event
  when OpenAI::Streaming::ResponseTextDeltaEvent
    print(event.delta)
  end
end

puts
```

`client.responses.stream` returns a `ResponseStream` that is an `Enumerable` emitting events.

The stream will be cancelled when the block exits but you can also close it prematurely by calling `stream.close`.

See an example of streaming helpers in action in [`examples/responses/streaming.rb`](examples/responses/streaming.rb).

### Events

The events listed here are just the event types that the SDK extends, for a full list of the events returned by the API, see [these docs](https://platform.openai.com/docs/api-reference/responses/streaming).

```ruby
require "openai"

client = OpenAI::Client.new

stream = client.responses.stream(
  input: "Write a haiku",
  model: "gpt-4o"
)

stream.each do |event|
  case event
  when OpenAI::Streaming::ResponseTextDeltaEvent
    print(event.delta)
  when OpenAI::Streaming::ResponseTextDoneEvent
    puts("\n\nText completed: #{event.text}")
  when OpenAI::Streaming::ResponseCompletedEvent
    puts("\nResponse ID: #{event.response.id}")
  end
end

# you can still get the accumulated final response outside of
# the block, as long as the entire stream was consumed
# inside of the block
final_response = stream.get_final_response
puts("Final response: #{final_response.to_json}")
```

#### `ResponseTextDeltaEvent`

This event is yielded whenever a text content delta is returned by the API & includes the delta and the accumulated snapshot, e.g.

```ruby
when OpenAI::Streaming::ResponseTextDeltaEvent
  event.type  # :"response.output_text.delta"
  event.delta  # " world"
  event.snapshot  # "Hello world"
```

#### `ResponseTextDoneEvent`

This event is fired when text generation is complete & includes the full text and parsed content if using structured outputs.

```ruby
when OpenAI::Streaming::ResponseTextDoneEvent
  event.type  # :"response.output_text.done"
  event.text  # "Hello world"
  event.parsed  # Your parsed model instance (when using text)
```

#### `ResponseFunctionCallArgumentsDeltaEvent`

This event is yielded whenever function call arguments are being streamed & includes the delta and accumulated snapshot, e.g.

```ruby
when OpenAI::Streaming::ResponseFunctionCallArgumentsDeltaEvent
  event.type  # :"response.function_call_arguments.delta"
  event.delta  # '": "San Francisco"}'
  event.snapshot  # '{"location": "San Francisco"}'
```

#### `ResponseCompletedEvent`

The event is fired when a full Response object has been accumulated.

```ruby
when OpenAI::Streaming::ResponseCompletedEvent
  event.type  # :"response.completed"
  event.response  # ParsedResponse object with all outputs
```

### Methods

Public Methods on the ResponseStream class:

#### `.text`

Returns an enumerable that yields the text deltas from the stream.

#### `.get_output_text`

Blocks until the stream has been read to completion and returns all `text` content deltas concatenated together.

#### `.get_final_response`

Blocks until the stream has been read to completion and returns the accumulated `ParsedResponse` object.

#### `.until_done`

Blocks until the stream has been read to completion.

#### `.close`

Aborts the request.

### Structured Outputs

The Responses API supports structured outputs via the `text` parameter:

```ruby
class Haiku < OpenAI::BaseModel
  field :first_line, String
  field :second_line, String
  field :third_line, String
end

stream = client.responses.stream(
  input: "Write a haiku about Ruby",
  model: "gpt-4o",
  text: Haiku
)

stream.each do |event|
  case event
  when OpenAI::Streaming::ResponseTextDoneEvent
    haiku = event.parsed
    puts("First line: #{haiku.first_line}")
    puts("Second line: #{haiku.second_line}")
    puts("Third line: #{haiku.third_line}")
  end
end
```

When `text` is provided:
- The model is instructed to output valid JSON matching your schema
- Text content is automatically parsed into instances of your type
- Parsed objects are available via `event.parsed` on text done events

## Chat Completions API

```ruby
stream = client.chat.completions.stream(
  model: "gpt-4",
  messages: [{role: "user", content: "Tell me a story about programming"}]
)

stream.each do |event|
  case event
  when OpenAI::Streaming::ChatContentDeltaEvent
    print(event.delta)
  end
end

puts
```

`client.chat.completions.stream` returns a `ChatCompletionStream` that is an `Enumerable` emitting events.

The stream will be cancelled when the block exits but you can also close it prematurely by calling `stream.close`.

See an example of streaming helpers in action in [`examples/chat/streaming.rb`](examples/chat/streaming.rb).

### Events

The events listed here are just the event types that the SDK extends, for a full list of the events returned by the API, see [these docs](https://platform.openai.com/docs/api-reference/chat/streaming).

```ruby
require "openai"

client = OpenAI::Client.new

stream = client.chat.completions.stream(
  model: "gpt-4",
  messages: [{role: "user", content: "Write a haiku"}]
)

stream.each do |event|
  case event
  when OpenAI::Streaming::ChatContentDeltaEvent
    print(event.delta)
  when OpenAI::Streaming::ChatContentDoneEvent
    puts("\n\nContent completed: #{event.content}")
  when OpenAI::Streaming::ChatFunctionToolCallArgumentsDoneEvent
    puts("\nTool call completed: #{event.name} with args: #{event.parsed}")
  end
end

# you can still get the accumulated final completion outside of
# the block, as long as the entire stream was consumed
# inside of the block
final_completion = stream.get_final_completion
puts("Final completion: #{final_completion.to_json}")
```

#### `ChatChunkEvent`

This event wraps each raw chunk from the API along with the accumulated state up to that point. All other events are derived from processing these chunks.

```ruby
when OpenAI::Streaming::ChatChunkEvent
  event.type  # :chunk
  event.chunk  # ChatCompletionChunk (raw API response)
  event.snapshot  # ParsedChatCompletion (accumulated state)
```

#### `ChatContentDeltaEvent`

This event is yielded whenever a text content delta is returned by the API & includes the delta and the accumulated snapshot, e.g.

```ruby
when OpenAI::Streaming::ChatContentDeltaEvent
  event.type  # :"content.delta"
  event.delta  # " world"
  event.snapshot  # "Hello world"
  event.parsed  # Your partially parsed model instance (when using structured outputs)
```

#### `ChatContentDoneEvent`

This event is fired when text generation is complete & includes the full text and parsed content if using structured outputs.

```ruby
when OpenAI::Streaming::ChatContentDoneEvent
  event.type  # :"content.done"
  event.content  # "Hello world"
  event.parsed  # Your parsed model instance (when using structured outputs)
```

#### `ChatRefusalDeltaEvent`

This event is yielded whenever the assistant is refusing to fulfill a request & includes the delta and accumulated refusal message.

```ruby
when OpenAI::Streaming::ChatRefusalDeltaEvent
  event.type  # :"refusal.delta"
  event.delta  # "I cannot"
  event.snapshot  # "I cannot help with that request"
```

#### `ChatRefusalDoneEvent`

This event is fired when the assistant has finished generating a refusal message.

```ruby
when OpenAI::Streaming::ChatRefusalDoneEvent
  event.type  # :"refusal.done"
  event.refusal  # "I cannot help with that request as it violates..."
```

#### `ChatFunctionToolCallArgumentsDeltaEvent`

This event is yielded whenever function call arguments are being streamed & includes the delta and accumulated snapshot, e.g.

```ruby
when OpenAI::Streaming::ChatFunctionToolCallArgumentsDeltaEvent
  event.type  # :"tool_calls.function.arguments.delta"
  event.name  # "get_weather"
  event.index  # 0 (tool call index in array)
  event.arguments_delta  # '{"location": "San'
  event.arguments  # '{"location": "San Francisco"'
  event.parsed  # {location: "San Francisco"} (if strict: true)
```

#### `ChatFunctionToolCallArgumentsDoneEvent`

The event is fired when a function tool call's arguments are complete.

```ruby
when OpenAI::Streaming::ChatFunctionToolCallArgumentsDoneEvent
  event.type  # :"tool_calls.function.arguments.done"
  event.name  # "get_weather"
  event.index  # 0
  event.arguments  # '{"location": "San Francisco", "unit": "celsius"}'
  event.parsed  # {location: "San Francisco", unit: "celsius"} (for strict tools)
```

#### `ChatLogprobsContentDeltaEvent`

This event is yielded when logprobs are requested and content tokens are being generated.

```ruby
when OpenAI::Streaming::ChatLogprobsContentDeltaEvent
  event.type  # :"logprobs.content.delta"
  event.content  # Array of ChatCompletionTokenLogprob objects for new tokens
  event.snapshot  # Array of all logprobs accumulated so far
```

#### `ChatLogprobsContentDoneEvent`

This event is fired when content generation is complete and logprobs were requested.

```ruby
when OpenAI::Streaming::ChatLogprobsContentDoneEvent
  event.type  # :"logprobs.content.done"
  event.content  # Complete array of ChatCompletionTokenLogprob objects
```

#### `ChatLogprobsRefusalDeltaEvent`

This event is yielded when logprobs are requested and refusal tokens are being generated.

```ruby
when OpenAI::Streaming::ChatLogprobsRefusalDeltaEvent
  event.type  # :"logprobs.refusal.delta"
  event.refusal  # Array of ChatCompletionTokenLogprob objects for refusal tokens
  event.snapshot  # Array of all refusal logprobs accumulated so far
```

#### `ChatLogprobsRefusalDoneEvent`

This event is fired when refusal generation is complete and logprobs were requested.

```ruby
when OpenAI::Streaming::ChatLogprobsRefusalDoneEvent
  event.type  # :"logprobs.refusal.done"
  event.refusal  # Complete array of ChatCompletionTokenLogprob objects for refusal
```

### Methods

Public Methods on the ChatCompletionStream class:

#### `.text`

Returns an enumerable that yields the text deltas from the stream.

#### `.get_output_text`

Blocks until the stream has been read to completion and returns all `content` deltas concatenated together.

#### `.get_final_completion`

Blocks until the stream has been read to completion and returns the accumulated `ParsedChatCompletion` object.

#### `.current_completion_snapshot`

Returns the current accumulated `ParsedChatCompletion` at any point during streaming.

#### `.until_done`

Blocks until the stream has been read to completion.

#### `.close`

Aborts the request.

### Structured Outputs

The Chat Completions API supports structured outputs via the `response_format` parameter:

```ruby
class Haiku < OpenAI::BaseModel
  field :first_line, String
  field :second_line, String
  field :third_line, String
end

stream = client.chat.completions.stream(
  model: "gpt-4",
  messages: [{role: "user", content: "Write a haiku about Ruby"}],
  response_format: Haiku
)

stream.each do |event|
  case event
  when OpenAI::Streaming::ChatContentDoneEvent
    haiku = event.parsed
    puts("First line: #{haiku.first_line}")
    puts("Second line: #{haiku.second_line}")
    puts("Third line: #{haiku.third_line}")
  end
end
```

When `response_format` is provided:
- The model is instructed to output valid JSON matching your schema
- Content is automatically parsed into instances of your type
- Parsed objects are available via `event.parsed` on content done events
