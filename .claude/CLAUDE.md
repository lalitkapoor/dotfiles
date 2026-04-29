# Lalit preferences

## Overall principles

Behavioral guidelines to reduce common LLM coding mistakes. Merge with project-specific instructions as needed.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

### 1. Think Before Coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them - don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

### 2. Simplicity First

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.

Ask yourself: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

### 3. Surgical Changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

### 4. Goal-Driven Execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- "Add validation" → "Write tests for invalid inputs, then make them pass"
- "Fix the bug" → "Write a test that reproduces it, then make it pass"
- "Refactor X" → "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

---

**These guidelines are working if:** fewer unnecessary changes in diffs, fewer rewrites due to overcomplication, and clarifying questions come before implementation rather than after mistakes.

---

## Values and collaboration
- Assume positive intent and stay optimistic while still challenging assumptions.
- Favor maintainability over cleverness.
- Reduce complexity whenever possible; keep abstractions helpful but not overdone.
- Seek deep understanding before changing a system; start from first principles.
- Apply Chesterton's Fence: understand why something exists before removing or redesigning it.
- Prototype or demo early to ground discussions in working reality, especially with complex ideas.
- Invest early in tool and debugger mastery to deepen understanding and speed up development.

## Planning and alignment
- After creating a plan Please step back and think again. How can we make this SIMPLER and DUMBER while still achieving our goals?
- Create a detailed plan before implementation.
- Start with the big picture, then break into sections and add details per section.
- Capture key decisions and evaluation learnings in the plan.
- Build alignment on the plan before executing.
- Ask whether the work should be behind a feature gate or experiment at the start of new projects or tasks.
- Avoid early factoring/abstraction; wait for cut points to emerge, then refactor slowly as the system's shape becomes clear.
- Prefer small, safe refactors that keep the system working at every step.
- It is okay if not everything is known up front; keep the plan current as new insights emerge.
- After each plan update, re-validate assumptions and scope with the latest insights.
- Explicitly mark unknowns and risks, and convert them into research tasks or tests.
- Keep changes scoped; if scope grows, re-align before proceeding.

## Notes and research
- Do not write to `~/docs/...` by default.
- Only create or update docs in `~/docs/<repo-name>/<project-name>/` when I explicitly ask, using language like “save this to docs”, “take notes”, “write a doc”, “capture this for later”, or “document this”.
- Each `~/docs/<repo-name>/` directory is its own git repo. When asked to commit or push docs, `cd` into `~/docs/<repo-name>/` (where the `.git` folder lives), NOT `~/docs/`. For example, to push changes in `~/docs/notion-next/local-snapshots/`, the git repo is at `~/docs/notion-next/`.
- If I ask you to study or explain something and do not explicitly ask to save it, respond in chat only.
- If a doc would be useful, suggest it, but do not create it without my explicit request.
- When studying or trying to understand how something works, check available skills to see if they can help.
- When studying a system, capture:
  - Concepts and insights that aid future understanding or implementation
  - Flows or complex state as ASCII or Mermaid diagrams
  - Concrete examples when possible
- Research and try ideas; summarize what was learned.
- Keep a short Decision Log in notes for major decisions and their rationale.
- Prefer Mermaid for flows and ASCII for state machines; keep diagrams minimal and labeled.

## Testing and execution
- Provide a test plan for the overall work and for each major section so we can rigorously build up a solution.
- Use TDD when possible: add failing tests first, then implement to make them pass.
- Update the plan with key insights and learnings as they emerge.
- If the domain is unclear, allow a brief prototype phase to learn the shape of the problem, then add tests as the system firms up.
- Prefer unit tests for library-like code; use integration tests when validating real system interactions; keep end-to-end tests small and curated; avoid heavy mocking except when truly necessary.
- For bugs, write a regression test first, then fix.
- Prefer small, incremental verification steps over big-bang checks.
- If risk is non-trivial, note a rollback or mitigation plan.
- Each section should have clear exit criteria (tests pass, docs updated, risks addressed).
- Summarize progress and blockers at each milestone.
- Prefer clear, descriptive naming over brevity; avoid clever patterns.

## PR templates
- When opening a PR, check the repo root for `.github/pull_request_template.md` and use that template.

## Git rebase safety (CRITICAL)
- After resolving ANY rebase/merge conflict, ALWAYS run `git diff --check` before staging or committing to catch leftover conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`).
- When `git rebase` reports "Recorded preimage" for a file, that file likely has conflicts even if not explicitly listed as CONFLICT — always inspect it.
- NEVER blindly `git add -A` or `git checkout <branch> -- <file>` after a rebase without verifying no conflict markers remain.
- After `gt restack` or `gt continue`, verify all modified files are clean before pushing.

## Command timeouts
- Default command timeouts to 30 seconds.
- If a command times out, retry or re-run with a 120-second timeout.

## CLAUDE.md updates
- When I ask you to add or update instructions to CLAUDE.md, ask whether the target is:
  - **user/global-level** (`~/.config/claude/CLAUDE.md`)
  - **project-team-level** (`.agent-instructions/BASE_INSTRUCTIONS.template.md`, or `CLAUDE.md` if that doesn't exist)
  - **project-personal-level** (`CLAUDE.local.md`)
