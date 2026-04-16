---
trigger: always_on
---

# Design System Strategy: High-End P2P Crypto Experience

## 1. Overview & Creative North Star

**The Creative North Star: "The Golden Standard"**

This design system moves away from the chaotic, high-density interfaces of traditional crypto exchanges. Instead, it adopts a philosophy of "Soft Minimalism" combined with energetic brand accents—an approach that prioritizes cognitive ease, approachability, and clear conversion paths.

The system breaks the standard "SaaS template" look through **Tonal Layering** and **Intentional Asymmetry**. Rather than rigid boxes, we use sophisticated depth, vibrant primary accents, and a high-contrast typography scale to guide the user. The goal is to make the complex world of P2P currency exchange feel friendly, fast, and secure.

---

## 2. Colors: Tonal Architecture

The palette is built on a foundation of "El Dorado Gold," "Soft Cyan," and "Atmospheric Grays" based on the brand's core identity.

- **Primary (`#FFB400` / El Dorado Gold):** Used for core actions, buttons (like "Cambiar"), and brand presence. It conveys energy, wealth, and approachability.

- **Background Accent (`#E0F7FA` / Soft Cyan):** Used as a calming, fresh background canvas to contrast with the warm primary color.

- **Surface Strategy:** We utilize a tiered surface system to create hierarchy without clutter.

- **The "No-Line" Rule:** 1px solid borders should be used sparingly (mostly for inputs like the "TENGO/QUIERO" section, using a primary yellow outline). Boundaries for main cards must be defined through shadows and background color shifts.

### Surface Hierarchy & Nesting

Treat the UI as a series of physical layers.

- **Base Level:** `surface` (Soft Cyan/Light Blue gradient or solid `#E4F6F8`)

- **Nested Content:** Use `surface-container-lowest` (#ffffff) for primary cards to create a clear focal point.

- **Secondary Areas:** Use `surface-container` (#f5f5f5) for background utility areas or unselected list items.

### The "Glass & Gradient" Rule

To elevate the experience beyond flat design:

- **Background Cards:** Clean white `#ffffff` with soft, expansive drop shadows.

- **Signature Textures:** Main CTAs and prominent floating elements should use the solid Primary Gold (`#FFB400`), or a subtle gradient towards a slightly deeper amber to provide tactile depth.

---

## 3. Typography: Editorial Authority

We utilize a pairing of **Manrope** for expressive, high-end headlines and **Inter** for functional, high-legibility data.

- **Display & Headlines (Manrope):** These are the "anchors." Use `display-lg` and `headline-md` with generous tracking adjustments to create a sense of bespoke luxury.

- **Body & Labels (Inter):** For currency pairs, transaction IDs, and input text. Inter’s neutral character ensures that financial data remains the hero.

- **Hierarchy through Scale:** Use dramatic size differences between input text (e.g., the "5.00" amount) and supplementary info (e.g., "Tasa estimada") to create a clear "read-order".

---

## 4. Elevation & Depth: Tonal Layering

Traditional sharp borders are replaced with sophisticated atmospheric depth.

- **The Layering Principle:** A `surface-container-lowest` (#ffffff) card placed on a Soft Cyan background provides a natural, clean lift.

- **Ambient Shadows:** When a float is required (e.g., the main calculator card), use a shadow with a blur radius of 30px-50px at 8-10% opacity.

- **Active States:** For selected inputs or focused elements, use a 1px or 2px border of the Primary Gold (`#FFB400`) to clearly indicate selection without heavy background fills.

---

## 5. Components: Refined Primitives

### Buttons

- **Primary:** Solid fill (`#FFB400`), `xl` (1rem to 1.5rem) roundedness. No border. Text should be white or very dark gray for contrast.

- **Secondary:** Transparent background with `on-surface` text and a subtle icon.

- **Swap Action Button:** A circular floating action button placed between inputs, filled with Primary Gold and white arrows, overlapping the input borders slightly.

### Input Fields

- **Styling:** Use `surface-container-lowest` (#ffffff) with rounded corners.

- **Interaction:** Unselected fields use a subtle gray outline. On focus or selection, transition the border to Primary Gold (`#FFB400`).

- **Refinement:** Labels should use `label-sm` in `on-surface-variant` (gray) positioned elegantly inside or slightly overlapping the top border of the field.

### Lists & Currency Selection

- **Layout:** Clear, generously spaced rows.

- **Selection Indicators:** Use circular radio buttons. When selected, the radio button should be outlined/filled with a dark color or the Primary Gold.

- **Currency Icons:** Use the official round flags or crypto logos alongside the ticker symbol and full name (e.g., 🇻🇪 VES Bolívares).

### P2P Specific: Trust Indicators

- **Verification Badges:** Use standard success green (`#28A745`) or the brand's dark contrast color to denote "safety" and successful transactions.

---

## 6. Do's and Don'ts

### Do

- **DO** use rounded corners for main containers to mirror the approachable, modern feel of the app.

- **DO** use the high-contrast El Dorado Gold (`#FFB400`) to draw attention to the primary conversion action (e.g., the "Cambiar" button).

- **DO** use white cards over colored backgrounds to make the calculator "pop" as the central piece of the UI.

### Don't

- **DON'T** use pure black (#000000) for large text blocks. Use a dark charcoal (`#191c1d`) to maintain a soft tone, though pure black can be used in marketing footers.

- **DON'T** overuse the Primary Gold. Reserve it for the main action buttons, the swap icon, and active input borders to preserve its visual impact.

- **DON'T** clutter the exchange widget. Follow the layout: Send input, Swap button, Receive input, followed by the exchange rate details and the CTA.
