# Versioning policy

The OpenAI Ruby SDK follows [Semantic Versioning](https://semver.org/). This
policy covers the public gem API, supported Ruby runtimes, dependencies, and
type definitions.

## Gem releases

| Change | While the gem is `0.x` | After `1.0` |
| --- | --- | --- |
| Backwards-compatible bug or security fix | Patch | Patch |
| Additive endpoint, optional argument, response field, or public type | Minor | Minor |
| Higher minimum Ruby version | Minor | Major by default |
| Other user-visible breaking change | Minor, with migration guidance | Major |

Breaking changes include removing or renaming public behavior and incompatible
changes to required arguments, return types, exception families,
serialization, retries, or authentication. A dependency upgrade follows the
same rule: its version number does not determine the SDK release; its effect on
SDK users does.

Corrections to non-runtime RBI or RBS definitions are normally patches. Use a
minor release when a type-only change is likely to create substantial new type
errors for users.

Security may require an accelerated breaking release, but an incompatible
change is never shipped as a routine patch.

## Ruby support

The SDK supports released CRuby versions that are in Ruby Core's normal or
security maintenance phases. An EOL Ruby may receive up to six months of grace
only through an explicit SDK and Security exception. See [Ruby maintenance
branches](https://www.ruby-lang.org/en/downloads/branches/) for the upstream
lifecycle.

The current supported versions are Ruby 3.3, 3.4, and 4.0. The authoritative
minimum is `required_ruby_version` in `openai.gemspec`.

When the minimum Ruby version changes:

1. Ship the change in the release category defined above, never in a patch.
2. Name the final compatible gem release line in the README and release notes.
3. Keep old releases available, without promising fixes or backports.
4. Test every supported Ruby minor and verify the built gem rejects the old
   runtime while installing on the new minimum.

CRuby is the supported implementation and its CI jobs are blocking. JRuby and
TruffleRuby are best effort until each has an explicitly owned compatibility
matrix and support decision.

## Dependencies

- Keep the runtime dependency graph small and framework-neutral.
- Declare standard-library components that are distributed as independent gems.
- Prefer minimum or open-ended requirements. Add upper bounds only for known
  incompatibilities.
- Test the minimum and latest resolvable dependency sets when practical.
- Keep framework and transport integrations optional or in separate gems when
  adding them to the core gem would expand its compatibility surface.

## Maintaining the policy

The Ruby version settings serve different purposes:

- `openai.gemspec` declares the customer support floor.
- `.rubocop.yml` targets the syntax of the oldest supported Ruby minor.
- The CI matrix tests every supported Ruby minor.
- `.ruby-version` pins the latest patch of the newest supported Ruby for local
  development; it is not the customer support floor.
- Routine lint, package, and release jobs use the newest supported Ruby minor.

After each annual Ruby release, add the new minor to CI and move routine
development jobs to it once the suite is green. Around each March/April Ruby
EOL window, explicitly decide whether to raise the customer floor. A floor
increase must update the gemspec, README, RuboCop target, CI matrix, and release
notes together; automation must not make that decision by itself.
