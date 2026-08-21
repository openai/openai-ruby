# Realtime WebSocket examples

This directory contains runnable examples for the Realtime WebSocket surface:

- `websocket_text.rb` creates a typed text session, sends one user message,
  streams assistant text, verifies a completed response, and exits.
- `websocket_transcription.rb` uploads raw 24 kHz mono PCM16 audio, explicitly
  commits one input turn, streams transcription deltas, verifies the matching
  completed transcript, and exits.
- `websocket_voice_turn.rb` uploads one raw 24 kHz mono PCM16 turn, explicitly
  commits it, streams the assistant's PCM response to standard output, returns
  its transcript to embedded callers, verifies a completed response, and exits.
- `function_calling.rb` forces one local function call, validates and executes
  it, submits a generic `function_call_output` item, and requires completed
  tool and final-text responses.
- `image_input.rb` submits one application-validated PNG or JPEG data URI with
  a text prompt and requires completed text.
- `mcp_approval.rb` correlates MCP discovery events, selects one advertised
  tool, submits an approval response, waits for tool completion, and requires
  completed follow-up text.

Add the optional transport dependency and set an API key:

```sh
bundle add async-websocket
export OPENAI_API_KEY="your-key"
```

Run the text example from the repository root:

```sh
bundle exec ruby examples/realtime/websocket_text.rb
```

A successful run prints `session.created`, `session.updated`, streamed
assistant text, `response.done status=completed`, and finally
`[realtime] smoke test passed`. Early connection closure, a non-completed
response, or a completed response without text is treated as a failure.

Optional environment variables:

- `OPENAI_REALTIME_MODEL` — defaults to `gpt-realtime-2.1`.
- `OPENAI_REALTIME_PROMPT` — defaults to `Say hello from Ruby.` and is not
  echoed to diagnostic output.
- `OPENAI_REALTIME_TIMEOUT` — overall example deadline in seconds; defaults to
  `30`.

## Call one deterministic local function

```sh
bundle exec ruby examples/realtime/function_calling.rb
```

The example configures exactly one forced function with parallel calls
disabled. It validates the function name and the complete JSON argument shape,
executes deterministic local code, and submits the result through
`conversation.items.create(type: :function_call_output, ...)`. The second
response disables tools and must finish with non-empty text. Prompts, arguments,
tool output, and model text are not written to diagnostics.

Optional environment variables:

- `OPENAI_REALTIME_MODEL` — defaults to `gpt-realtime-2.1`.
- `OPENAI_REALTIME_PROMPT` — defaults to a weather question.
- `OPENAI_REALTIME_TIMEOUT` — overall example deadline in seconds; defaults to
  `30`.

## Send one application-validated image

```sh
OPENAI_REALTIME_IMAGE_URL='data:image/png;base64,...' \
  bundle exec ruby examples/realtime/image_input.rb
```

The example accepts an application-validated PNG or JPEG base64 data URI and
passes it to the Realtime API unchanged. The calling application owns image
fetching, decoding, media-type checks, size limits, and data-URI creation; this
SDK example deliberately does not implement an image decoder. The response text
is returned to embedded callers, and executable diagnostics report only
lifecycle metadata.

Optional environment variables:

- `OPENAI_REALTIME_IMAGE_URL` — required application-validated PNG or JPEG
  base64 data URI.
- `OPENAI_REALTIME_MODEL` — defaults to `gpt-realtime-2.1`.
- `OPENAI_REALTIME_PROMPT` — defaults to a concise image-description request.
- `OPENAI_REALTIME_TIMEOUT` — overall example deadline in seconds; defaults to
  `30`.

## Approve one discovered MCP tool

Choose and operate a remote MCP server appropriate for your application; the
SDK example deliberately does not prescribe a public endpoint.

```sh
MCP_SERVER_URL=https://your-mcp-server.example/mcp \
MCP_APPROVED_TOOL=lookup \
MCP_APPROVED_ARGUMENTS='{"query":"Ruby"}' \
  bundle exec ruby examples/realtime/mcp_approval.rb
```

Tool discovery emits two independently ordered signals. The example waits for
both `mcp_list_tools.completed` and the matching finalized
`mcp_list_tools` conversation item before selecting the first advertised tool.
It then validates the approval request and consults a caller-provided approval
policy before submitting a generic `mcp_approval_response` item. The executable
uses an exact tool-name and argument-string allowlist from the environment.
Embedded applications can pass their own `approval_policy` callable, which
receives `server_label:`, `tool_name:`, and `arguments:`. Missing policies and
every result other than literal `true` deny the request. Before sending an
approval, the example also requires the approval-request arguments to match the
completed generated arguments; the finalized call must retain that exact
argument string. It then correlates approved tool completion and requests a
final response with tools disabled. Every response must complete, and the final
`response.done` must contain non-empty text.

Optional environment variables:

- `MCP_SERVER_URL` — required URL for a caller-selected MCP server.
- `MCP_APPROVED_TOOL` — required exact tool name independently allowed by the
  application.
- `MCP_APPROVED_ARGUMENTS` — required exact JSON argument string independently
  allowed by the application.
- `OPENAI_REALTIME_MODEL` — defaults to `gpt-realtime-2.1`.
- `OPENAI_REALTIME_PROMPT` — defaults to a generic request to use the server.
- `OPENAI_REALTIME_TIMEOUT` — overall example deadline in seconds; defaults to
  `60`.

## Transcribe one committed audio turn

Convert an audio file to the input format required by the Realtime API, then
run the transcription example:

```sh
ffmpeg -i input.wav -f s16le -acodec pcm_s16le -ac 1 -ar 24000 speech.pcm
bundle exec ruby examples/realtime/websocket_transcription.rb speech.pcm
```

The example defaults to `gpt-transcribe`, which is intended for an explicitly
committed audio turn over a Realtime WebSocket. It correlates transcription
events using `item_id` and treats an early close, failed transcription, empty
completion, or completion for the wrong item as a failure.

Optional environment variables:

- `OPENAI_REALTIME_TRANSCRIPTION_MODEL` — defaults to `gpt-transcribe`.
- `OPENAI_REALTIME_TIMEOUT` — overall example deadline in seconds; defaults to
  `60`.

This example intentionally reads a file and drains its result after commit. It
does not claim continuous microphone captioning or concurrent reader/writer
support; those require a separately reviewed lifecycle boundary.

## Send one voice turn and play the response

Convert an audio file to 24 kHz mono PCM16, stream it through the voice-turn
example, and play the response as it arrives:

```sh
ffmpeg -v error -i input.wav -f s16le -acodec pcm_s16le -ac 1 -ar 24000 - \
  | bundle exec ruby examples/realtime/websocket_voice_turn.rb \
  | ffplay -v error -f s16le -ar 24000 -ac 1 -
```

The executable reads raw PCM from standard input, writes only response PCM to
standard output, and sends metadata-only diagnostics to standard error.
`WebSocketVoiceTurn.run_with_timeout` returns the assistant transcript to
embedded callers without printing it. Its single deadline covers the initial
input read, network turn, and response stream. The boundary also suppresses
path details from operating-system I/O errors and payload-bearing parser causes
from malformed protocol events. A successful run writes non-empty response
audio, observes `response.done status=completed`, and then prints
`[realtime] voice turn smoke test passed` to standard error.

The example intentionally does not own output filenames, overwrite policy, or
filesystem durability. If you redirect its standard output to a file, those
semantics belong to your shell or application.

Optional environment variables:

- `OPENAI_REALTIME_MODEL` — defaults to `gpt-realtime-2.1`.
- `OPENAI_REALTIME_VOICE` — defaults to `marin`.
- `OPENAI_REALTIME_TIMEOUT` — overall example deadline in seconds; defaults to
  `60`.

This is an explicit, committed file turn. It does not capture a microphone,
play audio while it arrives, or claim full-duplex conversation support; those
require a separately reviewed concurrency and device-lifecycle boundary.

See the repository's [Realtime WebSocket guide](../../realtime.md) for the
public connection API, custom transports, proxy behavior, and TLS setup.
