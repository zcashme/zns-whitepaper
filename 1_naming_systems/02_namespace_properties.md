# Context 02: Namespace Properties

This document defines the fundamental properties that make a global naming system possible. It is not about ZNS. It is about the underlying physics of naming — the constraints that any naming system must satisfy to function at global scale, regardless of implementation.

A naming system is a mapping from human-readable identifiers to machine-readable identifiers. Before we can talk about the properties that govern the mapping, we must define its two ends: what a human-readable identifier is, what a machine-readable identifier is, and why they have opposing properties. That is the first subject of this document. The rest is about the mapping itself — its origin, the properties it must satisfy, the consensus it requires, and the time dimension it lives in.

---

## 1. The Origin of Naming

Before there were computers, there were names.

Humans name things. We name people, places, rivers, stars, concepts. A name is the most basic act of abstraction: it takes something complex and gives it a handle. "The big river near the hill where we hunt" becomes "the Nile." The name compresses reality into something a human mind can hold.

This is not a technological convenience. It is a cognitive necessity. Human working memory is finite. We cannot operate in a world where every object is identified by its full description. We need shorthand. Names are that shorthand.

The first naming systems were **local** — a family names its children, a village names its streets, a tribe names its territory. These names work because everyone who needs to use them is in the same context. If you say "the river" in your village, everyone knows which river. No global coordination is needed.

The problem begins when a name needs to work **beyond the context where it was coined.** When two villages both have "the river" and a trader visits both, the name is ambiguous. The trader needs to know *which* river. The local name fails at scale.

### 1.1 DNS: The First Global Machine Naming System

The Domain Name System, created in 1983, was the first attempt to solve this problem for machines. Before DNS, computers on the early internet were identified by hostnames maintained in a single text file (`HOSTS.TXT`) managed by Stanford Research Institute. As the network grew, this file became a bottleneck — every new computer required a manual update to a central file, and the file was getting too large to distribute.

DNS replaced the single file with a **hierarchical, distributed database.** Names were structured as trees: `www.example.com` is a path from the root (`.`) through `com` to `example` to `www`. Each level of the tree is delegated to a different authority. The root is managed by ICANN. `com` is managed by Verisign. `example.com` is managed by whoever registered it. The owner of `example.com` can create any subdomain they want without asking anyone else.

This solved the scaling problem — no single party has to manage all names. But it created a governance problem: the root of the tree is a single point of control. Whoever controls the root controls the entire namespace. This is why DNS, despite being distributed, is not decentralized.

### 1.2 ENS: Naming as Consensus State

The Ethereum Name Service, launched in 2017, approached the problem differently. Instead of a hierarchical database of servers, ENS stores the namespace as **state in a smart contract** on the Ethereum blockchain. The contract is a simple mapping: namehash → {owner, resolver, TTL}. The blockchain's consensus mechanism ensures everyone agrees on the current state of this mapping.

There is no root server. There is no delegation hierarchy that requires trust in a parent. The contract is the single source of truth, and the blockchain's consensus guarantees that everyone sees the same truth. Anyone can read; only the owner of a name can write.

This is a fundamentally different consensus mechanism than DNS. DNS consensus comes from a hierarchy of authorities backed by social and legal governance. ENS consensus comes from cryptographic agreement among thousands of independent nodes.

---

## 2. The Two Ends of the Mapping

A naming system bridges two kinds of identifiers. The properties of each, and the gap between them, are what make the mapping non-trivial.

### 2.1 Human-Readable Identifier

A human-readable identifier is a string that a human can **perceive, remember, reproduce, recognize, and communicate.**

Each of those verbs imposes a constraint:

#### Perceive

The characters must be visible and renderable. This rules out:
- Control characters
- Zero-width characters (zero-width space, zero-width joiner, etc.)
- Combining characters used in isolation
- Non-printing characters

#### Remember

The string must be short enough and structured enough to hold in human working memory. This means:
- Length matters: `alice` is memorable, `x7q3mz9plk2wnr8bvf4tj` is not
- Pronounceability helps: strings that can be "sounded out" are easier to remember than random character sequences
- Semantic content helps: a real word or name is easier to remember than a random string of equal length

#### Reproduce

The human must be able to type the identifier and produce the same string each time. This means:
- The character set must be accessible on common input devices (keyboards, mobile keyboards)
- Case sensitivity is dangerous: if `Alice` and `alice` are different identifiers, humans *will* make mistakes. You need either case-insensitivity or case-folding normalization
- Visually ambiguous character pairs create errors: `l` (lowercase L) vs `1` (one) vs `I` (capital i), `O` (capital O) vs `0` (zero). If both members of a pair are allowed, users will confuse them
- Complex Unicode normalization creates invisible differences: `café` (precomposed) vs `café` (decomposed) are the same visual string but different byte sequences

#### Recognize

The human must be able to distinguish two identifiers at a glance. This is where **homoglyph attacks** come in:
- Cyrillic `а` (U+0430) is visually identical to Latin `a` (U+0061) in most fonts. If both are allowed, `alice` (all Latin) and `аlice` (first character Cyrillic) look the same to a human but are different strings
- This is not just theoretical — it's the basis of real phishing attacks on DNS and IDN (Internationalized Domain Names)
- The defense is either restricting to a single script (e.g., ASCII only) or implementing confusable detection

#### Communicate

The human must be able to share the identifier with another human. Over a phone call, in a text message, on a business card. This means:
- Pronounceable names are easier to share than unpronounceable ones
- Names without special characters are easier to say ("alice" vs "alice_underscore_pay")
- Names that don't require spelling out character-by-character are more practical

#### Summary

A **human-readable identifier** is a string drawn from a restricted, unambiguous character set, short enough to remember, normalized so that equivalent representations collapse to one identifier, and free of visually confusable alternatives.

### 2.2 Machine-Readable Identifier

A machine-readable identifier is a string or data structure that a computer can **parse, compare, store, transmit, and validate** — with exactness and no ambiguity.

#### Parse

The identifier has a well-defined format with no ambiguity about its structure. A Zcash unified address has a known encoding (bech32m), a known HRP prefix, and a known internal structure. The parser either succeeds or fails; there's no "maybe."

#### Compare

Equality is exact and deterministic. Two machine-readable identifiers are either identical or they're not. There's no fuzzy matching, no "close enough." `u1qqabc...` and `u1qqabd...` are different addresses, period. This is why addresses are typically hashes or derived values — they have exact comparison properties by construction.

#### Store

The identifier can be represented in a fixed-size, efficient format. Addresses are fixed-length byte sequences. Content hashes are 32 bytes. This makes storage and indexing efficient.

#### Transmit

The identifier can be encoded for network transmission without ambiguity. Encodings like bech32m, base58, and hex are self-describing (you can tell what type of identifier it is from the format) and have built-in error detection.

#### Validate

The identifier's correctness can be checked, often cryptographically. A Zcash address can be validated by checking its bech32m checksum and decoding its internal structure. A public key can be validated by checking it's a valid curve point. This means you can detect corruption, typos, or fraud at the machine level without human inspection.

#### Summary

A **machine-readable identifier** is an exactly-comparable, fixed-format, self-validating string that a computer can process without interpretation or judgment.

### 2.3 The Gap Between Them

The fundamental problem is that human-readable and machine-readable identifiers have **opposing properties**:

| Property | Human-readable | Machine-readable |
|---|---|---|
| Length | Short | Can be long |
| Character set | Restricted, familiar, unambiguous | Any encoding |
| Comparison | Fuzzy (case, normalization, visual similarity) | Exact, byte-level |
| Uniqueness | Collision-prone (many people named Alice) | Collision-free (hashes, keys) |
| Memorability | High | Low |
| Communicability | Easy (verbal, written, phone) | Hard (must copy/paste, scan QR) |
| Forgery resistance | Low (easy to make similar-looking strings) | High (cryptographic) |
| Validation | Human judgment | Algorithmic |

A name system **bridges this gap.** It maintains a mapping that lets humans use the left column while machines use the right column, and ensures the mapping is secure — that the human-readable name actually points to the machine-readable identifier the legitimate owner chose.

### 2.4 The Syntax Question

The syntax rules for a namespace are a **choice about where to sit on the spectrum** between human-readable and machine-readable. Every decision is a tradeoff:

#### Character Set

| Choice | Pro | Con |
|---|---|---|
| `[a-z0-9]` (current) | No homoglyphs, no case confusion, works on every keyboard, easy to communicate verbally | No hyphens, no underscores, no Unicode, names like `alicepay` instead of `alice-pay` |
| `[a-z0-9-]` | Hyphens improve readability of multi-word names (`alice-pay`) | Need to prevent leading/trailing/double hyphens; still ASCII-only |
| `[a-z0-9-._]` | Most flexibility within ASCII | More ambiguity, harder to communicate verbally, more normalization rules |
| Unicode (UTS46 like ENS) | International names, non-Latin scripts | Homoglyph attacks, complex normalization, harder to type on some keyboards, harder to communicate verbally across language barriers |

#### Length

| Choice | Pro | Con |
|---|---|---|
| 1–62 chars (current) | Wide range, short names are premium | Very long names are hard to remember/communicate |
| 1–32 chars | Everything is memorable | Fewer available names |
| 3–62 chars | No 1-2 char names (reduces ultra-premium squatting) | Legitimate 1-2 char names are blocked |

#### Normalization

| Choice | Pro | Con |
|---|---|---|
| Lowercase only, ASCII | Simple, no ambiguity | No international names |
| Case-fold + UTS46 | International, matches ENS/DNS | Complex, homoglyph risk, surprising normalizations |

#### The Key Insight

The syntax rules are not just a technical choice — they are a **security boundary.** Every character you allow is an attack surface. Every normalization rule you add is a place where two strings that look different to a machine look the same to a human, or vice versa.

The most secure namespace is `[a-z0-9]` — no ambiguity, no homoglyphs, no normalization surprises. It's boring but it's safe. Every expansion from there (hyphens, underscores, dots, Unicode) buys expressiveness at the cost of security.

This is the tension you resolve when you define the syntax for a namespace.

---

## 3. The Fundamental Properties

Any system that maps human-readable names to machine-readable identifiers at global scale must satisfy certain properties. These are not design choices — they are requirements imposed by the nature of the problem. A system that violates any of them will fail in practice, even if it works in theory.

### 3.1 Global Uniqueness

**At any given moment, each name resolves to exactly one target.**

This is the defining property of a namespace. If `alice` could resolve to two different addresses depending on who you asked, the name would be useless as an identifier — it would be a source of ambiguity, not a resolution of it.

Formally, global uniqueness is a property of a **time-slice** of the namespace state. Given a state `S` at time `T`, `resolve(n, S)` is a function — it returns exactly one value (or `⊥` if the name is unregistered). This is distinct from **temporal permanence**, which would require that `resolve(n, S_t) = resolve(n, S_{t-1})` unless a mutation occurred. A system can have global uniqueness without temporal permanence: `alice` can point to address A today and address B tomorrow, and both are valid as long as all observers agree on the current answer at each point in time.

The key implication: global uniqueness requires **global consensus on namespace state.** Every participant must agree on:
- Which names exist (are claimed)
- Who owns each name
- What each name currently points to

Without consensus, there is no global namespace — there are only local namespaces that happen to share the same syntax.

This property implies **global consensus on namespace state.** Every participant must agree on:
- Which names exist (are claimed)
- Who owns each name
- What each name currently points to

Without consensus, there is no global namespace — there are only local namespaces that happen to share the same syntax.

**What breaks it:** A split in the consensus mechanism. If two groups of participants disagree on the state of the namespace (a chain fork, a registrar dispute, a DNS root server hijack), names become ambiguous. The namespace fragments. Resolving this requires a fork choice rule or a social consensus on which state is canonical.

A subtler break is **equivocation**: a single resolver returns different answers to different queriers for the same name at the same time. This is not a consensus failure — the resolver knows the correct answer — but a malicious one. Equivocation is an integrity failure (Section 3.4), but it manifests as a uniqueness violation from the perspective of the users who receive conflicting answers.

### 3.2 Authenticity of Mutation

**Only the legitimate owner of a name can change what it points to.**

If anyone could change `alice`'s target address, the name system would be useless for payments — an attacker could redirect `alice` to their own address and steal funds intended for Alice.

Authenticity requires that every mutation (update, transfer, sale) is **authorized** by the current owner. "Authorized" means the mutation carries proof that it was initiated by someone who controls the name. In practice, this means a cryptographic signature: the owner signs the mutation with a key only they hold.

But authorization is only half the problem. The other half is **ordering**: mutations must be applied in a consistent order. If Alice sends an update to address A and then an update to address B, all observers must agree on which happened last. If two resolvers disagree on the order, one returns A and the other returns B — global uniqueness is violated.

This means the name system needs not just authorization but **sequencing**: a way to determine the canonical order of mutations. Options include:
- A central authority that processes mutations in order (DNS, ZNS v1)
- A blockchain that records mutations in blocks with a total ordering (ENS)
- A logical clock or nonce that strictly orders mutations per-name (ZNS v2's predecessor reference)

**What breaks it:** A forged authorization (stolen key, compromised operator) or a disagreement about ordering (concurrent mutations, network partition). The first is a key management problem; the second is a consensus problem.

### 3.3 Liveness of Resolution

**Anyone can resolve a name at any time without permission.**

A name that only the owner can resolve is not a name — it's a secret. A name system requires that resolution is available to all parties who need it. If Alice registers `alice` so that Bob can pay her, Bob must be able to resolve `alice` without asking Alice, without trusting a third party to be honest, and without needing Alice to be online.

Liveness does not require that resolution is instant or free. DNS resolution takes time (milliseconds to seconds). ENS resolution requires an Ethereum RPC call. But it does require that:
- The resolution mechanism is available (the resolver is up, the chain is synced)
- The resolution result is current (it reflects the latest state, not a stale cache)
- The resolver cannot selectively refuse to answer (no censorship)

The tension is between liveness and privacy. A fully public resolution mechanism (like ENS) reveals the entire namespace state to everyone — you can enumerate all names, see all updates, track all activity. A private resolution mechanism (like Zcash's shielded transactions) hides this information but makes resolution harder because the data is encrypted.

**What breaks it:** The resolver goes down, the resolver returns stale data, the resolver refuses to answer specific queries, or the resolution mechanism is too expensive/slow to be practical.

### 3.4 Integrity of the Mapping

**The name you resolve is the name the owner intended.**

This is subtly different from authenticity of mutation. Authenticity says "only the owner can change the mapping." Integrity says "when you resolve a name, you get the mapping the owner set, not a mapping that was altered in transit."

The distinction matters because resolution often involves intermediaries. When you type `alice` into a wallet, the wallet asks a resolver, the resolver queries a database, the database returns a result. Each step is an opportunity for the result to be altered. The resolver could lie. The network could be compromised. The database could be corrupted.

Integrity is achieved when the resolver can **prove** that the result it returns is correct — not just assert it, but provide cryptographic evidence that any third party can verify. This is what ENS achieves via the blockchain: the resolver's answer is backed by the chain's consensus, and anyone can independently verify the chain state. It is what ZNS v2 aims to achieve via Name Notes: the resolution result is backed by an on-chain commitment that `zns-verify` can check.

Without integrity, resolution is just a request to a server that says "trust me." With integrity, resolution is a verifiable claim: "here is the answer, and here is the proof."

Integrity has a **freshness** sub-property that is easy to overlook. A proof that `alice → address A` was correct at block 3,900,000 is not sufficient if the current block is 3,910,000 and Alice updated her address at block 3,905,000. The proof must demonstrate not just that the binding was valid at some point, but that it is the **most recent** valid binding. This means the proof must either:
- Reference the current chain tip (proving no more recent mutation exists), or
- Include a monotonic counter (nonce, block height) that the client can compare against the current state

Freshness is the bridge between integrity and liveness. Without freshness, a resolver could serve stale but individually valid proofs — technically truthful, practically misleading.

**What breaks it:** A resolver that returns false results and the user has no way to check. This is the ZNS v1 problem — the resolver is trusted but not verifiable.

### 3.5 Persistence of the Mapping

**The mapping does not change unless the owner changes it.**

A name that randomly points to different addresses is worse than no name at all — it creates false confidence. The mapping must be **stable**: it stays the same until the owner explicitly mutates it.

Persistence has a temporal dimension and a spatial dimension:
- **Temporal:** The mapping at time T is the same as at time T-1 unless a mutation occurred between T-1 and T
- **Spatial:** The mapping returned to user A is the same as the mapping returned to user B at the same time

Temporal persistence requires that mutations are recorded and not lost. If a mutation is accepted but later disappears (a reorg, a database rollback), the mapping becomes unpredictable. This is why blockchain-based naming systems are appealing: once a transaction is confirmed, it is extremely difficult to undo.

Spatial persistence requires consensus: all observers see the same state. If the resolver returns A to user A and B to user B at the same time, the namespace has fragmented.

**What breaks it:** Chain reorganizations (the mutation is undone), database corruption (the mutation is lost), or resolver inconsistency (different resolvers return different results).

### 3.6 Censorship Resistance

**No party can prevent a user from registering, mutating, or resolving a name.**

This is the property that distinguishes a decentralized naming system from a centralized one. In DNS, ICANN can refuse to delegate a TLD. Verisign can refuse to register a domain. A government can order a registrar to seize a domain. These are all forms of censorship — a third party preventing the owner from exercising their rights to a name.

Censorship resistance requires that:
- **Registration** cannot be blocked by a gatekeeper (or the gatekeeper is constrained so it cannot discriminate)
- **Mutation** cannot be blocked by the system operator
- **Resolution** cannot be selectively denied to specific users or for specific names

Full censorship resistance is very hard to achieve. Even ENS, which runs on Ethereum's decentralized consensus, has a front-end censorability problem — the ENS app, the Ethereum RPC providers, and the wallets that integrate ENS could all refuse to resolve specific names. The on-chain state is censorship-resistant, but the user-facing experience is not necessarily.

The practical question is not "is it perfectly censorship-resistant?" but "what is the smallest set of parties that must cooperate to censor a name, and how difficult is it to make them cooperate?"

In DNS, a single government order to a single registrar can censor a name. In ENS, censoring a name requires controlling enough Ethereum validators to rewrite the chain (extraordinarily difficult) or convincing all wallets and RPC providers to block it (socially difficult but not technically impossible). In ZNS, the answer depends on the architecture — which is what the whitepaper must address.

**What breaks it:** A gatekeeper who can refuse registration, an operator who can refuse mutations, or a resolver that can refuse to answer. The more parties that must collude to censor, the more censorship-resistant the system.

---

## 4. Properties as a System

These six properties are not independent. They interact:

| Property | Depends on |
|---|---|
| Global uniqueness | Consensus mechanism (everyone agrees on state) |
| Authenticity of mutation | Authorization (signatures) + Sequencing (ordering) |
| Liveness of resolution | Availability of resolver + accessibility of data |
| Integrity of the mapping | Verifiable proofs (resolution is backed by evidence) |
| Persistence of the mapping | Immutability of record (mutations can't be lost) |
| Censorship resistance | Decentralization of all components (no single point of control) |
| Non-equivocation | Resolver returns the same answer to all queriers (no selective deception) |

Notice the dependency chain:

- **Integrity requires uniqueness:** If the namespace is fragmented (no global uniqueness), there's no single "correct" answer to prove.
- **Uniqueness requires sequencing:** If mutations can't be ordered, different observers see different final states.
- **Sequencing requires consensus:** Without consensus on the order of events, there's no canonical sequence.
- **Censorship resistance requires liveness:** If resolution can be denied, censorship is trivial.
- **Liveness requires censorship resistance:** If the resolver can selectively refuse to answer, liveness is not guaranteed for all users. The two properties are mutually dependent — liveness without censorship resistance is liveness only for those the resolver chooses to serve.
- **Liveness requires availability:** If the resolver is down, resolution fails for everyone.

This dependency chain is why naming systems are hard. You can't solve one property in isolation. A system that has perfect authorization but no consensus will have uniqueness violations. A system that has consensus but no verifiable proofs will have integrity problems. A system that has everything but a single point of failure will have censorship vulnerability.

The art of naming system design is finding an architecture where all six properties are satisfied simultaneously, given the constraints of the underlying platform.

---

## 5. The Consensus Problem

All six properties ultimately depend on **consensus** — agreement among all participants on the state of the namespace. This is the deepest problem in naming system design.

There are three approaches to consensus for a naming system, each with different trust assumptions:

### 5.1 Authority-Based Consensus

A designated authority maintains the canonical state of the namespace. Everyone trusts the authority to be correct. Examples: DNS (the root zone is the authority), traditional certificate authorities.

- **Trust assumption:** The authority is honest and available.
- **Failure mode:** The authority is compromised, goes rogue, or is coerced.
- **Censorship resistance:** Low — the authority can refuse to register or can alter any mapping.
- **Practicality:** High — this is how most systems work today because it's simple.

### 5.2 Computation-Based Consensus

The namespace state is stored in a smart contract on a blockchain. The blockchain's consensus mechanism (proof-of-work, proof-of-stake) ensures all participants agree on the contract's state. Examples: ENS (Ethereum), Unstoppable Domains (Polygon).

- **Trust assumption:** The blockchain's consensus is sound, and the contract is correct.
- **Failure mode:** A bug in the contract, a 51% attack on the chain, or a governance decision to alter the contract.
- **Censorship resistance:** High — censoring a name requires attacking the chain itself.
- **Practicality:** Requires a blockchain with general-purpose computation.

### 5.3 Observation-Based Consensus

There is no central authority and no smart contract. Instead, the namespace state is derived from a public record of events (transactions on a blockchain) that anyone can observe and interpret. The "consensus" is not in a data structure maintained by a program — it's in the shared interpretation of a sequence of events. Each participant observes the same events and independently computes the same state. Examples: ZNS v2 (proposed) — Name Notes on the Zcash blockchain are interpreted by a deterministic scanner.

- **Trust assumption:** The underlying chain's consensus is sound, and the interpretation rules (the scanner logic) are deterministic and public.
- **Failure mode:** The interpretation rules are ambiguous or non-deterministic, or the chain itself is attacked.
- **Censorship resistance:** Medium — registration requires access to the mint, but resolution can be done by anyone running the scanner.
- **Practicality:** Requires only a blockchain that supports the necessary data fields (not general computation).

This third approach is what makes ZNS possible on Zcash. Zcash doesn't have smart contracts, so computation-based consensus is impossible. But Zcash does have a consensus-validated blockchain with structured note fields that can carry semantic meaning. If the interpretation of those fields is deterministic and public, then all observers who run the same scanner will compute the same namespace state — achieving consensus without a smart contract.

The tradeoff is that the "smart contract" is now in the scanner, not on the chain. The chain enforces the *integrity* of the notes (they are valid Orchard outputs), but the *semantics* (what the note means as a name binding) are enforced by the scanner. This means the trust assumption shifts from "the chain's computation is correct" to "the scanner's interpretation is correct" — which is why the scanner must be deterministic, open-source, and independently verifiable.

This shift has a critical consequence: **the protocol can be upgraded without a chain fork.** In ENS, changing the registration rules requires modifying the smart contract, which requires a governance process and a transaction. In observation-based consensus, changing the interpretation rules means changing the scanner software. This is more flexible but also more dangerous — a malicious scanner update could silently change the semantics of every existing name. The defense is the same as with any open-source security tool: deterministic builds, reproducible verification, and multiple independent implementations that must agree.

---

## 6. The Time Dimension

Names are not static. They are mutated over time — owners update addresses, transfer names, list names for sale, buy names from others. A naming system is not just a mapping; it is a **sequence of mappings over time.**

Names are not static. They are mutated over time — owners update addresses, transfer names, list names for sale, buy names from others. A naming system is not just a mapping; it is a **sequence of mappings over time.**

This introduces a property that doesn't exist in static data: **history.**

The history of a name is the ordered sequence of all mutations that have ever been applied to it. At any point in time, the current mapping is the result of applying all mutations up to that point, in order.

History matters for several reasons:

- **Verification:** To verify that the current mapping is correct, you may need to verify the chain of mutations that led to it. If Alice claimed `alice`, then updated the address, then sold to Bob, the current owner is Bob — but you can only know this if you can see the full history.
- **Auditability:** A name's history is an audit trail. If `alice` was hijacked, the history shows when and how. If `alice` was sold, the history shows the sale.
- **Dispute resolution:** If two parties claim ownership of a name, the history determines who has the stronger claim.
- **Nonces and replay protection:** Mutations must be ordered to prevent replay attacks. If Alice sends "update alice to address X" and an attacker resends the same message, the system must not apply it twice. Nonces (strictly increasing counters per name) or predecessor references (each mutation references the previous one) solve this.

The time dimension means the namespace is not a data structure — it is a **log.** The current state is a function of the log. This is why blockchains are natural foundations for naming systems: a blockchain is, at its core, an append-only log with consensus on ordering.

The question for any naming system is: **where does the log live, who can append to it, and who can read it?** The third question — readability — is what makes shielded naming systems fundamentally different from their transparent counterparts. In ENS, the log is public: anyone can see every registration, every update, every transfer. In ZNS, the log lives inside shielded transactions: the events are on-chain and consensus-validated, but their semantic content is encrypted. Reading the log requires a viewing key; interpreting it requires the scanner. This is not a limitation — it is the property that makes ZNS possible on a privacy-preserving blockchain. But it means the readability of the log is no longer a given; it is a design decision with privacy implications.

| System | Where the log lives | Who can append | Ordering guarantee |
|---|---|---|---|
| DNS | Zone files on authoritative servers | The authority for each zone | Administrative (not cryptographic) |
| ENS | Ethereum blockchain | The owner of each name (via transaction) | Block ordering (cryptographic) |
| ZNS v2 (proposed) | Zcash blockchain (Name Notes) | The mint (via shielded transaction) | Block ordering (cryptographic) |
| ZNS v1 (current) | Zcash blockchain (Orchard memos) | Anyone with an Ed25519 key (sovereign) or the admin key | Block ordering (cryptographic) |

---

## 7. Summary: What Makes a Global Naming System Possible

A global naming system is possible when these conditions are met:

1. **The mapping's two ends are understood.** The human-readable identifier (perceivable, memorable, reproducible, recognizable, communicable) and the machine-readable identifier (parsable, comparable, storable, transmittable, validatable) have opposing properties. The syntax rules for the namespace are a choice about where on this spectrum the human-readable end sits — and that choice is a security boundary, not just a technical preference.

2. **There is a consensus mechanism** that all participants can rely on to agree on the state of the namespace — whether authority-based, computation-based, or observation-based.

3. **Mutations are authorized and ordered** — only the owner can change a mapping, and all observers agree on the order of changes.

4. **Resolution is available and verifiable** — anyone can look up a name, and the result can be proven correct against the consensus state.

5. **The record is immutable** — once a mutation is recorded, it cannot be lost or altered without breaking the consensus mechanism.

6. **No single party can censor** — or if a party can censor, the system is designed so that censorship is difficult, detectable, or reversible.

7. **The namespace has defined syntax and allocation rules** — names have a known format, and there is a deterministic rule for who gets a name when multiple parties want it.

8. **The system has a defined recovery model** — when an owner's key is compromised, there is a known process (or a known absence of one) for recovering control of a name. In a payments context, key compromise means an attacker can redirect a name to their own address. Without a recovery model, compromised names are permanently lost — which is acceptable if it is an explicit design choice, but dangerous if it is an unintended consequence.

These are universal. They apply to DNS, ENS, ZNS, and any future naming system that has not yet been imagined. The specific implementation of each property is where design decisions live.