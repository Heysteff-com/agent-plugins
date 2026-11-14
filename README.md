# heysteff agent plugins

Plugins y reglas para usar [heysteff](https://developers.heysteff.com) desde agentes de código: el servidor MCP (`https://mcp.heysteff.com/mcp`, con OAuth), skills de la API v1 y reglas de seguridad para no escribirle por error a personas reales ni exponer claves.

## Claude Code

```text
/plugin marketplace add heysteff-com/agent-plugins
/plugin install heysteff@heysteff
```

El plugin `heysteff` trae:

- `.mcp.json`: el servidor MCP con la URL fija. Autoriza con `/mcp` y elige el espacio en la pantalla de autorización.
- `/heysteff:setup`: deja listos el MCP, la CLI y la API key sin escribir la key en ningún archivo.
- La skill `heysteff-safety` y las de la API (`heysteff-integrate`, `heysteff-automate`, `heysteff-observe`).
- Un hook de inicio que corre `heysteff whoami` si la CLI está instalada y nunca muestra la key.

## Cursor

Copia `cursor/.cursor/` a la raíz de tu proyecto: `mcp.json` registra el MCP y `rules/heysteff-safety.mdc` deja las reglas siempre activas.

## Codex

Agrega el bloque de `codex/config.toml` a `~/.codex/config.toml` (o `codex mcp add heysteff --url "https://mcp.heysteff.com/mcp"`), autoriza con `codex mcp login heysteff` y copia `codex/AGENTS.md` a tu proyecto.

## Licencia

MIT
