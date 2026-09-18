import { ImageResponse } from "@vercel/og";
import { BUSINESS } from "@/lib/business-info";

export const runtime = "nodejs";

/**
 * Dynamic Open Graph image generator.
 * Visiting /api/og renders a 1200×630 branded card.
 * Query params:
 *   ?title=...   (default: site title)
 *   ?subtitle=... (default: delivery slogan)
 */
export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const title = searchParams.get("title") ?? "Ganjavores DC";
  const subtitle = searchParams.get("subtitle") ?? BUSINESS.slogans.delivery;

  return new ImageResponse(
    (
      <div
        style={{
          width: "100%",
          height: "100%",
          backgroundColor: "#070907",
          color: "#ffffff",
          display: "flex",
          flexDirection: "column",
          justifyContent: "center",
          alignItems: "center",
          padding: "60px",
          fontFamily: "monospace",
          textAlign: "center",
        }}
      >
        <img
          src="https://ganjavores.shop/brand/logo.png"
          alt="Ganjavores DC"
          style={{ width: 120, height: "auto", marginBottom: 24 }}
        />
        <h1
          style={{
            fontSize: 56,
            fontWeight: 700,
            margin: 0,
            lineHeight: 1.1,
            maxWidth: 880,
          }}
        >
          {title}
        </h1>
        <p
          style={{
            fontSize: 24,
            color: "#00c853",
            marginTop: 20,
            marginBottom: 0,
          }}
        >
          {subtitle}
        </p>
        <p
          style={{
            fontSize: 16,
            color: "#888",
            marginTop: 24,
            marginBottom: 0,
          }}
        >
          Licensed Medical Cannabis • Washington, DC &amp; DMV
        </p>
      </div>
    ),
    { width: 1200, height: 630 }
  );
}

export const dynamic = "force-dynamic";
