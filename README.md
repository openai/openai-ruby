# OpenAI Ruby API library

The OpenAI Ruby library provides convenient access to the OpenAI REST API from any Ruby 3.2.0+ application.

## Documentation

Documentation for releases of this gem can be found [on RubyDoc](https://gemdocs.org/gems/openai).

The REST API documentation can be found on [platform.openai.com](https://platform.openai.com/docs).

## Installation

ℹ️ The `openai` gem is not yet available on [rubygems.org](https://rubygems.org).

To use this gem, install via Bundler by adding the following to your application's `Gemfile`:

<!-- x-release-please-start-version -->

```ruby
gem "openai", github: "openai/openai-ruby", branch: "main"
```

<!-- x-release-please-end -->

## Usage

```ruby
require "bundler/setup"
require "openai"

openai = OpenAI::Client.new(
  api_key: "My API Key" # defaults to ENV["OPENAI_API_KEY"]
)

chat_completion = openai.chat.completions.create(
  messages: [{role: "user", content: "Say this is a test"}],
  model: :"gpt-4.1"
)

puts(chat_completion)
```

## Sorbet

This library is written with [Sorbet type definitions](https://sorbet.org/docs/rbi). However, there is no runtime dependency on the `sorbet-runtime`.

When using sorbet, it is recommended to use model classes as below. This provides stronger type checking and tooling integration.

```ruby
openai.chat.completions.create(
  messages: [OpenAI::Models::Chat::ChatCompletionUserMessageParam.new(role: "user", content: "Say this is a test")],
  model: :"gpt-4.1"
)
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

### Streaming

We provide support for streaming responses using Server-Sent Events (SSE).

**coming soon:** `openai.chat.completions.stream` will soon come with Python SDK style higher level streaming responses support.

```ruby
stream = openai.chat.completions.stream_raw(
  messages: [{role: "user", content: "Say this is a test"}],
  model: :"gpt-4.1"
)

stream.each do |completion|
  print(completion.choices.first.delta.content)
end
```

### File uploads

Request parameters that correspond to file uploads can be passed as `StringIO`, or a [`Pathname`](https://rubyapi.org/3.2/o/pathname) instance.

```ruby
require "pathname"

# using `Pathname`, the file will be lazily read, without reading everything in to memory
file_object = openai.files.create(file: Pathname("input.jsonl"), purpose: "fine-tune")

file = File.read("input.jsonl")
# using `StringIO`, useful if you already have the data in memory
file_object = openai.files.create(file: StringIO.new(file), purpose: "fine-tune")

puts(file_object.id)
```

### Errors

When the library is unable to connect to the API, or if the API returns a non-success status code (i.e., 4xx or 5xx response), a subclass of `OpenAI::Errors::APIError` will be thrown:

```ruby
begin
  job = openai.fine_tuning.jobs.create(model: :"babbage-002", training_file: "file-abc123")
rescue OpenAI::Errors::APIError => e
  puts(e.status) # 400
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
  model: :"gpt-4.1",
  request_options: {max_retries: 5}
)
```

### Timeouts

By default, requests will time out after 600 seconds.

Timeouts are applied separately to the initial connection and the overall request time, so in some cases a request could wait 2\*timeout seconds before it fails.

You can use the `timeout` option to configure or disable this:

```ruby
# Configure the default for all requests:
openai = OpenAI::Client.new(
  timeout: nil # default is 600
)

# Or, configure per-request:
openai.chat.completions.create(
  messages: [{role: "user", content: "How can I list all files in a directory using Python?"}],
  model: :"gpt-4.1",
  request_options: {timeout: 5}
)
```

## Model DSL

This library uses a simple DSL to represent request parameters and response shapes in `lib/openai/models`.

With the right [editor plugins](https://shopify.github.io/ruby-lsp), you can ctrl-click on elements of the DSL to navigate around and explore the library.

In all places where a `BaseModel` type is specified, vanilla Ruby `Hash` can also be used. For example, the following are interchangeable as arguments:

```ruby
# This has tooling readability, for auto-completion, static analysis, and goto definition with supported language services
params = OpenAI::Models::Chat::CompletionCreateParams.new(
  messages: [OpenAI::Models::Chat::ChatCompletionUserMessageParam.new(role: "user", content: "Say this is a test")],
  model: :"gpt-4.1"
)

# This also works
params = {
  messages: [{role: "user", content: "Say this is a test"}],
  model: :"gpt-4.1"
}
```

## Editor support

A combination of [Shopify LSP](https://shopify.github.io/ruby-lsp) and [Solargraph](https://solargraph.org/) is recommended for non-[Sorbet](https://sorbet.org) users. The former is especially good at go to definition, while the latter has much better auto-completion support.

## Advanced concepts

### Making custom/undocumented requests

#### Undocumented request params

If you want to explicitly send an extra param, you can do so with the `extra_query`, `extra_body`, and `extra_headers` under the `request_options:` parameter when making a requests as seen in examples above.

#### Undocumented endpoints

To make requests to undocumented endpoints, you can make requests using `client.request`. Options on the client will be respected (such as retries) when making this request.

```ruby
response = client.request(
  method: :post,
  path: '/undocumented/endpoint',
  query: {"dog": "woof"},
  headers: {"useful-header": "interesting-value"},
  body: {"he": "llo"},
)
```

### Concurrency & connection pooling

The `OpenAI::Client` instances are thread-safe, and should be re-used across multiple threads. By default, each `Client` have their own HTTP connection pool, with a maximum number of connections equal to thread count.

When the maximum number of connections has been checked out from the connection pool, the `Client` will wait for an in use connection to become available. The queue time for this mechanism is accounted for by the per-request timeout.

Unless otherwise specified, other classes in the SDK do not have locks protecting their underlying data structure.

Currently, `OpenAI::Client` instances are only fork-safe if there are no in-flight HTTP requests.

### Sorbet

#### Enums

Sorbet's typed enums require sub-classing of the [`T::Enum` class](https://sorbet.org/docs/tenum) from the `sorbet-runtime` gem.

Since this library does not depend on `sorbet-runtime`, it uses a [`T.all` intersection type](https://sorbet.org/docs/intersection-types) with a ruby primitive type to construct a "tagged alias" instead.

```ruby
module OpenAI::Models::ChatModel
  # This alias aids language service driven navigation.
  TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::ChatModel) }
end
```

#### Argument passing trick

It is possible to pass a compatible model / parameter class to a method that expects keyword arguments by using the `**` splat operator.

```ruby
params = OpenAI::Models::Chat::CompletionCreateParams.new(
  messages: [OpenAI::Models::Chat::ChatCompletionUserMessageParam.new(role: "user", content: "Say this is a test")],
  model: :"gpt-4.1"
)
openai.chat.completions.create(**params)
```

## Versioning

This package follows [SemVer](https://semver.org/spec/v2.0.0.html) conventions. As the library is in initial development and has a major version of `0`, APIs may change at any time.

This package considers improvements to the (non-runtime) `*.rbi` and `*.rbs` type definitions to be non-breaking changes.

## Requirements

Ruby 3.2.0 or higher.

## Contributing

See [the contributing documentation](https://github.com/openai/openai-ruby/tree/main/CONTRIBUTING.md).
