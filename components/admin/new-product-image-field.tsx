"use client";

import { useState } from "react";
import { ImageUploadButton } from "@/components/admin/image-upload-button";

export function NewProductImageField() {
  const [url, setUrl] = useState("");

  return (
    <div className="space-y-3">
      <input type="hidden" name="image_url" value={url} />

      {url && (
        <img src={url} alt="Preview" className="w-24 h-24 object-cover rounded-lg border border-border" />
      )}

      <div className="flex flex-wrap items-center gap-3">
        <ImageUploadButton onUploaded={setUrl} label="Upload Image" />
        <span className="text-soft text-xs">or</span>
        <input
          value={url}
          onChange={(e) => setUrl(e.target.value)}
          placeholder="Paste an image URL instead"
          className="flex-1 min-w-[200px] bg-[#101410] border border-border rounded-lg px-3 py-2 text-white text-sm"
        />
      </div>
    </div>
  );
}
