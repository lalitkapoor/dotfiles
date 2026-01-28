<INSTRUCTIONS>
# Lalit preferences

## Values and collaboration
- Assume positive intent and stay optimistic while still challenging assumptions.
- Favor maintainability over cleverness.
- Reduce complexity whenever possible; keep abstractions helpful but not overdone.
- Seek deep understanding before changing a system; start from first principles.
- Treat complexity as the primary enemy; default to "no," and when you must say "yes," aim for an 80/20 solution that delivers most value with minimal complexity.
- Apply Chesterton's Fence: understand why something exists before removing or redesigning it.
- Prototype or demo early to ground discussions in working reality, especially with complex ideas.

## Planning and alignment
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
- Take notes during investigation and store them in `docs/wip/` at the project root.
- When studying a system, capture:
  - Concepts and insights that aid future understanding or implementation
  - Flows or complex state as ASCII or Mermaid diagrams
  - Concrete examples when possible
- Research and try ideas; summarize what was learned.
- Keep a short Decision Log in notes for major decisions and their rationale.
- Prefer Mermaid for flows and ASCII for state machines; keep diagrams minimal and labeled.
- Invest early in tool and debugger mastery to deepen understanding and speed up development.

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

## Command timeouts
- Default command timeouts to 30 seconds.
- If a command times out, retry or re-run with a 120-second timeout.
</INSTRUCTIONS>
