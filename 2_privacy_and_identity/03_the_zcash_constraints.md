# Context 07: The Zcash Substrate Constraints

If the mandate is to build a privacy-preserving naming system, we must build it natively on Zcash. However, the architecture of Zcash imposes strict constraints that dictate exactly how a naming system can and cannot be designed. 

To solve the problem, we must first define the shape of the box we are trapped in.

---

## 1. No Turing-Complete Smart Contracts

The most defining characteristic of Zcash, relative to a network like Ethereum, is its lack of general-purpose, on-chain computation. 

Zcash does not have smart contracts. You cannot deploy a state machine to the chain that enforces arbitrary rules. 
- You cannot write a contract that says "If Bob pays 5 ZEC and `alice.zcash` is available, assign `alice.zcash` to Bob."
- You cannot write a contract that automatically increments a block height and expires a name.

**The implication:** Zcash's current consensus rules do not compute or enforce ZNS allocation, collision, or transition rules. They determine whether a transaction is a valid Zcash transaction, not whether its memo violates a ZNS rule.

Namecoin shows that a non-Turing-complete chain can enforce a restricted namespace through native consensus rules. Zcash has no equivalent name operations. Adding them would require a Zcash consensus change. [`04_zns_and_namecoin.md`](04_zns_and_namecoin.md) compares that consensus-enforced model with the ZNS Mint and Resolver model.

## 2. The Append-Only Shielded Log

What Zcash *does* have is an extraordinarily secure, decentralized, append-only log. 

With the introduction of the Orchard shielded protocol, Zcash allows users to embed structured data (memos) inside encrypted transactions. These transactions are strictly ordered by the consensus mechanism (blocks) and are immutable once finalized.

- **The Good:** We have a decentralized sequencer. If Alice and Bob both try to register the same name at the same time, the Zcash consensus mechanism will definitively order one transaction before the other.
- **The Catch:** The data inside these transactions (the Name Notes) is shielded. The blockchain consensus validates the proof of the transaction, but it does not know what the transaction "means" or what data it holds. 

## 3. The Memo Field Bottleneck

To write state to the Zcash log, we must use the memo field of shielded notes. The memo field is limited to 512 bytes.

This is a hard cryptographic limit. Every registration, mutation, or state transition must be serialized and compressed to fit within this limit. 
- You cannot store heavy profile pictures on-chain.
- You cannot store massive lists of subnames in a single transaction.
- You must carefully balance the bytes used for cryptographic proofs, target addresses, and the name string itself.

**The implication:** The on-chain footprint of ZNS must be radically minimalist. It can only serve as the cryptographic root of the identity, relying on off-chain auxiliary mechanisms to handle rich data.

## 4. Summary of the Problem State

By combining the motivation, the prior art, and the substrate constraints, the overarching problem statement of the ZNS Whitepaper is defined:

**How do we achieve global consensus on the state of a human-meaningful namespace, using only an encrypted, append-only log with 512-byte memos, without relying on a centralized authority or a Turing-complete smart contract?**

The answer to this question requires a paradigm shift from *computation-based consensus* to *observation-based consensus*, which forms the architectural core of ZNS.
