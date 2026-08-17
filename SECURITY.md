# Security Policy

## Reporting a vulnerability

Please report potential security vulnerabilities through OpenAI's
[coordinated vulnerability disclosure process](https://openai.com/policies/coordinated-vulnerability-disclosure-policy).
For questions about that process, contact disclosure@openai.com.

Do not report security vulnerabilities through public GitHub issues, pull requests, or discussions.

## What to include

When reporting a vulnerability, include:

- The affected package or product and version, or the relevant source commit.
- A clear description of the potential impact.
- Sanitized reproduction steps or a minimal proof of concept.
- Any relevant environment details or known mitigations.

Do not include live credentials, API keys, customer data, or unredacted sensitive logs.

For this repository, identify the `openai` gem version, Ruby version, operating
system, and any relevant provider or transport. Redact authorization headers,
access tokens, private keys, signed URLs, prompts, model responses, uploaded
files, and sensitive request/response bodies from logs, error reports, and
shared diagnostics.

Load API keys from environment variables or an approved secrets manager; never
commit them to source code, examples, tests, fixtures, or generated artifacts.

This policy applies to the source code in this repository and official releases
of the `openai` Ruby gem. See [VERSIONING.md](VERSIONING.md) for supported Ruby
versions and release policy. Older release lines remain available without
guaranteed security fixes or backports.

## Coordinated disclosure

Please give the maintainers a reasonable opportunity to investigate and address the issue before public disclosure.

Thank you for helping us keep this SDK and the systems it interacts with secure.
