# OpenAI Ruby API library

The OpenAI Ruby library provides convenient access to the OpenAI REST API from any Ruby 3.2.0+ application. It ships with comprehensive types & docstrings in Yard, RBS, and RBI – [see below](https://github.com/openai/openai-ruby#Sorbet) for usage with Sorbet. The standard library's `net/http` is used as the HTTP transport, with connection pooling via the `connection_pool` gem.

## Documentation

Documentation for releases of this gem can be found [on RubyDoc](https://gemdocs.org/gems/openai).

The REST API documentation can be found on [platform.openai.com](https://platform.openai.com/docs).

## Installation

To use this gem, install via Bundler by adding the following to your application's `Gemfile`:

<!-- x-release-please-start-version -->

```ruby
gem "openai", "~> 0.26.0"
```

<!-- x-release-please-end -->

## Usage

```ruby
require "bundler/setup"
require "openai"

openai = OpenAI::Client.new(
  api_key: ENV["OPENAI_API_KEY"] # This is the default and can be omitted
)

chat_completion = openai.chat.completions.create(messages: [{role: "user", content: "Say this is a test"}], model: :"gpt-5")

puts(chat_completion)
```

### Streaming

We provide support for streaming responses using Server-Sent Events (SSE).

```ruby
stream = openai.chat.completions.stream_raw(
  messages: [{role: "user", content: "Say this is a test"}],
  model: :"gpt-5"
)

stream.each do |completion|
  puts(completion)
end
```

### Pagination

List methods in the OpenAI API are paginated.

This library provides auto-paginating iterators with each list response, so you do not have to request successive pages manually:

```ruby
page = openai.fine_tuning.jobs.list(limit: 20)

# Fetch single item from page.
job = page.data[0]
puts(job.id)

# Automatically fetches more pages as needed.
page.auto_paging_each do |job|
  puts(job.id)
end
```

Alternatively, you can use the `#next_page?` and `#next_page` methods for more granular control working with pages.

```ruby
if page.next_page?
  new_page = page.next_page
  puts(new_page.data[0].id)
end
```

### File uploads

Request parameters that correspond to file uploads can be passed as raw contents, a [`Pathname`](https://rubyapi.org/3.2/o/pathname) instance, [`StringIO`](https://rubyapi.org/3.2/o/stringio), or more.

```ruby
require "pathname"

# Use `Pathname` to send the filename and/or avoid paging a large file into memory:
file_object = openai.files.create(file: Pathname("input.jsonl"), purpose: "fine-tune")

# Alternatively, pass file contents or a `StringIO` directly:
file_object = openai.files.create(file: File.read("input.jsonl"), purpose: "fine-tune")

# Or, to control the filename and/or content type:
file = OpenAI::FilePart.new(File.read("input.jsonl"), filename: "input.jsonl", content_type: "…")
file_object = openai.files.create(file: file, purpose: "fine-tune")

puts(file_object.id)
```

Note that you can also pass a raw `IO` descriptor, but this disables retries, as the library can't be sure if the descriptor is a file or pipe (which cannot be rewound).

### Handling errors

When the library is unable to connect to the API, or if the API returns a non-success status code (i.e., 4xx or 5xx response), a subclass of `OpenAI::Errors::APIError` will be thrown:

```ruby
begin
  job = openai.fine_tuning.jobs.create(model: :"babbage-002", training_file: "file-abc123")
rescue OpenAI::Errors::APIConnectionError => e
  puts("The server could not be reached")
  puts(e.cause)  # an underlying Exception, likely raised within `net/http`
rescue OpenAI::Errors::RateLimitError => e
  puts("A 429 status code was received; we should back off a bit.")
rescue OpenAI::Errors::APIStatusError => e
  puts("Another non-200-range status code was received")
  puts(e.status)
end
```

Error codes are as follows:

| Cause            | Error Type                 |
| ---------------- | -------------------------- |
| HTTP 400         | `BadRequestError`          |
| HTTP 401         | `AuthenticationError`      |
| HTTP 403         | `PermissionDeniedError`    |
| HTTP 404         | `NotFoundError`            |
| HTTP 409         | `ConflictError`            |
| HTTP 422         | `UnprocessableEntityError` |
| HTTP 429         | `RateLimitError`           |
| HTTP >= 500      | `InternalServerError`      |
| Other HTTP error | `APIStatusError`           |
| Timeout          | `APITimeoutError`          |
| Network error    | `APIConnectionError`       |

### Retries

Certain errors will be automatically retried 2 times by default, with a short exponential backoff.

Connection errors (for example, due to a network connectivity problem), 408 Request Timeout, 409 Conflict, 429 Rate Limit, >=500 Internal errors, and timeouts will all be retried by default.

You can use the `max_retries` option to configure or disable this:

```ruby
# Configure the default for all requests:
openai = OpenAI::Client.new(
  max_retries: 0 # default is 2
)

# Or, configure per-request:
openai.chat.completions.create(
  messages: [{role: "user", content: "How can I get the name of the current day in JavaScript?"}],
  model: :"gpt-5",
  request_options: {max_retries: 5}
)
```

### Timeouts

By default, requests will time out after 600 seconds. You can use the timeout option to configure or disable this:

```ruby
# Configure the default for all requests:
openai = OpenAI::Client.new(
  timeout: nil # default is 600
)

# Or, configure per-request:
openai.chat.completions.create(
  messages: [{role: "user", content: "How can I list all files in a directory using Python?"}],
  model: :"gpt-5",
  request_options: {timeout: 5}
)
```

On timeout, `OpenAI::Errors::APITimeoutError` is raised.

Note that requests that time out are retried by default.

## Advanced concepts

### BaseModel

All parameter and response objects inherit from `OpenAI::Internal::Type::BaseModel`, which provides several conveniences, including:

1. All fields, including unknown ones, are accessible with `obj[:prop]` syntax, and can be destructured with `obj => {prop: prop}` or pattern-matching syntax.

2. Structural equivalence for equality; if two API calls return the same values, comparing the responses with == will return true.

3. Both instances and the classes themselves can be pretty-printed.

4. Helpers such as `#to_h`, `#deep_to_h`, `#to_json`, and `#to_yaml`.

### Making custom or undocumented requests

#### Undocumented properties

You can send undocumented parameters to any endpoint, and read undocumented response properties, like so:

Note: the `extra_` parameters of the same name overrides the documented parameters.

```ruby
chat_completion =
  openai.chat.completions.create(
    messages: [{role: "user", content: "How can I get the name of the current day in JavaScript?"}],
    model: :"gpt-5",
    request_options: {
      extra_query: {my_query_parameter: value},
      extra_body: {my_body_parameter: value},
      extra_headers: {"my-header": value}
    }
  )

puts(chat_completion[:my_undocumented_property])
```

#### Undocumented request params

If you want to explicitly send an extra param, you can do so with the `extra_query`, `extra_body`, and `extra_headers` under the `request_options:` parameter when making a request, as seen in the examples above.

#### Undocumented endpoints

To make requests to undocumented endpoints while retaining the benefit of auth, retries, and so on, you can make requests using `client.request`, like so:

```ruby
response = client.request(
  method: :post,
  path: '/undocumented/endpoint',
  query: {"dog": "woof"},
  headers: {"useful-header": "interesting-value"},
  body: {"hello": "world"}
)
```

### Concurrency & connection pooling

The `OpenAI::Client` instances are threadsafe, but are only are fork-safe when there are no in-flight HTTP requests.

Each instance of `OpenAI::Client` has its own HTTP connection pool with a default size of 99. As such, we recommend instantiating the client once per application in most settings.

When all available connections from the pool are checked out, requests wait for a new connection to become available, with queue time counting towards the request timeout.

Unless otherwise specified, other classes in the SDK do not have locks protecting their underlying data structure.

## Sorbet

This library provides comprehensive [RBI](https://sorbet.org/docs/rbi) definitions, and has no dependency on sorbet-runtime.

You can provide typesafe request parameters like so:

```ruby
openai.chat.completions.create(
  messages: [OpenAI::Chat::ChatCompletionUserMessageParam.new(content: "Say this is a test")],
  model: :"gpt-5"
)
```

Or, equivalently:

```ruby
# Hashes work, but are not typesafe:
openai.chat.completions.create(messages: [{role: "user", content: "Say this is a test"}], model: :"gpt-5")

# You can also splat a full Params class:
params = OpenAI::Chat::CompletionCreateParams.new(
  messages: [OpenAI::Chat::ChatCompletionUserMessageParam.new(content: "Say this is a test")],
  model: :"gpt-5"
)
openai.chat.completions.create(**params)
```

### Enums

Since this library does not depend on `sorbet-runtime`, it cannot provide [`T::Enum`](https://sorbet.org/docs/tenum) instances. Instead, we provide "tagged symbols" instead, which is always a primitive at runtime:

```ruby
# :minimal
puts(OpenAI::ReasoningEffort::MINIMAL)

# Revealed type: `T.all(OpenAI::ReasoningEffort, Symbol)`
T.reveal_type(OpenAI::ReasoningEffort::MINIMAL)
```

Enum parameters have a "relaxed" type, so you can either pass in enum constants or their literal value:

```ruby
# Using the enum constants preserves the tagged type information:
openai.chat.completions.create(
  reasoning_effort: OpenAI::ReasoningEffort::MINIMAL,
  # …
)

# Literal values are also permissible:
openai.chat.completions.create(
  reasoning_effort: :minimal,
  # …
)
```

## Versioning

This package follows [SemVer](https://semver.org/spec/v2.0.0.html) conventions. As the library is in initial development and has a major version of `0`, APIs may change at any time.

This package considers improvements to the (non-runtime) `*.rbi` and `*.rbs` type definitions to be non-breaking changes.

## Requirements

Ruby 3.2.0 or higher.

## Contributing

See [the contributing documentation](https://github.com/openai/openai-ruby/tree/main/CONTRIBUTING.md).
