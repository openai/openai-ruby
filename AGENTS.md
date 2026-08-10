# Contributor instructions

## Ruby implementation guidelines

- Prefer direct method calls over Ruby reflection (`send`, `__send__`, or `public_send`) for internal SDK plumbing. When an internal method must be callable across components without becoming supported public API, keep the method public for direct dispatch and mark it `@api private`. Keep its RBI and RBS declarations at the same visibility.
