---
name: websocket-realtime
description: Design real-time communication with WebSocket lifecycle, reconnection, and backpressure handling.
license: MIT
compatibility: opencode
metadata:
  category: backend
---

## What I do
- Design WebSocket connection lifecycle (handshake, heartbeat, close).
- Implement reconnection with exponential backoff.
- Handle backpressure and message ordering.
- Scale WebSocket servers horizontally with pub/sub.

## Connection lifecycle
1. **Handshake**: Authenticate during upgrade (token in query or header).
2. **Heartbeat**: Ping/pong at regular intervals to detect dead connections.
3. **Message framing**: Use JSON or binary protocol with type field and sequence number.
4. **Graceful close**: Send close frame with reason code before disconnect.
5. **Timeout**: Drop connections that fail heartbeat after N retries.

## Client-side patterns
- **Auto-reconnect**: Exponential backoff with jitter (1s, 2s, 4s, 8s… max 30s).
- **State sync on reconnect**: Request missed messages or full state snapshot.
- **Offline queue**: Buffer outgoing messages during disconnect, flush on reconnect.
- **Connection status UI**: Show connected/reconnecting/offline state to user.

## Server-side patterns
- **Room/channel abstraction**: Group connections by topic for targeted broadcast.
- **Horizontal scaling**: Use Redis pub/sub or NATS to sync across server instances.
- **Backpressure**: Drop or throttle slow consumers to protect server memory.
- **Rate limiting**: Limit messages per connection per second.
- **Graceful shutdown**: Drain connections before server stop.

## Message protocol design
- Include `type`, `id`, `timestamp` in every message.
- Use acknowledgment messages for critical operations.
- Define error message format with code and description.
- Version the protocol for backward-compatible evolution.

## Security
- Authenticate on handshake, not per-message.
- Validate and sanitize all incoming messages.
- Limit message size to prevent memory abuse.
- Use WSS (TLS) in production.

## Output
- Protocol specification with message types
- Connection lifecycle diagram
- Scaling architecture for multi-server deployment
- Client reconnection flow
