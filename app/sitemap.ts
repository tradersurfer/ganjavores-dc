import { MetadataRoute } from "next";
import { getShopProducts, getAllBrands, getAllCategories } from "@/lib/supabase/queries";

/**
 * Dynamic sitemap — includes static pages plus product, brand, and category
 * routes fetched from Supabase. Falls back to static routes only if the
 * Supabase connection fails (e.g. during a build without env vars).
 */
export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const baseUrl = "https://ganjavores.shop";
  const now = new Date();

  const staticRoutes: MetadataRoute.Sitemap = [
    {
      url: baseUrl + "/",
      lastModified: now,
      changeFrequency: "daily",
      priority: 1,
    },
    {
      url: baseUrl + "/shop",
      lastModified: now,
      changeFrequency: "daily",
      priority: 0.9,
    },
    {
      url: baseUrl + "/deals",
      lastModified: now,
      changeFrequency: "weekly",
      priority: 0.7,
    },
    {
      url: baseUrl + "/brands",
      lastModified: now,
      changeFrequency: "daily",
      priority: 0.7,
    },
    {
      url: baseUrl + "/about",
      lastModified: now,
      changeFrequency: "monthly",
      priority: 0.6,
    },
    {
      url: baseUrl + "/contact",
      lastModified: now,
      changeFrequency: "monthly",
      priority: 0.6,
    },
    {
      url: baseUrl + "/pricing",
      lastModified: now,
      changeFrequency: "monthly",
      priority: 0.7,
    },
    {
      url: baseUrl + "/faq",
      lastModified: now,
      changeFrequency: "monthly",
      priority: 0.7,
    },
    {
      url: baseUrl + "/cart",
      lastModified: now,
      changeFrequency: "never",
      priority: 0.3,
    },
    {
      url: baseUrl + "/checkout",
      lastModified: now,
      changeFrequency: "never",
      priority: 0.3,
    },
  ];

  try {
    const [{ products }, brands, categories] = await Promise.all([
      getShopProducts({ perPage: 500 }),
      getAllBrands(),
      getAllCategories(),
    ]);

    const productRoutes: MetadataRoute.Sitemap = products.map((p) => ({
      url: `${baseUrl}/product/${p.slug}`,
      lastModified: now,
      changeFrequency: "weekly",
      priority: 0.8,
    }));

    const brandRoutes: MetadataRoute.Sitemap = brands.map((b) => ({
      url: `${baseUrl}/brands/${b.slug}`,
      lastModified: now,
      changeFrequency: "weekly",
      priority: 0.6,
    }));

    const categoryRoutes: MetadataRoute.Sitemap = categories.map((c) => ({
      url: `${baseUrl}/shop?category=${c.slug}`,
      lastModified: now,
      changeFrequency: "weekly",
      priority: 0.7,
    }));

    return [...staticRoutes, ...productRoutes, ...brandRoutes, ...categoryRoutes];
  } catch {
    // Supabase not available at build time — serve static routes only
    return staticRoutes;
  }
}
