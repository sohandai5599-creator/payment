declare namespace Cloudflare {
  interface Env {
    DISCORD_WEBHOOK_URL?: string;
    DB?: D1Database;
    BUCKET?: R2Bucket;
  }
}
