import Link from "next/link";
import { BUSINESS } from "@/lib/business-info";

export function SiteFooter() {
  const hasSocials = BUSINESS.social.x || BUSINESS.social.instagram || BUSINESS.social.tiktok;

  return (
    <footer className="bg-[#070907] border-t border-border mt-20">
      <div className="max-w-6xl mx-auto px-6 py-16 grid gap-12 md:grid-cols-3">
        <div>
          <h3 className="text-emerald font-display text-lg mb-4">Menu</h3>
          <ul className="space-y-2 text-soft text-sm">
            <li><Link href="/" className="hover:text-emerald">Home</Link></li>
            <li><Link href="/shop" className="hover:text-emerald">Shop</Link></li>
            <li><Link href="/deals" className="hover:text-emerald">Deals</Link></li>
            <li><Link href="/brands" className="hover:text-emerald">Brands We Carry</Link></li>
            <li><Link href="/about" className="hover:text-emerald">About</Link></li>
            <li><Link href="/contact" className="hover:text-emerald">Contact</Link></li>
          </ul>
        </div>

        <div>
          <h3 className="text-emerald font-display text-lg mb-4">Location</h3>
          <p className="text-soft text-sm">
            {BUSINESS.address.street}
            <br />
            {BUSINESS.address.city}, {BUSINESS.address.state} {BUSINESS.address.zip}
          </p>
          <a href={`tel:${BUSINESS.phone}`} className="text-soft text-sm hover:text-emerald">
            {BUSINESS.phone}
          </a>
          {BUSINESS.googleBusinessProfileUrl && (
            <p className="mt-1">
              <a
                href={BUSINESS.googleBusinessProfileUrl}
                target="_blank"
                rel="noopener noreferrer"
                className="text-soft text-sm hover:text-emerald"
              >
                Google Reviews &rarr;
              </a>
            </p>
          )}
        </div>

        <div>
          <h3 className="text-emerald font-display text-lg mb-4">Hours</h3>
          <p className="text-soft text-sm">{BUSINESS.hours.display}</p>
          <p className="text-soft text-sm mt-1">Delivery &amp; Curbside Pickup Only</p>

          {hasSocials && (
            <div className="flex gap-4 mt-4">
              {BUSINESS.social.x && (
                <a
                  href={BUSINESS.social.x}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-soft hover:text-emerald text-sm"
                >
                  X
                </a>
              )}
              {BUSINESS.social.instagram && (
                <a
                  href={BUSINESS.social.instagram}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-soft hover:text-emerald text-sm"
                >
                  Instagram
                </a>
              )}
              {BUSINESS.social.tiktok && (
                <a
                  href={BUSINESS.social.tiktok}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="text-soft hover:text-emerald text-sm"
                >
                  TikTok
                </a>
              )}
            </div>
          )}
        </div>
      </div>

      <div className="border-t border-border px-6 py-6 text-center text-xs text-soft/70 space-y-2">
        <p>{BUSINESS.license}</p>
        <p>
          For use only by persons 21 years of age or older, or valid DC
          medical cannabis patients. All cannabis products are final sale.
        </p>
        <p>
          © {new Date().getFullYear()} {BUSINESS.legalName}. All Rights
          Reserved.
        </p>
      </div>
    </footer>
  );
}
