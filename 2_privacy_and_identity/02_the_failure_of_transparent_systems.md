# Context 06: The Failure of Transparent Systems (Prior Art)

This document explores how existing naming systems attempt to square Zooko's Triangle, and why their solutions fundamentally fail the privacy mandate required by Zcash. 

To understand the problem ZNS is solving, we must understand why we cannot simply copy the systems that came before it.

---

## 1. The DNS Compromise (Authority-Based)

The Domain Name System (DNS) is the most successful naming system in human history. It is secure (via DNSSEC and CA certificates) and human-meaningful. 

However, DNS sits firmly on the "Authority-Based" edge of Zooko's Triangle. It sacrifices decentralization. 
- **Centralized Root:** The entire system relies on ICANN and the root zone servers.
- **Censorship:** A single legal order to a registrar or registry can seize, redirect, or censor a domain.
- **Custodial by Default:** Users do not truly "own" a DNS domain; they lease it under the ongoing permission of a hierarchy of trusted third parties.

For a decentralized, permissionless payment network like Zcash, relying on a centralized naming authority re-introduces the exact counterparty risk the blockchain was designed to eliminate.

## 2. The ENS Breakthrough (Computation-Based)

The Ethereum Name Service (ENS) was a paradigm shift. It proved that you could move inside Zooko's Triangle by leveraging **computation-based consensus**. 

In ENS, the rule-set is encoded into a Turing-complete smart contract. The blockchain's decentralized consensus mechanism ensures that everyone agrees on the contract's state, and the contract enforces the rules (auctions, uniqueness, transfers). ENS achieved all three properties: secure, decentralized, and human-meaningful.

But ENS relies on two assumptions that Zcash rejects:
1. **General-Purpose Computation:** It requires a blockchain that can run arbitrary code to compute the state of the namespace on-chain.
2. **Total Transparency:** It requires the entire history of registrations, mutations, and resolutions to be publicly visible.

## 3. The Surveillance Namespace

The second assumption—total transparency—is fatal for a privacy-preserving network. 

A naming system maps a human identity to a routing address. In a transparent system like ENS, tying `alice.eth` to an Ethereum address means Alice is voluntarily doxxing her entire financial life. Anyone who resolves `alice.eth` instantly sees her balance, every entity she has ever transacted with, and every application she uses. 

This creates a paradox: **the more useful the name becomes, the more dangerous it is to use.** If Alice uses her ENS name to receive salary, buy coffee, and donate to a political cause, her entire social and financial graph is exposed. 

A true identity layer must support **selective disclosure**. It must allow Alice to provide a recognizable handle to Bob, without exposing her interactions with Charlie. 

## 4. The Zcash Dilemma

This leaves us with the core dilemma that necessitates ZNS v2:
- We cannot use an authority-based system (like DNS or ZNS v1) because it sacrifices decentralization and introduces trusted intermediaries.
- We cannot use a transparent computation-based system (like ENS) because it destroys privacy and requires Turing-complete smart contracts, which Zcash does not have.

The problem is now fully bounded. We must build a system that achieves global consensus on a human-meaningful namespace, without relying on trusted authorities, without exposing the social graph, and without utilizing on-chain smart contracts.
