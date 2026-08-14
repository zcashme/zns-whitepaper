# AGENTS.md — ZNS Whitepaper

## Document Type

A technical whitepaper that serves as the specification (ground truth) for the Zcash Name
Service (ZNS). 

The intended reader is a protocol engineer or cryptographer who
will implement or evaluate the system.

## What the AI Assitant Should Do

When asked to draft a section:

1. Identify whether you are writing a constraint, a definition, or a consequence.
2. Check every sentence: is it one of those three things? If not, cut it.
3. Check for marketing language, hedging, and throat-clearing. Cut all of it.
4. Ensure the section introduces exactly one concept.
5. Ensure the section opens with the problem, not the solution.
6. Find the simplest expression of every idea. If a sentence is complex, it is probably doing two things — split it.
7. If you reference something that appears later in the document, make it a specific promise, not a vague gesture.
8. Do not add math unless you are proving a specific claim that prose cannot carry.

When asked to review a section:

1. Read every sentence. Ask: "Is this a constraint, a definition, or a consequence?" If the answer is "none of the above," flag it.
2. Ask: "Could this sentence appear in any competitor's whitepaper?" If yes, it is too generic. Make it specific to ZNS or cut it.
3. Ask: "Does this sentence advance the argument?" If it restates something already said, cut it.
4. Ask: "Is there a simpler way to say this?" If yes use the simpler way.

## Writing Style & Guidelines

Your writing style should be a rigorous synthesis of three distinct paradigms:

1. **George Orwell / Aaron Swartz (Clarity):** Use active voice, short sentences, and concrete English. Ban all marketing fluff, hedging, and throat-clearing (e.g., "seamless", "robust", "delve", "leverage", "it's worth noting", "plays a crucial role").
2. **Zellic Security Audits (Precision):** Write strictly in terms of definitions, invariants, constraints, and consequences. If a sentence is none of these, cut it. Explicitly isolate failure domains, state preconditions, and specify cardinality (e.g., "a single authoritative service" vs "a permissionless client").
3. **SICP (Conceptual Depth):** Do not write robotic, disconnected bullet lists. Provide elegant, profound connective tissue. Introduce the fundamental tension or trade-off first. Explain the architectural paradigm shift (e.g., "derived state", "metacircular separation") that resolves the tension before listing the mechanical constraints.

## Core Execution Loop

When drafting or reviewing a section, strictly follow this loop:

* **Rule 1:** Open with the problem and the trade-off, not the solution.
* **Rule 2:** State the philosophical invariant or conceptual shift (the "why") that resolves the tension.
* **Rule 3:** Define the components and strict constraints (the "how"). Every sentence here must be a literal Constraint, Definition, or Consequence.
* **Rule 4:** Find the simplest expression of every idea. If a sentence contains a semicolon or does two things, split it into two sentences.
* **Rule 5:** Ask: "Could this sentence appear in a competitor's whitepaper?" If yes, it is too generic. Make it specific or cut it.
