"use client";

import { useState } from "react";

export function DescriptionToggle({ description }: { description: string }) {
  const [expanded, setExpanded] = useState(false);
  const isLong = description.length > 280;
  const display = expanded || !isLong ? description : description.slice(0, 280) + "…";

  return (
    <div>
      <p className="text-soft leading-relaxed whitespace-pre-line">{display}</p>
      {isLong && (
        <button
          onClick={() => setExpanded((v) => !v)}
          className="text-emerald text-sm underline mt-2 hover:text-neon"
        >
          {expanded ? "show less" : "show more"}
        </button>
      )}
    </div>
  );
}
