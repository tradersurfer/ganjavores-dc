import Image from "next/image";
import Link from "next/link";

export function SecondaryBanner({
  announcement,
}: {
  announcement: {
    title: string;
    subtitle: string | null;
    image_url: string | null;
    link_url: string | null;
  } | null;
}) {
  const image = announcement?.image_url ?? "/brand/banner-secondary.jpg";

  return (
    <section className="max-w-6xl mx-auto px-4 md:px-6 py-6">
      <Link
        href={announcement?.link_url ?? "/shop"}
        className="relative block h-48 md:h-64 rounded-card overflow-hidden group"
      >
        <Image
          src={image}
          alt={announcement?.title ?? "Ganjavores DC Delivery"}
          fill
          className="object-cover transition-transform duration-500 group-hover:scale-105"
        />
        <div className="absolute inset-0 bg-gradient-to-r from-midnight/90 via-midnight/40 to-transparent" />
        <div className="relative h-full flex flex-col justify-center px-8 max-w-md">
          <h2 className="font-display text-2xl md:text-3xl text-white">
            {announcement?.title ?? "Fast Delivery. Top Quality."}
          </h2>
          <p className="text-soft mt-2">
            {announcement?.subtitle ?? "Serving DC & the DMV — order now, pay on arrival."}
          </p>
        </div>
      </Link>
    </section>
  );
}
