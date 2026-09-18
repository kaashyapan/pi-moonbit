# Scaffold Diagnostics

The generated MoonBit scaffold is buildable. Unsupported or ambiguous export surfaces are listed below with the decision taken by the generator.

## Summary

| export | decision | reason | runtime safety |
| --- | --- | --- | --- |
| `KeyId` | omitted | unsupported export surface | runtime-safe; the unsupported export is not exposed |
| `Token` | omitted | unsupported export surface | runtime-safe; the unsupported export is not exposed |
| `SizeValue` | omitted | unsupported export surface | runtime-safe; the unsupported export is not exposed |

## Runtime Safety

Widened surfaces keep the scaffold buildable, but ambiguous runtime exports are not callable until the source export is made unambiguous.
Omitted surfaces are intentionally absent from the generated MoonBit API. Bridge-wrapped surfaces are callable through generated `bridge.js` glue when the runtime binding can be resolved.

## Decision Vocabulary

- `widened`: emitted as `JSValue` so dependent code can still build
- `omitted`: not emitted
- `bridge-wrapped`: emitted through generated `bridge.js` glue

## Raw Entries

- KeyId (heterogeneous union member is not runtime-discriminable: the generic reference `ModifiedKeyId<...>` has no monomorphic payload type.)
- Token (heterogeneous union member is not runtime-discriminable: the qualified name `Tokens.Generic` cannot be spelled as an enum case.)
- SizeValue (heterogeneous union member is not runtime-discriminable: the member shape has no runtime discriminator.)