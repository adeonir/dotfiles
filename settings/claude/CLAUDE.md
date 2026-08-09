## General
- When I ask a question during a conversation, treat it as a question -- answer only what was asked, never adding extra information, adjacent findings, or unrequested next steps
- Never read a question or a request for analysis as an implicit request to edit, revert, undo, or implement anything. Ask or plan first, act only when explicitly told to proceed
- Keep responses short and direct — avoid excessive formatting and verbose explanations
- NEVER use emojis in responses, commit messages, or pull request descriptions
- Flag assumptions explicitly instead of silently filling gaps
- Always use descriptive variable names
- Only add comments for magic numbers, complex business logic, or non-self-explanatory functions
- When skills are available, always follow their guidelines and workflows instead of default behavior
- Always use the git-helpers skill for commits, pull requests, and branch cleanup. Never commit without following skill conventions
- Always use the plain-spoken skill for substantial technical prose (explanations, runbooks, specs, incident reports, architecture notes, documentation) -- familiar words, one term per concept, technical accuracy preserved. Skip for brief factual replies, code-only output, raw logs, and non-English output
- Always use the spec-driven skill to create, modify, or audit feature specs (spec.md, design.md, tasks.md). Never draft specs freehand -- load the skill first and follow its templates, auto-sizing rules, and knowledge verification chain
- Never delete files without explicit confirmation -- flag destructive actions before executing

## Environment
- Shell is always zsh
- Check for project-level CLAUDE.md for project-specific conventions (package manager, framework, linter, etc.)

## Serena MCP
- ALWAYS prefer Serena MCP tools over generic alternatives when available -- check Serena first before falling back to Read/Grep/Bash
- At the start of any non-trivial task, run `list_memories` and read relevant entries before exploring code
- Use `get_symbols_overview` for first-pass file understanding instead of reading the whole file
- Use `find_symbol` / `find_referencing_symbols` for semantic code navigation instead of text search
- Use `rename_symbol` / `replace_symbol_body` / `insert_after_symbol` for symbol-level edits instead of line-based Edit when refactoring
- Persist architectural decisions, blockers, and project conventions with `write_memory` -- treat Serena memory as the durable layer for cross-session knowledge
- Skip Serena only for trivial single-file edits or when the project lacks a language server for the target language

@RTK.md
