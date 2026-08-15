import Image from "next/image";
import { createClient } from "@/lib/supabase/server";
import { createAnnouncement } from "@/app/actions/admin-announcements";
import { AnnouncementRowActions } from "@/components/admin/announcement-row-actions";

export const dynamic = "force-dynamic";

const PLACEMENTS = [
  { value: "homepage_hero", label: "Homepage — Primary Hero" },
  { value: "homepage_secondary", label: "Homepage — Secondary Banner" },
  { value: "specials_page", label: "Deals Page" },
  { value: "sitewide_banner", label: "Sitewide Top Banner" },
];

export default async function AdminAnnouncementsPage() {
  const supabase = await createClient();
  const { data: announcements } = await supabase
    .from("announcements")
    .select("*")
    .order("placement")
    .order("display_order");

  return (
    <div className="max-w-4xl">
      <h1 className="gv-section-heading mb-8">Announcements &amp; Deals</h1>

      <div className="space-y-4 mb-10">
        {(announcements ?? []).map((a) => (
          <div key={a.id} className="gv-card flex gap-4">
            <div className="relative w-24 h-16 rounded bg-[#0d110d] overflow-hidden shrink-0">
              {a.image_url && (
                <Image src={a.image_url} alt={a.title} fill className="object-cover" />
              )}
            </div>
            <div className="flex-1">
              <p className="text-white font-medium">{a.title}</p>
              {a.subtitle && <p className="text-soft text-sm">{a.subtitle}</p>}
              <p className="text-soft text-xs capitalize mt-1">
                {a.placement.replace(/_/g, " ")}
              </p>
            </div>
            <AnnouncementRowActions id={a.id} isActive={a.is_active} />
          </div>
        ))}
        {(announcements ?? []).length === 0 && (
          <p className="text-soft text-sm">No announcements yet — add one below.</p>
        )}
      </div>

      <div className="gv-card">
        <h2 className="text-white font-display text-xl mb-4">New Announcement</h2>
        <form action={createAnnouncement} className="space-y-4">
          <input
            name="title"
            required
            placeholder="Title (e.g. 15% Off All RSO)"
            className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
          />
          <input
            name="subtitle"
            placeholder="Subtitle (optional)"
            className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
          />
          <div className="grid grid-cols-2 gap-4">
            <input
              name="image_url"
              placeholder="Desktop image URL"
              className="bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
            />
            <input
              name="mobile_image_url"
              placeholder="Mobile image URL (optional)"
              className="bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
            />
          </div>
          <input
            name="link_url"
            placeholder="Link URL (optional, e.g. /shop/flower)"
            className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
          />
          <select
            name="placement"
            required
            className="w-full bg-[#101410] border border-border rounded-lg px-3 py-2.5 text-white"
          >
            {PLACEMENTS.map((p) => (
              <option key={p.value} value={p.value}>{p.label}</option>
            ))}
          </select>
          <label className="flex items-center gap-2 text-white text-sm cursor-pointer">
            <input type="checkbox" name="is_active" defaultChecked className="accent-emerald" />
            Active immediately
          </label>
          <button type="submit" className="gv-btn-primary">
            Create Announcement
          </button>
        </form>
      </div>
    </div>
  );
}
