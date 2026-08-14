# Context 09: The Name Note

Zcash consensus can validate an Orchard note without understanding a Zcash name. It does not interpret `alice`, a Unified Address, or a ZNS lifecycle action. ZNS therefore needs an Orchard note whose existing commitment can also bind a name action.

A **Name Note** is an Orchard note whose commitment randomness is derived from a ZNS action instead of exclusively from the note's random seed. This construction makes the action independently checkable against the note commitment recorded on-chain.

This document introduces only that construction. It does not define the memo grammar, decide whether an action is authorized, or determine which Name Note is the current state of a name.

---

## 1. The Ordinary Orchard Note

An Orchard note represents a value received at an Orchard address. Its commitment depends on these note components:

| Component | Meaning |
|---|---|
| `g_d` | The diversified base associated with the recipient's diversifier `d` |
| `pk_d` | The recipient's diversified transmission key |
| `v` | The note value |
| `rho` | A field element derived from the nullifier of the note spent in the same Orchard action |
| `psi` | A field element used by the note commitment and nullifier construction |
| `rcm` | The trapdoor that randomizes the note commitment |

An ordinary Orchard sender samples a 32-byte `rseed`. Orchard derives `psi`, `rcm`, and an ephemeral secret key from that seed. The sender then computes the Orchard note commitment and publishes its extracted x-coordinate, `cmx`, in the Orchard action.

The encrypted note plaintext contains the recipient diversifier, value, `rseed`, and memo. A recipient decrypts that plaintext, derives the ordinary Orchard values from `rseed`, reconstructs the note commitment, and checks that the reconstructed `cmx` equals the `cmx` in the transaction.

This equality check prevents a wallet from accepting a decrypted plaintext that does not describe the committed note.

---

## 2. Why an Ordinary Memo Is Insufficient

An ordinary Orchard memo can contain the text `ZNS:claim:alice:...`, but Zcash consensus assigns no meaning to that text. The Orchard commitment is normally derived from the note components and values derived from `rseed`, not from the ZNS fields in the memo.

Consequently, the existence of an Orchard note with a ZNS-looking memo does not by itself establish the ZNS derivation claimed by a Resolver. ZNS needs a deterministic relationship between the claimed action and the note's on-chain `cmx`.

The Name Note creates that relationship by deriving `psi` and `rcm` from the ZNS action fields.

---

## 3. The Binding Tuple

A Name Note binds four ZNS fields:

| Field | Meaning |
|---|---|
| `action` | The name-binding operation: `claim`, `update`, or `release` |
| `name` | The canonical name acted upon |
| `ua` | The Unified Address bound to the name; empty for `release`. Name Notes do not bind other payment-object types. |
| `prev_rcm` | The predecessor witness required by the per-name chain rule |

These four fields form the **binding tuple**. The tuple is not an additional Zcash consensus object. It is the ZNS interpretation of bytes recovered from the Name Note memo.

The current `zns-verify` implementation uses the domain tag `ZcashName/v1`. It computes two separate BLAKE2b-512 hashes over the domain tag, a field tag, and the binding tuple. The field tag is `psi` for one hash and `rcm` for the other.

The variable-length fields are prefixed with their lengths before hashing. `prev_rcm` is appended as exactly 32 raw bytes. This encoding prevents two different sequences of variable-length fields from being interpreted as the same hash input.

The `psi` hash output is reduced to a Pallas base-field element. The `rcm` hash output is reduced to a Pallas scalar. The resulting values replace the `psi` and `rcm` that an ordinary Orchard note would derive from `rseed`.

Changing any binding field changes the expected `psi`, `rcm`, and `cmx`, except with negligible probability under the assumed collision resistance of the hash and binding property of the commitment.

---

## 4. The Orchard Commitment Remains the Anchor

A Name Note uses the Orchard Sinsemilla note-commitment construction. ZNS does not add a separate name commitment to the transaction format.

The commitment still covers the ordinary note inputs `g_d`, `pk_d`, `v`, and `rho`. It also covers the ZNS-derived `psi` and uses the ZNS-derived `rcm` as its trapdoor.

The chain records `cmx`, the extracted x-coordinate of that commitment. The chain does not expose the name, Unified Address, `psi`, or `rcm` as new consensus fields.

The ZNS fields remain inside the encrypted memo. A party must recover or receive those fields before it can test which binding tuple produced the on-chain `cmx`.

ZNS publishes the Orchard full viewing key for the account dedicated to Name Notes. Any participant can use that key to scan Orchard actions, recover Name Note plaintexts, and construct an independent Resolver.

The published full viewing key grants viewing authority, not spending authority. It does not permit its holder to spend notes controlled by the Mint.

The viewing key does not prove that the Mint created a particular output. A third party can construct a transaction addressed to the public Name Note account and place ZNS-looking fields in its memo. A valid Name Note must therefore satisfy the Mint self-send origin rule defined in [`03_the_mint_self_send.md`](03_the_mint_self_send.md).

Publishing the key makes every Name Note action, name, Unified Address, value, and memo visible to anyone who scans with it. ZNS therefore does not provide confidentiality for name bindings. Its privacy property is that the bound Unified Address can receive ordinary shielded payments without making the recipient's subsequent payment activity part of the public name registry.

The published key must belong to an account used only for Name Notes. Reusing that account for ordinary payments, OTP messages, or private Mint operations would expose those records to every holder of the public key.

This produces two distinct properties:

1. Orchard consensus determines whether the containing transaction is a valid Zcash transaction.
2. ZNS verification determines whether a claimed binding tuple and note components reproduce the transaction's `cmx`.

Neither property implies the other.

---

## 5. Name Note Verification

A verifier requires these inputs:

- `action`, `name`, `ua`, and `prev_rcm` from the parsed Name Note memo;
- `g_d`, `pk_d`, `v`, and `rho` from the decrypted note and containing Orchard action; and
- the expected `cmx` from the containing Orchard action.

The public full viewing key supplies the viewing authority needed to recover the encrypted note fields. The Zcash chain supplies the containing Orchard action and its `cmx`.

The verifier performs three steps:

1. Derive `psi` and `rcm` from the binding tuple.
2. Recompute the Orchard note commitment from the ordinary note components and those derived values.
3. Compare the recomputed `cmx` with the transaction's `cmx`.

A match establishes that the supplied binding tuple and note components are consistent with that commitment under the ZNS derivation.

A match does not establish:

- that the Orchard action was mined in the canonical Zcash chain;
- that the Name Note is the latest valid action for the name;
- that the Mint performed the required authorization or pricing checks;
- that the name was available when the Mint created the note;
- that `prev_rcm` extends the correct predecessor; or
- that a Resolver has disclosed every later Name Note.

Those claims require chain inclusion, lifecycle, authorization, and freshness rules outside the per-note commitment check.

---

## 6. Why Standard Orchard Receiving Rejects a Name Note

An ordinary Orchard receiver derives `psi` and `rcm` from the decrypted `rseed`. A Name Note instead uses `psi` and `rcm` derived from the binding tuple.

The ordinary receiver therefore reconstructs a different note commitment. Its commitment check fails, so standard Orchard receiving logic does not recognize the Name Note as a valid received note.

The optional decryption path in `zns-verify` separates two checks:

1. It authenticates and decrypts the Orchard ciphertext without applying the ordinary `rseed`-based commitment check.
2. It applies the ZNS commitment check using the binding tuple recovered from the memo.

Skipping the ordinary commitment check is safe only when the caller subsequently performs the ZNS commitment check. Successful decryption alone proves neither a valid ZNS binding nor a valid lifecycle transition.

---

## 7. The Predecessor Witness

The commitment binds `prev_rcm`, but `prev_rcm` is not independently recoverable from `cmx`. The Name Note memo therefore discloses `prev_rcm` as 32 bytes encoded in lowercase hexadecimal.

This disclosure lets a verifier test one Name Note without first deriving the predecessor value from the complete history.

The per-note check only proves that the disclosed predecessor was committed. A separate chain rule must determine whether that predecessor is the correct one for the name and action.

For the first `claim` of a name, ZNS uses 32 zero bytes as `prev_rcm`. An `update` or `release` must reference the `rcm` of the current live tip. A new `claim` after `release` must reference the `rcm` of that `release`.

This rule preserves one continuous history across separate registrations of the same name. A Resolver can therefore trace the current registration back through the preceding release and every earlier registration.

The current `zns-verify` implementation resets `prev_rcm` to zero for a claim after release. That implementation rule conflicts with the intended continuous-history rule and must change before the whitepaper treats the implementation as normative.

---

## 8. Current Construction Boundary

The Name Note action set consists of `claim`, `update`, and `release`. A Name Note binds one of those actions to a Unified Address and predecessor.

`list` and `buy` are marketplace actions, not Name Note actions. They require a separate construction and do not extend the name-binding action set.

The current implementation establishes a per-note binding check. It does not by itself establish a complete resolver-independent proof of current namespace state.

The whitepaper must later specify:

- the canonical memo grammar and exact byte encodings;
- the source and validation of every verification input;
- the encoding, publication, rotation, and replacement rules for the public full viewing key;
- the proof that `cmx` belongs to a mined Orchard action;
- the ordering, finality, and reorganization rules for Name Notes;
- the authorization rule for each action;
- the completeness or freshness argument for a resolved name; and
- the separate construction and history rules for `list` and `buy`.

Until those rules are fixed, the Name Note should be described as a commitment to one claimed action, not as proof of the current owner or current address of a name.

---

## 9. Sources and Status

The ordinary Orchard construction in this document is derived from the [Zcash Protocol Specification](https://zips.z.cash/protocol/protocol.pdf), [ZIP 224](https://zips.z.cash/zip-0224), and [ZIP 212](https://zips.z.cash/zip-0212).

The ZNS construction is derived from the [ZNS grant application](https://github.com/ZcashCommunityGrants/zcashcommunitygrants/issues/298) and the current [`zns-verify` implementation](https://github.com/zcashme/zns-verify).

The Zcash sources define the underlying Orchard protocol. The `zns-verify` source records the current ZNS implementation. The final whitepaper must decide which ZNS details are normative and pin them to reviewed test vectors.
