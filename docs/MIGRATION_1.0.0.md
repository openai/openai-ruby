# Ruby SDK 1.0 migration guide

## Compaction output

GA and beta compaction output now uses the broader `ResponseItem` union. A compacted history may contain retained user, system or developer messages as well as output items and compaction records. Ordinary Responses output types are unchanged.

Code that annotates compaction output as `ResponseOutputItem` or assumes every message is assistant output must accept the broader union. Check the concrete message class and role before reading content: input messages contain input content, while assistant output messages contain output content. Update Ruby, RBI and RBS collection annotations accordingly.

Some concrete item classes also change: function calls in compacted output use `ResponseFunctionToolCallItem` (and `BetaResponseFunctionToolCallItem` for beta). Update class-based branches accordingly. Audio content is not added to the existing input-content union by this change; unrecognized content retains its raw fields.

To continue a conversation, preserve the complete compacted history, including compaction records:

```ruby
compacted = client.responses.compact(model: model, input: history)
response = client.responses.create(model: model, input: compacted.deep_to_h.fetch(:output))
```

The same pattern applies to `client.beta.responses`. Treat unknown future item types conservatively and retain their fields when forwarding the history. The server uses the same wire format for both SDK versions.

## Live Responses delegation tool choices

Two choice classes move in both `OpenAI::Live::ResponsesDelegationConfig::ToolChoice` and `OpenAI::Live::ResponsesDelegationUpdateConfig::ToolChoice`. Update constructors, class checks, and type annotations, including Sorbet references to each class’s nested `OrHash` type.

| Previous Ruby / RBI class | New Ruby / RBI class | Previous RBS record alias | New RBS record alias |
| --- | --- | --- | --- |
| `LiveFunctionToolChoiceParam` | `Function` | `live_function_tool_choice_param` | `function` |
| `LiveMCPToolChoiceParam` | `Mcp` | `live_mcp_tool_choice_param` | `mcp` |

**Before**

```ruby
DelegationToolChoice = OpenAI::Live::ResponsesDelegationConfig::ToolChoice
choice = DelegationToolChoice::LiveMCPToolChoiceParam.new(server_label: "docs", name: "search")
```

**After**

```ruby
DelegationToolChoice = OpenAI::Live::ResponsesDelegationConfig::ToolChoice
choice = DelegationToolChoice::Mcp.new(server_label: "docs", name: "search")
```

A function choice still requires a string `name`. An MCP choice requires a string `server_label`. Omit `name` to leave the key out, pass `name: nil` to send JSON null, or pass a string to select a named tool. Handle `nil` when reading an MCP choice in a returned session. The same field contract applies to MCP entries inside `ToolChoice::LiveAllowedToolsChoiceParam::Tool::Mcp`. Their class name stays the same. In Sorbet the MCP name reader is `T.nilable(String)`. Its RBS record field is `?name: String?`.

## Named graders

Pass a hash of named graders as `graders:` when you construct a `MultiGrader`.
Use those names in `calculate_output`. Requests that already use a named hash
keep the same JSON shape. Values can be string-check, text-similarity, Python, score-model, or
label-model graders.

```ruby
check = OpenAI::Graders::StringCheckGrader.new(
  name: "exact", input: "{{sample.output_text}}", operation: :eq, reference: "ok"
)
combined = OpenAI::Graders::MultiGrader.new(
  name: "combined", graders: {exact: check}, calculate_output: "exact"
)
validated = client.fine_tuning.alpha.graders.validate(grader: combined)
grader = validated.grader
raise "Expected a multi grader" unless grader.is_a?(OpenAI::Graders::MultiGrader)
grader.graders.fetch(:exact)
```

## Image sizes

Read image response sizes and generation/edit stream event sizes as strings.
Use `image.size == "1024x1024"` to compare the size. Existing dimension constants
and event `Size::AUTO` are strings. `Size.values` returns an array of strings.
Custom sizes remain valid.

If you assign a symbol, the accessor returns its string form. `to_hash` retains
the supplied symbol and JSON serialization sends a string.

## Videos

Remove `client.videos` calls, video polling and download jobs, video resource
type annotations, and Batch inputs targeting `/v1/videos`. The Videos API and
Sora 2 model IDs have been retired. For stored `video.completed` or
`video.failed` webhook events, read the video ID with `event[:data][:id]`.

## Assistants

Create a Conversation to keep state across Responses requests. Move assistant
instructions and tools to a prompt or pass them in the request. Copy any
retained messages and tool results into the new conversation and store its ID
for subsequent requests. Create a new conversation for each thread you migrate.

```ruby
conversation = client.conversations.create
response = client.responses.create(
  model: model,
  instructions: instructions,
  conversation: conversation.id,
  input: question
)
puts response.output_text
```

Use `client.responses.stream` for streaming. Return function results as
`function_call_output` items with the matching `call_id`.

## Retired Chat Completions model IDs

Replace references to `GPT_4_VISION_PREVIEW`, `GPT_3_5_TURBO_0613`, and
`GPT_3_5_TURBO_16K_0613` with a supported model ID. For example, set
`model: ENV.fetch("OPENAI_MODEL")` and configure a model that supports your
application's inputs, including image input for applications migrating from
GPT-4 Vision Preview.
