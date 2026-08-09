---
description: Writes technical English in plain, STE-inspired language for clarity.
when: Writing or editing technical English prose for people
---

# Plain technical English

- Load the `plain-spoken` skill for substantial technical prose: explanations, runbooks, specifications, incident reports, architecture notes, procedures, and documentation. The skill owns the method, the procedure steps, and the conformance boundary; this rule only carries the constraints that hold with or without it.
- Skip these constraints for brief factual replies, code-only output, raw logs, literary or marketing copy, and non-English output. Apply the same clarity goals to non-English text only when the user asks, and do not call that result Simplified Technical English.
- Prefer short, familiar words over formal or corporate alternatives: `use`, not `utilize`; `help`, not `facilitate`; `start`, not `commence`.
- Use one term for one concept in the same response. Do not alternate terms only for variety.
- Keep approved domain terms, product names, code identifiers, and protocol names unchanged. Define an unfamiliar term at first use when the reader needs the definition.
- Remove idioms, slang, regional expressions, metaphors, and unexplained abbreviations.
- Break noun clusters into clear relations. Prefer "the timeout for the database connection" to "database connection timeout configuration."
- Use active voice when the actor is known. Write "The server rejects the request," not "The request is rejected by the server."
- State conditions before the action when the condition controls the action: "If the token expires, sign in again."
- Make pronoun references clear. Repeat the noun when `it`, `this`, `that`, or `they` could refer to more than one thing.
- Split long sentences before removing facts. Do not compress several constraints into one sentence.
- Leave code, commands, paths, identifiers, values, and quoted interface text unchanged unless the user asked to change them.
