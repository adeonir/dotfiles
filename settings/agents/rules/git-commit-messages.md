---
description: Writes commit and pull request messages from the diff, and never runs a destructive git command unasked.
when: Writing a commit message or pull request description, or running a git command that rewrites or publishes history
---

# Git messages and history

- Load the `git-helpers` skill to commit, to open or push a pull request, and to merge or clean up a branch. The skill owns the workflow; this rule sets the bar for the message and guards the destructive commands.
- Write the message from the diff. Trace every claim about what changed back to a hunk, and drop any claim about a change the diff does not show. Context explicitly supplied by the user may support why the change was needed, even when the diff does not show that context; it does not establish what changed or qualify a commit for a body on its own.
- Follow the conventional commit format: `type(scope): subject`, subject in the imperative and in lower case.
- Keep most commits subject-only. Add a body only when a reader holding the diff would act wrongly without it, and write one sentence: the problem the changed lines do not show, or the constraint that binds the solution. Never write both, and never write the body as a bullet list.
- Never run `git push`, `git reset --hard`, or `git clean` without explicit confirmation. Never run `git commit --amend`; create a new commit to correct an existing commit.
- Never delete a branch, a remote reference, or a file as part of a git workflow without explicit confirmation.
- Never add attribution or tool credit to a commit message or a pull request description: no `Co-Authored-By` trailer, no `Generated with Claude Code` footer.
