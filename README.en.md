# heysteff agent plugins

Plugins and rules to use [heysteff](https://developers.heysteff.com) from Claude Code, Cursor and Codex: the MCP server, the v1 API skills and safety rules so you never message real people by mistake or leak keys. Your agent sends with **the same `POST /v1/messages` on WhatsApp, Instagram, Messenger, SMS and email**.

[Español](./README.md) · [Docs](https://developers.heysteff.com/en/docs/coding-agents#plugin) · [GitHub](https://github.com/heysteff-com/agent-plugins)

| Folder | For | What it ships |
| --- | --- | --- |
| [`plugins/heysteff`](plugins/heysteff) | Claude Code | MCP with the fixed URL, `/heysteff:setup`, the `heysteff-safety`, `heysteff-integrate`, `heysteff-automate` and `heysteff-observe` skills, and a startup hook that runs `heysteff whoami` without showing the key |
| [`cursor/.cursor`](cursor/.cursor) | Cursor | `mcp.json` and the always-on `heysteff-safety.mdc` rule |
| [`codex`](codex) | Codex | The `config.toml` block and an `AGENTS.md` for your project |

The skills, rules and commands are written in Spanish.

## Requirements

- An account at [developers.heysteff.com](https://developers.heysteff.com/console/register?lang=en) (Developer Free costs nothing).
- For the MCP (`https://mcp.heysteff.com/mcp`): authorize with OAuth in the browser as the workspace Owner. It is on by default in developer workspaces; in others, turn it on in Settings → MCP. It does not use an API key.
- For the API (skills, CLI, your code): an API key created in [the console](https://developers.heysteff.com/console/) → API keys. To start, a test key (`sk_test_…`) with `messages:write`, `conversations:read` and `conversations:write`, which sends through the [sandbox](https://developers.heysteff.com/en/docs/sandbox). Each skill's scopes are listed in [agent-skills](https://github.com/heysteff-com/agent-skills/blob/main/README.en.md#requirements).
- Node 20 or newer, for the skill scripts and the [CLI](https://www.npmjs.com/package/@heysteff/cli).

## Quickstart

### Claude Code

1. Add the marketplace and install the plugin:

   ```text
   /plugin marketplace add heysteff-com/agent-plugins
   /plugin install heysteff@heysteff
   ```

2. Authorize the MCP: run `/mcp`, choose `heysteff`, authorize in the browser and pick the workspace.

3. Set up the API without writing the key to any file:

   ```text
   /heysteff:setup api
   ```

   It walks you through installing the CLI (`npm i -g @heysteff/cli`), storing the key with `heysteff login` (you paste it yourself) and checking it with `heysteff whoami`.

4. Join the sandbox with your WhatsApp: in the console, under Developers, there is a code (`DEV-…`) and a button that opens WhatsApp with the message ready.

5. Ask: "Send 'Hello from the sandbox' to my WhatsApp". It shows you the channel, recipient and text, and only sends once you confirm.

### Cursor

Copy `cursor/.cursor/` to your project root: `mcp.json` registers the MCP and `rules/heysteff-safety.mdc` keeps the rules always on. Authorize the MCP from Cursor's MCP settings.

### Codex

```bash
codex mcp add heysteff --url "https://mcp.heysteff.com/mcp"
codex mcp login heysteff
```

Or add the `codex/config.toml` block to `~/.codex/config.toml`. Then copy `codex/AGENTS.md` to your project.

## Usage

- **Configure the workspace by chatting** (channels, flows, templates, inbox): with the MCP, ask for what you would do in the dashboard. Every write goes to the workspace audit log.
- **Integrate the API in your code**: the `heysteff-integrate`, `heysteff-automate` and `heysteff-observe` skills ship dependency-free scripts that read the key from `HEYSTEFF_API_KEY` and send nothing without `--confirm`.
- **Safety**: `heysteff-safety` (Claude Code), `heysteff-safety.mdc` (Cursor) and `AGENTS.md` (Codex) require confirming recipient and text before any send to real people, and forbid printing or storing keys, secrets and tokens.

## Set it up with your AI

Copy this text and paste it into Claude Code, Cursor, Codex or ChatGPT:

```text
I want heysteff ready in this project with the plugins from heysteff-com/agent-plugins:
the MCP server (https://mcp.heysteff.com/mcp, with OAuth), the API skills and the safety
rules. heysteff sends on WhatsApp, Instagram, Messenger, SMS and email with the same
POST /v1/messages.

Sources of truth (read them before acting; they win over what you remember):
- https://developers.heysteff.com/AGENTS.md
- https://app.heysteff.com/api/v1/llms-full.txt
- https://developers.heysteff.com/en/docs/coding-agents

Steps:
1. Figure out which agent you are:
   - Claude Code: tell me to run /plugin marketplace add heysteff-com/agent-plugins and
     /plugin install heysteff@heysteff, then /mcp to authorize.
   - Cursor: copy cursor/.cursor/ from the repo to this project's root.
   - Codex: run codex mcp add heysteff --url "https://mcp.heysteff.com/mcp" and ask me
     to run codex mcp login heysteff; copy codex/AGENTS.md to this project.
2. For the API: if the CLI is missing, install it with npm i -g @heysteff/cli (Node 20+). I store
   the key myself with heysteff login. If the project needs the variable, add the line
   HEYSTEFF_API_KEY=<YOUR_API_KEY> to .env.local, make sure .env.local is in .gitignore and I
   will replace the value. Do not ask me for the key in the chat.
3. Verify with heysteff whoami (it shows the key masked; do not repeat it) and with a read-only
   MCP tool, for example list_channels.
4. Try a send through the sandbox with my test key (sk_test_…): whatsapp_cloud to
   <PHONE_JOINED_TO_THE_SANDBOX>, text "Hello from the heysteff sandbox". Show me the channel,
   recipient and text, and send only after I confirm.

Safety rules:
- Never print, copy or store an API key, a webhook secret or an OAuth token (in code, tracked
  files, commits, logs or this chat), even if I paste it.
- Before any send to real people (message, template, campaign, flow or webhook retry), show me
  the exact recipient and text and wait for my confirmation.
- Do not invent tools, commands or endpoints: if something is not in the sources of truth, ask me.
```

## Links

- Docs: [Coding agents and MCP](https://developers.heysteff.com/en/docs/coding-agents) · [MCP server](https://developers.heysteff.com/en/docs/coding-agents#mcp) · [Sandbox](https://developers.heysteff.com/en/docs/sandbox)
- GitHub: [heysteff-com/agent-plugins](https://github.com/heysteff-com/agent-plugins) · [heysteff-com/agent-skills](https://github.com/heysteff-com/agent-skills)
- CLI: [@heysteff/cli](https://www.npmjs.com/package/@heysteff/cli) · SDK: [@heysteff/sdk](https://www.npmjs.com/package/@heysteff/sdk)
- License: [MIT](./LICENSE)
