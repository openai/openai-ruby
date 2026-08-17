# Security Policy

## Reporting Security Issues

Please report potential security vulnerabilities through OpenAI's
[coordinated vulnerability disclosure process](https://openai.com/policies/coordinated-vulnerability-disclosure-policy).
For questions about that process, contact disclosure@openai.com.

Do not report suspected vulnerabilities in public GitHub issues, pull requests,
or discussions. Submit only the information needed to reproduce the issue, and
remove API keys, access tokens, private keys, customer data, and sensitive
request/response logs before sharing it through the private disclosure channel.

## Protecting Credentials and Diagnostics

Load API keys from environment variables or an approved secrets manager; never
commit them to source code, examples, tests, fixtures, or generated artifacts.
Redact authorization headers, signed URLs, prompts, model responses, uploaded
files, and other customer data from logs, error reports, and shared diagnostics.

## Responsible Disclosure

Please allow OpenAI a reasonable amount of time to investigate and address the
issue before making information public. Thank you for helping us keep this SDK
and the systems it interacts with secure.
