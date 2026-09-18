import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // Security headers — HSTS, CSP, X-Frame-Options, etc.
  // All were flagged as missing in the AEO report.
  async headers() {
    return [
      {
        source: "/:path*",
        headers: [
          {
            key: "Strict-Transport-Security",
            value: "max-age=31536000; includeSubDomains",
          },
          {
            key: "X-Content-Type-Options",
            value: "nosniff",
          },
          {
            key: "X-Frame-Options",
            value: "SAMEORIGIN",
          },
          {
            key: "Referrer-Policy",
            value: "strict-origin-when-cross-origin",
          },
          {
            key: "Permissions-Policy",
            value: "camera=(), microphone=(), geolocation=(), payment=()",
          },
          {
            key: "Content-Security-Policy",
            value:
              "default-src 'self'; " +
              "script-src 'self' 'unsafe-inline' 'unsafe-eval' https://vercel.live https://*.supabase.co https://a.klaviyo.com; " +
              "style-src 'self' 'unsafe-inline'; " +
              "img-src 'self' data: https: blob:; " +
              "font-src 'self' https: data:; " +
              "connect-src 'self' https://*.supabase.co https://*.vercel-analytics.com https://a.klaviyo.com; " +
              "frame-src https://maps.google.com https://*.supabase.co https://a.klaviyo.com; " +
              "frame-ancestors 'self'; " +
              "object-src 'none'; " +
              "base-uri 'self'; " +
              "form-action 'self'",
          },
          {
            key: "Cache-Control",
            value: "public, max-age=0, s-maxage=60, must-revalidate",
          },
        ],
      },
      {
        // Static assets — long cache
        source: "/static/(.*)",
        headers: [
          {
            key: "Cache-Control",
            value: "public, max-age=31536000, immutable",
          },
        ],
      },
      {
        // Images and fonts in /public — long cache
        source: "/(brand|products|banners|misc-lifestyle|misc-review-screenshots)/(.*)",
        headers: [
          {
            key: "Cache-Control",
            value: "public, max-age=31536000, immutable",
          },
        ],
      },
    ];
  },
  images: {
    remotePatterns: [
      // Supabase Storage — update the hostname once your project is live,
      // e.g. abcxyz.supabase.co
      {
        protocol: "https",
        hostname: "*.supabase.co",
        pathname: "/storage/v1/object/public/**",
      },
    ],
  },
};

export default nextConfig;
