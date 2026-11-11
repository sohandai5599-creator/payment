# Snow Cheats payment portal

Responsive eSewa payment page with a native dialog, sender details, screenshot preview, and a server-only Discord upload endpoint. Receipts are forwarded as attached images inside a Discord embed. Payment verification is manual.

## Payment images

The supplied purple Snow Cheats logo and eSewa QR card are in `public/`. The payment dialog displays the original QR card so the payer can check the recipient.

## Host on Windows

After installing dependencies, double-click `host.bat` or run it from a terminal. Open http://127.0.0.1:5173/ and keep the terminal open while hosting. Press Ctrl+C to stop. This starts a server on your own machine.

The launcher posts startup, shutdown, and failure status to Discord. Set `HOST_LOG_WEBHOOK_URL` in the ignored `.dev.vars` file to use a separate webhook. Otherwise it uses the same `DISCORD_WEBHOOK_URL` as receipts. Run `host.bat --no-discord` to turn off host notifications for a run without changing receipt delivery.

## Run

Use Node 22.13 or newer and pnpm 11.25.0.

```
pnpm install
pnpm dev
pnpm build
node --test tests/payment.test.mjs
```

Configure `DISCORD_WEBHOOK_URL` as a server runtime secret. For local delivery, set it in the ignored `.dev.vars` file. Never add it to a `NEXT_PUBLIC_` variable. The endpoint sends a multipart request with the receipt image and waits for Discord to confirm delivery.

Required fields: sender name, Discord username or contact, amount (NPR), screenshot, and consent. Transaction ID is optional. PNG/JPEG/WebP uploads are limited to 8 MB and checked on both client and server. The server bounds request bodies, validates same-origin submissions, disables mentions, and confirms Discord delivery before reporting success. Sender identity is self-reported. The cooldown is per isolate; add an edge rate limit before opening to anonymous high-volume traffic. The application holds uploads only in memory, then sends them to Discord, whose channel permissions and retention apply.

New Sites are private by default. The owner must explicitly request public access before customers outside that audience can use a hosted deployment.
