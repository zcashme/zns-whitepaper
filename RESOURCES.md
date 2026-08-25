# ZNS Whitepaper Resources

## Knowledge

- [ZNS grant application](https://github.com/ZcashCommunityGrants/zcashcommunitygrants/issues/298)
  The project's promised deliverables and current high-level technical approach. Use for scope and acceptance criteria; do not treat every sentence as settled protocol behavior.
- [ZNS grant proposal and public review thread](https://forum.zcashcommunity.com/t/grant-proposal-zcash-name-service/55737)
  Public presentation of the Name Note construction, intended TEE Mint, audit commitment, commercial questions, and reviewer concerns. Use to recover the proposal's narrative and the objections the whitepaper must answer.
- [Zcash Protocol Specification](https://zips.z.cash/protocol/protocol.pdf)
  The normative specification of the underlying Zcash protocol. Use whenever ZNS depends on Orchard notes, commitments, transaction ordering, fields, or decryption behavior.
- [ZIP 224: Orchard Shielded Protocol](https://zips.z.cash/zip-0224)
  The primary entry point for Orchard's design and its normative relationship to the Zcash Protocol Specification. Use for the structure and interpretation of Orchard notes and actions.
- [ZIP 212: Allow Recipient to Derive Ephemeral Secret from Note Plaintext](https://zips.z.cash/zip-0212)
  Defines receiving checks that apply to Sapling and Orchard note plaintexts. Use to evaluate claims about structured randomness and whether ordinary wallets accept ZNS Name Notes.
- [`zns-mint` reference implementation](https://github.com/zcashme/zns-mint)
  Implements the Mint: request memo parsing, OTP authorization and relay, Name Note creation, and operational state. Authoritative for implemented authorization behavior and the request/OTP memo grammars.

- [`zns-verify` reference implementation](https://github.com/zcashme/zns-verify)
  Implements the current ZNS binding derivation, Name Note commitment check, memo parser, and per-name predecessor rule. Use to distinguish implemented behavior from the broader promises in the grant.
- [BCP 14: RFC 2119 and RFC 8174](https://www.rfc-editor.org/info/bcp14)
  Defines the special meanings of uppercase requirement terms such as MUST, SHOULD, and MAY. Use when converting a ZNS design decision into an interoperability requirement.
- [Namecoin](https://www.namecoin.org/)
  Defines Namecoin's scope as a Bitcoin-derived key/value registration and transfer system and summarizes its public on-chain data model.
- [Namecoin FAQ](https://www.namecoin.org/docs/faq/)
  Defines Namecoin's registration operations, fees, renewal and expiration rules, resolution model, and anonymity limits. Use for comparisons between consensus-enforced Namecoin state and application-enforced ZNS state.
- [Ethereum Whitepaper](https://ethereum.org/whitepaper/)
  Defines ledgers as state transition systems and explains how Ethereum generalizes the transition function with contract code, persistent storage, and gas. Use to distinguish deterministic protocol computation from general-purpose smart contracts.
- [Ethereum Virtual Machine](https://ethereum.org/developers/docs/evm/)
  Defines the EVM as the deterministic execution environment used by Ethereum nodes. Use for comparisons between consensus-executed contract code and observer-executed ZNS Resolver rules.
- [ENSIP-1: ENS](https://docs.ens.domains/ensip/1/)
  Defines the ENS registry, registrars, resolvers, ownership, and resolver selection. Use to separate name authority from record resolution.
- [ENS Resolver Interface Standards](https://docs.ens.domains/resolvers/interfaces)
  Defines typed ENS records including addresses, text, public keys, and content hashes. Use when deciding whether ZNS is a payment alias or an extensible record root.
- [ENSIP-7: Contenthash](https://docs.ens.domains/ensip/7/)
  Defines the record that maps an ENS name to content-addressed networks such as IPFS and Swarm. Use for the `vitalik.eth.limo` resolution example.
- [eth.limo](https://eth.limo/)
  Documents the HTTP gateway that resolves ENS content records for ordinary browsers by appending `.limo`. Use to study how a name protocol becomes a user-facing application path.
- [Chaum, Fiat, and Naor: *Untraceable Electronic Cash*](https://chaum.com/wp-content/uploads/2021/12/Untraceable_Electronic_Cash.pdf)
  Defines bank-signed blinded coins, public verification, and double-spend handling in classic e-cash. Use to distinguish issuer certification of bearer value from the ZNS Mint's authority over name transitions.
- [ZIP 304: Sapling Address Signatures](https://zips.z.cash/zip-0304)
  Proposes message signatures proving control of a Sapling payment address. Use when evaluating whether ZNS can reuse wallet authority instead of introducing an independently backed-up owner key; account for its draft status, 320-byte raw signatures, and linkability properties.
- [The Halo 2 Book: Proof systems](https://zcash.github.io/halo2/concepts/proofs.html)
  Defines the relation, public inputs, private inputs, witness, circuit, and proof-security terms. Use before implementing or benchmarking the proposed PIR name circuit.
- [The Halo 2 Book: Using `halo2` in WASM](https://zcash.github.io/halo2/user/wasm-port.html)
  Documents browser proving constraints involving parallelism, workers, and memory. Use to identify deployment risks; do not treat its example measurements as ZNS mobile benchmarks.
- [`zcash/halo2`](https://github.com/zcash/halo2)
  Primary implementation source for the Halo 2 proving system and gadgets. Use when prototyping the PIR circuit and controlling prover parallelism.

## Wisdom (Communities)

- [Zcash Research forum](https://forum.zcashcommunity.com/c/technology/research/17)
  Use to expose protocol assumptions to Zcash researchers and solicit criticism of the trust and privacy model.
- [Zcash R&D Discord](https://discord.gg/zcash)
  Use for focused implementation questions after they have been reduced to a precise, answerable form.

## Gaps

- Local numbered design-doc directories (`1_naming_systems`, `2_privacy_and_identity`, `3_shielded_names`, `4_name_history`) have been removed; no local primary source docs remain.
- `paper/` has been emptied and its contents (`main.tex`, `sections/`, `figures/`, `watch.sh`) relocated to the repo root.
- The repository needs primary implementation sources for the existing ZNS system, including message examples and resolver behavior.
- The proposed `orchard-zns`, Mint, and Resolver repositories are not yet recorded here.
- A named cryptographic reviewer or protocol-engineering review process has not been recorded.
