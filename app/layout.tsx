import type { Metadata } from "next";
import "./globals.css";
import { AgeGate } from "@/components/age-gate";
import { SiteChrome } from "@/components/site-chrome";
import { CartProvider } from "@/lib/cart-context";
import { BUSINESS } from "@/lib/business-info";
import { GANJAVORES_FAQ } from "@/components/home/faq-section";

export const metadata: Metadata = {
  metadataBase: new URL("https://ganjavores.shop"),
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
    url: "https://ganjavores.shop",
    siteName: "Ganjavores DC",
    locale: "en_US",
    type: "website",
    images: [
      {
        url: "https://ganjavores.shop/api/og",
        width: 1200,
        height: 630,
        alt: "Ganjavores DC — Premium Medical Cannabis Delivery",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: "Ganjavores DC",
    description:
      "We Don't Compete — We Consume the Competition. Serving DC & the DMV.",
    images: ["/api/og"],
    creator: "@ganjavores",
    site: "@ganjavores",
  },
  authors: [{ name: "Ganjavores DC" }],
  alternates: {
    canonical: "https://ganjavores.shop",
  },
  themeColor: "#070907",
  robots: {
    index: true,
    follow: true,
  },
};

export const viewport = {
  width: "device-width",
  initialScale: 1,
  themeColor: "#070907",
};

// ——— Structured Data (JSON-LD) ——————————————————————
// Inline scripts so AI crawlers can read entity info without executing JS.
// AEO report flagged LocalBusiness, FAQPage, and SoftwareApplication as missing.

const organizationJsonLd = {
  "@context": "https://schema.org",
  "@type": "Organization",
  name: BUSINESS.name,
  legalName: BUSINESS.legalName,
  url: "https://ganjavores.shop",
  email: BUSINESS.email,
  telephone: BUSINESS.phone,
  logo: "https://ganjavores.shop/brand/logo.png",
  sameAs: BUSINESS.social.sameAs,
  address: {
    "@type": "PostalAddress",
    streetAddress: BUSINESS.address.street,
    addressLocality: BUSINESS.address.city,
    addressRegion: BUSINESS.address.state,
    postalCode: BUSINESS.address.zip,
    addressCountry: "US",
  },
  areaServed: BUSINESS.serviceArea,
  foundingDate: "2023-01-01",
};

const localBusinessJsonLd = {
  "@context": "https://schema.org",
  "@type": "LocalBusiness",
  name: BUSINESS.name,
  image: "https://ganjavores.shop/brand/logo.png",
  telephone: BUSINESS.phone,
  email: BUSINESS.email,
  url: "https://ganjavores.shop",
  address: {
    "@type": "PostalAddress",
    streetAddress: BUSINESS.address.street,
    addressLocality: BUSINESS.address.city,
    addressRegion: BUSINESS.address.state,
    postalCode: BUSINESS.address.zip,
    addressCountry: "US",
  },
  geo: {
    "@type": "GeoCoordinates",
    latitude: 38.881836,
    longitude: -76.995344,
  },
  openingHoursSpecification: [
    {
      "@type": "OpeningHoursSpecification",
      dayOfWeek: [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday",
      ],
      opens: "10:00",
      closes: "22:00",
    },
  ],
  priceCurrency: "USD",
  priceRange: "$$",
  sameAs: BUSINESS.social.sameAs,
  license: BUSINESS.license,
};

const softwareApplicationJsonLd = {
  "@context": "https://schema.org",
  "@type": "SoftwareApplication",
  name: "Ganjavores DC Online Ordering",
  applicationCategory: "ShoppingApplication",
  applicationPlatform: "Web",
  operatingSystem: "Any",
  offers: {
    "@type": "Offer",
    price: "0",
    priceCurrency: "USD",
  },
  url: "https://ganjavores.shop",
};

const faqJsonLd = {
  "@context": "https://schema.org",
  "@type": "FAQPage",
  mainEntity: GANJAVORES_FAQ.map((faq) => ({
    "@type": "Question",
    name: faq.question,
    acceptedAnswer: {
      "@type": "Answer",
      text: faq.answer,
    },
  })),
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <head>
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(organizationJsonLd) }}
        />
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(localBusinessJsonLd) }}
        />
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(softwareApplicationJsonLd) }}
        />
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(faqJsonLd) }}
        />
      </head>
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
