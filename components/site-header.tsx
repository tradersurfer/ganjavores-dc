"use client";

import Link from "next/link";
import { useState } from "react";
import { Menu, Search, ShoppingBag, X } from "lucide-react";
import { BUSINESS } from "@/lib/business-info";
import { useCart } from "@/lib/cart-context";

// Own nav labels — same job as District's Shop/Specials/Brands/Locations/
// Merch/420, but in our voice, and no Locations/Merch/420 since we're
// single-location delivery-only, not multi-store retail.
const NAV_LINKS = [
  { label: "Shop", href: "/shop" },
  { label: "Deals", href: "/deals" },
  { label: "Brands We Carry", href: "/brands" },
  { label: "Ganjavores Exclusive", href: "/shop/ganjavores-exclusive" },
  { label: "About", href: "/about" },
];

export function SiteHeader() {
  const [menuOpen, setMenuOpen] = useState(false);
  const { itemCount } = useCart();

  return (
    <header className="sticky top-0 z-40 bg-midnight/95 backdrop-blur border-b border-border">
      <div className="flex items-center justify-between px-4 py-2 text-xs text-soft border-b border-border/50">
        <a href={`tel:${BUSINESS.phone}`} className="hover:text-emerald">
          ☎ {BUSINESS.phone}
        </a>
        <a href={`mailto:${BUSINESS.email}`} className="hover:text-emerald">
          {BUSINESS.email}
        </a>
      </div>

      <div className="flex items-center justify-between px-4 py-3">
        <button
          onClick={() => setMenuOpen(true)}
          aria-label="Open menu"
          className="text-white md:hidden"
        >
          <Menu />
        </button>

        <Link href="/" className="mx-auto md:mx-0">
          {/* TODO: swap for real logo asset once wired into /public/brand */}
          <span className="font-display text-2xl text-emerald">
            Ganjavores
          </span>
        </Link>

        <nav className="hidden md:flex gap-6 mx-auto">
          {NAV_LINKS.map((link) => (
            <Link
              key={link.href}
              href={link.href}
              className="text-sm text-white hover:text-emerald transition-colors"
            >
              {link.label}
            </Link>
          ))}
        </nav>

        <div className="flex items-center gap-4 text-white">
          <button aria-label="Search">
            <Search size={20} />
          </button>
          <Link href="/cart" aria-label="Cart" className="relative">
            <ShoppingBag size={20} />
            {itemCount > 0 && (
              <span className="absolute -top-2 -right-2 bg-emerald text-midnight text-[10px] font-bold rounded-full w-4 h-4 flex items-center justify-center">
                {itemCount}
              </span>
            )}
          </Link>
        </div>
      </div>

      {/* Mobile full-screen nav — mirrors the District X-close overlay pattern */}
      {menuOpen && (
        <div className="fixed inset-0 z-50 bg-[#0B0E0B] flex flex-col px-6 py-8">
          <button
            onClick={() => setMenuOpen(false)}
            aria-label="Close menu"
            className="self-end text-white"
          >
            <X size={28} />
          </button>
          <nav className="flex flex-col gap-6 mt-10">
            {NAV_LINKS.map((link) => (
              <Link
                key={link.href}
                href={link.href}
                onClick={() => setMenuOpen(false)}
                className="font-display text-3xl text-white hover:text-emerald"
              >
                {link.label}
              </Link>
            ))}
          </nav>
        </div>
      )}
    </header>
  );
}
