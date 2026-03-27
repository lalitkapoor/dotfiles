---
name: typescript
description: "Enforce TypeScript safety rules when editing or reviewing `.ts` and `.tsx` files, adding shared types, handling external data, or resolving type errors. Use when Codex needs repo-specific guidance on narrowing unknown values, writing `catch (error: unknown)`, avoiding `any`, and keeping casts confined to explicit, already-approved boundaries such as generated and ignored files."
---

# TypeScript

## Overview

Apply strict TypeScript rules that keep unsafe values at the edges and preserve precise types inside the app. Prefer narrowing and better type modeling over assertions.

## Non-Negotiables

- Write caught errors as `catch (error: unknown)`.
- Narrow caught errors before reading properties. Prefer `instanceof Error`, small type guards, or object-shape checks.
- Never introduce `any`. This includes `as any`, `: any`, `<any>`, `Array<any>`, and generic placeholders that erase type information.
- Avoid casts in general. Prefer inference, generics, discriminated unions, overloads, helper functions, or `satisfies`.
- Treat external and untrusted input as `unknown` until runtime checks prove the shape.

## Preferred Patterns

- Prefer typed helpers over repeated inline checks.
- Prefer `unknown` over `any` at boundaries like `JSON.parse()`, `response.json()`, message events, and third-party callbacks.
- Prefer parsing and decoding helpers over YOLO-style object-shape guards. Once validation goes beyond a trivial check, centralize it in a parser that returns a typed value or throws.
- Use Zod for complex parsing when a schema is large, nested, reused, or hard to validate clearly by hand.
- Prefer complex parsing on the server, not the client. Validate and normalize data at the backend boundary so client code can consume already-shaped types.
- Prefer `satisfies` to verify object shapes without widening the inferred type.
- Prefer `as const` only when it models literal intent; do not use it as a substitute for proper typing.
- Push typing upstream. If a function always returns a known shape, type the function instead of asserting at each call site.

## Approved Boundaries

Keep assertions small, local, and justified. Accept them only when the boundary is already considered safe or intentionally ignored.
- Generated or ignored files may contain casts imposed by tooling. Do not cargo-cult those patterns into hand-written code.
- If a new boundary seems unavoidable, isolate it in one helper and explain why. Do not spread the assertion through callers.

## Examples

Prefer this:

```ts
try {
	return await runTask();
} catch (error: unknown) {
	if (error instanceof Error) {
		throw error;
	}

	throw new Error("Task failed");
}
```

Avoid this:

```ts
try {
	return await runTask();
} catch (error: any) {
	throw error;
}
```

Prefer this:

```ts
function parsePayload(value: unknown): { id: string } {
	if (value == null || typeof value !== "object") {
		throw new Error("Invalid payload");
	}

	const id = Reflect.get(value, "id");
	if (typeof id !== "string") {
		throw new Error("Invalid payload");
	}

	return { id };
}

const payload: unknown = await response.json();
const parsed = parsePayload(payload);
```

Avoid this:

```ts
const payload: unknown = await response.json();

if (
	payload != null &&
	typeof payload === "object" &&
	"id" in payload &&
	typeof payload.id === "string"
) {
	return payload.id;
}
```

Prefer this when shaping typed config:

```ts
const themeOptions = [
	{ value: "light", label: "Light" },
	{ value: "dark", label: "Dark" },
] satisfies ReadonlyArray<{ value: Theme; label: string }>;
```

## Review Checklist

- Confirm every `catch` clause uses `error: unknown`.
- Search for `as any`, `: any`, `<any>`, and `Array<any>` before finishing.
- Replace long inline `typeof` and `in` guard chains with a parser or decoder helper.
- If parsing is complex, check whether it should be implemented with Zod on the server boundary instead of in client code.
- Replace avoidable assertions with better types, narrowing, or helper functions.
- Keep any remaining assertion at the smallest explicit boundary and make sure the runtime checks justify it.
