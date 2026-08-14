# Context 14: Successor Selection

The canonical Name Note log can contain multiple candidate successors that reference the same predecessor state. The predecessor reference alone cannot select one of them. If Resolvers select different candidates, they derive different histories from the same Zcash chain.

ZNS selects successors by processing candidate-valid Name Note occurrences in canonical-log order. An occurrence is accepted only if it extends the accepted tip for its name at the point where the occurrence is processed.

This document introduces only successor selection. It does not define candidate-validity rules supplied by other contexts, select the current state reported to a client, or define a finality threshold.

---

## 1. Candidate Validity

A **candidate-valid occurrence** is a canonical Name Note occurrence that satisfies every applicable ZNS rule that does not depend on successor selection.

Those rules include the Name Note commitment check and the Mint self-send origin check. A later context can add a candidate-validity condition only by defining an objective check that every conforming Resolver can apply to the same canonical occurrence.

An occurrence that fails a candidate-validity rule cannot become an accepted history element. Its position in the canonical log does not prevent a later candidate-valid occurrence from being accepted.

Candidate validity does not establish that an occurrence extends the accepted tip. That condition is evaluated by the successor-selection rule.

---

## 2. Ordered Selection

A Resolver processes candidate-valid occurrences in the total order defined by the canonical Name Note log.

For each canonical name, the Resolver maintains either no accepted tip or one accepted tip.

If the name has no accepted tip, the Resolver accepts an occurrence only when all of these conditions hold:

1. the action is `claim`; and
2. `prev_rcm` is 32 zero bytes.

If the name has an accepted tip, the Resolver accepts an occurrence only when all of these conditions hold:

1. the occurrence's `prev_rcm` equals the derived `rcm` of the accepted tip;
2. the occurrence and the accepted tip contain the same canonical name; and
3. the action is a permitted transition from the state created by the accepted tip.

When an occurrence is accepted, it becomes the new accepted tip before the next occurrence is processed.

An occurrence that does not satisfy the applicable conditions is not added to accepted history. The Resolver must not reconsider it after processing a later occurrence.

---

## 3. Competing Successors

Suppose two candidate-valid occurrences reference the same accepted predecessor state. The earlier occurrence in canonical-log order is accepted. It replaces that predecessor as the accepted tip.

When the later occurrence is processed, its `prev_rcm` references the former tip rather than the current tip. The later occurrence is therefore a stale sibling and is not accepted.

The rule applies across blocks, across transactions in one block, and across Orchard actions in one transaction. Arrival time, discovery time, transaction fee, and request time do not affect the result.

The first occurrence that references a predecessor does not win if it is not candidate-valid. The winner is the first candidate-valid occurrence that extends that predecessor while the predecessor remains the accepted tip.

---

## 4. Predecessor State and Occurrence Identity

`prev_rcm` identifies a predecessor state value, not a unique on-chain occurrence.

The Resolver resolves that value against its accepted tip when it processes the candidate. If the value equals the accepted tip's derived `rcm`, the accepted tip occurrence supplies the predecessor occurrence for the new history element.

Another canonical occurrence with the same derived `rcm` does not become the predecessor merely because the values match. Only an occurrence already selected into accepted history can supply an accepted predecessor.

This rule makes occurrence identity a consequence of canonical order and accepted-history state. It does not add an occurrence identifier to the Name Note binding tuple.

---

## 5. Out-of-Order and Duplicate Candidates

A candidate that appears before its claimed predecessor is accepted is not deferred. It fails to extend the accepted tip at its own canonical position and remains outside accepted history.

If the same binding tuple occurs more than once, each on-chain position is a distinct occurrence. Accepting one occurrence does not accept the others. A later duplicate is evaluated against the tip that exists at the later occurrence's position.

Rebroadcasting the same signed transaction does not create another occurrence. If the transaction appears once in the current best valid chain, the canonical log contains one occurrence at that position.

---

## 6. Chain Reorganizations

Successor selection is relative to the canonical Name Note log for the current best valid chain. Acceptance under one chain does not make an occurrence permanent.

When a reorganization disconnects occurrences, the Resolver removes their effects as required by the canonical-log rollback rule. It then applies successor selection in forward order over the replacement occurrences.

The replacement log can select a different successor for the same predecessor. Two conforming Resolvers given the same canonical log and the same candidate-validity rules must select the same accepted history.

---

## 7. Acceptance and Finality

An **accepted occurrence** is an occurrence selected into the history derived from the Resolver's current canonical log.

Acceptance does not establish that the containing block will remain in the best chain. A confirmation-depth or finality policy may delay when a Resolver reports an accepted transition, but it must not change which occurrence wins for a fixed canonical log.

The current-state and resolution contexts must distinguish the accepted tip from any separately defined reportable or finalized tip.

---

## 8. Consequences and Non-Guarantees

The successor-selection rule has these consequences:

- each accepted occurrence has at most one accepted successor;
- each name has one accepted history for a fixed canonical log and fixed rule set;
- an accepted successor prevents later siblings from entering accepted history;
- a candidate cannot become accepted because a matching predecessor appears later; and
- a chain reorganization can replace the selected successor.

Successor selection does not establish:

- that a candidate satisfies an undefined or unapplied namespace rule;
- that the Mint followed a policy not verifiable from the canonical log;
- that an accepted occurrence is final;
- that the accepted tip is sufficiently current for a client; or
- that a Resolver supplied complete or correct resolution evidence.

---

## 9. Relationship to Earlier Contexts

The predecessor state value and permitted lifecycle transitions are defined in [`01_the_name_note_chain.md`](01_the_name_note_chain.md). Canonical membership, total occurrence order, and rollback are defined in [`02_the_canonical_name_note_log.md`](02_the_canonical_name_note_log.md).

The statement in Context 08 that the first transaction in a block wins is incomplete. The selected occurrence must be candidate-valid, and the total order also distinguishes different blocks and different Orchard actions within one transaction.

This context fixes first-eligible canonical occurrence as the successor-selection rule. Finality, current-state derivation, and resolution evidence remain separate protocol decisions.
