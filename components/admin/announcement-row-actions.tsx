"use client";

import { useTransition } from "react";
import { Trash2 } from "lucide-react";
import { toggleAnnouncementActive, deleteAnnouncement } from "@/app/actions/admin-announcements";

export function AnnouncementRowActions({
  id,
  isActive,
}: {
  id: string;
  isActive: boolean;
}) {
  const [isPending, startTransition] = useTransition();

  return (
    <div className="flex items-center gap-3">
      <label className="flex items-center gap-2 text-sm text-soft cursor-pointer">
        <input
          type="checkbox"
          defaultChecked={isActive}
          disabled={isPending}
          onChange={(e) =>
            startTransition(() => toggleAnnouncementActive(id, e.target.checked))
          }
          className="accent-emerald"
        />
        Active
      </label>
      <button
        onClick={() => {
          if (confirm("Delete this announcement?")) {
            startTransition(() => deleteAnnouncement(id));
          }
        }}
        className="text-soft hover:text-red-400"
        aria-label="Delete announcement"
      >
        <Trash2 size={16} />
      </button>
    </div>
  );
}
