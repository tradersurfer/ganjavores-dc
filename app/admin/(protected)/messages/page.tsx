import { createClient } from "@/lib/supabase/server";
import { MarkReadButton } from "@/components/admin/mark-read-button";

export const dynamic = "force-dynamic";

export default async function AdminMessagesPage() {
  const supabase = await createClient();
  const { data: messages } = await supabase
    .from("contact_messages")
    .select("*")
    .order("created_at", { ascending: false });

  return (
    <div className="max-w-3xl">
      <h1 className="gv-section-heading mb-8">Contact Messages</h1>

      <div className="space-y-4">
        {(messages ?? []).map((m) => (
          <div key={m.id} className={`gv-card ${!m.is_read ? "border-emerald" : ""}`}>
            <div className="flex items-start justify-between gap-4">
              <div>
                <p className="text-white font-medium">
                  {m.name}
                  {!m.is_read && <span className="ml-2 gv-badge-exclusive text-[10px]">New</span>}
                </p>
                <p className="text-soft text-sm">
                  <a href={`mailto:${m.email}`} className="hover:text-emerald">{m.email}</a>
                  {m.phone && <> · {m.phone}</>}
                </p>
                {m.subject && <p className="text-white text-sm mt-2 font-medium">{m.subject}</p>}
                <p className="text-soft text-sm mt-1">{m.message}</p>
                <p className="text-soft/60 text-xs mt-2">
                  {new Date(m.created_at).toLocaleString("en-US")}
                </p>
              </div>
              {!m.is_read && <MarkReadButton id={m.id} />}
            </div>
          </div>
        ))}

        {(messages ?? []).length === 0 && (
          <p className="text-soft text-sm py-8 text-center">No messages yet.</p>
        )}
      </div>
    </div>
  );
}
