---
description: Deja listo heysteff en este proyecto (MCP con OAuth, CLI, API key y skills) sin exponer claves.
argument-hint: "[api|mcp]"
---

Ayuda a la persona a dejar heysteff listo para trabajar en este proyecto. Argumento opcional: `$ARGUMENTS` (`api` para integrar por la API, `mcp` para configurar el espacio conversando; sin argumento, pregunta cuál necesita).

Sigue estos pasos en orden y detente a confirmar en cada uno:

1. **Servidor MCP.** Este plugin ya registra `heysteff` con la URL fija `https://mcp.heysteff.com/mcp`. Pídele que corra `/mcp`, elija `heysteff` y autorice en el navegador. En la pantalla de autorización elige el espacio: el permiso queda ligado a ese espacio. Solo el rol Dueño puede autorizar, y en los espacios developer el MCP viene activo; en otros se activa en Configuración → MCP.
2. **CLI (para la API).** Revisa si existe con `command -v heysteff`. Si no, sugiere `npm i -g @heysteff/cli`. Para la key, la persona corre `heysteff login` y pega la key ella misma, o define `HEYSTEFF_API_KEY` en su entorno. Después corre `heysteff whoami`: muestra la key enmascarada y si la API la acepta.
3. **Variables del proyecto.** Si el proyecto necesita la key, agrégala solo como nombre en `.env.example` (`HEYSTEFF_API_KEY=`) y verifica que `.env` esté en `.gitignore`. Nunca escribas el valor.
4. **Prueba segura.** Propón un primer mensaje a un número de la propia persona (o del sandbox con una key `sk_test_…`). Muestra canal, destinatario y texto exactos y espera un sí antes de enviarlo.

Reglas que no se negocian:

- Nunca imprimas, copies ni guardes una API key, un secreto de webhook ni un token de OAuth, aunque la persona los pegue en el chat.
- Antes de cualquier envío a personas reales (mensaje, plantilla, campaña, flujo o reintento de webhook), confirma el destinatario y el texto con la persona.
- Docs: https://developers.heysteff.com/docs/agentes-de-codigo y https://app.heysteff.com/api/v1/llms-full.txt
