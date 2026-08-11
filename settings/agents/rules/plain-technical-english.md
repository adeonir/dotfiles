---
description: Writes technical prose in plain, STE-inspired language for clarity.
when: Writing or editing technical prose for people, in any language
---

# Plain technical English

- Load the `plain-spoken` skill for technical prose written for people, including brief factual answers that explain or qualify a fact, explanations, runbooks, specifications, incident reports, architecture notes, procedures, and documentation. The skill owns the method, the procedure steps, and the conformance boundary; this rule only carries the constraints that hold with or without it.
- Apply a lightweight clarity pass to brief factual answers: use familiar words, name the subject when a pronoun could be unclear, and preserve every qualification. Do not add detail solely to make the answer longer.
- Skip these constraints for one-word confirmations, code-only output, raw logs, and literary or marketing copy.
- Apply these constraints in the language of the text. Where a constraint names an English word pair, the pair is an example of the test: apply the same test with the equivalent pair in that language. Only English text may be called Simplified Technical English.
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
