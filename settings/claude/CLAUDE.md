## General
- Always use descriptive variable names
- NEVER use emojis in responses, commit messages, or pull request descriptions
- Keep responses short and direct — avoid excessive formatting and verbose explanations
- Only add comments for magic numbers, complex business logic, or non-self-explanatory functions
- When writing files in Portuguese, always use proper accents (e.g., "código", "informação", "será", "não", "área") — in chat responses accents are optional
- When skills are available, always follow their guidelines and workflows instead of default behavior
- Never run destructive git commands (push, reset --hard, clean, amend) without explicit confirmation -- always create a new commit instead of amending
- Never delete files without explicit confirmation -- flag destructive actions before executing
- Flag assumptions explicitly instead of silently filling gaps
- Never add Co-Authored-By or any Claude attribution to commit messages or pull request descriptions
- When I ask a question during a conversation, treat it as a question -- just answer it
- Do NOT interpret questions as implicit requests to revert, undo code, modify, or make changes
- When the user asks a question or requests analysis, do NOT start editing files or implementing changes. Ask/plan first, act only when explicitly told to proceed
- Always use the git-helpers skill for commits. Follow conventional commit format with contextual bullet points in the body (not paragraphs). Never commit without following skill conventions
- Always use the spec-driven skill to create, modify, or audit feature specs (spec.md, design.md, tasks.md). Never draft specs freehand -- load the skill first and follow its templates, auto-sizing rules, and knowledge verification chain

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
