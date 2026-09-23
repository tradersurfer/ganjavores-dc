import assert from "node:assert/strict";
import test from "node:test";
import { validateTrustedCart } from "../lib/secure-checkout.ts";

const variant = {
  id: "11111111-1111-4111-8111-111111111111",
  product_id: "22222222-2222-4222-8222-222222222222",
  label: "3.5g",
  price: 45.5,
  inventory_count: 3,
  products: { name: "Trusted Flower", is_active: true },
};

 test("ignores a tampered client price and snapshots server values", () => {
  const result = validateTrustedCart(
    [{ variant_id: variant.id, quantity: 2, unit_price: 0.01, product_name: "Fake" }],
    [variant]
  );
  assert.equal(result.success, true);
  if (result.success) {
    assert.equal(result.subtotal, 91);
    assert.equal(result.items[0].unit_price, 45.5);
    assert.equal(result.items[0].product_name_snapshot, "Trusted Flower");
  }
});

test("rejects a missing or inactive variant", () => {
  assert.equal(
    validateTrustedCart([{ variant_id: "missing", quantity: 1 }], [variant]).success,
    false
  );
  assert.equal(
    validateTrustedCart(
      [{ variant_id: variant.id, quantity: 1 }],
      [{ ...variant, products: { name: "Hidden Flower", is_active: false } }]
    ).success,
    false
  );
});

test("rejects quantities above inventory and per-line cap", () => {
  assert.equal(validateTrustedCart([{ variant_id: variant.id, quantity: 4 }], [variant]).success, false);
  assert.equal(validateTrustedCart([{ variant_id: variant.id, quantity: 21 }], [variant]).success, false);
});

test("rejects more than thirty client lines", () => {
  const lines = Array.from({ length: 31 }, () => ({ variant_id: variant.id, quantity: 1 }));
  assert.equal(validateTrustedCart(lines, [variant]).success, false);
});
