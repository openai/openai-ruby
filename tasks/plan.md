# Zero patches to Castiron-generated Ruby files

## Goal and baseline

Preserve the released gem's runtime and type API while making every Castiron-owned
file identical to its verified generated snapshot. Do not broaden ownership
exclusions, weaken the reporter, or rewrite generation metadata to lower usage.
Handwritten implementation and tests may remain in existing handwritten locations.

Baseline: public main `5490f04d01949633e750d5a0288ba73178a39f60`; verified generated
snapshot `d31d2b112ac489c71fc19642831d52c916385915`. 48 mixed files, 2,091 patch
lines. This replaces the earlier inventory taken from an older checkout.

## Decisions

- Work in focused, independently testable PRs. Keep runtime and its RBI/RBS
  declarations together; split unrelated features into separate PRs.
- Use the existing handwritten helper/class-reopening convention for additive SDK
  conveniences. Preserve method owners, visibility, constants, initialization,
  serialization, loading order, return types, exceptions, and typechecker behavior.
  Every signature extraction must pass the exported RBI/Tapioca merge test as well
  as Sorbet and RBS; partial RBI model declarations must repeat their superclass.
- Fix general generation defects in Castiron's OpenAI profile. Keep immutable
  Stainless fixtures unchanged and verify parity alongside the production profile.
- Do not replace a customization with a semantically different generated version
  just because the diff becomes smaller. If preserving compatibility conflicts
  with the zero-patch goal, stop and ask the owner for a decision.
- Compiler changes must land before promoting SDK output built from them. Draft
  generation is validation, not permission to publish an unmerged compiler.
- Do not auto-merge review-sensitive work or bypass human approval/required checks.
- Count all output files using existing ownership; the final audit must explicitly
  account for workflow paths outside the current reporter's hash coverage.

## Ordered PR series

| PR | Change | Acceptance / verification | Dependency |
| --- | --- | --- | --- |
| 1 | Restore reporting scripts to exact generated content; record this plan | Existing reporter/budget tests pass; 3 files / 7 patch lines removed; budget and counting unchanged | None |
| 2 | Move handwritten container upload regression cases out of the generated resource test | Same multipart/JSON public-entrypoint assertions pass offline; generated test matches snapshot | 1 |
| 3 | Extract Responses `output_text` into a handwritten model extension with RBI/RBS | Existing output-text tests and type declarations pass; same owner/visibility and empty/mixed output behavior | 2 |
| 4 | Extract Chat parsed-result fields into handwritten model extensions | Existing parsing/streaming and Sorbet tests pass; response-only fields keep serialization semantics | 3 |
| 5 | Extract Responses parsed-result fields into handwritten model extensions | Existing response parsing/streaming tests pass; same runtime/type API | 4 |
| 6a | Generate the existing schema-converter RBI input contract for annotated model parameters (including Responses text) | Preserve reader, constructor, response-model and RBS types; test enabled/disabled annotations, inheritance, streaming and Stainless parity | 5 |
| 6b | Preserve remaining Chat/Responses schema and tool union inputs through native compiler support or typed extension points | Both APIs' schema/tool examples, parsing/streaming and type tests pass without generated patches | 6a |
| 7a | Extract Agents file conveniences (independent; brought forward alongside 6a) | Same upload/download methods and RBI/RBS; synthetic transport tests pass | 5 |
| 7b | Extract additive Agents `sessions.stream` method into the existing handwritten helper | Same method owner/parameters, subclass super, streaming/result/error semantics and block cleanup; existing handwritten RBI/RBS unchanged | 7a |
| 7c | Preserve Agents `create_streaming` runtime and type contract through compiler support | Preserve local-only keywords and CreationStream return type; no duplicate RBI definitions; compiler lands before regeneration | 7b |
| 8a | Extract Chat structured-output resource wrappers and stream helper | Create/stream public-entrypoint, tool parsing, and type tests pass | 7c |
| 8b | Extract Responses structured-output resource wrappers and stream helper | Creation/resumption, structured tools, unknown events, and type tests pass | 8a |
| 9a | Preserve webhook endpoint diagnostic redaction in handwritten extension or native generation | Existing secret-redaction tests pass; field access and serialization unchanged | 8b |
| 9b | Reconcile webhook verifier with native output without changing accepted inputs/errors | Existing signature/error tests pass; no Base64 dependency regression | 9a |
| 10a | Preserve client copying/default-header behavior through compiler-supported extension boundary | Copy/subclass/header/type compatibility tests pass | 9b |
| 10b | Preserve provider routing/authentication through the same boundary | Azure/Bedrock configuration and synthetic transport tests pass | 10a |
| 10c | Preserve workload identity and X.509 through the same boundary | Identity, replay, timeout, credential isolation, and type tests pass | 10b |
| 11a | Fix remaining transcription union ordering in compiler | Plain/verbose/diarized/StringIO return behavior unchanged; parity fixtures intact | 10c |
| 11b | Fix nil optional usage filters in compiler | Existing request-shape regression passes; no unrelated query behavior change | 11a |
| 11c | Fix generated credential update test's required request body | Mock-backed generated test passes without a local metadata patch | 11b |
| 12 | Generate the supported handwritten bootstrap/loading boundary; preserve Threads placeholder | Ordinary require, direct-load expectations, Tapioca, gem package, and type checks pass; root matches generated output | All earlier slices |
| 13 | Regenerate with merged compiler; audit exact generated-file equality | Verified current snapshot; zero mixed files and patch lines; runtime/offline suite, types, package, and sequential large-payload tests pass | 12 |
| 14 | Separate budget-only PR ratcheting the ceiling to zero | Only `.castiron-ratchet.json` changes; zero usage already established | 13 |

Compiler-backed slices may need a compiler PR followed by an SDK regeneration PR.
Slice 7a can proceed while 6a is under compiler review: its additive file/artifact
methods and declarations do not depend on structured-output input conversion.
Refine implementation details using code evidence, but do not silently enlarge a
PR to absorb another feature or skip a compatibility gate. Each checkpoint records
measured counts, test results, and review links in `tasks/todo.md`.

## Risks

The highest-risk boundaries are client super dispatch and token lifecycle,
model DSL inheritance/loading, duplicate Sorbet/RBS signatures, stream cleanup,
webhook error semantics, and union selection order. Preserve behavior with existing
public-entrypoint tests and add narrowly targeted characterization tests where
coverage is missing. Do not weaken tests or reduce large-payload fixture sizes.

## Completion evidence

A zero advisory counter alone is insufficient. Record the exact SDK and compiler
revisions, normal generation provenance, generated-file comparison, excluded-path
audit, consumer compatibility results, and final zero-budget PR. Until then this
project is explicitly incomplete.
