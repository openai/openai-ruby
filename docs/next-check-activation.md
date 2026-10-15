# Trusted checks on next: activation record

## Proposed protection change

After this evidence and proposal are approved and this PR lands through the normal
next queue, add exactly these two required checks to the existing next ruleset
(25099844), each bound to GitHub Actions (integration ID 15368):

- `Castiron / budget-only change`
- `Castiron / custom-code budget`

Retain the five existing required checks, strict checking, CODEOWNERS and approving
review, MERGE queue settings, CodeQL scanning, deletion/force-push protections,
and all other settings. Do not change main's ruleset, budgets, snapshots,
ownership, release restrictions, or generation targets. Re-read the ruleset
before applying; stop and reconcile if any settings changed since review.

This document records the reviewed proposal; its presence does not activate
repository settings. Record application and read-back verification separately.

## Hosted evidence

Shared checker support landed in #870. Documentation candidates #873 (main)
and #874 (next) were independently approved and merged through normal queues
with full CI green. Temporary probes #875 and #876 were closed unmerged.

Target SHAs below come from the trusted `budget.json` reports; source run and
attempt identities are checked against the publisher logs and Actions run records.
The stale replays retain their original source target for traceability; their
rejection did not produce a freshly validated target or policy identity.

All initial measurements below used trusted main policy
`f0c4dfd8119b7b614439646d8584379b847f7660` with a 4,000-line ceiling.
The original next target was
`1aed60edb78200ae63819c7bb8c03bbcb18289d0`, with verified historical
snapshot `692029346b20529532faf82ddc226cb882962ff2`.

| Case / PR | Candidate / source run:attempt | Target branch / exact SHA | Trusted run | Observed result |
| --- | --- | --- | --- | --- |
| Main PR #873 | `5236d5bcea515718a4b6ceaddeaaad6c7582b211` / [38762377332:1](https://github.com/openai/openai-ruby/actions/runs/38762377332/attempts/1) | `main` / `f0c4dfd8119b7b614439646d8584379b847f7660` | [38762442431](https://github.com/openai/openai-ruby/actions/runs/38762442431) | Both checks pass; 810/4000. |
| Next PR #874 | `f73ea25bbb83955ce5017af98467ff588cb09583` / [38762417578:1](https://github.com/openai/openai-ruby/actions/runs/38762417578/attempts/1) | `next` / `1aed60edb78200ae63819c7bb8c03bbcb18289d0` | [38762470941](https://github.com/openai/openai-ruby/actions/runs/38762470941) | Both pass; 807/4000; next target distinct from main policy. |
| Unviable budget-only decrease (#875) | `4c1e39bb6ec6e4413a912c23f7d4104666499a66` / [38762594408:1](https://github.com/openai/openai-ruby/actions/runs/38762594408/attempts/1) | `next` / `1aed60edb78200ae63819c7bb8c03bbcb18289d0` | [38762647227](https://github.com/openai/openai-ruby/actions/runs/38762647227) | Isolation passes; 807 lines rejected against proposed zero ceiling. Main policy remains 4000. |
| Mixed budget/documentation (#875) | `da082b9ce46ba510d366c854a9b7c4a9372fef41` / [38762876708:1](https://github.com/openai/openai-ruby/actions/runs/38762876708/attempts/1) | `next` / `1aed60edb78200ae63819c7bb8c03bbcb18289d0` | [38762940683](https://github.com/openai/openai-ruby/actions/runs/38762940683) | Isolation fails; budget passes at 807/4000 using trusted main policy. |
| Over-budget generated-owned code (#875) | `00fd67962997e35b22d5d0f20f94ed589f76f7ea` / [38763736864:1](https://github.com/openai/openai-ruby/actions/runs/38763736864/attempts/1) | `next` / `1aed60edb78200ae63819c7bb8c03bbcb18289d0` | [38763829318](https://github.com/openai/openai-ruby/actions/runs/38763829318) | Isolation passes; 4909 lines rejected against unchanged 4000 ceiling. |
| Stale PR head replay (#875) | `4c1e39bb6ec6e4413a912c23f7d4104666499a66` / [38762594408:2](https://github.com/openai/openai-ruby/actions/runs/38762594408/attempts/2) | `next` / `1aed60edb78200ae63819c7bb8c03bbcb18289d0` (original source target; replay rejected before target/policy evaluation) | [38763448871](https://github.com/openai/openai-ruby/actions/runs/38763448871) | No current matching PR; evaluation rejected and old-head status timestamps/URLs unchanged. |
| Fork PR targeting next (#876) | `42f4eb0e44023e02486a89ee1dcc0a345fa384b3` / [38763083531:1](https://github.com/openai/openai-ruby/actions/runs/38763083531/attempts/1) | `next` / `1aed60edb78200ae63819c7bb8c03bbcb18289d0` | [38763143159](https://github.com/openai/openai-ruby/actions/runs/38763143159) | Both pass with next target and main policy. |
| Same fork head retargeted to main (#876) | `42f4eb0e44023e02486a89ee1dcc0a345fa384b3` / [38763325220:1](https://github.com/openai/openai-ruby/actions/runs/38763325220/attempts/1) | `main` / `f0c4dfd8119b7b614439646d8584379b847f7660` | [38763381035](https://github.com/openai/openai-ruby/actions/runs/38763381035) | Fresh evaluation uses main target and policy; both pass. |
| Main merge queue #873 | `9196a24282555fb7312844eb7d792ed589f2ea64` / [38763841966:1](https://github.com/openai/openai-ruby/actions/runs/38763841966/attempts/1) | `main` / `f0c4dfd8119b7b614439646d8584379b847f7660` | [38763862944](https://github.com/openai/openai-ruby/actions/runs/38763862944) | Real membership validated; both pass; full queue CI green; merged. |
| Next merge queue #874 | `686bf32b98ea15135e998648a596ca4141448f07` / [38764318246:1](https://github.com/openai/openai-ruby/actions/runs/38764318246/attempts/1) | `next` / `1aed60edb78200ae63819c7bb8c03bbcb18289d0` | [38764348001](https://github.com/openai/openai-ruby/actions/runs/38764348001) | Real membership validated; both pass; full queue CI green; merged. |
| Main policy SHA moves while next is queued (#874) | `686bf32b98ea15135e998648a596ca4141448f07` / [38764318246:2](https://github.com/openai/openai-ruby/actions/runs/38764318246/attempts/2) | `next` / `1aed60edb78200ae63819c7bb8c03bbcb18289d0` | [38764967191](https://github.com/openai/openai-ruby/actions/runs/38764967191) | Both pass using new main policy SHA `9196a24282555fb7312844eb7d792ed589f2ea64`, same next target; 807/4000. |
| Former queue replay after landing (#874) | `686bf32b98ea15135e998648a596ca4141448f07` / [38764318246:3](https://github.com/openai/openai-ruby/actions/runs/38764318246/attempts/3) | `next` / `1aed60edb78200ae63819c7bb8c03bbcb18289d0` (original source target; replay rejected before target/policy evaluation) | [38765540587](https://github.com/openai/openai-ruby/actions/runs/38765540587) | Rejects missing current queue membership and publishes failure, never stale success. |

The final negative replay intentionally changes the former queue SHA's latest
Castiron statuses to failure after it has merged. Its original green queue
validation is preserved in the linked run history; this is expected rejection
evidence, not a regression in the landed documentation. A new reviewed candidate
must receive its own fresh PR and queue results.

Policy movement here means movement of the trusted main commit. The production
budget amount was preserved; no actual main-budget decrease is claimed.
The existing regression suite separately covers policy-value changes and stale
policy rejection. No required-check activation is implied by these probes alone.

## Application and verification

1. Obtain explicit review of this evidence and exact proposed ruleset addition.
2. Land this record through the normal next review and queue process.
3. Confirm both authoritative statuses passed for this PR and its queue candidate.
4. Re-read next's ruleset and add only the two checks above.
5. Read back the rule, confirm its seven required checks and unchanged protections,
   and confirm main's ruleset is unchanged.
6. Record the reviewer, activation time and verification in the rollout tracker.
