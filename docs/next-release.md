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
3. Never hand-edit generated files on either branch. Change the authoritative
   schema, generation configuration, or compiler and regenerate. Keep handwritten
   behavior in separately owned helpers and extension points.
4. Verify generation and promotion can explicitly target `next`. A candidate
   branch name alone is not a release-target selector. Until target support is
   validated, do not promote breaking generated changes through the stable path.

## Generated-file ownership

Regeneration replaces generated files and removes retired paths. It does not
carry handwritten edits forward. Code review and the ordinary SDK checks enforce
the ownership rule; the customization budget and its workflows are retired.
Preserve independently reviewed source/configuration pins for each release target.

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
  compatibility tests or generated-file ownership.

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
