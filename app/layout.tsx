import type { Metadata } from "next";
import "./globals.css";
import { AgeGate } from "@/components/age-gate";
import { SiteChrome } from "@/components/site-chrome";
import { CartProvider } from "@/lib/cart-context";

export const metadata: Metadata = {
  metadataBase: new URL("https://ganjavores.com"),
  title: {
    default: "Ganjavores DC | Premium Medical Cannabis Delivery in Washington, DC",
    template: "%s | Ganjavores DC",
  },
  description:
    "Licensed medical cannabis delivery and curbside pickup serving Washington, DC and the DMV. Premium flower, vapes, edibles, and pre-rolls, plus our house line Ganjavores Exclusive. Fast, discreet, local.",
  openGraph: {
    title: "Ganjavores DC",
    description:
      "We Don't Compete — We Consume the Competition. Serving DC & the DMV.",
    url: "https://ganjavores.com",
    siteName: "Ganjavores DC",
    locale: "en_US",
    type: "website",
  },
  robots: {
    index: true,
    follow: true,
  },
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body>
        {/* Blocks the whole site behind a 21+ confirmation on first visit.
            Client component — stores confirmation in localStorage/cookie. */}
        <AgeGate />
        <CartProvider>
          <SiteChrome>{children}</SiteChrome>
        </CartProvider>
      </body>
    </html>
  );
}
