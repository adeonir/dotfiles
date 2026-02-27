## General
- Always use descriptive variable names
- NEVER use emojis in responses, commit messages, or pull request descriptions
- Keep responses short and direct — avoid excessive formatting and verbose explanations
- Only add comments for magic numbers, complex business logic, or non-self-explanatory functions
- When writing files in Portuguese, always use proper accents (e.g., "código", "informação", "será", "não", "área") — in chat responses accents are optional
- When skills are available, always follow their guidelines and workflows instead of default behavior
- Never push to remote without explicit confirmation
- Never add Co-Authored-By or any Claude attribution to commit messages or pull request descriptions

## Environment
- Shell is always zsh
- Check for project-level CLAUDE.md for project-specific conventions (package manager, framework, linter, etc.)

## Serena MCP
- When making architectural decisions or resolving blockers, persist them with Serena's write_memory
- At the start of complex tasks, check list_memories for relevant prior context
- Use find_symbol/rename_symbol for semantic code navigation instead of text search when available
