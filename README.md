# OpenAI Ruby API library

The OpenAI Ruby library provides convenient access to the OpenAI REST API from any Ruby 3.3.0+ application. It ships with comprehensive types & docstrings in Yard, RBS, and RBI – [see below](https://github.com/openai/openai-ruby#Sorbet) for usage with Sorbet. The standard library's `net/http` is used as the HTTP transport, with connection pooling via the `connection_pool` gem.

## Documentation

Documentation for releases of this gem can be found [on RubyDoc](https://gemdocs.org/gems/openai).

The REST API documentation can be found on [platform.openai.com](https://platform.openai.com/docs).

## Installation

To use this gem, install via Bundler by adding the following to your application's `Gemfile`:

<!-- x-release-please-start-version -->

```ruby
gem "openai", "~> 0.84.0"
```

<!-- x-release-please-end -->

## Usage

```ruby
require "bundler/setup"
require "openai"

openai = OpenAI::Client.new(
  api_key: ENV["OPENAI_API_KEY"] # This is the default and can be omitted
)

chat_completion = openai.chat.completions.create(messages: [{role: "user", content: "Say this is a test"}], model: "gpt-5.2")

puts(chat_completion)
```

### Streaming

We provide support for streaming responses using Server-Sent Events (SSE).

```ruby
stream = openai.responses.stream(
  input: "Write a haiku about OpenAI.",
  model: "gpt-5.2"
)

stream.each do |event|
  puts(event.type)
end
```

### Realtime WebSockets

The SDK supports block-scoped, typed Realtime WebSocket sessions for
server-side text, committed-turn transcription, one-turn voice, WebRTC call
creation, and sideband control of existing WebRTC or SIP calls. Add the
optional `async-websocket` gem for WebSocket connections, then use
`client.realtime.connect`:

```ruby
client.realtime.connect(model: "gpt-realtime-2.1") do |connection|
  connection.session.update(type: :realtime, output_modalities: [:text])
  connection.conversation.items.create(
    type: :message,
    role: :user,
    content: [{type: :input_text, text: "Hello"}]
  )
  connection.response.create

  connection.each do |event|
    print(event.delta) if event.is_a?(OpenAI::Realtime::ResponseTextDeltaEvent)
    break if event.is_a?(OpenAI::Realtime::ResponseDoneEvent)
  end
end
```

WebRTC calls can be created with `client.realtime.calls.create`; its HTTP
response preserves the SDP answer and the `Location` header needed to attach a
sideband connection. See the [Realtime WebSocket guide](realtime.md) and the runnable
[text, transcription, voice, and sideband examples](examples/realtime/README.md)
for lifecycle, authentication, proxy, TLS, and custom transport details.

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

Request parameters that correspond to file uploads can be passed as raw contents, a [`Pathname`](https://rubyapi.org/3.3/o/pathname) instance, [`StringIO`](https://rubyapi.org/3.3/o/stringio), or more.

Raw `String` and `StringIO` values, and `IO` objects without a path, do not carry format-identifying metadata. The SDK sends them using the fallback filename `upload`; raw `String` values default to `text/plain`, while `StringIO` and pathless `IO` values default to `application/octet-stream`. For format-sensitive endpoints, such as audio transcriptions, wrap each value in `OpenAI::FilePart` and provide an extension-bearing filename and content type.

```ruby
require "pathname"

# Use `Pathname` to send the filename and/or avoid paging a large file into memory:
file_object = openai.files.create(file: Pathname("input.jsonl"), purpose: "fine-tune")

# Alternatively, pass file contents or a `StringIO` directly:
file_object = openai.files.create(file: File.read("input.jsonl"), purpose: "fine-tune")

puts(file_object.id)

# For format-sensitive uploads, provide the filename and content type:
audio_data = StringIO.new(File.binread("audio.wav"))
audio = OpenAI::FilePart.new(
  audio_data,
  filename: "audio.wav",
  content_type: "audio/wav"
)
transcription = openai.audio.transcriptions.create(
  model: "gpt-4o-transcribe",
  file: audio
)
puts(transcription.text)

# FilePart also accepts a Pathname:
image = OpenAI::FilePart.new(Pathname("dog.jpg"), content_type: "image/jpeg")
edited = openai.images.edit(
  prompt: "make this image look like a painting",
  model: "gpt-image-2",
  size: "1024x1024",
  image: image
)

puts(edited.data.first)
```

Note that you can also pass a raw `IO` descriptor, but this disables retries, as the library can't be sure if the descriptor is a file or pipe (which cannot be rewound).

#### Polling and vector store ingestion

Polling helpers wait for file processing and return the final resource. Durations are
expressed in seconds. By default, the helpers honor the API's recommended polling
interval, fall back to 5 seconds, and stop after 30 minutes. Pass `timeout: nil` to
wait indefinitely.

To keep a finite overall deadline strict, each polling retrieval includes
authentication and request replay time and does not perform transport-level retries.
Pass `timeout: nil` to retain the client's configured retry behavior.

```ruby
file = openai.files.wait_for_processing(
  file_object.id,
  poll_interval: 2,
  timeout: 10 * 60
)

vector_file = openai.vector_stores.files.upload_and_poll(
  vector_store.id,
  file: Pathname("handbook.pdf"),
  attributes: {department: "engineering"}
)

batch = openai.vector_stores.file_batches.upload_and_poll(
  vector_store.id,
  files: [Pathname("one.pdf"), Pathname("two.pdf")],
  file_ids: [file_object.id],
  max_concurrency: 3
)
```

The vector store helpers return terminal `failed` and `cancelled` resources instead
of raising, so inspect `status`, `last_error`, or `file_counts` as appropriate. An
overall polling timeout raises `OpenAI::Errors::PollingTimeoutError`; its `resource`
attribute contains the last object returned by the API, or `nil` if the deadline
elapsed before the first response.

Batch inputs are enumerated before requests begin so the 2,000-file API limit can be
checked without orphaning uploads. IO streams yielded by an enumerable must remain
open until the helper returns; use paths for block-scoped lazy enumeration. Batch
uploads are concurrent but not transactional. If one upload fails, the helper stops
starting queued uploads and raises that error; files uploaded successfully before the
failure remain available through the Files API.

### Custom HTTP clients

`OpenAI::Client` accepts an `http_client` for advanced transport requirements.
Provide an object that implements `execute(request)` and returns an
`OpenAI::HTTPClient::Response`; subclassing `OpenAI::HTTPClient` is the easiest
way to make that contract explicit. The request exposes the SDK-prepared HTTP
method, URL, headers, encoded body, and timeout. Response bodies are enumerable
byte-string chunks (or a single buffered string), so large and streaming
responses do not need to be buffered.

The OpenAI client owns API authentication, redirects, and API-level retries.
The custom HTTP client owns connection pooling and lifecycle, must enforce
`request.timeout`, and should raise `OpenAI::Errors::APIConnectionError` or
`OpenAI::Errors::APITimeoutError` for retryable transport failures. Other
exceptions propagate without an SDK retry. The SDK does not close an injected
HTTP client.

The default `OpenAI::NetHTTPClient` implements this contract with pooled
`Net::HTTP` connections. It accepts an optional block for native connection
configuration, as shown below. Call `close` to retire its current pools; the
HTTP client remains reusable and creates fresh connections on its next request.

### Mutual TLS with a custom HTTP client

To opt in and activate mTLS for an organization or project, follow the
[OpenAI Mutual TLS Beta Program
guide](https://help.openai.com/en/articles/10876024-openai-mutual-tls-beta-program).
If you use an intermediate chain, confirm that certificate-chain support is
enabled for your organization.

For API-key requests that also require mutual TLS (mTLS), set the mTLS endpoint
explicitly and pass a configured `OpenAI::NetHTTPClient` as `http_client`.
`OpenAI::Client` accepts an HTTP client object so advanced transport behavior
does not require a separate SDK option for every use case. The default
`OpenAI::NetHTTPClient` accepts a block that configures each native
`Net::HTTP` connection before it is pooled and started.

Ruby's native TLS properties configure the client identity. The certificate
file must contain the leaf certificate first, followed by any intermediate
certificates needed when certificate-chain support is enabled for your
organization:

```ruby
require "openai"

mtls_endpoint = URI("https://mtls.api.openai.com/v1")
certificates = OpenSSL::X509::Certificate.load(
  File.binread(ENV.fetch("OPENAI_CLIENT_CERTIFICATE_CHAIN"))
)
raise "Expected a client certificate" if certificates.empty?

leaf_certificate, *intermediates = certificates
private_key = OpenSSL::PKey.read(
  File.binread(ENV.fetch("OPENAI_CLIENT_KEY")),
  ENV["OPENAI_CLIENT_KEY_PASSPHRASE"]
)
raise "Certificate and key do not match" unless leaf_certificate.check_private_key(private_key)

now = Time.now
raise "Certificate is not yet valid" if now < leaf_certificate.not_before
raise "Certificate has expired" if now > leaf_certificate.not_after

mtls_destination = [mtls_endpoint.host, mtls_endpoint.port]
http_client = OpenAI::NetHTTPClient.new do |http|
  unless http.use_ssl? && mtls_destination == [http.address, http.port]
    raise "Refusing to present the client certificate to an unexpected origin"
  end

  http.cert = leaf_certificate
  http.extra_chain_cert = intermediates
  http.key = private_key
end

client = OpenAI::Client.new(
  api_key: ENV.fetch("OPENAI_API_KEY"),
  base_url: mtls_endpoint.to_s,
  http_client: http_client
)
```

The SDK cannot infer whether custom HTTP configuration uses mTLS, so it does not
automatically change `base_url`. An explicit `base_url`, including an EU or
custom endpoint, is always preserved. Scope client certificates to the expected
origin, as above, so they cannot be presented elsewhere. Use the
`OpenAI::NetHTTPClient` block for TLS and other connection-level configuration.
Server trust remains separate from the client identity and can be customized
with `Net::HTTP` properties such as `cert_store` or `ca_file`.

Each `OpenAI::NetHTTPClient` owns its connection pool, so separate HTTP client
instances do not share connections or credentials.

After a process forks, create new OpenAI and HTTP clients in the child. Keep the
certificate configuration captured by an HTTP client immutable. For certificate
rotation, build and atomically swap in new `OpenAI::NetHTTPClient` and
`OpenAI::Client` instances, then call `close` on the retired HTTP client after
in-flight work finishes. See the complete [custom HTTP client mTLS
example](examples/mtls_custom_http_client.rb).

## Microsoft Azure OpenAI

Use the standard client with the Azure provider to call model deployments through
the Azure OpenAI v1 API. The provider accepts an Azure resource endpoint and
adds `/openai/v1` when needed:

```ruby
require "openai"

client = OpenAI::Client.new(
  provider: OpenAI::Providers.azure(
    endpoint: ENV.fetch("AZURE_OPENAI_ENDPOINT"),
    api_key: ENV.fetch("AZURE_OPENAI_API_KEY")
  )
)

response = client.responses.create(
  model: ENV.fetch("AZURE_OPENAI_DEPLOYMENT"),
  input: "Say hello!"
)

puts(response.output_text)
```

Omit `endpoint` and `api_key` to use `AZURE_OPENAI_ENDPOINT` and
`AZURE_OPENAI_API_KEY`. For Microsoft Entra authentication, pass a callable
that returns a current bearer token. The provider invokes it before every
request attempt, including retries:

```ruby
client = OpenAI::Client.new(
  provider: OpenAI::Providers.azure(
    endpoint: ENV.fetch("AZURE_OPENAI_ENDPOINT"),
    token_provider: -> { fetch_azure_openai_token }
  )
)
```

This integration targets the Azure OpenAI v1 API. It does not add dated
`api-version` query parameters or rewrite requests to legacy
`/deployments/{deployment}` paths. See [azure.md](azure.md) for configuration,
authentication precedence, and endpoint security details.

## Amazon Bedrock

Use the standard client with the Bedrock provider to call OpenAI models through Amazon Bedrock's OpenAI-compatible API. Add `aws-sdk-core` to your application for AWS credential discovery and SigV4 signing:

```ruby
gem "openai"
gem "aws-sdk-core", "~> 3"
```

With your normal AWS credentials configured, only the region is required:

```ruby
require "openai"

client = OpenAI::Client.new(
  provider: OpenAI::Providers.bedrock(region: "us-west-2")
)

response = client.responses.create(
  model: ENV.fetch("BEDROCK_MODEL"),
  input: "Say hello!"
)

puts(response.output_text)
```

The provider uses the standard AWS credential chain, including environment credentials, `~/.aws/credentials`, `~/.aws/config`, `AWS_PROFILE`, named profiles, SSO and assume-role profiles, and workload credentials. Select a profile explicitly with:

```ruby
client = OpenAI::Client.new(
  provider: OpenAI::Providers.bedrock(
    region: "us-west-2",
    profile: "engineering"
  )
)
```

`AWS_BEARER_TOKEN_BEDROCK` and explicit Bedrock bearer credentials are also supported. Bearer authentication does not load or require `aws-sdk-core`:

```ruby
client = OpenAI::Client.new(
  provider: OpenAI::Providers.bedrock(
    region: "us-west-2",
    api_key: ENV.fetch("AWS_BEARER_TOKEN_BEDROCK")
  )
)
```

See [bedrock.md](bedrock.md) for authentication precedence, static and refreshable credentials, endpoint configuration, and SigV4 request constraints.

## Workload Identity Authentication

For secure, automated environments like cloud-managed Kubernetes, Azure, and GCP, you can use workload identity authentication with short-lived tokens from cloud identity providers instead of long-lived API keys.

`client_id` remains available as an optional parameter for token exchange setups that require an explicit OAuth client ID.

### X.509 Workload Identity (Preview)

Organizations enrolled in the X.509 workload identity preview can exchange a
client certificate for a short-lived OpenAI bearer credential. Both the token
exchange and subsequent API request use the same caller-attested mTLS transport.
The bearer is not cryptographically bound to the certificate; the API separately
requires an accepted client certificate.

```ruby
require "openai"

certificates = OpenSSL::X509::Certificate.load(
  File.binread(ENV.fetch("OPENAI_CLIENT_CERTIFICATE_CHAIN"))
)
raise "Expected an enrolled client certificate" if certificates.empty?

client_certificate, *intermediate_certificates = certificates
client_private_key = OpenSSL::PKey.read(
  File.binread(ENV.fetch("OPENAI_CLIENT_KEY")),
  ENV["OPENAI_CLIENT_KEY_PASSPHRASE"]
)
unless client_certificate.check_private_key(client_private_key)
  raise "The enrolled certificate and private key do not match"
end

api_origin = ENV.fetch("OPENAI_X509_API_ORIGIN", "https://mtls.api.openai.com")
api_host = URI(api_origin).host&.downcase
approved_hosts = ["mtls.auth.openai.com", api_host].freeze
native_http_client = OpenAI::NetHTTPClient.new do |connection|
  unless connection.use_ssl? && connection.port == 443 && approved_hosts.include?(connection.address.downcase)
    raise "Refusing to present the enrolled certificate to an unexpected destination"
  end

  connection.cert = client_certificate
  connection.extra_chain_cert = intermediate_certificates
  connection.key = client_private_key
end

identity = OpenAI::Auth::X509WorkloadIdentity.new(
  identity_provider_id: ENV.fetch("IDENTITY_PROVIDER_ID"),
  service_account_id: ENV.fetch("SERVICE_ACCOUNT_ID"),
  http_client: native_http_client,
  api_origin: api_origin
)

client = OpenAI::Client.new(
  api_key: nil,
  workload_identity: identity
)

model = client.models.list.data.first
```

The identity creates its guarded transport internally and selects the matching
mTLS API endpoint automatically. The application still owns its certificate,
key, trust settings, and native HTTP client. Keep the selected certificate
identity static, configure only the approved issuer and API destinations, and
create a fresh native client and identity when rotating credentials. Clients
derived with `with_options` share the original identity's cached token when
their transport is unchanged.

The supported X.509 API regions are global, US, and EU. Set `api_origin:` to
`https://mtls.api.openai.com`, `https://mtls-us.api.openai.com`, or
`https://mtls-eu.api.openai.com`; an optional `data_residency:` on the client
must match. Direct mode rejects ambient proxies; pass `proxy: :http_connect` to
the identity only when an HTTP CONNECT proxy is configured. HTTPS proxies are
rejected before proxy credentials can be transmitted. Arbitrary custom
transports, Azure/Bedrock providers, and Realtime WebSockets are not supported.
The normal client or per-request timeout covers both token exchange and the API
request; `timeout: nil` disables both deadlines. Preview access must be enabled
for the organization, and mTLS can be configured for the enrolled organization
or project.

See the complete [X.509 workload identity live smoke
example](examples/x509_workload_identity.rb). It performs a real token exchange
and API request only when an enrolled certificate, private key, identity-provider
ID, and mapped service-account ID are explicitly supplied.

Keep these values in a private environment file outside your checkout or in a
secret manager, then run the example without an API key:

```sh
export OPENAI_CLIENT_CERTIFICATE_CHAIN=/secure/path/client-chain.pem
export OPENAI_CLIENT_KEY=/secure/path/client-key.pem
export IDENTITY_PROVIDER_ID=idp_example
export SERVICE_ACCOUNT_ID=svc_acct_example

ruby examples/x509_workload_identity.rb
```

Set `OPENAI_X509_PROXY_MODE=http_connect` only when an approved HTTP CONNECT
proxy is configured. Encrypted keys can use `OPENAI_CLIENT_KEY_PASSPHRASE`.

### Kubernetes Service Account

```ruby
require "openai"

# Configure Kubernetes service account provider
provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new

workload_identity = OpenAI::Auth::WorkloadIdentity.new(
  identity_provider_id: ENV["IDENTITY_PROVIDER_ID"], # This is the default and can be omitted
  service_account_id: ENV["SERVICE_ACCOUNT_ID"], # This is the default and can be omitted
  provider: provider
)

client = OpenAI::Client.new(
  workload_identity: workload_identity,
)

response = client.chat.completions.create(
  messages: [{role: "user", content: "Hello!"}],
  model: "gpt-5.2"
)
```

### Azure Managed Identity

```ruby
provider = OpenAI::Auth::SubjectTokenProviders::AzureManagedIdentityTokenProvider.new

workload_identity = OpenAI::Auth::WorkloadIdentity.new(
  identity_provider_id: ENV["IDENTITY_PROVIDER_ID"], # This is the default and can be omitted
  service_account_id: ENV["SERVICE_ACCOUNT_ID"], # This is the default and can be omitted
  provider: provider
)

client = OpenAI::Client.new(
  workload_identity: workload_identity,
)
```

### GCP Metadata Server

```ruby
provider = OpenAI::Auth::SubjectTokenProviders::GCPIDTokenProvider.new

workload_identity = OpenAI::Auth::WorkloadIdentity.new(
  identity_provider_id: ENV["IDENTITY_PROVIDER_ID"], # This is the default and can be omitted
  service_account_id: ENV["SERVICE_ACCOUNT_ID"], # This is the default and can be omitted
  provider: provider
)

client = OpenAI::Client.new(
  workload_identity: workload_identity,
)
```

### Custom Token Providers

You can implement custom token providers by including the `OpenAI::Auth::SubjectTokenProvider` module:

```ruby
class CustomProvider
  include OpenAI::Auth::SubjectTokenProvider

  def token_type
    OpenAI::Auth::TokenType::JWT
  end

  def get_token
    "custom-token"
  end
end

provider = CustomProvider.new

workload_identity = OpenAI::Auth::WorkloadIdentity.new(
  identity_provider_id: ENV["IDENTITY_PROVIDER_ID"], # This is the default and can be omitted
  service_account_id: ENV["SERVICE_ACCOUNT_ID"], # This is the default and can be omitted
  provider: provider
)

client = OpenAI::Client.new(
  workload_identity: workload_identity,
  organization: ENV["OPENAI_ORG_ID"],
  project: ENV["OPENAI_PROJECT_ID"]
)
```

## Webhook Verification

Verifying webhook signatures is _optional but encouraged_.

For more information about webhooks, see [the API docs](https://platform.openai.com/docs/guides/webhooks).

### Parsing webhook payloads

For most use cases, you will likely want to verify the webhook and parse the payload at the same time. To achieve this, we provide the method `client.webhooks.unwrap`, which parses a webhook request and verifies that it was sent by OpenAI. This method will raise an error if the signature is invalid.

Note that the `body` parameter must be the raw JSON string sent from the server (do not parse it first). The `unwrap` method will parse this JSON for you into an event object after verifying the webhook was sent from OpenAI.

```ruby
require 'sinatra'
require 'openai'

# Set up the client with API credentials and the webhook secret
client = OpenAI::Client.new(
  api_key: ENV.fetch('OPENAI_API_KEY'),
  webhook_secret: ENV.fetch('OPENAI_WEBHOOK_SECRET')
)

post '/webhook' do
  request_body = request.body.read
  
  begin
    event = client.webhooks.unwrap(request_body, request.env)
    
    case event.type
    when 'response.completed'
      puts "Response completed: #{event.data}"
    when 'response.failed'
      puts "Response failed: #{event.data}"
    else
      puts "Unhandled event type: #{event.type}"
    end
    
    status 200
    'ok'
  rescue StandardError => e
    puts "Invalid signature: #{e}"
    status 400
    'Invalid signature'
  end
end
```

### Verifying webhook payloads directly

In some cases, you may want to verify the webhook separately from parsing the payload. If you prefer to handle these steps separately, we provide the method `client.webhooks.verify_signature` to _only verify_ the signature of a webhook request. Like `unwrap`, this method will raise an error if the signature is invalid.

Note that the `body` parameter must be the raw JSON string sent from the server (do not parse it first). You will then need to parse the body after verifying the signature.

```ruby
require 'sinatra'
require 'json'
require 'openai'

# Set up the client with API credentials and the webhook secret
client = OpenAI::Client.new(
  api_key: ENV.fetch('OPENAI_API_KEY'),
  webhook_secret: ENV.fetch('OPENAI_WEBHOOK_SECRET')
)

post '/webhook' do
  request_body = request.body.read
  
  begin
    client.webhooks.verify_signature(request_body, request.env)
    
    # Parse the body after verification
    event = JSON.parse(request_body)
    puts "Verified event: #{event}"
    
    status 200
    'ok'
  rescue StandardError => e
    puts "Invalid signature: #{e}"
    status 400
    'Invalid signature'
  end
end
```

### [Structured outputs](https://platform.openai.com/docs/guides/structured-outputs) and function calling

This SDK ships with helpers in `OpenAI::BaseModel`, `OpenAI::ArrayOf`, `OpenAI::EnumOf`, and `OpenAI::UnionOf` to help you define the supported JSON schemas used in making structured outputs and function calling requests.

<details>
<summary>Snippet</summary>

```ruby
# Participant model with an optional last_name and an enum for status
class Participant < OpenAI::BaseModel
  required :first_name, String
  required :last_name, String, nil?: true
  required :status, OpenAI::EnumOf[:confirmed, :unconfirmed, :tentative]
end

# CalendarEvent model with a list of participants.
class CalendarEvent < OpenAI::BaseModel
  required :name, String
  required :date, String
  required :participants, OpenAI::ArrayOf[Participant]
end


client = OpenAI::Client.new

response = client.responses.create(
  model: "gpt-5.2",
  input: [
    {role: :system, content: "Extract the event information."},
    {
      role: :user,
      content: <<~CONTENT
        Alice Shah and Lena are going to a science fair on Friday at 123 Main St. in San Diego.
        They have also invited Jasper Vellani and Talia Groves - Jasper has not responded and Talia said she is thinking about it.
      CONTENT
    }
  ],
  text: CalendarEvent
)

response
  .output
  .flat_map { _1.content }
  # filter out refusal responses
  .grep_v(OpenAI::Models::Responses::ResponseOutputRefusal)
  .each do |content|
    # parsed is an instance of `CalendarEvent`
    pp(content.parsed)
  end
```

</details>

See the [examples](https://github.com/openai/openai-ruby/tree/main/examples) directory for more usage examples for helper usage.

To make the equivalent request using raw JSON schema format, you would do the following:

<details>
<summary>Snippet</summary>

```ruby
response = client.responses.create(
  model: "gpt-5.2",
  input: [
    {role: :system, content: "Extract the event information."},
    {
      role: :user,
      content: "..."
    }
  ],
  text: {
    format: {
      type: :json_schema,
      name: "CalendarEvent",
      strict: true,
      schema: {
        type: "object",
        properties: {
          name: {type: "string"},
          date: {type: "string"},
          participants: {
            type: "array",
            items: {
              type: "object",
              properties: {
                first_name: {type: "string"},
                last_name: {type: %w[string null]},
                status: {type: "string", enum: %w[confirmed unconfirmed tentative]}
              },
              required: %w[first_name last_name status],
              additionalProperties: false
            }
          }
        },
        required: %w[name date participants],
        additionalProperties: false
      }
    }
  }
)
```

</details>

#### Sorbet structured-output models

Applications that use Sorbet can provide their own `T::Struct` models instead of
subclassing `OpenAI::BaseModel`. Add `sorbet-runtime` to your application's
dependencies and explicitly load the optional integration:

```ruby
require "openai"
require "openai/helpers/sorbet"

class Participant < T::Struct
  const :name, String
  const :email, T.nilable(String)
end

class CalendarEvent < T::Struct
  const :title, String
  const :participants, T::Array[Participant]
end

schema = OpenAI::StructuredOutput.from_sorbet(CalendarEvent)
client = OpenAI::Client.new

response = client.responses.create(
  model: "gpt-5.2",
  input: "Extract the event information.",
  text: schema
)

message = response.output.grep(OpenAI::Responses::ResponseOutputMessage).fetch(0)
output_text = message.content.grep(OpenAI::Responses::ResponseOutputText).fetch(0)
event = T.cast(output_text.parsed, CalendarEvent)
event.participants.fetch(0).name

completion = client.chat.completions.create(
  model: "gpt-5.2",
  messages: [{role: :user, content: "Extract the event information."}],
  response_format: schema
)

T.cast(completion.choices.fetch(0).message.parsed, CalendarEvent)
```

The integration supports nested structs, arrays, nullable values, boolean and
numeric fields, application-defined `T::Enum` values, and Sorbet's `name:` field
aliases. All structured-output fields are required, including nullable fields.
Unsupported unions, hashes, recursive models, and enum values that do not
serialize to strings are rejected. `sorbet-runtime` remains optional and is not
loaded by ordinary SDK usage. This integration supports non-streaming
`responses.create` and `chat.completions.create` requests only; streaming
structured outputs and function-tool schemas are not supported.

### Handling errors

When the library is unable to connect to the API, or if the API returns a non-success status code (i.e., 4xx or 5xx response), a subclass of `OpenAI::Errors::APIError` will be thrown:

```ruby
begin
  job = openai.fine_tuning.jobs.create(model: "gpt-4o", training_file: "file-abc123")
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
| Polling timeout  | `PollingTimeoutError`      |
| Network error    | `APIConnectionError`       |

### Request logging

Request logging is disabled by default. Enable it with a standard Ruby logger
when creating the client:

```ruby
client = OpenAI::Client.new(
  api_key: ENV.fetch("OPENAI_API_KEY"),
  logger: Rails.logger,
  log_level: :info
)
```

The logger can be any object that responds to `debug`, `info`, `warn`, and
`error`; the SDK does not depend on Rails. Supplying a logger enables `:info`
logging by default. When logging is enabled without a custom logger, the SDK
uses a standard-library `Logger` that writes to stderr. Use `log_level: :off`
when you only need retry notifications.

You can instead set `OPENAI_LOG=info` or `OPENAI_LOG=debug`. An explicit
`log_level:` takes precedence over the environment variable.

For example, to use the stderr logger for one process:

```sh
OPENAI_LOG=info bundle exec ruby app.rb
```

A completion message includes the logical request and retry context:

```text
[openai] request complete log_id=log_a1b2c3d4e5f6 method=POST path=/v1/responses status=200 request_id=req_123 attempts=1 duration_ms=42.7
```

| Level | Behavior |
| --- | --- |
| `:off` | No SDK request logs (default) |
| `:error` | Terminal request failures after retries are exhausted |
| `:warn` | Error events plus retry reason and delay |
| `:info` | Safe request completion summaries |
| `:debug` | Per-attempt headers and bounded structural body diagnostics |

Info, warning, and error logs include operational fields such as the HTTP
method, sanitized path, status, request ID, duration, and attempt count. They
never include headers or bodies. Debug logs redact credential-bearing headers
and query parameters, including authorization, API-key, cookie, token,
credential, and signature values.

Debug body diagnostics never include customer-controlled object keys, string
values, prompts, model responses, tool arguments, form fields, or signed URLs.
JSON bodies report only their byte size, top-level type, and object-field or
array-item count; form bodies report only their byte size and field count. The
built-in logger omits uploaded file contents, multipart bodies, binary bodies,
server-sent event contents, unsupported text bodies, oversized bodies, and
incomplete bodies. Response bodies are observed only as the application consumes
them and are never read eagerly for logging.

SDK log messages are intended for human diagnostics. Their text format is not
a stable structured-event API and may change between releases. Exceptions from
a supplied logger are isolated and never replace an API result or API error.

### Response metadata and request IDs

OpenAI recommends logging request IDs in production so requests can be traced
during troubleshooting. Top-level models and pages returned by the client expose
immutable HTTP response metadata through `last_response`:

```ruby
response = openai.responses.create(model: "gpt-5.2", input: "Say 'this is a test'.")
puts(response.last_response.status)                 # 200
puts(response.last_response.headers["x-request-id"]) # req_123
puts(response.last_response.request_id)             # req_123
puts(response._request_id)                           # req_123
```

Header names and values are normalized to strings, header names are lowercase,
and the metadata and header map are frozen. Streams expose the metadata for the
HTTP response that opened the stream. Higher-level streaming helpers expose the
same metadata as their underlying stream; models assembled from stream events
do not.

`last_response` and `_request_id` are only populated on top-level typed models
and pages returned by the client. They are `nil` on constructed or nested models
and are not included in `to_h`, JSON, or YAML output. Endpoints returning raw
primitives, binary data, or `nil` do not expose this metadata. Unlike other
properties that begin with an underscore, `_request_id` is public.

For failed HTTP requests, catch `OpenAI::Errors::APIStatusError` and use
`request_id`:

```ruby
begin
  openai.responses.create(model: "gpt-5.2", input: "Say 'this is a test'.")
rescue OpenAI::Errors::APIStatusError => e
  puts(e.request_id) # req_123
  raise
end
```

See the [official OpenAI request debugging documentation](https://developers.openai.com/api/reference/overview#debugging-requests)
for more information.

### Retries

Certain errors will be automatically retried 2 times by default, with a short exponential backoff.

Connection errors (for example, due to a network connectivity problem), 408 Request Timeout, 409 Conflict, 429 Rate Limit, >=500 Internal errors, and timeouts will all be retried by default.

When the server supplies a valid `Retry-After` or `Retry-After-Ms` delay, the SDK
waits at least that long before retrying. If the delay exceeds `max_retry_delay`
(8 seconds by default), automatic retries stop and the original error is raised
with its body and headers available. Increase `max_retry_delay` when longer
server-directed waits are acceptable. Existing request deadlines still apply.

You can use the `max_retries` option to configure or disable this:

```ruby
# Configure the default for all requests:
openai = OpenAI::Client.new(
  max_retries: 0 # default is 2
)

# Or, configure per-request:
openai.chat.completions.create(
  messages: [{role: "user", content: "How can I get the name of the current day in JavaScript?"}],
  model: "gpt-5.2",
  request_options: {max_retries: 5}
)
```

To observe retries as they happen, supply an `on_retry` callback when creating
the client. The callback runs immediately before the retry delay and receives
an immutable `OpenAI::RetryEvent`:

```ruby
openai = OpenAI::Client.new(
  log_level: :off,
  on_retry: lambda do |event|
    Rails.logger.warn(
      "OpenAI retry #{event.attempt}/#{event.max_attempts} " \
      "status=#{event.status.inspect} request_id=#{event.request_id.inspect}"
    )
  end
)
```

For response-triggered retries, `event.response` contains the same immutable
status, headers, and request ID shape as `last_response`. For connection errors,
`event.error` is populated instead. Exceptions raised by the callback are
isolated and do not replace the API result or error.

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
  model: "gpt-5.2",
  request_options: {timeout: 5}
)
```

On timeout, `OpenAI::Errors::APITimeoutError` is raised.

Note that requests that time out are retried by default.

## Advanced concepts

### Default request headers

Use `default_headers` to send the same custom headers with every request made by a client:

```ruby
finance = OpenAI::Client.new(
  default_headers: {"x-cost-center" => "finance"}
)
```

Explicit `default_headers` override values from `OPENAI_CUSTOM_HEADERS`. For a single request,
`request_options[:extra_headers]` can override a client default or remove it by assigning `nil`.
Authentication and endpoint-specific headers also take precedence over client defaults.

### BaseModel

All parameter and response objects inherit from `OpenAI::Internal::Type::BaseModel`, which provides several conveniences, including:

1. All fields, including unknown ones, are accessible with `obj[:prop]` syntax, and can be destructured with `obj => {prop: prop}` or pattern-matching syntax.

2. Structural equivalence for equality; if two API calls return the same values, comparing the responses with == will return true.

3. Both instances and the classes themselves can be pretty-printed.

4. Helpers such as `#to_h`, `#deep_to_h`, `#to_json`, and `#to_yaml`.

### Making custom or undocumented requests

#### Undocumented properties

You can send undocumented parameters to any endpoint, and read undocumented response properties, like so:

Note: the `extra_` parameters of the same name override the documented parameters.

```ruby
chat_completion =
  openai.chat.completions.create(
    messages: [{role: "user", content: "How can I get the name of the current day in JavaScript?"}],
    model: "gpt-5.2",
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

Generic requests use the ordinary API key when one is configured, even if an
admin API key is also available. A client configured with only an admin API key
uses that key. To explicitly use an admin API key when both credentials are
configured, pass `security: {admin_api_key_auth: true}` to `client.request`.

### Concurrency & connection pooling

`OpenAI::Client` instances using the default `OpenAI::NetHTTPClient` are threadsafe, but are only fork-safe when there are no in-flight HTTP requests. Injected HTTP clients are responsible for documenting and enforcing their own concurrency guarantees.

#### Asynchronous requests with a fiber scheduler

The default HTTP client also cooperates with Ruby's fiber scheduler interface
(`Fiber.scheduler`). When a request runs inside a non-blocking fiber managed by
an active scheduler, network operations, streaming reads, retry delays, and
waits for a pooled connection yield to other fibers instead of blocking the
thread. Resource methods keep their normal return types; schedule each complete
request or stream operation as a task using the scheduler implementation your
application already uses.

For example, with the [`async`](https://github.com/socketry/async) gem:

```ruby
require "async"

prompts = ["Summarize the incident report.", "Draft the follow-up actions."]

responses = Async do |task|
  prompts.map do |prompt|
    task.async do
      openai.responses.create(model: "gpt-5.2", input: prompt)
    end
  end.map(&:wait)
end.wait
```

Outside a non-blocking fiber managed by an active scheduler, calls block the
current thread as usual. The SDK does not install a scheduler or depend on a
particular scheduler gem.

#### Connection pooling

By default, each `OpenAI::Client` creates its own HTTP connection pool with a size of at least 99 connections. As such, we recommend instantiating the client once per application in most settings. An injected HTTP client may instead share its pool across multiple SDK clients; the caller owns that HTTP client's lifecycle.

When all available connections from the pool are checked out, requests wait for a new connection to become available, with queue time counting towards the request timeout.

Unless otherwise specified, other classes in the SDK do not have locks protecting their underlying data structure.

## Sorbet

This library provides comprehensive [RBI](https://sorbet.org/docs/rbi) definitions and has no dependency on sorbet-runtime.

You can provide typesafe request parameters like so:

```ruby
openai.chat.completions.create(
  messages: [OpenAI::Chat::ChatCompletionUserMessageParam.new(content: "Say this is a test")],
  model: "gpt-5.2"
)
```

Or, equivalently:

```ruby
# Hashes work, but are not typesafe:
openai.chat.completions.create(messages: [{role: "user", content: "Say this is a test"}], model: "gpt-5.2")

# You can also splat a full Params class:
params = OpenAI::Chat::CompletionCreateParams.new(
  messages: [OpenAI::Chat::ChatCompletionUserMessageParam.new(content: "Say this is a test")],
  model: "gpt-5.2"
)
openai.chat.completions.create(**params)
```

### Enums

Since this library does not depend on `sorbet-runtime`, it cannot provide [`T::Enum`](https://sorbet.org/docs/tenum) instances. Instead, we provide "tagged symbols" instead, which is always a primitive at runtime:

```ruby
# :none
puts(OpenAI::ReasoningEffort::NONE)

# Revealed type: `T.all(OpenAI::ReasoningEffort, Symbol)`
T.reveal_type(OpenAI::ReasoningEffort::NONE)
```

Enum parameters have a "relaxed" type, so you can either pass in enum constants or their literal value:

```ruby
# Using the enum constants preserves the tagged type information:
openai.chat.completions.create(
  reasoning_effort: OpenAI::ReasoningEffort::NONE,
  # …
)

# Literal values are also permissible:
openai.chat.completions.create(
  reasoning_effort: :none,
  # …
)
```

## Versioning

This package follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html). See the [versioning policy](VERSIONING.md) for how releases, breaking changes, Ruby support, dependencies, and type definitions are managed.

## Requirements

Ruby 3.3.0 or higher.

Ruby 3.2 users can continue using v0.75.x, the final compatible release line.
This line will not receive separate maintenance.

## Contributing

See [the contributing documentation](https://github.com/openai/openai-ruby/tree/main/CONTRIBUTING.md).
