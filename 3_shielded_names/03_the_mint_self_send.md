# Context 10: The Mint Self-Send

The public full viewing key lets anyone find and decrypt Name Notes. It does not prove that the Mint authorized them. A third party can send an Orchard output to the public Name Note account and encode a syntactically valid ZNS memo.

ZNS authenticates the origin of a Name Note by requiring its Orchard action to be a **Mint self-send**. The action must spend a note controlled by the Mint and create its output back to the dedicated Name Note account.

This document introduces only the self-send origin rule. It does not define when the Mint should approve a user request or whether the enclave executed the correct approval policy.

---

## 1. Viewing Authority Is Not Spending Authority

An Orchard full viewing key can detect incoming and outgoing activity for its account. It can also derive the nullifier of a note received by that account.

A nullifier is the public identifier revealed when a shielded note is spent. The full viewing key therefore lets a Resolver recognize that an Orchard action spends a note previously received by the Mint account.

The full viewing key cannot create a valid spend-authorization signature. That signature requires the Mint's spending authority.

Consequently, knowledge of the public full viewing key lets a participant identify a Mint-controlled input but does not let that participant spend the input.

---

## 2. The Self-Send Rule

A Resolver treats an Orchard action as a Mint self-send only when all of these conditions hold:

1. The action's revealed input nullifier matches an unspent note previously recognized under the Mint's full viewing key.
2. The containing Orchard transaction is valid under Zcash consensus, including its Orchard proof and spend-authorization signature.
3. The action's output decrypts under the public full viewing key for the dedicated Name Note account.
4. The decrypted output parses as a Name Note.
5. The binding tuple and note components reproduce the action's `cmx` under the ZNS commitment derivation.

The first two conditions establish that the action spends a Mint-controlled note with the Mint's spending authority. The third condition establishes that the output returns to the Mint account. The final two conditions establish that the output is a valid Name Note rather than an ordinary self-payment.

---

## 3. Resolver State

A Resolver maintains a set of unspent notes controlled by the dedicated Mint account. It obtains that set by scanning the canonical Zcash chain with the public full viewing key.

When the Resolver encounters a valid Mint self-send, it performs two state changes:

1. Remove the spent input note identified by the action's nullifier from the unspent set.
2. Add the newly created output note to the unspent set.

The Name Note is eligible for namespace processing only after both the self-send rule and the Name Note commitment check succeed.

A transaction sent to the Mint account by a third party may create a note that the Mint can later spend. The incoming transaction is not itself a Mint self-send because its input nullifier does not identify a note previously controlled by the Mint.

---

## 4. Why Outgoing Decryption Is Not Authentication

An Orchard full viewing key includes outgoing viewing capability. This capability lets its holder recover information about outputs created using the corresponding outgoing viewing key.

The ZNS full viewing key is public. Its outgoing viewing capability is therefore public as well. A third party can use that public information when constructing outgoing ciphertext.

Successful outgoing decryption cannot serve as proof that the Mint authorized a transaction. The authorization evidence is the valid spend of a recognized Mint-controlled input.

---

## 5. What the Self-Send Proves

A valid Mint self-send proves that an entity holding the Mint spending authority authorized the Orchard action.

It does not prove:

- that the user requesting the action controlled the bound Unified Address;
- that an OTP challenge succeeded;
- that the requested name was available;
- that the Mint applied the correct price;
- that the action is valid under the name lifecycle rules; or
- that the spending key was used inside the attested enclave.

The self-send authenticates the Mint key. Remote attestation must separately bind that key to a specific enclave program and execution environment.

---

## 6. Bootstrap and Key Continuity

The first accepted Mint self-send requires a recognized Mint-controlled input note. A Resolver can identify candidate Mint notes by scanning from the published ZNS activation point with the public full viewing key.

The whitepaper must define the activation point and the initial Mint account before namespace processing begins. Otherwise, two Resolvers can disagree about which earlier notes belong to the Mint's initial unspent set.

If the Mint changes its spending key or full viewing key, the protocol must define an authenticated handoff from the old account to the new account. Publishing an unrelated replacement key is insufficient because a malicious operator could redirect the namespace to a different Mint.

---

## 7. Remaining Rules

The whitepaper must later specify:

- the ZNS activation block or marker transaction;
- how the initial Mint-controlled note set is derived;
- whether every Mint-controlled note may authorize a Name Note or one designated authorization chain is required;
- how concurrent Mint self-sends are ordered;
- how chain reorganizations restore the Mint's unspent-note set;
- how Mint key rotation is authorized; and
- how TEE attestation binds the Mint spending authority to reviewed enclave code.

Until those rules are fixed, the self-send establishes control of the Mint spending key but not compliance with the complete ZNS policy.

---

## 8. Sources

[ZIP 224](https://zips.z.cash/zip-0224) defines the Orchard note, nullifier, and RedPallas spend-authorization construction. [ZIP 225](https://zips.z.cash/zip-0225) defines the Orchard action fields and the correspondence between each action and its spend-authorization signature.

The [`orchard` key documentation](https://docs.rs/orchard/latest/orchard/keys/) distinguishes full viewing, incoming viewing, outgoing viewing, and spending authority. [ZIP 315](https://zips.z.cash/zip-0315) describes recognizing a spend by matching a revealed nullifier to a note previously held by a wallet.
