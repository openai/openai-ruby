# Shipped RBS compatibility cases

These are type-checker inputs, not executable examples. The `.rb.txt` files are
copied to separate `.rb` files in a temporary project and checked together by
`test/openai/rbs_compatibility_test.rb`. One Steep process loads the complete
shipped signatures for all consumers. Separate files preserve local-variable
isolation. Runtime behavior and declaration-structure assertions remain in their
original unit suites.

| Fixtures | Regression protected | Original change |
| --- | --- | --- |
| `request_*` | Documented request hashes are accepted; invalid security values are rejected | #554 |
| `response_stream_valid` | Enhanced Responses events expose their declared helpers after narrowing | #654 |
| `chat_stream_errors_*` | Finish errors expose completion metadata and reject an unsupported constructor argument | #657 |
| `webhook_error_valid` | The public webhook exception can be rescued and inspected | #642 |
| `subject_token_providers_*` | Built-in providers satisfy the workload identity contract; invalid token paths are rejected | #659 |
| `workload_identity_errors_*` | Authentication errors expose metadata with the declared types | #658 |

`expectations.yml` records the exact location, code, and message for each intended
negative diagnostic. Steep's `--with-expectations` fails on unexpected diagnostics
(including errors in positive cases) and on missing expected diagnostics. Review
expectation changes against the intended contract; do not rebaseline unexplained
failures.

Run all cases with:

```sh
bundle exec ruby test/openai/rbs_compatibility_test.rb
```
