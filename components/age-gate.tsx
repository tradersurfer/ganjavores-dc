"use client";

import { useEffect, useState } from "react";

const STORAGE_KEY = "gv_age_confirmed";

export function AgeGate() {
  const [visible, setVisible] = useState(false);

  useEffect(() => {
    const confirmed = window.localStorage.getItem(STORAGE_KEY);
    if (!confirmed) setVisible(true);
  }, []);

  function confirm() {
    window.localStorage.setItem(STORAGE_KEY, "true");
    setVisible(false);
  }

  function deny() {
    // Bounce anyone under 21 off the site entirely
    window.location.href = "https://www.dc.gov";
  }

  if (!visible) return null;

  return (
    <div className="fixed inset-0 z-[999] flex items-center justify-center bg-midnight/95 backdrop-blur-sm px-4">
      <div className="gv-card max-w-md w-full text-center space-y-6 shadow-glow-emerald">
        {/* TODO: swap in the metallic-foil Ganjavores logo once assets are wired into /public */}
        <h1 className="font-display text-2xl text-emerald">Ganjavores DC</h1>
        <p className="text-soft">
          You must be 21 years of age or older, or a valid DC medical
          cannabis patient, to enter this site.
        </p>
        <div className="flex gap-4 justify-center">
          <button onClick={confirm} className="gv-btn-primary">
            I&rsquo;m 21+ — Enter
          </button>
          <button onClick={deny} className="gv-btn-outline">
            Leave
          </button>
        </div>
        <p className="text-xs text-soft/70">
          Licensed medical cannabis Internet Retailer under DC ABCA.
          For use only by persons 21 years of age or older.
        </p>
      </div>
    </div>
  );
}
