---
name: heysteff-safety
description: Reglas para trabajar con heysteff (API v1, CLI o MCP) sin escribirle por error a personas reales ni filtrar claves. Úsala siempre antes de mandar un mensaje, una plantilla, una campaña, disparar un flujo o reintentar un webhook de heysteff, y cuando aparezca una API key o un secreto.
---

# heysteff: seguridad

heysteff manda mensajes a personas reales por WhatsApp, Instagram, Messenger, SMS y correo. Un error no se deshace: el mensaje ya llegó.

## Antes de cualquier envío

Aplica a `POST /v1/messages`, `heysteff send`, las tools del MCP que envían (`send_message`, `start_whatsapp_conversation`, `approve_suggested_message`, `send_marketing_campaign_now`, `trigger_campaign`…), disparar un flujo y reintentar una entrega de webhook.

1. Muestra a la persona el canal, el destinatario exacto (número, usuario o correo) y el texto completo, o la plantilla con sus variables.
2. Para envíos masivos, di cuántas personas son y cómo se eligieron.
3. Espera un sí explícito. "Hazlo" sobre un plan general no cuenta como confirmación de un envío concreto.
4. Si es una prueba, usa el número de la propia persona o una key de sandbox (`sk_test_…`).

## Claves y secretos

- Nunca imprimas, copies, guardes ni pongas en un commit una API key (`sk_live_…`, `sk_test_…`), un secreto de webhook ni un token de OAuth. Ni enmascarados en un archivo.
- La key se lee de `HEYSTEFF_API_KEY`. Si la persona la pega en el chat, no la repitas y pídele que la guarde como variable de entorno (y que la rote si quedó en un lugar compartido).
- Para saber qué key se usa, `heysteff whoami`: ya la muestra enmascarada.

## Permisos

- Un `403` es un scope que falta en la key o un rol que no alcanza: pídele a la persona que lo ajuste. No busques un rodeo con otra key ni otra ruta.
- El MCP queda ligado al espacio que la persona eligió al autorizar. Si necesitas otro espacio, que vuelva a autorizar y lo elija; no cambies la URL para saltarlo.
