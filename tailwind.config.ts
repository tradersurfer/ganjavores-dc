import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./app/**/*.{ts,tsx}",
    "./components/**/*.{ts,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        // Ganjavores DC brand palette — strict per brand spec
        emerald: "#00D66B",     // primary / accent
        midnight: "#0B0E0B",    // background
        neon: "#00FF75",        // hover / active accent
        soft: "#BBFFDD",        // secondary / muted text on dark
        border: "#00331A",      // borders, subtle shadows
        highlight: "#39FF14",   // sale / badge lime
      },
      fontFamily: {
        // swap these for the actual brand fonts once picked —
        // District uses a serif display + clean sans body, we should
        // land somewhere premium-dark rather than copying it directly
        display: ["var(--font-display)", "serif"],
        sans: ["var(--font-sans)", "system-ui", "sans-serif"],
      },
      boxShadow: {
        "glow-emerald": "0 0 24px rgba(0, 214, 107, 0.35)",
        "glow-neon": "0 0 24px rgba(0, 255, 117, 0.45)",
      },
      borderRadius: {
        card: "1rem",
      },
    },
  },
  plugins: [],
};

export default config;
