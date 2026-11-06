# Google Vertex AI

Configure the standard `OpenAI::Client` to use the Responses API through Vertex AI. For Google Application Default Credentials (ADC), add the optional `googleauth` gem to your application's Gemfile and run `bundle install`:

```ruby
gem "googleauth", "~> 1"
```

Configure ADC in your environment, then create a client:

```ruby
require "openai"

client = OpenAI::Client.new(
  provider: OpenAI::Providers.vertex(
    project: "your-project-id",
    location: "your-vertex-location"
  )
)

response = client.responses.create(model: "your-enabled-model", input: "Say hello!")
puts(response.output_text)
```

Use a model enabled for your project and location. Vertex AI determines which Responses features are available.

To manage credentials in your application, pass either `credentials:` with a Google credentials object or `token_provider:` with a callback that returns a current access token. The callback runs once per request attempt, including retries; cache and refresh tokens as needed. The `googleauth` gem is not required when using `token_provider:`.

To use a test server or trusted gateway, set `base_url:` to the full API root before `/responses`. The configured origin receives your bearer token. HTTP test roots are supported; use HTTPS in production.
