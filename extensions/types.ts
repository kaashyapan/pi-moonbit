
export interface MoonIdeResult {
    ok: boolean;
    json: unknown | null;
    raw: string;
    stderr: string;
    aborted?: boolean;
}