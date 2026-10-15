# Preparing the next breaking release

`main` remains the current release line. `next` integrates reviewed changes for
the next planned breaking release. The branch name does not choose a gem version;
select the version using [VERSIONING.md](../VERSIONING.md) before release.

## Branch readiness

1. Synchronize `next` with current `main`, preserving ancestry and reviewing
   conflicts. Avoid force-resetting a shared branch. The old branch's unique
   commit changed only obsolete generation metadata; retain current main's
   metadata when resolving that synchronization.
2. Require pull-request review, CODEOWNERS, CI and CodeQL for `next`; prohibit
   branch deletion and force pushes. Repository rules must support the chosen
   synchronization merge method. Main's existing rules remain authoritative.
3. The trusted custom-code checker on `main` supports PRs and merge groups
   targeting `main` or `next`. It compares against the actual target while
   taking executable checker code and budget policy from `main`. Validate the
   hosted PR and queue paths before requiring its statuses on `next`; do not
   bypass checks or raise the budget to start the release branch.
4. Verify generation and promotion can explicitly target `next`. A candidate
   branch name alone is not a release-target selector. Until target support is
   validated, do not promote breaking generated changes through the stable path.

## Hosted checker rollout

Keep validation and required-check activation as separate reviewed steps.
For each hosted case, retain the PR number, exact candidate and target SHAs,
trusted main-policy SHA, source workflow run, trusted publisher run, and both
status results. A passing PR result alone is not merge-queue evidence.

Exercise passing PRs and real merge-queue candidates on both `main` and `next`.
Also verify fork PRs, retargeting, over-budget changes, mixed budget/code changes,
and policy movement. Keep deliberately failing probes unmerged and close them
when their evidence is recorded. Any lasting budget change needs its own
budget-only PR and normal review.

After the evidence is reviewed, add these exact required statuses to `next`,
bound to GitHub Actions, while retaining all existing checks and protections:

- `Castiron / budget-only change`
- `Castiron / custom-code budget`

The trusted main policy must remain authoritative even when `next` has a
different policy file. Queue validation must reject stale policy, target or
membership identities. This rollout does not enable generation, promotion or
publishing to a new target.

## Per-change workflow

- Land compatible fixes and helper extractions on `main`, then synchronize them
  into `next`. Keep that synchronization frequent and reviewable.
- Open one PR per coherent breaking change against `next`. Include affected
  public methods/types, migration examples and explicit before/after tests.
- Keep SDK-owned runtime behavior in the SDK. Generate model/signature changes
  from pinned source/configuration inputs using a reviewed compiler.
- Record the target branch and SHA, source/configuration identity, compiler
  identity and generated checkpoint for each candidate. Stable and next inputs
  must remain independently reproducible. Reject stale or mismatched targets.
- Validate each intentional contract change without weakening unrelated
  compatibility tests, generated-file ownership or custom-code limits.

## Release validation

Run the complete required CI matrix, runtime and transport tests, Sorbet/RBS
consumer checks, and migration examples against a built gem. Verify the intended
behavior for supported Ruby versions and unchanged behavior outside accepted
scope. Integration-branch CI does not replace installed-package validation.

The release workflow remains restricted to `main`, including manual retries.
There is no automatic stable gem publication from `next`. Prerelease publication
requires a separately reviewed workflow and version decision.

At release time, synchronize with `main`, freeze the accepted scope, and open a
`next` to `main` PR. Test the resulting merge candidate and use the repository's
permitted merge method. Do not reconstruct the release with a late sequence of
cherry-picks. Record the final source commit and verify the published gem.

Create a maintenance branch before the release cut only if continued support
for the previous line has an explicit owner and policy.
