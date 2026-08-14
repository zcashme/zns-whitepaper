# Context 05: The Identity Gap in Shielded Networks

This document defines the core problem and motivation for the Zcash Name Service (ZNS). It argues that the fundamental missing piece for mainstream adoption of privacy networks is not just usability, but a native, shielded identity layer.

---

## 1. An Address is Not an Identity

A Zcash shielded address (a Z-address) is a cryptographic primitive. It is designed to be an opaque, unreadable blob of data, acting as a secure routing destination for value. 

However, human interaction requires recognition, reputation, and trust. You cannot build a social graph, a reputation system, or a recognizable merchant network on top of ephemeral, unreadable blobs. Without a human-meaningful anchor, a privacy network is effectively a dark forest. 

The lack of a naming system means:
- **Commerce is high-friction:** Users must carefully verify 70+ character strings for every transaction.
- **Recurring interactions are unsafe:** If an address changes or is typed incorrectly, funds are lost permanently.
- **Reputation cannot accumulate:** A merchant or creator cannot build brand recognition around a string that humans cannot perceive or remember.

## 2. The Public Identity Trap (Why ENS Fails Privacy)

If the problem was just mapping strings to addresses, a transparent system like the Ethereum Name Service (ENS) would suffice. But a global namespace built on a transparent ledger is not a true digital identity—it is a surveillance tag.

When a user ties a human-readable name (like `alice.eth`) to a transparent address, they are voluntarily publishing their entire financial history and future transactions to the world. Anyone who interacts with `alice.eth` can see her balance, who she transacts with, and what applications she uses. 

True identity requires **selective disclosure**—the ability to be known without being fully exposed. A system must allow Alice to say "I am Alice" to the network, without revealing her balance or transaction graph to the network. Zcash, with its shielded pool, is the only network capable of supporting this natively, provided the namespace itself can preserve that privacy during resolution.

## 3. The Auxiliary Layer: From Name to Persona

A name (`alice`) is merely the anchor. A true identity requires expressiveness. By attaching auxiliary mechanisms to the core namespace, the name evolves into a **persona**.

These auxiliary mechanisms include:
- **Text Records & Metadata:** Linking social handles, websites, or PGP keys.
- **Avatars:** Attaching a visual representation to the identity.
- **Subname Delegation:** Allowing an organization (`company.zcash`) to issue identities to its members (`employee.company.zcash`).
- **Reverse Resolution:** Allowing an application to display `alice.zcash` instead of a long Z-address when Alice connects her wallet.

In ZNS, these auxiliary records do not need to bloat the blockchain. We are enabling verifiable profiles that can live entirely off-chain, while remaining cryptographically bound to the shielded on-chain root of the name.

## 4. The Economics of Identity (Scarcity and Conflict)

Because human-meaningful strings are short and memorable, identity is inherently scarce. There is only one `alice` in a global namespace. 

The economic and lifecycle rules of the namespace are often viewed purely as market mechanics, but they are fundamentally the tools we use to resolve human conflict over identity:
- **Squatting** is not just an economic inefficiency; it is an impersonation attack and a denial of identity to a legitimate user.
- **Pricing and Auctions** are the decentralized mechanisms for allocating a scarce societal resource without a central gatekeeper.
- **Expiry** is the controlled decay and death of an abandoned persona, ensuring that the namespace does not become a graveyard of lost keys.

Building ZNS is not just about routing payments; it is about establishing the economic and cryptographic rules of engagement for identity in a shielded ecosystem.
