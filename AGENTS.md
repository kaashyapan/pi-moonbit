
**Critical:** If you have a question that requires a response from the user. STOP and ask the user for a prompt. DO NOT assume.

- Directories `../` & `../extensions` contain a pi harness extension written in typescript.
- This folder contains the same extension written in moonbit language compiled to javascript
- Invoke moon_check tool with target = "js"; override the default target.

## MoonBit Language HowTo

- MoonBit code samples repository

   1. ~/moonbit-docs/next/sources/language
   2. ~/moonbit-docs/next/sources/async
   3. ~/moonbit-docs/next/sources/sudoku
   3. ~/moonbit-docs/next/sources/fullstack-one-project
  
## build

1. MoonBit to JS build  => `bun run build:moon`
2. JS build  => `bun run build:js`
