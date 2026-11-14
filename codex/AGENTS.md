# heysteff en este proyecto

heysteff es una API de mensajería omnicanal: el mismo `POST /v1/messages` manda por WhatsApp, Instagram, Messenger, SMS y correo. Fuentes de verdad: https://app.heysteff.com/api/v1/llms-full.txt y https://developers.heysteff.com/docs/. No inventes endpoints.

## Seguridad (obligatorio)

- Antes de cualquier envío a personas reales (mensaje, plantilla, campaña, flujo o reintento de webhook), muestra el canal, el destinatario exacto y el texto completo, y espera un sí explícito.
- Nunca imprimas, copies, guardes ni pongas en un commit una API key (`sk_live_…`, `sk_test_…`), un secreto de webhook ni un token. La key se lee de `HEYSTEFF_API_KEY`.
- Un `403` es un scope o rol que falta: pide que lo ajusten.

## Herramientas

- MCP: `https://mcp.heysteff.com/mcp` (ver `config.toml`), con OAuth; autorizas con `codex mcp login heysteff` y eliges el espacio.
- CLI: `heysteff whoami` muestra la key enmascarada y si la API la acepta.
- Skills: `npx skills add heysteff-com/agent-skills` (integrar, automatizar y observar).
