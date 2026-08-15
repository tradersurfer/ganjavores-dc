import Image from "next/image";
import Link from "next/link";
import { BUSINESS } from "@/lib/business-info";

export function Hero({
  announcement,
}: {
  announcement: {
    title: string;
    subtitle: string | null;
    image_url: string | null;
    mobile_image_url: string | null;
    link_url: string | null;
  } | null;
}) {
  const desktopImage = announcement?.image_url ?? "/brand/banner-primary.png";
  const mobileImage = announcement?.mobile_image_url ?? "/brand/hero-mobile.jpg";

  return (
    <section className="relative">
      <div className="relative h-[70vh] min-h-[420px] w-full overflow-hidden">
        {/* Mobile crop — swaps in below md breakpoint */}
        <div className="md:hidden absolute inset-0">
          <Image src={mobileImage} alt="Ganjavores DC" fill priority className="object-cover" />
        </div>
        {/* Desktop crop */}
        <div className="hidden md:block absolute inset-0">
          <Image src={desktopImage} alt="Ganjavores DC" fill priority className="object-cover" />
        </div>
        <div className="absolute inset-0 bg-gradient-to-t from-midnight via-midnight/40 to-midnight/10" />

        <div className="relative h-full max-w-6xl mx-auto px-6 flex flex-col justify-end pb-16">
          <p className="text-emerald text-sm uppercase tracking-widest mb-3">
            {BUSINESS.slogans.local}
          </p>
          <h1 className="font-display text-4xl md:text-6xl text-white max-w-2xl leading-[1.05]">
            {announcement?.title ?? "Ganjavores DC"}
          </h1>
          <p className="text-soft text-lg mt-4 max-w-xl">
            {announcement?.subtitle ?? BUSINESS.slogans.delivery}
          </p>
          <div className="flex flex-wrap gap-4 mt-8">
            <Link href={announcement?.link_url ?? "/shop"} className="gv-btn-primary">
              Shop Now
            </Link>
            <a href={`tel:${BUSINESS.phone}`} className="gv-btn-outline">
              Call {BUSINESS.phone}
            </a>
          </div>
        </div>
      </div>
    </section>
  );
}
