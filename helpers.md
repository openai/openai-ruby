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
