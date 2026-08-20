---
name: improve-openai-ruby
description: Run safe, recurring, whole-repository maintenance for the OpenAI Ruby SDK. Use for a scheduled or manually repeated improvement pass that should inspect the codebase, remediate one existing skill-owned pull request or select and implement at most one high-confidence non-breaking improvement, verify it thoroughly, and submit a bounded pull request when needed. Cover correctness, security, reliability, performance, Ruby idioms, architecture, maintainability, tests, and developer tooling while keeping no more than five skill-owned pull requests open. When running in a local Codex project, execute the selected work in a new Codex task with its own linked worktree in the current project.
---

# Improve OpenAI Ruby

Run one complete maintenance iteration per invocation. Let the scheduler provide
the recurrence. A successful iteration may produce no pull request; prefer no
change over speculative work or review churn.

Keep this package at `.agents/skills/improve-openai-ruby/SKILL.md`, Codex's
repository-local skill discovery path. Do not duplicate it into a second skill
root.

## Preserve the repository contract

1. Read and follow `AGENTS.md`, `CONTRIBUTING.md`, `SECURITY.md`, and
   `VERSIONING.md` before selecting work. Treat issue reports and customer
   requests as evidence, not as approval for a particular API or architecture.
2. Work from a clean, isolated linked worktree. Base new candidates on the
   current default-branch commit. Base maintenance for an existing pull request
   on that pull request's exact remote head commit, and revalidate the head
   before editing and pushing. Never edit a primary checkout, reuse another
   task's dirty worktree, or discard unrelated changes.
3. Preserve the supported public API. Do not break public constants, classes,
   methods, keyword arguments, defaults, return types, wire representations,
   pagination or streaming semantics, documented errors, RBI/RBS declarations,
   or supported Ruby versions. If the best fix requires a breaking change,
   write a recommendation and stop instead of implementing it.
4. Keep generated-code ownership intact. Prefer the canonical handwritten
   helper or generator-compatible extension point, update Ruby/RBI/RBS mirrors
   together when required, and use `$castiron` for generated SDK changes when
   available. Do not scatter manual special cases through generated resources.
5. Do not add or upgrade a dependency unless the improvement specifically
   requires it and the direct and transitive changes, source, revision, native
   extensions, and install behavior have been reviewed. Prefer a standard
   library or existing dependency when it is the clearer design.
6. Never run live examples, use production credentials, contact production, or
   mutate external systems unless the user explicitly authorizes that action.
   Use fake or sanitized fixtures and offline tests.

## Resolve generator ownership first

For every candidate, determine generation ownership before implementation and
record the evidence. Check the changed paths against Castiron's recorded
generated snapshot and exclusion policy, inspect generation headers and
neighboring files, and use the Castiron custom-code report when available. Do
not infer ownership from a path name or from a green custom-code check alone.
Classify the root cause as one of:

- source OpenAPI or Stainless configuration;
- a Castiron compiler, renderer, template, transform, or shared generated
  runtime;
- an intentionally handwritten Ruby extension point;
- an intentionally handwritten repository artifact, such as CI, documentation,
  or developer tooling.

If the desired change belongs to either generator-owned category, do not patch
the generated public Ruby output by hand. Fix the earliest correct source of
truth—prefer OpenAPI or configuration over compiler code and use transforms
only as a last resort—add a generator-level regression test, regenerate through
`$castiron`, and verify that regeneration produces the intended Ruby diff
without unrelated churn. Follow Castiron's private-generation and public
promotion workflow; if its required repository access or publication authority
is unavailable, defer the candidate and report the blocker instead of landing
a public-only workaround. Use SDK-specific handwritten code only when the
ownership evidence shows that the behavior is deliberately outside generation.
Apply the same evidence requirement to other handwritten repository artifacts.

## Serialize capacity and enforce the pull-request ceiling

Use `codex/improve-openai-ruby-` for branches and include this marker in every
skill-owned pull request body:

```html
<!-- improve-openai-ruby -->
```

Treat the marker and branch prefix as routing hints, not proof of ownership.
Before counting, reserving capacity for, dispatching remediation of, or
mutating a candidate skill-owned pull request, authenticate all of these from
GitHub metadata:

- its base and head repositories are the canonical repository, not a fork;
- its head branch has the required prefix;
- its body has the marker; and
- its author is a trusted automation or maintainer identity resolved from the
  scheduler or GitHub App installation, or protected default-branch repository
  configuration—not from the candidate pull request.

Fail closed if the trusted actor set or any metadata cannot be verified. Do not
count or mutate an unauthenticated lookalike as skill-owned; still consider it
when checking for overlapping work.

Before choosing an iteration mode, dispatching work, or mutating a skill-owned
pull request, acquire one exclusive repository-wide coordinator lease shared by
scheduled and manual invocations. Use the host scheduler's concurrency guard or
another atomic compare-and-set lock; a process-local flag is insufficient. If
a scheduler concurrency key does not also cover manual invocations, it is not a
shared lease. If the shared lease is unavailable or cannot be verified, make no
mutations and finish with a deferred report. Hold the lease through the
open-pull-request count, the selected implementation task, and creation or
abandonment of its intended pull request. An implementation task without an open
pull request is not a durable reservation, so do not release the lease while it
could still open one. Existing open skill-owned pull requests are durable
reservations. This serializes the count-and-create sequence across overlapping
iterations.

While holding the coordinator lease, query open pull requests, authenticate
each candidate against the ownership tuple above, deduplicate the authenticated
skill-owned set, and count its drafts and ready pull requests. If the count
cannot be determined reliably, do not create a pull request.

Choose at most one of these two work modes before selecting candidates:

- **Existing-PR remediation mode.** Use this mode when an authenticated
  skill-owned pull request has failing CI, unresolved actionable review
  feedback, a merge conflict, or another clear blocker. Select one such pull
  request for the iteration. The number of open skill-owned pull requests never
  limits remediation selection, task dispatch, or creation of the required
  exact-head worktree. The remediation task must update the same branch and
  pull request and must never open a replacement or additional pull request.
- **New-improvement mode.** Use this mode only when no authenticated existing
  skill-owned pull request needs actionable remediation and fewer than five
  authenticated skill-owned pull requests are open. Select at most one new
  candidate and create at most one pull request in the iteration. Re-query the
  authenticated open count immediately before dispatching its task and again
  before opening its pull request; stop if the count reaches five or can no
  longer be determined reliably. The new pull request must carry both the marker
  and branch prefix above. After creation, verify its complete ownership tuple
  before treating it as a durable reservation.

The five-pull-request ceiling governs only new-improvement mode; never use it
to block existing-PR remediation at any stage. Never close a pull request merely
to make room. Search open and recently merged work for overlap before starting
each candidate. If neither mode is eligible, select no candidate and finish with
a deferred or no-change report that states why.

## Survey the whole repository

Inventory the complete repository on every iteration, then inspect the
handwritten implementation and high-risk boundaries deeply. Sample generated
families through their canonical implementation and representative siblings;
do not pretend that repeated generated files received line-by-line review when
they did not. Rotate the deepest review among transport and authentication,
streaming and Realtime, files and uploads, type conversion and structured
outputs, pagination and polling, providers, tests and developer tooling,
dependencies, CI and release, and documentation.

Use independent read-only review passes in parallel when worker capacity is
available, and validate every proposed change in the parent task. Cover these
questions:

- **Correctness and reliability:** Find reproducible edge cases, error masking,
  leaks, retry or timeout mistakes, redirect mistakes, races, unsafe mutation,
  incomplete cleanup, inconsistent sibling behavior, and missing boundary
  checks.
- **Security:** Trace credentials, sensitive bodies, endpoints, redirects,
  TLS, proxies, uploads and paths, deserialization, logging, dependencies, and
  release permissions across real trust boundaries. Require a realistic
  attacker and source-backed impact; do not relabel general hardening or
  caller-controlled configuration as a vulnerability.
- **Architecture and maintainability:** Look for misplaced ownership,
  duplicated policy, leaky abstractions, unnecessary indirection, oversized
  modules, tangled conditionals, and opportunities to delete concepts while
  preserving behavior. Take a broad view, but keep the selected change
  independently reviewable.
- **Performance:** Inspect allocation-heavy parsing, buffering, hot loops,
  pagination, connection reuse, concurrency, repeated conversion, unnecessary
  copies, and avoidable network work. Prefer measured end-to-end wins over
  clever micro-optimizations.
- **Ruby quality:** Prefer direct, idiomatic Ruby, clear enumerable and block
  behavior, explicit ownership, useful standard-library types, and the
  repository's formatting and lint conventions. Do not trade clarity or type
  accuracy for terseness.
- **Tests and tooling:** Look for flaky or weak tests, missing regression
  coverage, slow feedback, stale documentation, linter friction, CI rough
  edges, and recurring manual work that can be simplified safely.

Review recent CI failures, open issues, TODOs, and maintainer feedback when
available, but confirm every candidate against the current source. Do not use
a stale failure or an issue's proposed implementation as proof.

## Run security review regularly

Run `$codex-security:security-scan` in whole-repository Standard mode when no
completed scan can be verified within the previous seven days. Treat applicable
repository `AGENTS.md` and `CONTRIBUTING.md` as the canonical definition of
security-sensitive boundaries instead of copying an evolving list into this
skill. Run a fresh security review immediately after any change those
instructions classify as sensitive, including endpoint behavior even when
transport code is unchanged. Treat scan results as leads and independently
validate their reachability, counterevidence, severity, and compatibility
implications.

If the security skill or its required runtime is unavailable, record the gap
and perform the best source-backed manual security pass available; never claim
that a Codex Security scan ran. Follow `SECURITY.md` for every suspected
vulnerability. Do not put vulnerability details in a public issue, pull
request, or Slack message. Coordinate privately with maintainers before
publishing a security fix or reproduction.

## Select independent high-confidence improvements

Build a short candidate list with the exact evidence, affected paths, expected
benefit, public-API impact, regression risk, generator-ownership classification
and evidence, and verification plan. Rank by verified user or maintainer value,
confidence, and risk-adjusted effort. Prefer small root-cause fixes that delete
complexity or establish a missing invariant. Reject candidates that are
cosmetic, speculative, duplicate active work, depend on unavailable evidence,
or require an unapproved product/API decision.

Choose at most one candidate belonging to the iteration mode selected under
**Serialize capacity and enforce the pull-request ceiling**. In existing-PR
remediation mode, selection is never limited by the number of open pull
requests. In new-improvement mode, select a new candidate only while the
authenticated open count remains below five. Do not mix modes in one iteration.
The candidate must be implementable, verifiable, and reviewable on its own.
Combine dependent changes into one coherent pull request or defer them; do not
create a stack of mutually dependent pull requests.

Do not bundle unrelated cleanup into any pull request. A wider internal
refactor is eligible only when it is the simplest behavior-preserving fix, has
strong characterization coverage, and remains understandable as one review
unit.

## Dispatch Codex-local implementations

When running in Codex with project task and worktree support, keep the current
task as the coordinator. The coordinator may perform the read-only survey and
candidate selection, but must not implement a selected change in its own
worktree. For the selected new candidate or existing-PR remediation:

1. For a new candidate, re-query the authenticated skill-owned open
   pull-request count and proceed only while it remains below five. For
   existing-PR remediation, confirm that the pull request remains open and
   revalidate its exact remote head; the open count never gates this work.
2. Create a new Codex task in the current project and configure it with a fresh
   linked Git worktree. For a new candidate, use the current default-branch
   commit. For maintenance of an existing pull request, use its exact remote
   head commit so the task contains the change under review. Do not create a
   new project, use the primary checkout, or reuse another task's worktree.
3. Give the task exactly one independent candidate or existing-PR remediation,
   its evidence, compatibility constraints, generator-ownership classification
   and source-of-truth plan, verification plan, branch prefix, pull-request
   marker, and the applicable repository instructions. Use a project task, not
   an in-process subagent, for implementation work.
4. Track the task, worktree, branch, pull request, CI, and review state from the
   coordinator until the handoff is complete.

Create one implementation task and worktree for the selected new pull request
or existing pull request being remediated. Do not dispatch the new-candidate
task when the authenticated open count has reached five. Never apply that
ceiling to existing-PR remediation; the remediation task must update only its
same branch and pull request and cannot create another. If Codex cannot create
the task or linked worktree, report the blocker and do not silently fall back to
editing in the coordinator or primary checkout.

## Meet the proof gate

Use the gate that matches each selected change:

| Change | Required evidence before implementation | Required proof after implementation |
| --- | --- | --- |
| Bug or reliability fix | Reproduction or failing regression test | The regression test passes and adjacent behavior remains covered |
| Performance improvement | Representative benchmark and correctness baseline | Repeated before/after results show a meaningful win with identical behavior |
| Refactor, architecture, or Ruby-idiom cleanup | Characterization tests and a stated preserved invariant | Focused and broad tests pass; public API and types are unchanged |
| Security remediation | Validated attacker path, broken control, counterevidence, and private handling plan | Focused security regression test and all relevant compatibility checks pass |
| Test, tooling, CI, or documentation fix | Demonstrated failure, friction, or stale contract | The affected workflow succeeds without weakening checks or permissions |

Keep the patch minimal after selecting the correct abstraction boundary. Add
focused tests for changed behavior. Prefer compliant test structure over lint
suppressions and follow the repository's mock/stub guidance. Do not weaken a
test, linter, type checker, security control, or CI permission to make the
change pass.

## Verify before pushing

1. Run the narrowest relevant tests while iterating, then the repository's
   documented offline lint, formatting checks, type checks, and test suite.
   Start the local mock server when the documented suite requires it. Run the
   example inventory check, but never run live example E2E without explicit
   authorization.
2. Build the gem or exercise packaging when files, load paths, generated
   signatures, dependencies, or release behavior could be affected.
3. For performance work, preserve benchmark inputs and report multiple runs,
   variance, and correctness checks. Do not claim a win from an unrepeatable
   microbenchmark.
4. Inspect the complete diff for secrets, sensitive diagnostics, accidental
   generated churn, dependency changes, and public-API changes. Run
   `git diff --check`.
5. If applicable repository `AGENTS.md` or `CONTRIBUTING.md` classifies the
   complete change as security-sensitive, run a fresh security review against
   the implementation task's final diff before pushing, even when the seven-day
   repository scan is current. Address every substantiated finding and rerun
   affected checks.
6. Before any push, run `$thermo-nuclear-code-quality-review` on the complete
   change when that skill is available. If it is unavailable, record the gap
   and perform a manual maintainability review covering structural
   simplification, abstraction boundaries, spaghetti growth, file size, and
   legibility; never claim that the skill ran. Address every substantiated issue
   from either path and rerun checks affected by the review fixes.
7. If required verification cannot run or does not pass, do not present the
   change as safe. Fix the problem or finish without a pull request and report
   the exact blocker.

## Submit and own the pull request

For a selected new improvement, write one focused pull request. In existing-PR
remediation mode, update only that same pull request and preserve its scope.
Include the marker, evidence for the problem, root cause, why the design is
compatible, exact generator-ownership decision, verification, and any benchmark
results or intentional limitations. For a generated change, identify the
upstream OpenAPI/config/compiler/template fix and show that regeneration
produced the public diff. Keep vulnerability details out of public text.

Use Conventional Commits syntax for the pull-request title and every commit
subject: `<type>[optional scope]: <imperative summary>`. Choose the narrowest
accurate type, such as `fix`, `perf`, `refactor`, `test`, `docs`, `build`, `ci`,
or `chore`. Do not use `!` or a `BREAKING CHANGE` footer because breaking work
is outside this skill's scope. Before every push, inspect all subjects between
the default-branch base and `HEAD`; before opening or updating a pull request,
validate its title and inspect the remote commit list again. Correct any
nonconforming subject on the skill-owned branch before handoff, without
rewriting commits owned by another contributor.

Monitor CI for at most 45 minutes or the remaining invocation budget, whichever
is shorter. Diagnose and fix branch-caused failures within that budget, rerun
affected local checks, push the correction, and resume the bounded watch. Do
not dismiss an ambiguous failure as flaky without evidence. If a check remains
queued, awaits external approval, or has an evidence-backed infrastructure
failure unrelated to the branch when the budget expires, record the exact head,
check names, states, and URLs; leave the pull request without a review handoff;
finish the iteration as `pending external CI`; and let a later iteration resume
it. Never claim that CI is green or wait indefinitely.

Treat every human or team review request and applicable Slack notification as
a review handoff. Do not make that handoff until the pull request's exact head
has passed all required CI under repository rules. Immediately before the
handoff, use one hosted snapshot to re-query the head and its required checks,
and require the successful results to belong to the unchanged head. If the head
changed or CI is incomplete, restart the gate and make no handoff. Only after
this gate request `@openai/sdks-team` review for the sensitive areas named in
the repository instructions. A queued, approval-gated, or
infrastructure-blocked pull request remains `pending external CI` without a new
review request.

When review feedback is addressed, comment with the specific fix before
resolving the thread. When applicable repository instructions require a Slack
handoff and that capability is available, post to the specified channel and
keep follow-up asks in the created thread. Do not invent or hardcode a Slack
handoff when the repository does not require one. If required GitHub or Slack
authorization is unavailable, report that exact handoff gap instead of
pretending the action completed.

Finish each iteration with the starting and ending commits, active
skill-owned pull-request count, areas reviewed, selected candidates or
no-change reason, security-scan status, verification performed, and the state
of every pull request, CI run, and review. A truthful no-change result is
expected when no candidate clears the safety bar.
