# Union characterization corpus

This corpus records current behavior; it does not declare every selected class to be semantically correct.

- `discriminator_evidence` is an explicit fixture fact: missing, known and unique, known but duplicated, or explicitly unknown.
- `exact_candidates` lists every generated variant whose independent coercion has no `no` or `maybe` evidence.
- `structural_candidates` lists every generated variant whose independent coercion has no `no` evidence.
- `best_ranked_fallbacks` applies the current `Union#coerce` fallback score only when no exact candidate exists.
- `compatibility_selected` is the class selected by the current runtime. It is a compatibility observation, not an endorsement.
- `serialized_body` proves that accepted request shorthand and unknown fields retain their wire representation regardless of materialization.
- `public_boundary` records context-specific behavior when it differs from the shared union. It is currently available for the Realtime connection introduced after v0.80.0.

The fixtures deliberately pair wire-string hashes with idiomatic Ruby symbol hashes. Their different candidate sets are part of the observed contract. Focused tests retain the compatibility-sensitive selections and serialized bodies without checking in full generated output snapshots.

Run `scripts/union-characterization` to print every current observation using this checkout's `lib`. Run `scripts/union-characterization-differential` under the repository Ruby to generate observations from temporary v0.78.0 and v0.80.0 tag archives, verify that those published releases agree, and print their differential from the current checkout. The differential reports any unavailable release tags together before attempting to archive them; fetch the tags when working from a shallow or no-tags checkout.

The two published baselines agree for this corpus. Current `main` retains the request behavior and serialized bodies, but newer generated Responses/Beta variants change which known event wins structural fallback for an explicit unknown stream tag. Current Realtime adds a public connection boundary that returns `UnknownServerEvent`, even though direct shared-union coercion can still select a known event for symbolized input.
