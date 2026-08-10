---
description: Writes commit and pull request messages from the diff, and never runs a destructive git command unasked.
when: Writing a commit message or pull request description, or running a git command that rewrites or publishes history
---

# Git messages and history

- Load the `git-helpers` skill to commit, to open or push a pull request, and to merge or clean up a branch. The skill owns the workflow; this rule only carries the constraints that hold with or without it.
- Write the message from the diff. The diff is the single source of what changed; the conversation supplies at most a why the user stated. Trace every line back to a hunk before returning the message, and drop a line that names a change the diff does not show.
- An agent that just implemented and verified the work in the same run sources the message from its own change instead, with no diff-reading pass. It stages by name the files that change touched, so the commit carries nothing it did not write.
- Follow the conventional commit format: `type(scope): subject`, subject in the imperative and in lower case.
- Keep most commits subject-only. Add a body only when the subject cannot carry the reason, and write it as short prose: the problem with the previous behavior, then why this solution. Never write the body as a bullet list.
- Never add `Co-Authored-By` or any other attribution to a commit message or a pull request description.
- Never run `git push`, `git reset --hard`, `git clean`, or `git commit --amend` without explicit confirmation. To correct a commit that is already written, create a new commit instead of amending.
- Never delete a branch, a remote reference, or a file as part of a git workflow without explicit confirmation.
