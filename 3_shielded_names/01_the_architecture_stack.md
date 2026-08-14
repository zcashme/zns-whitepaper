# Context 08: The Architecture Stack of ZNS

If Section 2 defined the hostile environment of privacy networks, this document defines the spaceship we built to survive it. 

The Zcash Name Service (ZNS) is not a smart contract. It is a distributed architecture that separates the *sequencing* of events from the *semantics* of those events. To understand how ZNS works, you must understand the four distinct actors in the stack and how they interact to replace an on-chain state machine.

---

## 1. The Wallet Layer (The User)

The Wallet is the edge of the system. It is where human intent is formed and where names are ultimately resolved.

In a transparent network, wallets are thin clients that blindly trust a centralized RPC provider (like Infura) to resolve names. In ZNS, the Wallet is an active participant in verifiable resolution.

**The Wallet's Job:**
- Generate the cryptographic intent to register, update, or transfer a name.
- Request name resolutions from the Resolver without leaking its IP address or revealing which names it actually cares about (privacy-preserving queries).
- Cryptographically verify the proofs returned by the Resolver, ensuring that the resolution is authentic, fresh, and hasn't been tampered with.

## 2. The TEE Mint (The Enforcer)

Because Zcash lacks smart contracts, there is no on-chain logic to prevent Alice and Bob from registering the exact same name. If both registrations are valid Zcash transactions, both will be mined.

To prevent collisions and enforce the rules of the namespace (pricing, syntax, availability), ZNS introduces the **Mint**. The Mint operates inside a Trusted Execution Environment (TEE). 

**The Mint's Job:**
- Receive registration requests from Wallets.
- Check the current state of the namespace to ensure the requested name is actually available and valid.
- If valid, spend a Mint-controlled note to create a Name Note output back to the dedicated Mint account, then broadcast the transaction to the Zcash network.
- Provide a cryptographic attestation that it followed the open-source rules perfectly, without equivocating or leaking the user's shielded data.

The Mint acts as the highly constrained, verifiable gateway into the namespace.

## 3. The Blockchain (The Sequencer)

In ZNS, the Zcash blockchain is completely blind to the namespace. It does not know what a "name" is. It is utilized purely as an encrypted, decentralized, append-only log.

**The Blockchain's Job:**
- **Sequencing:** If two Mints attempt to register the same name at the same time, the Zcash consensus mechanism strictly orders one transaction before the other. The first one in the block wins; the second one is a collision and is ignored by the system.
- **Availability:** Ensure that the encrypted Name Notes are permanently available for anyone to download and scan.
- **Integrity:** Ensure that once a Name Note is mined, it cannot be altered or deleted.

## 4. The Resolver (The Off-Chain State Machine)

If the blockchain is the hard drive, the Resolver is the CPU. 

The Resolver is an open-source, deterministic scanner. Anyone can run a Resolver. It downloads the Zcash blockchain, uses the published full viewing key for the Name Note account to decrypt Name Notes, and processes them in chain order.

**The Resolver's Job:**
- Read the encrypted log from genesis to the chain tip.
- Reject ZNS-looking outputs that do not spend a note previously recognized as controlled by the Mint account.
- Apply the deterministic rules of the namespace to every Name Note (e.g., ignoring invalid syntax, dropping collisions, processing transfers).
- Compute the global state: a definitive map of who currently owns which name.
- Serve this state to Light Wallets, attaching cryptographic proofs so the Wallet doesn't have to trust the Resolver blindly.

---

## The Paradigm Shift: Observation-Based Consensus

By splitting the system into these four actors, ZNS achieves **Observation-Based Consensus**. 

There is no central database, and there is no smart contract. Instead, the "contract" is the deterministic logic shared by the Mint and the Resolver. The rules and the Name Note account's full viewing key are public. Any participant can therefore decrypt the Name Note log and apply the shared rules to it.

This architecture allows ZNS to square Zooko's Triangle without requiring a Turing-complete blockchain.
