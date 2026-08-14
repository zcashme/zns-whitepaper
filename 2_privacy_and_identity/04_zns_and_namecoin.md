# ZNS and Namecoin: The Consensus Boundary

Zcash consensus does not know whether a ZNS name is available, whether a ZNS
update is authorized, or which binding is current. Namecoin consensus does know
the corresponding facts for a Namecoin name. The two systems therefore place
the namespace state on opposite sides of the consensus boundary.

This comparison concerns that boundary. It does not compare adoption, monetary
policy, or supported applications.

---

## 1. Namecoin Places Name State Inside Consensus

Namecoin is a Bitcoin-derived blockchain with native name operations. A
`name_new` operation commits to an unrevealed name. A later
`name_firstupdate` operation reveals and registers that name. A `name_update`
operation changes the name's value, transfers its controlling output, or renews
the registration.

Namecoin nodes interpret these operations while validating the chain. They
derive the current owner, value, and expiration status of each name from
consensus-valid transactions. An operation that violates the Namecoin name
rules is not a valid state transition.

Namecoin does not require a Turing-complete smart contract for this behavior.
Its restricted name state machine is part of the blockchain's native consensus
rules.

The registered name and value become public when `name_firstupdate` reveals
them. Later `name_update` operations are public. Namecoin's Bitcoin-derived
transaction graph is also public, and Namecoin transactions are not anonymous
by default.

## 2. ZNS Places Name State Above Consensus

Zcash consensus validates the Orchard transaction that contains a Name Note. It
does not interpret the Name Note's `action`, `name`, `ua`, or `prev_rcm` fields.
A Zcash transaction can therefore be consensus-valid even when its memo claims
an invalid ZNS transition.

The ZNS Mint decides whether to create a Name Note. The Mint self-send rule lets
a Resolver verify that the action spent a recognized Mint-controlled note. It
does not prove that the Mint checked availability, authorization, pricing, or
lifecycle policy.

A ZNS Resolver scans the Zcash chain with the published full viewing key. It
decrypts candidate Name Notes, verifies their commitment derivation and Mint
self-send origin, and applies the ZNS transition rules in chain order. Invalid
ZNS transitions remain valid Zcash transactions but do not enter the Resolver's
namespace state.

The published full viewing key exposes every accepted Name Note's name and
Unified Address to a scanner. It does not expose ordinary shielded payments
received by that Unified Address. ZNS therefore separates a public name binding
from the recipient's shielded payment graph; it does not make the name registry
confidential.

## 3. Consequences of the Boundary

| Property | Namecoin | ZNS |
|---|---|---|
| Namespace transition rules | Enforced by Namecoin consensus | Enforced by Mint policy and deterministic Resolver rules |
| Invalid name operation | Rejected as an invalid Namecoin state transition | A consensus-valid transaction remains in Zcash; ZNS Resolvers ignore its name operation |
| Mutation authority | Spending authority for the current name output | Challenge plaintext access under the current draft, followed by a Mint-authorized self-send |
| Collision handling | Consensus validates the registration rule | The Mint checks availability before issuance; Resolvers accept the first valid claim in chain order |
| Registry visibility | Revealed names, values, and updates are public | Names and Unified Addresses are public to every holder of the published viewing key |
| Payment visibility | Bitcoin-derived transactions are public | Ordinary payments to the bound Unified Address remain shielded |
| Mutation liveness | Depends on transaction inclusion under Namecoin consensus | Depends on Zcash transaction inclusion and on the Mint accepting and processing the request |
| Rule changes | Require a Namecoin consensus change when the rule is consensus-critical | Require compatible Mint and Resolver behavior; a disagreement can split the interpreted namespace |

Independent ZNS resolution does not remove the Mint from the mutation path. A
Resolver can reject an invalid Mint action after it appears on-chain, but it
cannot create a valid Mint self-send when the Mint refuses a request or becomes
unavailable.

Namecoin shows that a blockchain without Turing-complete contracts can enforce
a namespace if name operations are native consensus objects. Applying that
model directly to Zcash would require Zcash consensus to interpret name
operations. ZNS avoids that consensus change by making Zcash the sequencer and
placing namespace interpretation in the Mint and Resolver.

This placement requires every ZNS security claim to distinguish five checks:

1. Zcash consensus validates and orders the Orchard transaction.
2. The Name Note commitment binds the parsed ZNS fields.
3. The Mint self-send proves authorization by the Mint spending key.
4. The Mint policy determines whether the requested transition is issued.
5. The Resolver rules decide whether the issued transition changes namespace
   state.

No earlier check implies a later check.

---

## 4. Sources

- [Namecoin](https://www.namecoin.org/) defines Namecoin as a Bitcoin-derived
  key/value registration and transfer system.
- The [Namecoin FAQ](https://www.namecoin.org/docs/faq/) defines
  `name_new`, `name_firstupdate`, `name_update`, renewal, expiration, and the
  privacy limits of Namecoin transactions.
- The ZNS [`Name Note`](../3_shielded_names/02_the_name_note.md),
  [`Mint Self-Send`](../3_shielded_names/03_the_mint_self_send.md), and
  [`User Authorization by Shielded Challenge`](../3_shielded_names/04_user_authorization_by_shielded_challenge.md)
  sections define the ZNS checks compared above.
