## General
- Always use descriptive variable names
- NEVER use emojis in responses, commit messages, or pull request descriptions
- Keep responses short and direct — avoid excessive formatting and verbose explanations
- Only add comments for magic numbers, complex business logic, or non-self-explanatory functions
- When writing files in Portuguese, always use proper accents (e.g., "código", "informação", "será", "não", "área") — in chat responses accents are optional
- When skills are available, always follow their guidelines and workflows instead of default behavior
- Never push to remote without explicit confirmation
- Never add Co-Authored-By or any Claude attribution to commit messages or pull request descriptions
- When I ask a question during a conversation, treat it as a question -- just answer it
- Do NOT interpret questions as implicit requests to revert, undo code, modify, or make changes
- When the user asks a question or requests analysis, do NOT start editing files or implementing changes. Ask/plan first, act only when explicitly told to proceed
- Always use the git-helpers skill for commits. Follow conventional commit format with contextual bullet points in the body (not paragraphs). Never commit without following skill conventions
- Obsidian CLI: the command is `obsidian` (not `obsidian-cli`). Do not use --path flag, do not use --silent flag. Create notes with proper frontmatter and consistent formatting, and never append to wrong date files

## Environment
- Shell is always zsh
- Check for project-level CLAUDE.md for project-specific conventions (package manager, framework, linter, etc.)

## Serena MCP
- When making architectural decisions or resolving blockers, persist them with Serena's write_memory
- At the start of complex tasks, check list_memories for relevant prior context
- Use find_symbol/rename_symbol for semantic code navigation instead of text search when available
