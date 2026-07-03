# Context: Naming System — Index & Core Primitives

This document is the index for a collection of context documents that build the shared understanding for a naming system whitepaper — specifically, the Zcash Name Service (ZNS). It is not the whitepaper itself. It defines the core primitives and then points to the numbered documents that develop each topic in depth.

---

## 0. Document Index

The context documents are organized in a logical reading order: **Problem → Requirements → Mechanism → Threats**.

| # | Document | Topic | Key Question |
|---|---|---|---|
| 01 | [`01_zookos_triangle.md`](01_zookos_triangle.md) | Zooko's Triangle | Why is naming hard? What is the central trilemma? |
| 02 | [`02_namespace_properties.md`](02_namespace_properties.md) | Namespace Properties | What must a namespace satisfy to function at global scale? |
| 03 | [`03_consensus.md`](03_consensus.md) | Consensus: Genesis, Lifecycle, Governance | How does a namespace come into being, persist through time, and adapt? |
| 04 | [`04_attacker_model.md`](04_attacker_model.md) | Attacker Models & Attack Surface | What can go wrong, who attacks, and how? |

### Reading Order & Dependencies

```
                    ┌──────────────────────┐
                    │  Core Primitives (§1) │
                    │  What is a naming     │
                    │  system? (this doc)   │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │  01: Zooko's Triangle │
                    │  The motivating       │
                    │  trilemma             │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │  02: Namespace        │
                    │  Properties           │
                    │  What must be true    │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │  03: Consensus        │
                    │  How it works over    │
                    │  time                 │
                    └──────────┬───────────┘
                               │
                               ▼
                    ┌──────────────────────┐
                    │  04: Attacker Model   │
                    │  What threatens it    │
                    └──────────────────────┘
```

Each document is self-contained but builds on the ones before it. Zooko's Triangle frames the problem; Namespace Properties defines the requirements; Consensus explains the mechanism; the Attacker Model enumerates the threats.

---

## 1. What is a Name System?

A name system is a mapping from human-readable identifiers to machine-readable identifiers.

You have a string that a human can remember, type, and recognize — and the system tells you what that string points to. The pointed-to thing could be an IP address (DNS), an Ethereum address (ENS), a content hash, or a cryptocurrency address.

The value of this mapping is **stability**: the human-readable name stays the same even when the underlying address changes. You shouldn't have to tell everyone your new address when you rotate keys or switch wallets — you just update what the name points to.

A name system has three functional components, regardless of implementation:

1. **Registration** — the process by which someone acquires a name and binds it to an address
2. **Resolution** — the process by which someone looks up a name and gets back an address
3. **Mutation** — the process by which the owner of a name changes what it points to (or transfers/sells it)

Every naming system in history has these three. The question is how each is implemented, who controls them, and what trust is required.

---

## 2. What is a Namespace?

A namespace is **the bounded universe of names that can exist**, together with the rules that govern them.

A name system *uses* a namespace. The namespace defines what names are possible; the name system defines how names within that namespace are registered, resolved, and mutated.

The namespace is the *territory*; the name system is the *machinery* for staking claims on that territory.

### 2.1 Properties of a Namespace

A namespace is defined by four properties:

#### Syntax — What is a valid name?

The rules for what strings are allowed:
- Character set (ASCII only? Unicode? `[a-z0-9]`?)
- Length constraints (minimum, maximum)
- Structure (can names contain dots? are they hierarchical?)
- Normalization (is `Alice` the same as `alice`?)

Examples:
- DNS: hierarchical dotted names (`blog.example.com`), labels up to 63 characters each
- ENS: same structure as DNS but with Unicode normalization (UTS46), case-folded
- Example (flat namespace): `[a-z0-9]{1,62}` — lowercase alphanumeric, no hierarchy

#### Uniqueness — Can two names point to different things?

Within a namespace, **a given name resolves to exactly one target at any point in time.** If `alice` could mean two different addresses depending on who you asked, it wouldn't be a useful namespace — it would be ambiguity.

Uniqueness is what creates scarcity. There are infinitely many strings, but within a namespace, each one can only be claimed once. That scarcity is what gives names value.

#### Allocation — Who gets a name when two people want it?

When a name is unclaimed, anyone might want it. The allocation rule determines who wins:

| Rule | Description | Tradeoff |
|---|---|---|
| First-come-first-served | Whoever registers first gets it | Simple, but rewards speed and squatting |
| Auction | Highest bidder wins | Market-based, but favors wealth |
| Pricing tiers | Fixed cost based on a property (e.g., name length) | Predictable, but doesn't fully prevent squatting |
| Invitation/permission | Central authority decides | Accurate but centralized |

Pricing tiers (shorter names cost more) layered on top of first-come-first-served is one approach — you can be first, but you have to pay the price.

#### Scope — Is the namespace global or local?

- **Global** — `alice` means the same thing to everyone, everywhere. Requires consensus on namespace state.
- **Local** — `alice` means different things depending on context (your personal address book, your org's internal directory). No global consensus needed.

A global namespace is more useful but much harder to build — every participant must agree on the current state of all name registrations.

### 2.2 The Collision Problem

The fundamental tension in any namespace is **collision**: two parties want the same name.

In an infinite namespace (any valid string is claimable), collisions are resolved by the allocation rule — typically, whoever acts first under the rules wins. The loser must pick a different name.

This creates a secondary problem: **squatting**. If registration is cheap or free, an attacker can register thousands of names they don't intend to use, purely to resell them or block others. This degrades the usefulness of the namespace.

Pricing is the standard solution. By making names costly proportional to their desirability (shorter names are more desirable → cost more), you raise the barrier to mass squatting. But you also raise the barrier for legitimate users. This is an inherent tradeoff in namespace design — there is no solution, only a chosen balance point.

### 2.3 Flat vs. Hierarchical Namespaces

**Flat** — all names exist at one level. `alice`, `bob`, `charlie`. No parent-child relationships.

- Every collision is global — two people wanting `alice` must fight over the single global slot
- Delegation is impossible — you can't let someone manage a subset of names without trusting them with the whole namespace
- The namespace is one undifferentiated commons

**Hierarchical** — names form a tree. `alice`, `alice.pay`, `alice.pay.monthly`. Each node can have children, and the owner of a node controls its subtree.

- Delegation — the owner of `alice` can create unlimited subnames without asking anyone
- Partitioning — disputes are localized. Two organizations can both have `members` under different parent names
- Organic growth — the namespace expands from the root outward

DNS and ENS are hierarchical. A flat namespace — a single TLD with all names as direct children — is simpler to implement, but every name collision is a global dispute.

### 2.4 What Makes a Namespace "Real"?

A namespace becomes real — as in, it actually functions — when there is **global consensus on its state.** Everyone must agree on:
- Which names are claimed and by whom
- What each name currently points to
- The history of changes to each name

Without consensus, you have a *proposed* namespace. With consensus, you have an *enforced* one. The question for any namespace design is: **what is the consensus mechanism?**

DNS uses a hierarchy of authoritative servers backed by social/legal governance. ENS uses Ethereum smart contract state (the chain IS the consensus). A naming system on a blockchain without smart contracts must derive consensus from a different mechanism.

---

## 3. What Makes Naming Hard? — Zooko's Triangle

The foundational tension in naming system design is **Zooko's Triangle**: a name system can achieve at most two of {secure, decentralized, human-meaningful}. Squaring the triangle — achieving all three — is the central design challenge. Blockchains introduced a substrate (computation-based consensus) that can satisfy all three, which is how ENS squares it on Ethereum. But Zcash lacks smart contracts, so the ENS approach is not directly available.

➡️ **See Document 01:** [`01_zookos_triangle.md`](01_zookos_triangle.md) — Full treatment of the trilemma, why each pair is compatible, why the triple is hard, and how blockchains reframe the problem.

---

## 4. What Can Go Wrong? — The Attacker Model

For a name system attached to a payment network, getting the mapping wrong means **money goes to the wrong person.** The attack surface spans data storage, communication channels, admin interfaces, delegation boundaries, namespace collisions, infrastructure config, and environment variables. Attacker profiles range from off-path network adversaries to nation-state actors to the operator themselves.

➡️ **See Document 04:** [`04_attacker_model.md`](04_attacker_model.md) — Full attack surface analysis, attacker models, real-world incidents, and defensive measures.

---

## 5. How Does a Namespace Actually Work? — Properties & Consensus

A namespace is not a static mapping — it is a **log of events over time**, interpreted under a fixed rule-set. The fundamental properties (global uniqueness, authenticity, liveness, integrity, persistence, censorship resistance) describe what must be true at any given moment. But the deeper consensus problems are: how the namespace comes into existence (genesis), how it persists through mutations over time (lifecycle), and how the rules themselves evolve (governance).

➡️ **See Document 02:** [`02_namespace_properties.md`](02_namespace_properties.md) — The fundamental properties, the two ends of the mapping (human-readable vs. machine-readable), syntax as a security boundary, and the consensus approaches.

➡️ **See Document 03:** [`03_consensus.md`](03_consensus.md) — Genesis (the bootstrap problem), lifecycle (states & transitions, expiry, transfer, sale), and governance (how rules change, backward compatibility, forks).

---
