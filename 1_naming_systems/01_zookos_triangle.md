# Context 01: Zooko's Triangle

This document is about the central tension that every naming system design must confront. It defines Zooko's Triangle, explains where it comes from, walks through each property and why each pair is compatible but the triple is hard, and locates the design space that ZNS must navigate.

---

## 1. The Claim

In 2006, Zooko Wilcox — later a co-founder of Zcash — observed that naming systems seem to be caught in a trilemma. He wrote, roughly:

> You can't have all three of the following in a naming system:
> - **Secure:** the name resolves to what the legitimate owner intended, and an attacker cannot redirect it.
> - **Decentralized:** no single party controls the namespace; no one can be coerced or bribed into altering or censoring mappings.
> - **Human-meaningful:** names are strings that humans can read, remember, type, and recognize — not random hashes or opaque identifiers.

You can have any two. You cannot have all three. The three properties sit at the corners of a triangle, and a naming system is a point on the triangle's edges — never inside it.

This is **Zooko's Triangle.** It is not a theorem. It is not proven. It is an empirical observation, distilled from decades of naming system designs, that the three properties pull against each other and that no one had, at the time, found a system that satisfied all three simultaneously.

The claim matters because it names the real problem. Before Zooko, naming system designs tended to fail in predictable ways and their designers would insist the failure was fixable with more engineering. Zooko's Triangle says: the failure is not a bug, it is a tension in the requirements. You will not engineer your way out of it by trying harder. You will get out of it only by finding a new substrate or a new mechanism that changes what is possible.

The history of naming system design since 2006 is, in large part, the history of attempts to square the triangle — to find a point inside it.

---

## 2. The Three Properties

### 2.1 Secure

A naming system is **secure** if, when a user resolves a name, the result they get is the result the legitimate owner of that name intended — and an attacker cannot cause the user to get anything else.

"Legitimate owner" means the agent the system recognizes as the current holder of the name. "Intended" means the binding the owner deliberately set. An attacker is anyone who is not the legitimate owner and who wants the binding to resolve differently.

Security has two halves:

- **Authenticity of mutation.** Only the legitimate owner can change the binding. An attacker cannot rewrite `alice` to point at their own address.
- **Integrity of resolution.** When a user resolves `alice`, what they receive is the genuine current binding, not a substituted or altered value. An attacker cannot intercept resolution and return a false answer.

A system can satisfy one half and not the other. A system with strict mutation control but no integrity of resolution is vulnerable to a man-in-the-middle who leaves the registry alone but lies to resolvers. A system with verifiable resolution but open mutation is vulnerable to anyone who rewrites the binding. **Secure** requires both.

### 2.2 Decentralized

A naming system is **decentralized** if no single party can, acting alone, alter, revoke, refuse, or censor a mapping.

This is a negative property — it is defined by the *absence* of a point of control. To evaluate it, ask: **what is the smallest set of parties that must cooperate to censor, alter, or revoke a specific name?** If the answer is "one party," the system is centralized. If the answer is "a large group that must conspire and cannot easily be made to conspire," the system is decentralized.

Decentralization is a spectrum, not a boolean. The useful question is not "is it decentralized?" but "how concentrated is the power, and how hard is it to abuse that concentration?" A system with five operators is more decentralized than a system with one. A system whose operator can be replaced by anyone is more decentralized than one whose operator is enshrined.

The thing that makes decentralization hard is that **every naming system needs an agreement mechanism** (see `00_naming_system.md` §4 and `02_namespace_properties.md` §4) — some way for all participants to converge on the same binding. The simplest agreement mechanisms are centralized: trust one authority. Decentralization requires an agreement mechanism where no single party is the authority.

### 2.3 Human-meaningful

A naming system is **human-meaningful** if its names are strings that a human can **perceive, remember, reproduce, recognize, and communicate.**

This is the property that pulls names toward the human side of the human/machine identifier gap (see `identifiers.md`). A human-meaningful name is short, drawn from a familiar character set, free of visually confusable alternatives, and pronounceable enough to share over a phone call. `alice` is human-meaningful. `0x7f3a...c2b9` is not. `u1qqabc...` is not. A 56-character Tor onion address is not.

Human-meaningfulness is in tension with the other two properties because it is the property that makes names **scarce and desirable.** There are only so many short, memorable strings. Everyone wants `alice`; only one agent can have it. That scarcity creates conflict — collisions, squatting, impersonation — and conflict is what security and decentralization have to manage. A namespace of random hashes has no collisions and no squatting, because no one wants a random hash. Human-meaningfulness is the property that *generates* the problem the other two properties have to solve.

---

## 3. Why the Pairs Are Compatible

Zooko's claim is not that any two properties are hard to combine. It is that *all three* are hard to combine. Each pair is achievable. This is why the triangle is a triangle of edges, not a wall.

### 3.1 Secure + Decentralized (sacrificing human-meaningful)

Build a system where the binding for a label is derived from a public key, and the label itself is the hash of the public key. To resolve a name, you look up the hash and read the corresponding public key. To mutate, the holder signs the new binding with the private key. Agreement is achieved because every participant can verify the signatures and the hash-to-key relationship themselves — no authority is needed.

This is **self-certifying naming.** It is secure (signatures) and decentralized (no authority). But the labels are hashes. They are not human-meaningful. A user cannot remember, type, or recognize a 32-byte hash.

Examples: Tor onion services, PGP key fingerprints, SSB identifiers.

### 3.2 Secure + Human-meaningful (sacrificing decentralized)

Build a system where a trusted authority maintains the registry. The authority binds human-meaningful labels to referents and signs each binding. Users resolve names by querying the authority and checking the signature against the authority's well-known public key. Mutations require the authority to verify that the requester is the legitimate owner.

This is **certificate-authority style naming.** It is secure (the authority's signature is cryptographic) and human-meaningful (the labels are words). But the authority is a single point of control. Whoever controls the authority's key can censor, alter, or revoke any name. The system is centralized.

Examples: DNS with DNSSEC, conventional certificate authorities, a corporate internal directory run by IT.

### 3.3 Decentralized + Human-meaningful (sacrificing secure)

Build a system where every participant maintains their own personal mapping of labels to referents, and there is no global agreement. You call `alice` whoever you've decided `alice` is; I call `alice` whoever *I've* decided `alice` is. No authority. No collision. No global namespace at all.

This is **petname naming.** It is decentralized (no one controls anyone else's bindings) and human-meaningful (you choose your own labels). But it is not secure in the global sense — there is no global binding to be secure about. When I say `alice`, I mean my Alice; when you say `alice`, you mean your Alice. The names do not travel. They are local, not global.

Examples: personal address books, SSB petnames, contact lists in any messenger app.

### 3.4 The Three Edges

| Edge | Held | Sacrificed | Example |
|---|---|---|---|
| Secure + Decentralized | security, decentralization | human-meaningful | Tor onion services |
| Secure + Human-meaningful | security, human-meaningful | decentralization | DNS + DNSSEC |
| Decentralized + Human-meaningful | decentralization, human-meaningful | global security | petname systems |

Every pre-blockchain naming system that anyone actually used sat on one of these three edges. None sat inside the triangle. That is Zooko's empirical claim.

---

## 4. Why the Triple Is Hard

The triple is hard because **the three properties make incompatible demands on the agreement mechanism.**

Security requires that the binding be **verifiable**: a resolver must be able to prove that the answer they got is the genuine binding, not a substitution. This pushes toward a binding that is signed, committed, or otherwise backed by cryptographic evidence that anyone can check.

Decentralization requires that the agreement mechanism have **no single point of control**: no party who can unilaterally alter, withhold, or rewrite the binding. This pushes toward a binding that is replicated, consensus-driven, and resistant to coercion.

Human-meaningfulness requires that the labels be **short, memorable, and chosen by humans**: `alice`, not `0x7f3a...c2b9`. This means the labels collide — many agents want the same short string — and the collision must be resolved by some allocation rule that picks one binding as the global one.

Put the three together and the demands compound:

- The binding must be verifiable (security), so it must be backed by something a resolver can check.
- The binding must be globally agreed (decentralization forbids a single authority to do the agreeing), so the backing thing must be something many mutually distrustful parties can all check and converge on.
- The label must be a human-chosen string that collides (human-meaningful), so the backing thing must also encode a deterministic rule for who wins the collision.

The reason the triple is hard is the last condition. Self-certifying systems (secure + decentralized) avoid collisions entirely by making the label a function of the key — but then the label is not human-meaningful. Authority systems (secure + human-meaningful) resolve collisions by letting the authority pick — but then the system is centralized. Petname systems (decentralized + human-meaningful) avoid the collision by not having a global namespace at all — but then the names are not globally secure.

To get all three, you need a substrate where:

1. A binding can be published in a form that anyone can verify (security).
2. The publication happens through a mechanism with no single point of control (decentralization).
3. The label space is human-chosen and collision-prone, and the collision is resolved by a deterministic, publicly-agreed rule (human-meaningful + global agreement).

For most of history, no such substrate existed. The three requirements seemed to genuinely require incompatible infrastructure.

---

## 5. The Blockchains Reframe

Blockchains introduced a new substrate, and with it a new option: **computation-based consensus.** A blockchain is, at its core, an append-only log whose contents are agreed upon by a decentralized set of participants who do not trust each other. If the binding for a name is stored as state in a program running on that log, then:

- The binding is **verifiable** — anyone can check the chain state and confirm the answer. (security)
- The agreement is **decentralized** — no single party controls the chain's consensus. (decentralization)
- The label can be a **human-chosen string** — the program just stores `alice → address`, and resolves collisions by first-come or auction. (human-meaningful)

This is what ENS does on Ethereum, and it is the standard answer to "how do you square Zooko's Triangle?" The blockchain provides the substrate that makes the triple possible, by giving the agreement mechanism a form that is simultaneously verifiable, decentralized, and tolerant of human-chosen labels.

But notice the dependency: **this requires a substrate that can run programs.** ENS works because Ethereum is a general-purpose computer. The naming logic lives in a smart contract, and the contract's state is the namespace. Without general-purpose computation on the substrate, the ENS approach is not available.

This is the situation ZNS is in. Zcash is a blockchain, but it is **not a general-purpose computer.** It has consensus, it has an append-only log, it has shielded notes with structured fields — but it does not have smart contracts. So the ENS answer — "use computation-based consensus to square the triangle" — is not directly available. ZNS must find a different point inside the triangle, or a different way to reach one.

---

## 6. The Triangle as a Design Map

Zooko's Triangle is most useful as a **map of the design space**, not as a verdict. It tells you which corner you are sacrificing when you make a given choice, and it forces you to be honest about it.

For ZNS, the map is:

- **ZNS v1** sits on the Secure + Human-meaningful edge. Names are human-readable (`alice.zcash`). The Ed25519 signature on each action makes mutations authentic. But the system is centralized: there is one operator, one indexer, one admin key, and no way for a user to verify a resolution independently. If the operator lies or is coerced, the user gets a wrong answer and cannot tell. The triangle's verdict: **sacrifices decentralization.**

- **ZNS v2** attempts to move inside the triangle. The goal is to keep human-meaningful names, keep security (via on-chain Name Note commitments that a verifier can check directly), and gain as much decentralization as the Zcash substrate allows (via a TEE-constrained mint, deterministic scanners, and a verification crate that removes the need to trust the resolver). The triangle's question for ZNS v2: **does the Zcash substrate provide enough to actually reach the interior, or does the lack of smart contracts cap the system at an edge?**

This is the question the whitepaper must answer. The remaining context documents supply the pieces — the properties a global namespace must satisfy (`02_namespace_properties.md`), the identifier constraints (`identifiers.md`), the Zcash substrate (`00_naming_system.md` §7), and the attacker model (`00_naming_system.md` §4). Zooko's Triangle is the frame that holds them together and gives the answer its meaning.

---

## 7. Summary

- **Zooko's Triangle** is the empirical claim that a naming system can have at most two of: secure, decentralized, human-meaningful.
- Each **pair** is achievable and corresponds to a known family of systems: self-certifying (secure + decentralized), authority-based (secure + human-meaningful), petname (decentralized + human-meaningful).
- The **triple** is hard because the three properties make incompatible demands on the agreement mechanism — and for most of history, no substrate satisfied all three demands at once.
- **Blockchains** introduced a substrate (computation-based consensus) that can satisfy all three, which is how ENS squares the triangle — but only on chains that support general-purpose computation.
- **ZNS** is on a chain that does not. Squaring the triangle on Zcash, without smart contracts, is the design problem the whitepaper must solve, and Zooko's Triangle is the frame in which the solution is evaluated.