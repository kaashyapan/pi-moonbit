// Error explain tool
//
// Accept an integer error code and return an explanation.

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { Type } from "typebox";
import { failureFlagged } from "./shared";
import fs from 'fs';
import path from 'path';

export function registerErrorTools(pi: ExtensionAPI) {
  pi.registerTool({
    name: "moon_explain_error",
    label: "MoonBit: Explain error",
    description:
      "Ask for detailed explanation for an integer error code that was received from moon_check." +
      "Call this if the cause of error is not understood from the moon_check diagnostic message." +
      "Do not make assumptions about errors until you read this.",
    parameters: Type.Object({
      error_code: Type.Integer({
        description:
          "Error code from moon_check diagnostic",
      }),
    }),
    promptGuidelines: [
      "Use this tool, Do not search on the internet.",
      "Do not make assumptions about error messages based on Rust or Python"
    ],
    promptSnippet:
      "moon_explain_error - Returns a detailed explanation of the error code.",
    async execute(_toolCallId, params, _signal, _onUpdate, _ctx) {
      const code = params.error_code;
      let content = getErrorDetail(code)
      if (content == null) {
        const text =
          `Error code ${code} was not found in the explanations database. ` +
          "Treat the moon_check diagnostic message itself as authoritative.";
        return {
          content: [{ type: "text" as const, text }],
          details: failureFlagged({ ok: false, error_code: code, error: `Error code ${code} was not found` }),
        };
      } else
        return {
          content: [{ type: "text" as const, text: content }],
          details: { ok: true, error_code: code },
        };
    },
  });
}


function getErrorDetail(code: number): string | null {
  const file_name = "E" + code.toString().padStart(4, "0") + ".md";
  const filePath = path.join(__dirname, "./error_codes", file_name);
  if (fs.existsSync(filePath)) {
    const content = fs.readFileSync(filePath, 'utf-8')
    return content
  }
  return null
}
