# Context 03: Consensus

A namespace is valuable only when there is global consensus on its state. There are three consensus problems that are less visible and harder:

1. **Consensus on the origin.** Before there is a state to agree on, there must be agreement on when the namespace began and what counts as its first records. This is the **genesis** problem.

2. **Consensus on the trajectory.** A name is not a mapping; it is a sequence of mappings over time. Consensus must hold not just on the current binding but on the entire ordered history of bindings — the **lifecycle** of each name, and the authorization and ordering of every transition.

3. **Consensus on the rules.** The rules that determine what a valid name is, who owns it, and what its bindings mean are themselves subject to change. Consensus on the *state* is meaningless without consensus on the *rule-set* that interprets the state, and that rule-set must survive contact with reality — which is the **governance** problem.

These three are the consensus problems that are easy to overlook, because the static framing ("a namespace is a mapping") hides them. The static framing assumes the namespace already exists, the names already have owners, and the rules are already fixed. None of those assumptions is given. Each must be bootstrapped, maintained, and evolved — and each is a consensus problem.

This document is not about ZNS. It is about the underlying mechanics of how any global namespace comes into existence, persists through time, and adapts without breaking.

---

# Part I — Genesis: Consensus on the Origin

## 1. The Empty Namespace Problem

A namespace does not exist until there is consensus on its state. But at the moment of creation, the state is *empty* — no names, no owners, no mappings. An empty namespace is trivially consistent: everyone agrees it contains nothing. The problem is that an empty namespace is also useless. Usefulness begins only when the first name is claimed, and the moment the first name is claimed, the namespace has a state that must be agreed upon, protected, and made durable.

This transition — from empty-and-consistent to populated-and-consistent — is **genesis.** It is the bootstrap.

Genesis is harder than it looks because the consensus mechanism that will protect the namespace once it is populated must already be in place at the moment of the first registration. You cannot build the lock after the door is used. Whoever registers the first name must trust that the mechanism recording their registration is the one everyone else will later treat as canonical. If two incompatible mechanisms claim to be the namespace at the same time, there are two namespaces — and the problem of which one wins is a social problem, not a technical one.

### 1.1 The Three Things That Must Exist Before the First Name

Before a single name can be registered, three things must already be settled:

1. **The interpretation rules.** What strings count as valid names? What is the allocation rule? What does a registration record look like? These rules must be fixed and public, because every later participant must apply the same rules to the same events to compute the same state. Changing the rules after the first name is registered is not "upgrading the namespace" — it is forking it (see Part III).

2. **The append medium.** Registrations are events; events must be recorded somewhere with ordering guarantees. DNS uses zone files on authoritative servers. ENS uses Ethereum blocks. ZNS uses Zcash notes. Whatever the medium, it must already be running and already have its consensus secured at the moment of the first registration — because the first registration is itself an event in that medium.

3. **The first reader.** A registration that no one can read is not a registration. There must be a deterministic scanner, a resolver, or an indexer that can take the event log and produce the current namespace state. The reader's logic *is* part of the interpretation rules — if the reader is buggy or non-deterministic, the namespace fragments even if the underlying log is fine.

The bootstrap, then, is not a single act. It is a coordination among: a fixed set of rules, a running append medium, and a working reader. If any one of the three is not ready at the moment the first name is claimed, the namespace either fails to come into existence or comes into existence in a form that will later have to be retroactively declared canonical — which is a kind of fork.

## 2. The Bootstrap Trust Problem

Genesis creates a peculiar trust situation. At the moment of the first registration, there are no prior registrants — there is no established history, no track record, no "this is how we've always done it." The first registrant must trust:

- That the rule-set they register under is the one the community will later adopt.
- That the append medium they register into is the one the community will later treat as canonical.
- That the reader that interprets their registration is the one everyone will later run.

If any of these is wrong, the first registrant has a name in a namespace that no one else recognizes. They have paid a fee, committed a transaction, staked their identity — for nothing.

This is the **bootstrap trust problem**: the early adopters of a namespace take on risk that late adopters do not. Late adopters can verify that the namespace is functioning, that the rules are stable, that the reader is widely run. Early adopters cannot — they are the ones establishing that the namespace functions at all.

### 2.1 How Systems Solve It

| Mechanism | How it works | Tradeoff |
|---|---|---|
| **Authority commitment** | A recognized authority (a foundation, a core team) publicly commits to a rule-set and a medium before launch. The commitment is the trust anchor: early adopters trust the authority, late adopters trust the now-established namespace. | Centralized bootstrap. The authority is a single point of failure for the genesis. |
| **Pre-publication of rules** | The rules, the medium, and the reader are all published, audited, and discussed before launch. The bootstrap is "open" — anyone can verify the design before the first name. | Still requires trusting that the published rules are the ones that will actually be enforced. |
| **On-chain commitment** | The rule-set itself is encoded on-chain (as a smart contract on ENS, or as a known interpretation of fields on Zcash). The chain's consensus guarantees the rules cannot be silently changed. | Requires a substrate that supports this. Not all chains do. |
| **Multiple independent readers** | Several independent teams implement the reader from the same specification. If their outputs agree on the same log, that is evidence the rules are unambiguous and the namespace is real. | Doesn't solve the rule-set trust problem; only the reader-trust problem. |
| **Brand and reputation** | The namespace is launched by an entity whose reputation makes defection costly. The entity cannot credibly commit cryptographically, but can credibly commit reputationally. | Weak. Reputation is fungible and defection can be obfuscated. |

No system fully solves the bootstrap trust problem. ENS relied on a combination of authority commitment (the ENS team and the Ethereum Foundation) and on-chain commitment (the smart contract itself). DNS relied on authority commitment (the IETF and ICANN process). The honest answer is that **every namespace begins with a social act**, and the role of the technical design is to make that social act as verifiable and as hard to defect from as possible.

## 3. The Genesis Event

Within the bootstrap, there is often a single **genesis event** — the moment that separates "before the namespace" from "after the namespace." It is the line in the log before which no name registrations are recognized and after which they are.

The genesis event is not necessarily the first registration. It can be:

- **A marker transaction.** A specific on-chain transaction whose presence defines the start of the namespace. Registrations before it are ignored; registrations after it are processed. This is how some blockchain-based systems define their genesis block.
- **A deployment transaction.** A transaction that installs the smart contract (ENS-style) or commits the rule-set. The namespace begins with the deployment, not the first registration.
- **A timestamp.** The namespace begins at a published block height or wall-clock time. Registrations before the timestamp are not part of the namespace. This is fragile — it requires every reader to agree on the timestamp and on which events fall before or after it.
- **The first valid registration itself.** There is no separate genesis event; the namespace begins with the first registration under the published rules. This is the most decentralized option but the hardest to verify, because "the first registration" is a claim about the log that must be checked by scanning the entire log from the beginning.

The choice of genesis event matters because it determines what counts as part of the namespace. If the genesis event is ambiguous — if two readers disagree on whether a given early transaction is part of the namespace or not — the namespace has forked before its first name is even registered.

### 3.1 The Cold-Start Problem

A namespace with one name is not a namespace in any meaningful sense — it is a single record. A namespace becomes useful only when enough names exist that resolving a name is a thing people *do*. This is the **cold-start problem**: the namespace is more valuable to each new registrant the more registrants already exist, which means the early registrants get less value than the late ones.

This is a network effect, and network effects have a standard set of solutions:

- **Subsidize early registration.** Make early names free or cheap to attract the first cohort. The risk is that this rewards squatting, not use — early registrants claim names to resell, not to identify themselves.
- **Seed with known names.** Pre-register a set of well-known identities (foundations, wallets, exchanges, public figures) so that resolving the namespace is useful from day one. The risk is that this is a centralized act — someone decides who the seed names are.
- **Tie to an existing identity system.** Bootstrap the namespace off an existing trusted registry (Twitter handles, GitHub usernames, DNS domains). The risk is inheriting the trust model of that other system.
- **Wait.** Do nothing special; let the namespace grow organically as people find reasons to register. The risk is that it never grows, or grows too slowly to matter.

There is no clean solution. Every namespace that succeeded used some combination of these, and every namespace that succeeded also got lucky — the cold-start problem is genuinely hard, and good design only improves the odds.

## 4. The Genesis Records Problem

Once names are being registered, the namespace accumulates records. The set of records is the namespace's state. The first records are special because they are the ones against which all later records are compared — they are the namespace's *origin*.

This creates a record-keeping obligation that does not exist for later records:

- **The first records must be unambiguously attributable to the genesis event.** A later reader scanning the log from the beginning must be able to tell, for each early record, whether it is part of the namespace or a stray transaction that happens to look like one. If the genesis event is a marker transaction, every record after it is in. If the genesis event is "the first valid registration," the reader must scan for the first valid registration and treat everything before it as noise — which requires the reader to know what "valid" means at the genesis, which requires the rule-set to have been fixed at the genesis.

- **The first records must be interpretable under the genesis rule-set, not the current rule-set.** If the rules have been upgraded since genesis (see Part III), a reader running the current rules might misinterpret an early record. The namespace's history is not just a log of events; it is a log of events paired with the rule-set under which each event was valid. Readers must process the log with the rules in force at the time of each event, or the early state will be computed wrong.

- **The first records are the most replicated and the most scrutinized.** Every reader, every indexer, every auditor starts at the beginning. A corruption in an early record propagates to every later computation that depends on it. This is why genesis records are often the most heavily verified part of the entire namespace history — and why a discovered error in them is the most damaging, because it calls the entire namespace into question.

The practical implication: **the bootstrap is not finished when the first name is registered. It is finished when the first records have been independently verified by enough parties that the namespace's origin is no longer in doubt.** Until then, the namespace is provisional. After then, it is established — and the bootstrap is over.

## 5. What Can Go Wrong at Genesis

| Failure | Description | Consequence |
|---|---|---|
| **Ambiguous genesis event** | Two readers disagree on when the namespace began. | The namespace forks at the origin; there are two namespaces that share early history and diverge later. |
| **Rule-set not actually fixed** | The published rules are discovered to be ambiguous, and the first registrations are interpreted differently by different readers. | The first cohort of names is contested; resolving this requires a social decision, which is a kind of fork. |
| **Bootstrap trust defection** | The entity that committed to the namespace at genesis changes the rules, the medium, or the reader after the first names are registered. | Early registrants are stranded; the namespace either dies or forks into "the one the entity controls" and "the one the community kept." |
| **Cold-start failure** | Too few names are registered for the namespace to be useful; new registrants see an empty namespace and don't bother. | The namespace never achieves escape velocity and is abandoned. The early records remain on-chain but are meaningless. |
| **Genesis squatting** | The first registrant (or the first cohort) claims all the valuable short names. The namespace is captured at the moment of its creation. | The namespace is technically functional but socially captured. Later users find all the good names taken and the namespace useless to them. |
| **Append medium consensus failure** | The medium the namespace is being recorded into suffers a reorganization or a fork around the genesis event itself. | The namespace's origin is lost or contested. Recovery requires re-establishing the genesis event on the surviving chain, which is a social act. |

The thread through all of these is the same: **genesis is the moment at which the namespace is most fragile, because it has the least history and the least redundancy.** Every later property of the namespace — its consensus, its integrity, its persistence — is built on the assumption that the genesis was clean. If the genesis is dirty, nothing built on top of it is sound.

---

# Part II — Lifecycle: Consensus on the Trajectory

## 6. Why the Lifecycle Is a Consensus Problem

A namespace is often described as a mapping — name → target. But a mapping is a static data structure, and a name is not static. Over its lifetime a name is bound, rebound, moved between owners, possibly transferred, possibly sold, possibly expired, possibly recovered. The current mapping is just the latest entry in a log; the log is the name.

This reframes what consensus must cover. Consensus is not just on the current state — it is on the *entire ordered history* of the state. Two resolvers that agree on the current mapping but disagree on how that mapping came to be have not actually agreed; they have coincidentally converged, and any future divergence will reveal that they were never running the same namespace.

Consensus on the trajectory requires consensus on:

- **The set of mutations that have been applied to each name.** Not just the latest, but all of them.
- **The order in which they were applied.** If Alice updates to address A then to address B, and Bob sees the order reversed, Bob computes a different current state.
- **The authorization of each mutation.** Every mutation must be attributable to a legitimate authorizer, and all observers must agree on the authorization rule that was in force at the time.

The lifecycle — the set of states a name can be in and the transitions between them — is the structure on which this consensus operates. Designing the lifecycle is designing the grammar of mutations that consensus must order and verify.

## 7. Why the Lifecycle Matters

The lifecycle matters because it determines:

- **What an owner can do.** Can they update the target freely? Can they transfer the name? Can they sell it? Can they delegate subnames? The lifecycle is the menu of actions the system permits.
- **What the system guarantees.** A name that cannot be transferred cannot be stolen by transfer. A name that cannot expire cannot be lost to inattention. Each transition allowed or forbidden is a guarantee the system makes or breaks.
- **What an attacker can exploit.** Every transition is an attack surface. An unauthorized transfer is theft. An unauthorized update is hijacking. An expired name reclaimed by an attacker is impersonation. The lifecycle is the attack surface, enumerated.
- **What failure looks like.** A name with no recovery path is lost forever if the owner's key is compromised. A name with no expiry can be held idle indefinitely. The lifecycle determines how names die, and whether death is reversible.

Designing the lifecycle is designing the name. The same string — `alice` — is a different object in a system where it can be sold than in one where it cannot.

## 8. The Canonical States

A name, over its lifetime, is in exactly one of these states at any given moment:

| State | Meaning |
|---|---|
| **Unclaimed** | The name has never been registered. It exists only as a syntactic possibility — a valid string that no one owns. |
| **Active** | The name is registered, has a current owner, and resolves to a target the owner set. This is the "normal" state. |
| **Suspended** | The name is registered but is temporarily not resolvable, or not mutable, by its owner. This is an intermediate state used for disputes, governance actions, or operator-imposed holds. Not all systems have this state. |
| **In transfer** | The name is in the process of moving from one owner to another. Depending on the mechanism, this may be atomic (the transfer transaction either fully completes or fully reverts) or multi-step (a two-phase commit where the name is locked pending acceptance). |
| **For sale** | The name is registered and active, but the owner has publicly listed it as available for purchase at a stated price (or via an auction). This is a sub-state of Active in some systems, a distinct state in others. |
| **Expired** | The name was active but its registration lapsed because the owner failed to renew (or failed to pay an ongoing fee, where applicable). The owner may still be able to recover it during a grace period. |
| **Reclaimed** | The name was expired, the grace period elapsed, and the name has been returned to the unclaimed pool — or, in some systems, has been claimed by a new owner. |
| **Burned** | The name has been intentionally rendered permanently unusable. It cannot be registered again, cannot resolve, cannot be recovered. This is rare and usually reserved for names that must never exist (e.g., reserved names, names that would conflict with system operations). |
| **Revoked** | The name was active but has been taken from its owner by some authority or governance process. Distinct from Expired (which is owner negligence) and Burned (which is permanent). |

Not every system has every state. A minimal system has Unclaimed, Active, and Reclaimed (the post-expiry pool). A maximal system has all of them. Each state you add is a feature you must implement and an attack surface you must defend.

## 9. The Canonical Transitions

States are connected by transitions. Each transition is an event in the namespace log — a mutation, in the sense of `02_namespace_properties.md` §2.2. The set of transitions a system permits is the set of things an owner (or the system) can do to a name.

### 9.1 The Core Transitions

These are the transitions every naming system must define, even if only to forbid them:

| Transition | From → To | Triggered by | Authorization |
|---|---|---|---|
| **Register** | Unclaimed → Active | A registrant requests the name and pays the fee | The allocation rule (first-come, auction, pricing) |
| **Update** | Active → Active | The owner changes the target address | The current owner's signature |
| **Transfer** | Active → Active (with new owner) | The owner gives the name to someone else | The current owner's signature (and, in two-phase systems, the recipient's acceptance) |
| **Sell** | Active → For sale → Active (with new owner) | The owner lists the name; a buyer pays; ownership moves | The owner's signature to list, the buyer's payment to purchase, possibly the owner's signature to accept the sale |
| **Expire** | Active → Expired | The registration period elapses without renewal | Automatic (no one's signature) |
| **Recover** | Expired → Active | The original owner renews during a grace period | The original owner's signature |
| **Reclaim** | Expired → Reclaimed (or Unclaimed) | The grace period elapses without recovery | Automatic |
| **Burn** | Active → Burned | A governance action or a self-burn by the owner | Varies — governance signature, or owner signature with a burn intent |
| **Revoke** | Active → Revoked | An authority or governance process | The authority's signature (this is the dangerous transition) |

### 9.2 The Authorization Question

Every transition has an authorization model — a rule for whose signature or whose action makes the transition valid. The two design questions are:

1. **Who can authorize this transition?** Usually the current owner, but not always. Registration is authorized by the allocation rule, not by an owner (there is no owner yet). Expiry is authorized by no one — it happens automatically. Revocation is authorized by an authority or governance process.

2. **Is authorization one-party or multi-party?** A simple Update is one-party: the owner signs, done. A Transfer can be one-party (the owner signs the name over to a new key) or two-party (the owner offers, the recipient accepts — a two-phase commit that prevents the owner from dumping an unwanted name on someone). A Sale is at least two-party and often three (owner, buyer, and the marketplace/escrow). Multi-party transitions are harder to attack but harder to complete.

The lifecycle design is, in large part, the choice of which transitions are one-party and which are multi-party, and what happens when a party to a multi-party transition disappears or refuses to act.

## 10. Sub-Lifecycles: The Things That Sit On Top of a Name

A name is not just a label. As it moves through its lifecycle, it can carry other bindings besides the primary address. These are the **sub-bindings** of a name, and they have their own (simpler) lifecycles nested inside the name's lifecycle.

| Sub-binding | Description | Lifecycle |
|---|---|---|
| **Primary address** | The main thing the name resolves to. The default target. | Set at registration, mutated by Update. |
| **Text records** (ENS-style) | Arbitrary key→value metadata: avatar URLs, email, social handles, etc. | Added, mutated, removed by the owner. |
| **Subname delegations** (hierarchical only) | The owner of `alice` creates `alice.pay` and delegates control of it. | Created by the owner of the parent; the delegated owner has their own lifecycle on the subname. |
| **Reverse records** | A reverse mapping: given an address, what name (if any) does it claim to be? | Set by the address's key holder; verified against the forward record. |
| **Sale listings** | A public declaration that the name is for sale at a price. | Set and unset by the owner; resolved when a sale completes. |
| **Delegation of mutation rights** | The owner authorizes another key to perform Updates (but not Transfers). | Granted and revoked by the owner. |

Each sub-binding is a separate authorization scope. The primary address might be mutable only by the owner; a text record might be mutable by a delegated key; a subname might be fully controlled by its delegated owner. The lifecycle design must specify, for each sub-binding, who can mutate it and how the mutation is authorized.

The most important sub-lifecycle is **subname delegation**, because it is what makes hierarchical namespaces work. The owner of a parent name can create child names and either retain control of them or hand control to someone else. This is a recursive application of the entire lifecycle — each subname has its own Register, Update, Transfer, Expire, and so on, with the parent owner as the (initial) authority. The namespace's hierarchy is, in effect, a tree of lifecycles nested inside each other.

## 11. Expiry, Renewal, and the Question of Permanence

The most consequential lifecycle decision is whether names can expire.

### 11.1 Permanent Registration

A name, once registered, is owned forever. There is no renewal, no fee, no expiry. The owner has the name until they transfer it or burn it.

- **Pro:** Owners cannot lose a name through inattention. A name is a durable identity, not a lease.
- **Pro:** No recurring payment infrastructure is needed. The namespace is simpler.
- **Con:** Names that are registered and then abandoned (owner dies, loses key, loses interest) are permanently locked. The namespace shrinks over time as names go dark.
- **Con:** Squatting is permanent. An attacker who claims `alice` holds it forever, even if they never use it.
- **Con:** There is no mechanism to recover a name whose owner's key is lost. The name is effectively burned, but it remains in the Active state from the namespace's perspective, polluting the resolution set with dead records.

### 11.2 Time-Limited Registration (Renewable)

A name is registered for a fixed period (e.g., 1 year, 5 years). The owner must renew before the period elapses, or the name expires and eventually returns to the unclaimed pool.

- **Pro:** Abandoned names return to circulation. The namespace does not accumulate dead records.
- **Pro:** Squatters must pay to hold names, which raises the cost of mass squatting and forces squatters to release names they don't expect to sell.
- **Pro:** Lost-key names eventually return. Key compromise is not permanent damage to the namespace.
- **Con:** Owners must maintain the ability and willingness to renew, possibly for decades. Loss of the renewal key, or simply forgetting, means losing one's identity.
- **Con:** The renewal infrastructure is itself an attack surface. An attacker who can prevent renewal (by blocking the owner's renewal transaction, by compromising the renewal path) can cause a name to expire and then reclaim it.
- **Con:** Recurring payments are a recurring attack — every renewal is a moment of vulnerability.

### 11.3 The Grace Period

The standard compromise between the two is the **grace period**: a name that has reached its expiry time is not immediately returned to the pool. It enters a state (often still called Expired, sometimes a distinct "Grace" state) in which:

- Resolution may continue to work (so the name is not abruptly useless to dependents).
- The owner can still renew, possibly at a penalty fee.
- No one else can claim the name yet.

The grace period is a buffer that absorbs the most common expiry cause — the owner forgot, or was temporarily unable to renew — without permanently losing the name. The cost is that the namespace accumulates a population of names in limbo, neither fully active nor reclaimable by others.

The grace period length is a design parameter. Too short and it fails its purpose (owners still lose names to inattention). Too long and the namespace accumulates a large population of zombie names that are not really in use but cannot be reclaimed.

### 11.4 The Permanence Question

The deeper question is whether a name is a **thing you own** (like a piece of land — permanent, transferable, but yours until you give it up) or a **thing you rent** (like a domain — yours while you pay, gone when you stop). The answer shapes everything else about the lifecycle:

- A permanent namespace leans toward squatting as the dominant failure mode. The defense is high upfront pricing.
- A renewable namespace leans toward loss-of-identity as the dominant failure mode. The defense is robust renewal infrastructure and long grace periods.

There is no right answer. The choice reflects a view about what a name *is* — and different naming systems have answered it differently.

## 12. Transfer, Sale, and the Secondary Market

A name is an asset, and assets are traded. The lifecycle must specify how a name moves from one owner to another, and whether that movement can be mediated by payment.

### 12.1 Transfer (No Payment)

A transfer is a one-sided gift: the owner signs the name over to a new owner's key. The new owner now controls the name. No payment is involved.

- **One-party transfer:** The owner signs, the transfer is done. The recipient has no say. This is simple but allows the owner to dump a name on someone who doesn't want it (which is usually harmless, but can be used for harassment or to evade responsibilities attached to the name).
- **Two-party transfer:** The owner offers, the recipient accepts. The name is locked during the offer period. This is safer but requires the recipient to be reachable and willing.

### 12.2 Sale (Payment-Mediated)

A sale is a transfer with a payment condition: the name moves to the new owner if and only if a payment is made. This is the secondary market.

The design questions are:

- **Is sale a first-class lifecycle transition, or an application built on top of transfer?** In ENS, sale is handled by separate marketplace contracts; the core lifecycle has only transfer. This keeps the core simple but pushes sale into the application layer, where it is less standardized.
- **Is the sale atomic?** A sale where the payment and the transfer happen in one transaction (or one atomic operation) is safe against the obvious attack: the buyer pays and the seller doesn't transfer, or the seller transfers and the buyer doesn't pay. Atomicity requires either a smart contract (ENS) or a trusted escrow (some centralized marketplaces).
- **Is the sale price public?** A public sale price makes the market transparent and lets buyers find names. A private sale price (negotiated off-chain) preserves privacy but makes price discovery harder.

The secondary market is where the lifecycle interacts with the namespace's economics. A namespace with a vibrant secondary market is one in which names have real, transferable value — which is both a feature (it incentivizes registration and use) and a risk (it incentivizes squatting and speculation).

## 13. The Full Lifecycle as a State Machine

Putting it together, a maximal lifecycle looks like:

```
                         ┌─────────────┐
                         │  Unclaimed   │
                         └──────┬──────┘
                                │ Register
                                ▼
                         ┌─────────────┐
                ┌────────│   Active     │────────┐
                │        └──────┬──────┘        │
                │               │               │
           Revoke           Update           Transfer
                │               │               │
                ▼               ▼               ▼
        ┌─────────────┐  (stays Active,  (stays Active,
        │  Revoked    │   new target)   new owner)
        └─────────────┘
                ▼
                         ┌─────────────┐
                         │  For sale   │◀─── (sub-state of Active)
                         └──────┬──────┘
                                │ Sale completes
                                ▼
                         ┌─────────────┐
                         │   Active    │ (new owner)
                         └──────┬──────┘
                                │ Expire (if renewable)
                                ▼
                         ┌─────────────┐
                         │  Expired    │
                         └──────┬──────┘
                           Recover │  │ (grace period elapses)
                          ▼        ▼
                  (back to Active) │
                                  ▼
                          ┌─────────────┐
                          │  Reclaimed  │
                          └──────┬──────┘
                                 │ (returns to pool)
                                 ▼
                         ┌─────────────┐
                         │  Unclaimed   │
                         └─────────────┘

        Burn is reachable from Active (owner-initiated) or Revoked (governance):
                ┌─────────────┐
                │   Burned    │  (terminal)
                └─────────────┘
```

A real system is a subset of this. The minimal viable lifecycle is:

```
Unclaimed ──Register──▶ Active ──Update──▶ Active
                              │
                              │ (no expiry, no transfer)
                              ▼
                         (terminal: name stays Active forever)
```

Most production systems fall between these. The choice of which states and transitions to include is the lifecycle design, and it is one of the most consequential decisions in namespace design — more consequential, in many cases, than the syntax of the names themselves.

---

# Part III — Governance: Consensus on the Rules

## 14. Why Governance Is a Consensus Problem

Consensus on the state is consensus *under* a rule-set. But the rule-set itself is not given by physics — it is a human artifact, and human artifacts are subject to revision. The deepest consensus problem in a namespace is therefore not on the state but on the **rules that interpret the state.**

If two participants run different readers, they compute different namespaces from the same event log. If two participants disagree on what the allocation rule is, they disagree on who owns a contested name. If two participants disagree on whether names expire, they disagree on whether a lapsed name is still owned. The rule-set is the grammar in which consensus is expressed, and consensus on the state is meaningless without consensus on the grammar.

This is the problem of **governance**: how does the rule-set change, who decides, and what happens to the names that already exist when it does? Governance is consensus on consensus — the meta-layer that determines how the lower layer evolves.

## 15. The Paradox of Namespace Governance

A namespace is valuable because it is stable. Names are stable because the rules that govern them are stable. If the rules can be changed, the names are not stable — they are subject to whatever the new rules say.

But the rules cannot be perfectly designed at launch. The world changes, attacks evolve, usage patterns surprise the designers, and the rules must adapt or the namespace becomes obsolete or insecure.

This is the **paradox of namespace governance**: the system needs both *immutability* (so names are stable and trustworthy) and *mutability* (so the system can survive contact with reality). Every namespace design must resolve this paradox somehow, and the resolution is never free.

The two extreme answers are:

- **The rules never change.** The namespace is a constitution: ratified once, applied forever. Pro: maximum stability, maximum trust. Con: the namespace cannot adapt. When a critical bug is found, or a new attack vector appears, or the character set needs to expand to support a new language community, the namespace either lives with the flaw or dies.
- **The rules change whenever the operators say so.** The namespace is a policy: the operators update it as they see fit. Pro: maximum adaptability. Con: the namespace is not stable. The operators can change what a name means, who owns it, whether it exists. The namespace is centralized by another name.

Neither extreme works. Every real namespace lives somewhere in between, and the design of governance is the design of where, exactly, on that spectrum the namespace sits.

## 16. What Can Be Governed

Not everything about a namespace is governable in the same way. Different aspects have different change profiles, and conflating them leads to bad governance design. The governable aspects are:

| Aspect | What it is | How hard to change | Why |
|---|---|---|---|
| **Syntax** | The character set, length, normalization rules for valid names. | Medium | A syntax expansion (allowing hyphens, or Unicode) doesn't break existing names, but does change the namespace's population and attack surface. A syntax restriction breaks existing names and is close to impossible. |
| **Allocation rule** | Who gets a name when multiple parties want it. | Medium | Changing from first-come to auction, or from flat pricing to tiered pricing, changes the dynamics of new registration but doesn't affect existing owners. |
| **Fees** | The cost to register, renew, or mutate. | Easy | Changing a fee doesn't change any name's ownership or target. It changes the economics of the namespace. |
| **Lifecycle** | Which transitions are permitted (can names be transferred? sold? do they expire?). | Hard | Adding a transition (e.g., enabling sale) usually doesn't break existing names. Removing a transition (e.g., forbidding transfer) takes a capability away from existing owners, which is a taking. |
| **Reader logic** | The deterministic scanner that interprets the event log into namespace state. | Hard | Changing the reader retroactively changes the interpretation of every past event. This is the most dangerous change, because it can silently alter the meaning of names that owners thought were settled. |
| **Recovery model** | What happens when an owner's key is compromised or lost. | Hard | Adding a recovery model is generally additive (it gives owners a new option). Removing a recovery model takes away a safety net. Changing a recovery model changes who can recover a name, which is a security-critical change. |
| **Genesis** | The marker that defines when the namespace began. | Effectively impossible | Moving the genesis retroactively rewrites the namespace's origin. This is a fork, not a governance action. |
| **The append medium itself** | The blockchain or authority that records events. | Impossible without a fork | The namespace's history is recorded in the medium. Changing the medium means migrating the history, which is a fork. |

The governance design must specify, for each of these, **who can change it, by what process, and with what effect on existing names.** A governance design that treats them all the same ("the operators can change anything") is too coarse and too dangerous. A governance design that specifies a different process for each is more robust but more complex.

## 17. The Mechanisms of Change

How does a namespace's rule-set actually get updated? There are several mechanisms, each with different trust assumptions:

### 17.1 Operator Discretion

The operators of the namespace simply change the rules. They update the reader, they adjust the fees, they expand the syntax. Users either accept the change or leave.

- **Trust assumption:** The operators are honest and competent.
- **Failure mode:** The operators make a bad change, or are coerced into making one.
- **When it works:** When the operators are constrained by reputation, by competition (users can migrate to a fork), or by a governance process that is itself hard to capture.
- **When it fails:** When the operators are a single point of control and there is no recourse.

This is, in effect, how most early naming systems were governed. The operators had discretion, and the system worked as long as the operators were trustworthy.

### 17.2 On-Chain Governance (Smart Contract Upgrade)

The rule-set is encoded in a smart contract. The contract has an upgrade mechanism — typically a governance token, a multisig, or a timelocked admin function. Changes to the rule-set are themselves on-chain transactions, visible and auditable.

- **Trust assumption:** The upgrade mechanism is sound and cannot be captured.
- **Failure mode:** The governance mechanism is captured (a token attack, a multisig compromise), or a buggy upgrade is pushed.
- **When it works:** When the upgrade mechanism is well-designed, the governance community is broad, and upgrades are slow and visible (timelocked).
- **When it fails:** When the governance is concentrated (a small set of token holders, a multisig with few signers), or when upgrades can be pushed instantly without review.

This is how ENS is governed: the ENS DAO (token-based governance) can upgrade the core contracts via a timelocked process. The mechanism is public, the changes are slow, and the community has time to react.

### 17.3 Social Consensus (Fork Choice)

There is no formal governance mechanism. When the rules need to change, someone proposes a change, the community discusses it, and the change is adopted (or not) by the community choosing to run the new reader or to stay on the old one. A change that the community accepts becomes canonical; a change that the community rejects does not.

- **Trust assumption:** The community is paying attention and will reject bad changes.
- **Failure mode:** The community is not paying attention and accepts a bad change, or the community splits and the namespace forks.
- **When it works:** When the community is engaged, the change process is public and slow, and there is a strong norm against unilateral changes.
- **When it fails:** When the community is small or disengaged, when the proposer of a change has outsized influence, or when the change is controversial enough to split the community.

This is, in effect, how Bitcoin and Zcash are governed: there is no on-chain governance, but changes to the consensus rules are adopted (or not) by the community of node operators choosing which software to run. It is also how observation-based naming systems (like the proposed ZNS v2) must govern their reader logic: a reader change is adopted by users choosing to run the new reader.

### 17.4 Constitutional Commitment

The rule-set is published as a document — a "constitution" or "specification" — that the operators commit to follow. Changes to the rule-set require a formal process of amending the constitution, which is itself governed by a social or legal process.

- **Trust assumption:** The operators honor the constitution.
- **Failure mode:** The operators defect from the constitution, or the amendment process is captured.
- **When it works:** When the constitution is clear, the amendment process is demanding, and the operators are constrained by reputation or law.
- **When it fails:** When the constitution is ambiguous, the amendment process is loose, or the operators are not actually constrained.

This is close to how DNS is governed: the root zone is managed under a process defined by ICANN and the relevant contracts, and changes to the governance of the root require a multi-stakeholder process. It is also how many permissioned or semi-permissioned systems are governed.

### 17.5 No Governance (Immutability by Design)

The rule-set is fixed at genesis and cannot be changed by any mechanism. If the rules turn out to be wrong, the namespace lives with the flaw or dies.

- **Trust assumption:** The genesis rule-set was correct.
- **Failure mode:** The genesis rule-set was wrong, and the namespace is stuck with it.
- **When it works:** Rarely. It works for systems that are simple enough that the rule-set is unlikely to need change, and where the cost of a flaw is acceptable.
- **When it fails:** Whenever a real flaw is discovered and the system cannot adapt.

In practice, no namespace adopts pure immutability — even Bitcoin, which is often described as immutable, has changed its rules through soft forks and hard forks. Immutability is an aspiration, not a state. The question is how hard it is to change, not whether it can change.

## 18. The Backward Compatibility Problem

When a rule-set changes, the new rules must say what happens to names that were registered under the old rules. This is the **backward compatibility** problem, and it is where most governance failures actually happen.

### 18.1 The Three Compatibility Postures

| Posture | What it means | Consequence |
|---|---|---|
| **Strict backward compatibility** | Every name valid under the old rules is valid under the new rules, with the same owner and the same target. The new rules only add capability; they do not remove or alter. | Safest. Existing names are unaffected. But this constrains what changes are possible — you can add a character to the syntax, but you cannot remove one. |
| **Transforming compatibility** | Existing names are reinterpreted under the new rules in a deterministic way. For example, if the syntax expands from `[a-z0-9]` to `[a-z0-9-]`, every existing name is unchanged (it's still valid). But if a normalization rule changes, an existing name might map to a different canonical form, and the owner of that form might be different from the original owner. | Risky. Deterministic reinterpretation can produce surprising results. Must be carefully specified and widely communicated before adoption. |
| **Breaking change** | The new rules invalidate some existing names, or change their ownership or target. | Catastrophic for trust. Existing owners lose their names or find them altered. This is, in effect, a fork — the old names still exist under the old rules, and the new rules create a new namespace. |

The default posture for any governance change should be strict backward compatibility. Breaking changes should be reserved for cases where the old rules were actively harmful (a security flaw, a captured allocation) and where the cost of preserving the old state exceeds the cost of breaking it.

### 18.2 The Reader Change Problem

The hardest backward compatibility problem is the **reader**. When the reader logic changes, the new reader must produce the same state as the old reader for all events up to the change, and a new state for events after the change. This means:

- The new reader must include the old reader's logic as a special case for the pre-change portion of the log.
- The new reader must specify a **cutover point** — a block height, a transaction, or a marker that separates "interpret under old rules" from "interpret under new rules."
- Every participant must agree on the cutover point, or the namespace forks.

The reader change is dangerous because it is invisible to most users. A user who resolves `alice` does not know which reader the resolver is running. If the resolver silently switches to a new reader, the user gets a different answer and has no way to tell. The defense is the same as for any open-source security tool: the reader change must be public, the new reader must be deterministic and reproducibly built, and multiple independent implementations must agree on the cutover.

This is why reader changes are the most consequential governance action in an observation-based naming system. The reader *is* the rule-set, in a sense that no other aspect of the system is. Changing the reader is changing the namespace.

## 19. The Fork

When governance fails — when the community cannot agree on a change, or when the operators push a change that part of the community rejects — the namespace **forks**. The single namespace splits into two namespaces that share a common history up to the fork point and diverge after it.

A fork is the failure mode of governance, but it is also its safety valve. The threat of a fork is what constrains the operators from pushing changes the community rejects: if the operators push a bad change, the community can fork away from them, leaving the operators with a namespace no one uses.

### 19.1 What Forks

A namespace fork is not like a blockchain fork. A blockchain fork produces two chains with different transaction histories. A namespace fork produces two namespaces with the same history up to a point and different rules after — but both namespaces might be reading the *same* chain, just with different readers. The fork is in the interpretation, not the substrate.

This means an observation-based naming system can fork without the underlying chain forking. Two readers, applied to the same Zcash blockchain, can produce two different namespace states. The chain is one; the namespaces are two. Which one is "the" namespace is a social question — it is whichever one the community of users, wallets, and resolvers adopts.

### 19.2 The Fork Choice Problem

After a fork, users must choose which namespace to treat as canonical. The choice is made by:

- **Wallets and resolvers** deciding which reader to run.
- **Indexers and explorers** deciding which state to display.
- **Registrants** deciding which fork to register new names on (or both).
- **The broader community** deciding which namespace to refer to as "the real one."

There is no algorithmic resolution to fork choice for a namespace. The blockchain's fork-choice rule resolves which chain is canonical, but it does not resolve which *interpretation* of the chain is canonical. That is a social decision, made by the participants collectively.

The practical implication: **the legitimacy of a namespace fork depends on the legitimacy of the process that produced it.** A fork that emerges from a transparent, broadly-discussed governance process is more likely to be adopted than one pushed by a small group. A fork that preserves backward compatibility (existing names are unchanged) is more likely to be adopted than one that breaks them.

### 19.3 The Threat of Fork as Governance

The possibility of a fork is itself a governance mechanism. It is the ultimate constraint on the operators: if they push a change the community rejects, the community can leave. This is the same dynamic that constrains blockchain developers — the threat of a chain fork is what prevents unilateral changes to the consensus rules.

For this to be a real constraint, the community must be *capable* of forking. This requires:

- An alternative reader implementation, or the ability to write one.
- Enough users, wallets, and resolvers willing to switch.
- A shared understanding of what the canonical rules are (so the fork can be specified).

A namespace whose community cannot fork is a namespace whose operators are unconstrained. The fork capability is what makes observation-based governance workable.

## 20. The Stages of Namespace Evolution

A namespace is not governed the same way at every point in its life. The governance needs change as the namespace matures:

### 20.1 Genesis (pre-launch and launch)

Governance is concentrated in the founders. They design the rule-set, choose the medium, write the reader, and launch the namespace. The community has not yet formed; there is no one to govern with. The founders' discretion is total, and the bootstrap trust problem (Part I) is the cost early adopters pay for this.

The governance question at genesis is: **what commitments do the founders make about how they will govern later?** A founder who makes no commitments is asking for unconditional trust. A founder who makes specific commitments (a published constitution, a timelocked upgrade process, a multi-sig for any rule changes) is constraining their own future discretion, which makes the namespace more trustworthy at the cost of the founders' flexibility.

### 20.2 Establishment (early growth)

The namespace is growing. The founders are still the primary operators, but a community is forming around the namespace — users, wallets, indexers, secondary marketplaces. Governance begins to involve this community, even if only informally (the founders consult the community before making changes).

The governance question at establishment is: **how does the transition from founder-led governance to community-influenced governance happen?** A namespace that never makes this transition remains founder-controlled forever, which is fragile (a single point of failure) and not credible as a long-term decentralized system. A namespace that makes the transition too early can be captured by a small or unrepresentative community.

### 20.3 Maturity (stable operation)

The namespace is widely used. The rule-set is largely stable. Changes are rare and incremental. Governance is a process of small adjustments (fees, minor reader updates) rather than fundamental redesigns. The community is broad enough that any change must be broadly acceptable to be adopted.

The governance question at maturity is: **how do you prevent the governance process from being captured?** A mature namespace is a valuable target. The governance mechanism — whatever it is — is the attack surface for capturing the namespace. A token-based governance can be captured by buying tokens. A multisig can be captured by compromising enough signers. A social consensus process can be captured by a well-resourced party that dominates the discussion.

### 20.4 Crisis (a flaw is discovered, or an attack succeeds)

The namespace faces a situation the rule-set does not handle: a critical bug, a successful attack, a social conflict that cannot be resolved under the existing rules. Governance must respond, and the response will shape the namespace's future legitimacy.

The governance question at crisis is: **can the governance process produce a legitimate response under pressure?** A governance process that works in peacetime may fail in crisis — decisions must be made quickly, the community is divided, and the cost of a wrong decision is high. The maturity of the governance process is tested here.

### 20.5 Senescence (the namespace is being superseded)

The namespace is being replaced by a successor (a new version, a competing system, a migration to a different substrate). Governance is about the **decommission**: how do existing names move to the successor, what happens to names that don't move, and how does the old namespace wind down?

The governance question at senescence is: **does the namespace have a graceful exit, or does it just decay?** A namespace with a migration plan can hand off its names to a successor. A namespace without one leaves its names stranded — registered in a system that no one maintains, resolvable only by readers that no one runs.

---

# Summary

The static framing of a namespace — "a mapping from names to addresses" — hides the three consensus problems that actually determine whether a namespace works:

1. **Consensus on the origin (genesis).** Before there is a state to agree on, there must be agreement on when the namespace began, what its first records are, and what rule-set was in force when they were created. The bootstrap is the moment of maximum fragility; every later property rests on the assumption that the genesis was clean.

2. **Consensus on the trajectory (lifecycle).** A name is a sequence of mappings over time, not a single mapping. Consensus must cover the entire ordered history of each name, the authorization of every mutation, and the set of transitions the system permits. The lifecycle is the grammar of mutations that consensus must order and verify — and it is the attack surface, enumerated.

3. **Consensus on the rules (governance).** The rule-set that interprets the event log into namespace state is itself subject to change. Consensus on the state is meaningless without consensus on the rules. Governance is the meta-consensus problem: how the rule-set evolves, who decides, and what happens to existing names when it does. The fork is both the failure mode of governance and its safety valve — the threat of a fork is what constrains the operators, and only a community capable of forking can keep them honest.

These three are the consensus problems that determine whether a namespace survives contact with reality. The static properties — global uniqueness, authenticity, liveness, integrity, persistence, censorship resistance — are necessary but not sufficient. They describe a namespace that already exists and whose rules are already fixed. Genesis, lifecycle, and governance describe how the namespace comes to exist, how it persists through time, and how it adapts without breaking. Together, they are the full consensus problem a global naming system must solve.
