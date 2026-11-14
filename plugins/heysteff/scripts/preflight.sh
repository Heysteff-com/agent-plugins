#!/bin/sh
# Preflight de heysteff al empezar una sesión de Claude Code.
#
# Si la CLI `heysteff` existe, corre `heysteff whoami --json` y deja en el
# contexto solo el modo (live/test), el estado de la key y la base URL. Nunca
# imprime la key, ni siquiera enmascarada. Si la CLI no está o algo falla, no
# corta la sesión: siempre sale con 0.

if ! command -v heysteff >/dev/null 2>&1; then
  echo "heysteff: la CLI no está instalada (opcional). Para la API: npm i -g @heysteff/cli y heysteff login. El MCP (https://mcp.heysteff.com/mcp) se autoriza con /mcp."
  exit 0
fi

out=$(heysteff whoami --json 2>/dev/null)

if command -v node >/dev/null 2>&1 && [ -n "$out" ]; then
  printf '%s' "$out" | node -e '
let raw = "";
process.stdin.on("data", (c) => { raw += c; });
process.stdin.on("end", () => {
  try {
    const w = JSON.parse(raw);
    const parts = [
      "modo " + (w.mode ?? "?"),
      "key " + (w.status === "valid" ? "válida" : (w.status ?? "sin revisar")),
      "base " + (w.base_url ?? "?"),
    ];
    console.log("heysteff: CLI lista (" + parts.join(", ") + "). Antes de mandar algo a una persona real, confirma destinatario y texto.");
  } catch {
    console.log("heysteff: la CLI está instalada pero whoami no respondió JSON. Revisa con heysteff whoami.");
  }
});'
else
  echo "heysteff: la CLI está instalada pero no hay una key configurada o no respondió. Corre heysteff login (la key la pega la persona, nunca la escribas tú)."
fi
exit 0
