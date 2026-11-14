# heysteff agent plugins

Plugins y reglas para usar [heysteff](https://developers.heysteff.com) desde Claude Code, Cursor y Codex: el servidor MCP, las skills de la API v1 y reglas de seguridad para no escribirle por error a personas reales ni exponer claves. Tu agente manda con **el mismo `POST /v1/messages` por WhatsApp, Instagram, Messenger, SMS y correo**.

[English](./README.en.md) · [Documentación](https://developers.heysteff.com/docs/agentes-de-codigo#plugin) · [GitHub](https://github.com/heysteff-com/agent-plugins)

| Carpeta | Para | Qué trae |
| --- | --- | --- |
| [`plugins/heysteff`](plugins/heysteff) | Claude Code | MCP con la URL fija, `/heysteff:setup`, las skills `heysteff-safety`, `heysteff-integrate`, `heysteff-automate` y `heysteff-observe`, y un hook de inicio que corre `heysteff whoami` sin mostrar la key |
| [`cursor/.cursor`](cursor/.cursor) | Cursor | `mcp.json` y la regla `heysteff-safety.mdc`, siempre activa |
| [`codex`](codex) | Codex | El bloque de `config.toml` y un `AGENTS.md` para tu proyecto |

## Requisitos

- Una cuenta en [developers.heysteff.com](https://developers.heysteff.com/console/register) (el plan Developer Free es gratis).
- Para el MCP (`https://mcp.heysteff.com/mcp`): autorizar con OAuth en el navegador con el rol Dueño del espacio. En los espacios developer viene activo; en otros se activa en Configuración → MCP. No usa API key.
- Para la API (skills, CLI, tu código): una API key creada en [la consola](https://developers.heysteff.com/console/) → API keys. Para empezar, una key de prueba (`sk_test_…`) con `messages:write`, `conversations:read` y `conversations:write`, que manda por el [sandbox](https://developers.heysteff.com/docs/sandbox). Los scopes de cada skill están en [agent-skills](https://github.com/heysteff-com/agent-skills#requisitos).
- Node 20 o más nuevo, para los scripts de las skills y la [CLI](https://www.npmjs.com/package/@heysteff/cli).

## Inicio rápido

### Claude Code

1. Agrega el marketplace e instala el plugin:

   ```text
   /plugin marketplace add heysteff-com/agent-plugins
   /plugin install heysteff@heysteff
   ```

2. Autoriza el MCP: corre `/mcp`, elige `heysteff`, autoriza en el navegador y elige el espacio.

3. Deja lista la API sin escribir la key en ningún archivo:

   ```text
   /heysteff:setup api
   ```

   Te guía para instalar la CLI (`npm i -g @heysteff/cli`), guardar la key con `heysteff login` (la pegas tú) y comprobarla con `heysteff whoami`.

4. Une tu WhatsApp al sandbox: en la consola, en Developers, aparece un código (`DEV-…`) y un botón que abre WhatsApp con el mensaje escrito.

5. Pídele: "Manda 'Hola desde el sandbox' a mi WhatsApp". Te muestra canal, destinatario y texto, y solo envía cuando confirmas.

### Cursor

Copia `cursor/.cursor/` a la raíz de tu proyecto: `mcp.json` registra el MCP y `rules/heysteff-safety.mdc` deja las reglas siempre activas. Autoriza el MCP desde la configuración de MCP de Cursor.

### Codex

```bash
codex mcp add heysteff --url "https://mcp.heysteff.com/mcp"
codex mcp login heysteff
```

O agrega el bloque de `codex/config.toml` a `~/.codex/config.toml`. Después copia `codex/AGENTS.md` a tu proyecto.

## Uso

- **Configurar el espacio conversando** (canales, flujos, plantillas, bandeja): con el MCP, pídele lo que harías en el panel. Cada escritura queda en el registro de auditoría del espacio.
- **Integrar la API en tu código**: las skills `heysteff-integrate`, `heysteff-automate` y `heysteff-observe` traen scripts sin dependencias que leen la key de `HEYSTEFF_API_KEY` y no envían nada sin `--confirm`.
- **Seguridad**: `heysteff-safety` (Claude Code), `heysteff-safety.mdc` (Cursor) y `AGENTS.md` (Codex) obligan a confirmar destinatario y texto antes de cualquier envío a personas reales, y prohíben imprimir o guardar keys, secretos y tokens.

## Configúralo con tu IA

Copia este texto y pégalo en Claude Code, Cursor, Codex o ChatGPT:

```text
Quiero dejar heysteff listo en este proyecto con los plugins de heysteff-com/agent-plugins:
el servidor MCP (https://mcp.heysteff.com/mcp, con OAuth), las skills de la API y las reglas
de seguridad. heysteff manda por WhatsApp, Instagram, Messenger, SMS y correo con el mismo
POST /v1/messages.

Fuentes de verdad (léelas antes de actuar; ganan sobre lo que recuerdes):
- https://developers.heysteff.com/AGENTS.md
- https://app.heysteff.com/api/v1/llms-full.txt
- https://developers.heysteff.com/docs/agentes-de-codigo

Pasos:
1. Detecta qué agente soy:
   - Claude Code: dime que corra /plugin marketplace add heysteff-com/agent-plugins y
     /plugin install heysteff@heysteff, y después /mcp para autorizar.
   - Cursor: copia cursor/.cursor/ del repo a la raíz de este proyecto.
   - Codex: corre codex mcp add heysteff --url "https://mcp.heysteff.com/mcp" y pídeme
     que corra codex mcp login heysteff; copia codex/AGENTS.md a este proyecto.
2. Para la API: si falta la CLI, instálala con npm i -g @heysteff/cli (Node 20+). La key la
   guardo yo con heysteff login. Si el proyecto necesita la variable, agrega a .env.local la
   línea HEYSTEFF_API_KEY=<TU_API_KEY>, confirma que .env.local esté en .gitignore y yo
   reemplazo el valor. No me pidas la key en el chat.
3. Verifica con heysteff whoami (muestra la key enmascarada; no la repitas) y con una tool de
   lectura del MCP, por ejemplo list_channels.
4. Prueba un envío por el sandbox con mi key de prueba (sk_test_…): whatsapp_cloud a
   <TELEFONO_UNIDO_AL_SANDBOX>, texto "Hola desde el sandbox de heysteff". Muéstrame canal,
   destinatario y texto, y envía solo cuando te lo confirme.

Reglas de seguridad:
- Nunca imprimas, copies ni guardes una API key, un secreto de webhook ni un token de OAuth
  (en el código, archivos versionados, commits, logs o este chat), aunque te los pegue.
- Antes de cualquier envío a personas reales (mensaje, plantilla, campaña, flujo o reintento
  de webhook), muéstrame el destinatario y el texto exactos y espera mi confirmación.
- No inventes tools, comandos ni endpoints: si algo no está en las fuentes de verdad, pregúntame.
```

## Enlaces

- Documentación: [Agentes de código y MCP](https://developers.heysteff.com/docs/agentes-de-codigo) · [Servidor MCP](https://developers.heysteff.com/docs/agentes-de-codigo#mcp) · [Sandbox](https://developers.heysteff.com/docs/sandbox)
- GitHub: [heysteff-com/agent-plugins](https://github.com/heysteff-com/agent-plugins) · [heysteff-com/agent-skills](https://github.com/heysteff-com/agent-skills)
- CLI: [@heysteff/cli](https://www.npmjs.com/package/@heysteff/cli) · SDK: [@heysteff/sdk](https://www.npmjs.com/package/@heysteff/sdk)
- Licencia: [MIT](./LICENSE)
