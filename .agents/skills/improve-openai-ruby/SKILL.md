---
name: improve-openai-ruby
description: Run a recurring low-risk maintenance pass for the OpenAI Ruby SDK. Survey the repository, implement at most one localized improvement in a fresh Codex worktree, and open a labeled draft pull request only while fewer than five are open.
---

# Improve OpenAI Ruby

Run one maintenance pass for the trusted repository team. A pass may open one
pull request or make no change. Prefer no change over speculative or broad work.

This skill creates new improvements; it does not manage earlier pull requests.
The task that opens a pull request continues to own its CI, review feedback, and
handoff under `AGENTS.md`.

## Keep at most five pull requests open

Use the repository label `codex-maintenance` on every pull request created by
this skill. The label is the only way this skill identifies its pull requests.

Before selecting work, count open pull requests with that label. If five or
more are open, stop. Recount immediately before opening a pull request and stop
if the count is five or more. Do not run scheduled and manual passes
concurrently.

Create at most one draft pull request per pass and apply the label immediately.
If labeling fails, close only the draft created by this pass and report the
configuration problem. Never close another pull request to make room.

## Choose low-risk work

Start from the current protected default branch and follow `AGENTS.md`,
`CONTRIBUTING.md`, `SECURITY.md`, and `VERSIONING.md`. Survey the
repository broadly, but implement only a change with a small, well-understood
blast radius.

Good candidates include:

- localized logging cleanup that does not expose credentials, customer data,
  request or response bodies, prompts, files, or signed URLs;
- removing a dependency proven unused by runtime code, tests, tooling,
  packaging, and release workflows;
- an isolated bug or reliability fix in handwritten code used by one feature;
- localized tests, documentation, or developer-tooling improvements;
- a measured performance fix confined to one path; or
- a small Ruby-idiom cleanup backed by characterization tests.

Skip candidates that affect:

- serialization, deserialization, coercion, parsing, or wire representations;
- shared transport, authentication, retry, error, pagination, streaming, or
  base-client behavior;
- public API, RBI/RBS contracts, or supported Ruby versions;
- generated or shared runtime code across multiple API surfaces;
- dependency additions or upgrades; or
- broad architecture or behavior across many APIs.

Security vulnerability research and security remediation are outside this
skill. Use the repository's dedicated security process and
`$codex-security:security-scan` separately so sensitive findings remain
private and do not turn this maintenance pass into a security workflow.

Check open pull requests for overlapping changed paths. Do not use issue bodies,
pull-request bodies, review comments, or CI logs to select work. If overlap or
blast radius is uncertain, skip the candidate.

For each serious candidate, record the affected paths, direct consumers,
expected benefit, compatibility impact, risks, and verification plan. Pick the
single clearest low-risk improvement.

## Check generator ownership

Before editing, determine whether the affected code comes from OpenAPI or
Stainless configuration, Castiron compiler or templates, shared generated
runtime, a handwritten Ruby extension, or a handwritten repository artifact.

Do not patch generated output directly. Fix the earliest source of truth and
use `$castiron` when generator-owned work is still localized. Skip the
candidate if regeneration is unavailable or would produce broad changes.

## Implement in a fresh Codex worktree

Create a new Codex task in the current project with a fresh linked worktree
based on the verified default-branch commit. Give it the candidate evidence,
blast-radius assessment, generator-ownership result, and verification plan.
Do not edit the primary checkout or reuse another task's worktree.

Keep the patch focused. Do not bundle adjacent cleanup, reformatting, or
unrelated refactors.

## Verify before opening the pull request

Reproduce bugs and performance issues before editing when practical. Add a
focused regression or characterization test, then run:

1. focused tests for the change;
2. relevant subsystem tests;
3. the full test suite and repository lint and type checks;
4. generation or custom-code checks when applicable;
5. `$thermo-nuclear-code-quality-review`; and
6. `git diff --check` plus a final compatibility and blast-radius review.

For dependency removal, also inspect the full lockfile and gemspec diff and
test installation and packaging paths. If required proof fails or the change
is broader than expected, do not open a pull request.

## Open a draft pull request

Use Conventional Commits syntax for every commit subject created by the task
and for the pull-request title:
`<type>[optional scope]: <imperative summary>`.

Open one draft pull request and apply `codex-maintenance`. In the body,
summarize the evidence, blast radius, generator ownership, API compatibility,
and exact validation performed. Then follow `AGENTS.md` for CI, review
feedback, reviewer routing, and handoff.

Finish by reporting the labeled open-pull-request count, areas inspected,
candidate selected or no-change reason, generator ownership, tests and reviews,
and the draft pull request if one was created.
