# Context 15: The Current Name State

Successor selection produces an accepted history for each canonical name. It does not state which binding, if any, that history currently represents. Without one state-derivation rule, Resolvers could agree on the accepted history and still disagree on whether the name resolves.

The **current name state** is the state derived from the accepted tip for a canonical name after a Resolver processes the complete canonical Name Note log available to it.

This document introduces only current-state derivation. It does not define name syntax, claim eligibility, resolution responses, finality, or proof that a Resolver processed the latest canonical log.

---

## 1. State Values

Each canonical name has exactly one of these current states:

| State | Accepted tip | Current Unified Address |
|---|---|---|
| `unclaimed` | None | None |
| `live` | An accepted `claim` or `update` | The `ua` bound by that tip |
| `released` | An accepted `release` | None |

`unclaimed` means that the canonical log contains no occurrence selected into the accepted history of the name.

`live` means that the accepted tip creates a current binding between the canonical name and the tip's Unified Address.

`released` means that the accepted tip removes the preceding live binding while preserving the accepted history and its tip.

A released name is not unclaimed. Its release remains the predecessor required by any later accepted claim.

---

## 2. Accepted Tip

The **accepted tip** of a name is the last accepted occurrence in that name's accepted history.

An accepted occurrence becomes the accepted tip when the successor-selection rule accepts it. Its accepted predecessor ceases to be the tip but remains in accepted history.

A candidate occurrence that is ignored by successor selection does not change the accepted tip or current name state.

The accepted tip is an occurrence in the current canonical Name Note log. Its identity therefore includes its canonical position, even though a successor references its derived `rcm` rather than that position.

---

## 3. State Derivation

A Resolver derives the current state of a canonical name by applying this rule after processing the canonical Name Note log:

1. If the name has no accepted tip, return `unclaimed` with no tip and no Unified Address.
2. If the accepted tip's action is `claim` or `update`, return `live` with that tip and the tip's `ua`.
3. If the accepted tip's action is `release`, return `released` with that tip and no Unified Address.

No other state value or action exists in the Name Note lifecycle defined by the current rule set.

The derivation depends only on the accepted tip. Earlier accepted occurrences explain how the tip was reached but do not override the state created by the tip.

---

## 4. State Transitions

An accepted occurrence changes the current state as follows:

| Prior state | Accepted action | Resulting state | Resulting Unified Address |
|---|---|---|---|
| `unclaimed` | `claim` | `live` | The claim's `ua` |
| `live` | `update` | `live` | The update's `ua` |
| `live` | `release` | `released` | None |
| `released` | `claim` | `live` | The claim's `ua` |

Every other state-and-action pair is ineligible under the predecessor and successor-selection rules. An ineligible occurrence leaves the current state unchanged.

An update replaces the current Unified Address. It does not create a second current binding.

A release removes the current Unified Address. It does not erase the accepted tip or reset the name to its initial state.

A claim after release creates a new live binding and makes that claim the accepted tip. The released tip remains its accepted predecessor.

---

## 5. Reducer State

For each canonical name with an accepted occurrence, a Resolver must retain enough state to identify one accepted tip. The absence of an accepted-history entry for a canonical name represents no accepted tip and therefore the `unclaimed` state.

When the Resolver accepts an occurrence, it replaces the stored tip for that name with the accepted occurrence and derives the state value from the occurrence's action.

When the Resolver ignores an occurrence, it leaves the stored tip and derived state unchanged.

Two conforming Resolvers given the same complete canonical Name Note log and the same candidate-validity rules must derive the same accepted tip, state value, and current Unified Address for every canonical name.

---

## 6. Chain Reorganizations

The current name state is relative to the current canonical Name Note log. It is not permanent merely because its tip was accepted before a chain reorganization.

When a reorganization disconnects an accepted tip, the Resolver must restore the state derived at the common ancestor and process the replacement log in forward order.

The resulting state can have an earlier accepted tip, a different accepted tip, or no accepted tip. It can therefore change among `unclaimed`, `live`, and `released` after a reorganization.

A disconnected occurrence cannot supply the current state unless the same transaction occurs in the replacement canonical log and is accepted at its replacement position.

---

## 7. Consequences and Non-Guarantees

The current-state rule has these consequences:

- every canonical name has one state for a fixed canonical log and fixed rule set;
- only a live name has a current Unified Address;
- an ignored candidate cannot change the state;
- release preserves the continuous accepted history; and
- a chain reorganization can change the current state.

The current-state rule does not establish:

- that a string is a valid canonical name;
- that an otherwise candidate-valid claim satisfied an undefined availability, pricing, or payment rule;
- that the accepted tip is final;
- that a Resolver processed the latest chain available to the client;
- that a returned resolution result contains sufficient evidence; or
- that the Unified Address in a live tip is controlled, reachable, or safe to use.

Those claims require the namespace, authorization, resolution, finality, and evidence rules that govern the applicable occurrence or response.

---

## 8. Relationship to Earlier Contexts

The predecessor relation and permitted lifecycle transitions are defined in [`01_the_name_note_chain.md`](01_the_name_note_chain.md). Canonical membership, total order, and reorganization handling are defined in [`02_the_canonical_name_note_log.md`](02_the_canonical_name_note_log.md). Accepted-history construction and tip replacement are defined in [`03_successor_selection.md`](03_successor_selection.md).

This context projects the accepted tip produced by those rules into one current name state. The resolution contexts will specify how a Resolver maps that state to a response and which chain position and evidence accompany the response.
