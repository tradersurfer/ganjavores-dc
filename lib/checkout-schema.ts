import { z } from "zod";

export const checkoutSchema = z
  .object({
    customer_name: z.string().min(2, "Name is required"),
    customer_phone: z
      .string()
      .min(10, "Enter a valid phone number")
      .regex(/^[\d\s()+-]+$/, "Enter a valid phone number"),
    customer_email: z.string().email().optional().or(z.literal("")),
    fulfillment_type: z.enum(["delivery", "pickup"]),
    delivery_address: z.string().optional(),
    delivery_city: z.string().optional(),
    delivery_zip: z.string().optional(),
    preferred_window: z.string().optional(),
    order_notes: z.string().optional(),
  })
  .refine(
    (data) =>
      data.fulfillment_type !== "delivery" ||
      (data.delivery_address && data.delivery_address.length > 4),
    {
      message: "Delivery address is required for delivery orders",
      path: ["delivery_address"],
    }
  );

export type CheckoutFormValues = z.infer<typeof checkoutSchema>;
