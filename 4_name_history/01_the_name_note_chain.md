# Context 12: The Name Note Chain

A valid Name Note proves one committed name action. It does not prove that the action extends the accepted history of that name. Without a predecessor rule, a requester could present an old update as current or create an action unrelated to the state it claims to replace.

ZNS links each Name Note to the preceding state by committing to `prev_rcm`. The resulting predecessor links preserve one continuous history for each canonical name.

This document introduces only the predecessor link. It does not decide between competing successors, select the current tip, or define chain-reorganization handling.

---

## 1. The Predecessor Reference

Each Name Note contains an `rcm` derived from its binding tuple. A successor commits to the predecessor's `rcm` as its own `prev_rcm`.

Because `rcm` is derived from the binding tuple, `prev_rcm` identifies a predecessor state value rather than a unique on-chain occurrence. The accepted-history rule must identify the accepted occurrence that realizes that state value.

The predecessor reference is part of the successor's binding tuple. Changing `prev_rcm` changes the successor's expected `psi`, `rcm`, and `cmx`, except with negligible probability under the hash and note-commitment assumptions.

The predecessor and successor must contain the same canonical name. A reference to an `rcm` derived for another name does not extend the history of the successor's name.

The reference establishes a claimed parent-child state relationship. It does not identify a unique occurrence or establish that the referenced state was the accepted tip when the successor was created.

---

## 2. Initial Claim

The first accepted `claim` for a canonical name has no preceding Name Note. Its `prev_rcm` is 32 zero bytes.

The zero value is the initial-history marker. It is not a reference to a Name Note.

A later `claim` must not use the zero marker merely because the name is currently released. Reusing zero would begin a second history and disconnect the new registration from the earlier one.

---

## 3. Live-State Successors

An accepted `claim` or `update` creates a live state. A live state may be followed by:

| Successor action | Required predecessor | Resulting state |
|---|---|---|
| `update` | The `rcm` of the accepted live tip | Live, with the successor's Unified Address |
| `release` | The `rcm` of the accepted live tip | Released, with no bound Unified Address |

An `update` or `release` that references an earlier live note is a stale successor candidate. The predecessor link alone does not determine whether that candidate loses to another successor.

A `claim` must not directly follow a live state. A name must first enter the released state before another registration can claim it.

---

## 4. Claim After Release

A `release` remains part of the name's history. The next accepted `claim` must commit to the `rcm` of the accepted release tip.

The new claim begins a new registration period but not a new history. Its predecessor reference connects the new registration to every earlier claim, update, and release for the name.

The continuous-history rule distinguishes a first claim from a claim after release:

| Claim type | Required `prev_rcm` |
|---|---|
| First accepted claim | 32 zero bytes |
| Accepted claim after release | The accepted release tip's `rcm` |

Resetting `prev_rcm` to zero after release violates the continuous-history rule.

---

## 5. Candidate Links and Accepted History

Zcash consensus can include two Mint self-sends that both reference the same predecessor. Both notes can satisfy the per-note commitment and Mint-origin checks.

The predecessor relation therefore permits competing successor candidates. Before an ordering rule is applied, the observed notes form a predecessor graph rather than a single chain.

The **accepted history** of a name is the sequence obtained after applying the ZNS successor-selection rules. Every accepted note except the first claim has exactly one accepted predecessor. Every accepted note except the current tip has at most one accepted successor.

The successor-selection rules are defined in [`03_successor_selection.md`](03_successor_selection.md). Until those rules are applied, a predecessor reference proves continuity with a candidate predecessor but not membership in the accepted history.

---

## 6. Publication Retries

The Mint may retry publication by rebroadcasting the same signed transaction. Rebroadcasting does not create another Name Note occurrence.

The Mint must not create two transactions that can both publish the same authorized Name Note operation. It may construct a replacement only after the earlier transaction can no longer enter the canonical chain.

This rule makes publication retry an operation on transaction delivery rather than a second state transition. The Name Note commitment does not enforce this rule; conformity depends on the Mint policy and its attested implementation.

---

## 7. Resolver Construction

A Resolver recovers each Name Note with the public full viewing key and recomputes its `rcm` from the binding tuple. It indexes each candidate by canonical name, derived `rcm`, and disclosed `prev_rcm`.

For a non-initial candidate, the Resolver searches the same name's candidate set for a note whose derived `rcm` equals the candidate's `prev_rcm`. A match supplies a candidate predecessor.

The equality check does not prove that the predecessor was accepted, that the successor was first, or that no competing child exists. Those conclusions require the successor-selection and chain-ordering rules.

---

## 8. Consequences and Non-Guarantees

The predecessor rule has these consequences:

- the first claim uses the zero predecessor marker;
- an update or release references the accepted live tip;
- a claim after release references the accepted release tip;
- every registration period remains connected to one continuous name history; and
- a verifier can reject a successor whose disclosed predecessor does not match the required accepted state after that state has been determined.

The predecessor link does not guarantee:

- that the referenced note was accepted;
- that the successor is the first child of its predecessor;
- that a competing successor does not exist;
- that the candidate belongs to the canonical Zcash chain;
- that the candidate is sufficiently final;
- that a Resolver disclosed the latest candidate; or
- that the Mint followed the single-publication rule.

---

## 9. Implementation Conflict

The current `zns-verify` predecessor helper resets `prev_rcm` to zero for a claim after release. That behavior creates a disconnected history.

The implementation must instead require a claim after release to reference the release tip's `rcm` before it conforms to the intended ZNS history rule.

---

## 10. Unresolved Decisions

The protocol author must still decide:

1. Which chain-finality condition permits an accepted candidate to be reported as final.
2. Which condition proves that a transaction being replaced can no longer enter the canonical chain.
3. How a Resolver proves that a reported tip has no later accepted successor.

Until current-state and finality rules are fixed, the predecessor construction and successor-selection rule establish accepted history but not a final or sufficiently current resolution result.

---

## 11. Sources and Status

The `prev_rcm` commitment construction is defined in [`../3_shielded_names/02_the_name_note.md`](../3_shielded_names/02_the_name_note.md). The Mint-origin requirement is defined in [`../3_shielded_names/03_the_mint_self_send.md`](../3_shielded_names/03_the_mint_self_send.md).

The first-claim zero marker, continuous history across release, action-transition restrictions, single-publication rule, and successor-selection rule are decisions of the protocol author. Finality and proof of resolution freshness remain open.
