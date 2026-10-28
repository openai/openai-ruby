# Migrating to the next major

## Compaction output

GA and beta compaction output now uses the broader `ResponseItem` union. A compacted history may contain retained user, system or developer messages as well as output items and compaction records. Ordinary Responses output types are unchanged.

Code that annotates compaction output as `ResponseOutputItem` or assumes every message is assistant output must accept the broader union. Check the concrete message class and role before reading content: input messages contain input content, while assistant output messages contain output content. Update Ruby, RBI and RBS collection annotations accordingly.

Some concrete item classes also change: function calls in compacted output use `ResponseFunctionToolCallItem` (and `BetaResponseFunctionToolCallItem` for beta). Update class-based branches accordingly. Audio content is not added to the existing input-content union by this change; unrecognized content retains its raw fields.

To continue a conversation, preserve the complete compacted history, including compaction records:

```ruby
compacted = client.responses.compact(model: model, input: history)
response = client.responses.create(model: model, input: compacted.deep_to_h.fetch(:output))
```

The same pattern applies to `client.beta.responses`. Treat unknown future item types conservatively and retain their fields when forwarding the history. This change does not publish a new package or change the server's wire format.


## Decisions message constructors

Compared with earlier `next` snapshots, `DecisionInputMessage` is now the
constructible user-message model. The union covering all four message roles is
`DecisionInputMessageUnion`. Update constructors and type annotations together:

| Earlier name | New name |
| --- | --- |
| `OpenAI::DecisionInputMessage::User` | `OpenAI::DecisionInputMessage` |
| `OpenAI::DecisionInputMessage::Developer` | `OpenAI::DecisionInputMessageUnion::Developer` |
| `OpenAI::DecisionInputMessage::System` | `OpenAI::DecisionInputMessageUnion::System` |
| `OpenAI::DecisionInputMessage::Assistant` | `OpenAI::DecisionInputMessageUnion::Assistant` |
| Sorbet `OpenAI::DecisionInputMessage::Variants` | `OpenAI::DecisionInputMessageUnion::Variants` |
| RBS `OpenAI::Models::decision_input_message` (all roles) | `OpenAI::Models::decision_input_message_union` |

Apply the same prefix substitutions to nested constants and types: `Content`,
`Type`, their Sorbet `Variants`/`OrSymbol` aliases, and each model's `OrHash` alias.
For the assistant, this also includes `Phase`, `Content::Part::OutputText`,
`Content::Part::Refusal`, and their nested aliases. For RBS, user-specific hash
alias `OpenAI::Models::DecisionInputMessage::user` becomes
`OpenAI::Models::decision_input_message`; the other role hash aliases move under
`OpenAI::Models::DecisionInputMessageUnion`. Nested RBS `content`, `type_`, and
assistant `phase`/part aliases follow the same model-prefix substitutions.
The old variant constants are not compatibility aliases in this next major.

```ruby
user = OpenAI::DecisionInputMessage.new(content: "Hello")
developer = OpenAI::DecisionInputMessageUnion::Developer.new(content: "Be concise")
system = OpenAI::DecisionInputMessageUnion::System.new(content: "Synthetic instructions")
assistant = OpenAI::DecisionInputMessageUnion::Assistant.new(content: "Hello back")
client.decisions.create(model: model, input: [developer, system, user, assistant], questions: questions)
```

User messages continue to accept strings or typed text, image, and JSON parts.
Developer and system messages accept strings or input-text parts; assistant
messages accept strings or output-text/refusal parts. These name changes do not
change the wire roles or content fields. `OpenAI::DecisionInputMessage.new` is
retained for callers already using that user-message constructor.
