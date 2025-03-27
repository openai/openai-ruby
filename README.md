# OpenAI Ruby API library

The OpenAI Ruby library provides convenient access to the OpenAI REST API from any Ruby 3.0.0+ application.

## Documentation

Documentation for released of this gem can be found [on RubyDoc](https://gemdocs.org/gems/openai).

The underlying REST API documentation can be found on [platform.openai.com](https://platform.openai.com/docs).

## Installation

To use this gem during the beta, install directly from GitHub with Bundler by adding the following to your application's `Gemfile`:

```ruby
gem "openai", git: "https://github.com/openai/openai-ruby", branch: "main"
```

To fetch an initial copy of the gem:

```sh
bundle install
```

To update the version used by your application when updates are pushed to GitHub:

```sh
bundle update openai
```

## Usage

```ruby
require "bundler/setup"
require "openai"

openai = OpenAI::Client.new(
  api_key: "My API Key" # defaults to ENV["OPENAI_API_KEY"]
)

chat_completion = openai.chat.completions.create(
  messages: [{
    role: "user",
    content: "Say this is a test"
  }],
  model: "gpt-4o"
)

puts(chat_completion)
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

We provide support for streaming responses using Server Side Events (SSE).

```ruby
stream = openai.chat.completions.create_streaming(
  messages: [{
    role: "user",
    content: "Say this is a test"
  }],
  model: "gpt-4o"
)

stream.for_each do |completion|
  puts(completion)
end
```

### Errors

When the library is unable to connect to the API, or if the API returns a non-success status code (i.e., 4xx or 5xx response), a subclass of `OpenAI::Error` will be thrown:

```ruby
begin
  job = openai.fine_tuning.jobs.create(model: "gpt-4o", training_file: "file-abc123")
rescue OpenAI::Error => e
  puts(e.status) # 400
end
```

Error codes are as followed:

| Cause            | Error Type                 |
| ---------------- | -------------------------- |
| HTTP 400         | `BadRequestError`          |
| HTTP 401         | `AuthenticationError`      |
| HTTP 403         | `PermissionDeniedError`    |
| HTTP 404         | `NotFoundError`            |
| HTTP 409         | `ConflictError`            |
| HTTP 422         | `UnprocessableEntityError` |
| HTTP 429         | `RateLimitError`           |
| HTTP >=500       | `InternalServerError`      |
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
  messages: [{
    role: "user",
    content: "How can I get the name of the current day in JavaScript?"
  }],
  model: "gpt-4o",
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
  messages: [{
    role: "user",
    content: "How can I list all files in a directory using Python?"
  }],
  model: "gpt-4o",
  request_options: {timeout: 5}
)
```

## Sorbet Support

This library is written with [Sorbet type definitions](https://sorbet.org/docs/rbi). However, there is no runtime dependency on the `sorbet-runtime`.

What this means is that while you can use Sorbet to type check your code statically, and benefit from the [Sorbet Language Server](https://sorbet.org/docs/lsp) in your editor, there is no runtime type checking and execution overhead from Sorbet itself.

Due to limitations with the Sorbet type system, where a method otherwise can take an instance of `OpenAI::BaseModel` class, you will need to use the `**` splat operator to pass the arguments:

Please follow Sorbet's [setup guides](https://sorbet.org/docs/adopting) for best experience.

```ruby
model = CompletionCreateParams.new(
  messages: [{
    role: "user",
    content: "Say this is a test"
  }],
  model: "gpt-4o"
)

openai.chat.completions.create(**model)
```

## Versioning

This package follows [SemVer](https://semver.org/spec/v2.0.0.html) conventions. As the library is in initial development and has a major version of `0`, APIs may change at any time.

This package considers improvements to the (non-runtime) `*.rbi` and `*.rbs` type definitions to be non-breaking changes.

## Requirements

Ruby 3.0.0 or higher.
