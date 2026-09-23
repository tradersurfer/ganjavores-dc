export type TrustedCatalogVariant = {
  id: string;
  product_id: string;
  label: string;
  price: number;
  inventory_count: number;
  products?:
    | { name: string; is_active: boolean }
    | Array<{ name: string; is_active: boolean }>
    | null;
};

export type TrustedOrderItem = {
  product_id: string;
  variant_id: string;
  product_name_snapshot: string;
  variant_label_snapshot: string;
  unit_price: number;
  quantity: number;
  line_total: number;
};

type TrustedCartResult =
  | { success: true; items: TrustedOrderItem[]; subtotal: number }
  | { success: false; error: string };

function isLine(value: unknown): value is { variant_id: string; quantity: number } {
  if (!value || typeof value !== "object") return false;
  const line = value as Record<string, unknown>;
  return (
    typeof line.variant_id === "string" &&
    line.variant_id.length > 0 &&
    typeof line.quantity === "number" &&
    Number.isSafeInteger(line.quantity) &&
    line.quantity > 0 &&
    line.quantity <= 20
  );
}

function productFor(variant: TrustedCatalogVariant) {
  return Array.isArray(variant.products) ? variant.products[0] : variant.products;
}

export function validateTrustedCart(
  clientLines: readonly unknown[],
  catalog: readonly TrustedCatalogVariant[]
): TrustedCartResult {
  if (!Array.isArray(clientLines) || clientLines.length === 0 || clientLines.length > 30) {
    return { success: false, error: "Invalid cart" };
  }
  if (!clientLines.every(isLine)) {
    return { success: false, error: "Invalid cart" };
  }

  const variantsById = new Map(catalog.map((variant) => [variant.id, variant]));
  const quantities = new Map<string, number>();
  for (const line of clientLines) {
    quantities.set(line.variant_id, (quantities.get(line.variant_id) ?? 0) + line.quantity);
  }

  const items: TrustedOrderItem[] = [];
  for (const [variantId, quantity] of quantities) {
    const variant = variantsById.get(variantId);
    if (!variant) {
      return { success: false, error: "One or more items are no longer available" };
    }
    const product = productFor(variant);
    if (!product || product.is_active !== true) {
      return { success: false, error: "One or more products are no longer available" };
    }
    if (!Number.isFinite(variant.price) || variant.price < 0) {
      return { success: false, error: "Invalid product price" };
    }
    if (quantity > variant.inventory_count) {
      return {
        success: false,
        error: `Insufficient inventory for ${product.name} (${variant.label})`,
      };
    }

    const lineTotal = variant.price * quantity;
    items.push({
      product_id: variant.product_id,
      variant_id: variant.id,
      product_name_snapshot: product.name,
      variant_label_snapshot: variant.label,
      unit_price: variant.price,
      quantity,
      line_total: lineTotal,
    });
  }

  return {
    success: true,
    items,
    subtotal: items.reduce((sum, item) => sum + item.line_total, 0),
  };
}
