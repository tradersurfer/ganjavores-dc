# Ganjavores DC Skill

> What AI agents can do via this site's API surface.

## Overview

Ganjavores DC is a licensed medical cannabis Internet Retailer (DC ABCA) serving
Washington, DC and the DMV. This skill file describes the agent-facing surface
of the site so AI agents can route tasks correctly.

## API Endpoint

- Base URL: `https://ganjavores.shop`
- Auth: Supabase Auth (email/password) for admin routes; public anon key for
  read-only catalog/product endpoints.

## Tools (Agent Tasks)

- **search_products**: Browse the full product catalog (flower, vapes, edibles,
  pre-rolls, concentrates, Ganjavores Exclusive house line). Filter by category,
  brand, strain type, price range, and minimum THC%.
- **get_product**: Retrieve a full product page by slug — includes variant
  pricing, terpene/cannabinoid panels, brand info, lab-test data, and related
  products.
- **get_brands**: List all brands carried, or view a single brand page.
- **get_deals**: Fetch current specials and limited-time offers from the
  announcements table.
- **submit_contact**: Send a contact message (name, email, phone, subject,
  message) — writes to the `contact_messages` table.
- **get_faq**: Retrieve structured FAQ data for common customer questions.

## Public Pages

- `https://ganjavores.shop/` — Homepage
- `https://ganjavores.shop/shop` — Shop all products
- `https://ganjavores.shop/deals` — Current deals
- `https://ganjavores.shop/brands` — Brands we carry
- `https://ganjavores.shop/about` — About us
- `https://ganjavores.shop/contact` — Contact form
- `https://ganjavores.shop/pricing` — Pricing & payment info
- `https://ganjavores.shop/faq` — Frequently asked questions

## Notes

- No online payments are collected — orders are pay-on-arrival / pay-on-pickup.
- Must be 21+ or a valid DC medical cannabis patient to order.
- All products are final sale.
