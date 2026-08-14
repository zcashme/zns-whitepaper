# Context 13: The Canonical Name Note Log

A Resolver can observe Name Notes in competing Zcash branches. A block height alone does not identify which branch supplies ZNS state. If a Resolver combines Name Notes from different branches, its name history does not correspond to any chain accepted by Zcash consensus.

The **canonical Name Note log** is the ordered sequence of Name Note occurrences in the current best valid chain selected by the Resolver's Zcash full node.

This document introduces only chain membership, occurrence order, and reorganization handling for that log. It does not select an accepted successor, select the current tip of a name, or define a finality threshold.

---

## 1. Chain Selection

A Resolver must obtain chain selection from a Zcash full node that validates Zcash consensus. The Resolver must not implement a separate ZNS chain-choice rule.

Only blocks in that node's current best valid chain contribute occurrences to the canonical Name Note log. A Name Note in a side branch is not a member of the log and must not affect ZNS state.

Chain length or block height alone is not a sufficient membership test. Two branches can contain blocks at the same height, and the full node can replace one valid branch with another under Zcash consensus.

Different Resolvers can temporarily derive different logs if their full nodes select different best chains. Their logs converge when their full nodes converge on the same chain and they apply the same ZNS rules.

---

## 2. Name Note Occurrences

A **Name Note occurrence** is a Name Note candidate together with its position in the current best valid chain.

The position consists of:

1. the containing block's position in the chain;
2. the containing transaction's position in that block; and
3. the containing Orchard action's position in that transaction.

The same signed transaction can be transmitted more than once without creating more than one occurrence. An occurrence exists only at the position where the transaction is included in the current best valid chain.

A transaction removed from that chain has no canonical occurrence unless the same transaction is later included in the current best valid chain.

---

## 3. Deterministic Order

A Resolver processes canonical Name Note occurrences in this order:

1. earlier blocks before later blocks;
2. earlier transaction positions before later transaction positions within one block; and
3. earlier Orchard action positions before later Orchard action positions within one transaction.

These positions are determined by the serialized block and transaction data accepted by the Zcash full node. Arrival time, discovery time, transaction fee, and the order in which peers announced candidates must not affect processing order.

This order is total for Name Note occurrences in one chain. It orders competing successor candidates but does not determine which candidate is an accepted successor. Successor selection over this ordered log is defined in [`03_successor_selection.md`](03_successor_selection.md).

---

## 4. Chain Reorganizations

The current best valid chain can change after a Resolver has processed its tip. Such a change replaces a suffix of the old chain with a suffix of the new chain.

When the full node changes its best chain, the Resolver must:

1. identify the common ancestor of the old and new chains;
2. remove occurrences from disconnected blocks in reverse processing order;
3. reverse every ZNS state change derived from those occurrences; and
4. process occurrences from replacement blocks in forward processing order.

The rollback must restore the Resolver state that existed immediately after the common ancestor. This includes the Mint-controlled unspent-note set used by the self-send rule and every Name Note candidate index derived from disconnected blocks.

A disconnected Name Note must not remain an accepted history element, predecessor candidate, or current binding merely because the Resolver accepted it before the reorganization.

A replacement branch can contain the same transaction, a different Name Note for the same name, or no corresponding Name Note. The Resolver derives the replacement state only from occurrences in the new current best valid chain.

---

## 5. Ordering Boundary

Membership in the canonical Name Note log establishes only that a Name Note occurrence is present in the chain currently selected by Zcash consensus.

Its position establishes only its order relative to other canonical occurrences.

Neither property establishes:

- that the occurrence satisfies the Name Note commitment rule;
- that the occurrence satisfies the Mint self-send rule;
- that its predecessor is the accepted tip for its name;
- that it wins against another successor candidate;
- that it is the current binding for the name; or
- that its containing block will remain in the best chain.

Those conclusions require the per-note, Mint-origin, predecessor, successor-selection, and finality rules applicable to the occurrence.

---

## 6. Resolver Requirements

A conforming Resolver must produce the same ordered Name Note occurrences as another conforming Resolver when both are given the same current best valid chain, activation point, Mint account parameters, and protocol rules.

The Resolver must preserve enough undo information or reproducible prior state to remove every effect of disconnected blocks. Rebuilding all ZNS state from the activation point is conforming if it produces the same result.

The Resolver must not report a disconnected occurrence as part of the canonical Name Note log. A user interface may retain it as non-canonical diagnostic history only if it is identified as disconnected and excluded from resolution.

---

## 7. Unresolved Decisions

The protocol author must still decide:

1. Whether resolution waits for a confirmation depth or another finality condition before reporting a state transition.
2. How a Resolver proves that a reported tip has no later accepted successor.
3. Which ZNS activation point and protocol-version schedule apply while scanning the chain.

The canonical Name Note log and successor-selection rule determine accepted history for a fixed best chain and rule set. They do not determine whether its tip is final or sufficiently current for a client.

---

## 8. Relationship to Earlier Contexts

The Name Note construction is defined in [`../3_shielded_names/02_the_name_note.md`](../3_shielded_names/02_the_name_note.md). The Mint self-send rule is defined in [`../3_shielded_names/03_the_mint_self_send.md`](../3_shielded_names/03_the_mint_self_send.md). The predecessor relation is defined in [`01_the_name_note_chain.md`](01_the_name_note_chain.md).

This context supplies the chain-membership and ordering rules that those checks require. It does not change their cryptographic or lifecycle requirements.
