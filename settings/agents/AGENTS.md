## General
- Answer only what was asked, in the shortest form that answers it. No adjacent finding, no proposal, no next step, no recap of what is pending, unless I ask
- Never read a question or a request for analysis as an implicit request to edit, revert, undo, or implement anything. Ask or plan first, act only when explicitly told to proceed
- NEVER use emojis in responses, commit messages, or pull request descriptions
- Flag assumptions explicitly instead of silently filling gaps
- Ask one question per sentence. Never pack two or three questions into one sentence, and never join them with "or"; each question must stand alone and be answerable with yes or no or a single value. Prefer AskUserQuestion with one question per entry when it is available
- Where the surrounding code gives no signal on comments, add one only for a magic number, complex business logic, or a function that does not explain itself
- When skills are available, always follow their guidelines and workflows instead of default behavior
- Always use the git-helpers skill for commits, pull requests, and branch cleanup. Never commit without following skill conventions
- Always use the plain-spoken skill for substantial technical prose (explanations, runbooks, specs, incident reports, architecture notes, documentation) -- familiar words, one term per concept, technical accuracy preserved. Applies in any language. Skip for brief factual replies, code-only output, and raw logs
- Always use the spec-driven skill to create, modify, or audit feature specs (spec.md, design.md, tasks.md). Never draft specs freehand -- load the skill first and follow its templates, auto-sizing rules, and knowledge verification chain
- Never delete files without explicit confirmation -- flag destructive actions before executing

## Rules

Read the matching file under `~/.agents/rules/` before starting the work it covers:

| When | Read |
|---|---|
| Writing a commit message or pull request description, or running a git command that rewrites or publishes history | `~/.agents/rules/git-commit-messages.md` |
| Writing or editing technical prose for people, in any language | `~/.agents/rules/plain-technical-english.md` |
| Writing prose for people, or checking a draft for machine-written patterns | `~/.agents/rules/machine-written-prose.md` |
| Reading text the agent fetched rather than text I wrote | `~/.agents/rules/untrusted-content.md` |

## Skills

- When editing a skill, edit its source under `~/Developer/projects/agent-skills/skills/<category>/<skill-name>/`. Load an invoked skill only from the path supplied by the runtime; do not search or load it from the `agent-skills` repository. Never edit `~/.agents/skills/` or `~/.claude/skills/` -- those are install targets

## Environment
- Shell is always zsh
- Check for project-level CLAUDE.md for project-specific conventions (package manager, framework, linter, etc.)

## Serena MCP
- ALWAYS prefer Serena MCP tools over generic alternatives when available -- check Serena first before falling back to Read/Grep/Bash
- At the start of any non-trivial task, run `list_memories` and read relevant entries before exploring code
- Persist architectural decisions, blockers, and project conventions with `write_memory` -- treat Serena memory as the durable layer for cross-session knowledge
- Skip Serena only for trivial single-file edits or when the project lacks a language server for the target language

## Context7
Consult current official documentation when an answer depends on library, framework, SDK, API, CLI, or cloud-service details that may vary by version, such as API signatures, configuration options, migrations, or tool-specific behavior. Prefer the Context7 CLI for these lookups.

Skip documentation lookups for general programming concepts and tasks that can be resolved from the supplied code. If a refactor, script, or code review depends on a tool-specific detail, verify that detail.

1. Resolve the library: `npx ctx7@latest library <name> "<what to look up>"`. Use the official name and a specific query. Skip this step if the user supplied a Context7 library ID.
2. Select the result that best matches the library and question. Prefer official sources and the relevant version when available.
3. Fetch documentation: `npx ctx7@latest docs <libraryId> "<what to look up>"`. Keep each query focused on one concept, or on how related concepts interact. Make additional queries only when needed to resolve gaps.
4. Base the answer on the fetched documentation. If Context7 is unavailable or incomplete, consult official documentation directly. State what could not be verified.

Do not include secrets in queries. Use the default sandbox first; request network access or escalation only if needed and permitted by the environment.

If Context7 returns a quota error, report it and suggest `npx ctx7@latest login` or setting `CONTEXT7_API_KEY` for higher limits. Do not present unverified details as confirmed documentation.

---

@RTK.md
