# Contributor instructions

## Pull requests

- Before pushing code, run the `thermo-nuclear-code-quality-review` skill and address its findings.
- After submitting a pull request, monitor CI, fix failures, and push the fixes. Once CI is green, ask for review in `#sdk-reviews`, create a thread, and keep follow-up asks in that thread.
- When addressing pull request feedback, push the fix, reply to each comment with what changed, and then resolve the thread.

## Ruby implementation guidelines

- Prefer direct method calls over Ruby reflection (`send`, `__send__`, or `public_send`) for internal SDK plumbing. When an internal method must be callable across components without becoming supported public API, keep the method public for direct dispatch and mark it `@api private`. Keep its RBI and RBS declarations at the same visibility.
