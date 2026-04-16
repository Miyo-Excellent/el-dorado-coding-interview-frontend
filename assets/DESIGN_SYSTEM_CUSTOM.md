---
trigger: always_on
---

# Design System: The Electric Alchemist

## 1. Overview & Creative North Star

The design system is built to transform the "SuperApp" experience from a utility into a high-energy editorial event. We are moving away from the safe, sterile layouts of traditional fintech and toward a philosophy we call **"The Electric Alchemist."**

**The Creative North Star: High-Voltage Editorial.**
This system utilizes extreme tonal contrast—deep charcoal depths meeting neon highlights—to create a sense of premium urgency. We reject the "template" look by embracing intentional asymmetry, massive typographic scales, and physical layering. Every screen should feel like a page from a high-end fashion or tech lookbook, where white space isn't just "empty," it’s a stage for bold action.

---

## 2. Colors & Surface Logic

### The Palette

The core of this system is the tension between `#131313` (Surface) and `#EFFF00` (Vibrant Energy).

- **Primary (`#FFFFFF`):** Used for maximum readability and high-end elegance against dark backgrounds.
- **Primary Container (`#deed00` / `#EFFF00`):** Our "Golden" signature. Use this for high-energy CTAs and critical status indicators.
- **Surface Tiers:**
  - `surface_container_lowest`: `#0e0e0e` (Deepest recesses)
  - `surface`: `#131313` (The base canvas)
  - `surface_container_high`: `#2a2a2a` (Elevated interactive elements)

### The "No-Line" Rule

**Prohibit 1px solid borders for sectioning.** Boundaries must be defined solely through background color shifts. To separate a section, transition from `surface` to `surface_container_low`. This creates a sophisticated, seamless flow that feels integrated rather than boxed-in.

### Surface Hierarchy & Nesting

Treat the UI as a series of physical layers.

- **Nesting:** An inner card (`surface_container_highest`) should sit inside a section (`surface_container_low`) to define its importance.
- **Glass & Gradient:** For floating elements or top-level navigation, use Glassmorphism. Apply `surface_bright` at 60% opacity with a `24px` backdrop-blur.
- **Signature Textures:** For Hero backgrounds, use a subtle radial gradient: `radial-gradient(circle at top left, #deed00 0%, #131313 40%)` at a 5% opacity to add "soul" to the darkness.

---

## 3. Typography: The Editorial Voice

We use a high-contrast pairing to balance tech-modernity with friendly accessibility.

- **Display & Headlines (Space Grotesk):** This is our "loud" voice. Headlines should be tight-leaded and bold.
  - _Display-lg (3.5rem):_ Reserved for hero moments and major value propositions.
- **Body & Titles (Inter):** Our "functional" voice. Inter provides the Swiss-style clarity needed for complex data.
  - _Body-md (0.875rem):_ The workhorse for all app content.

**Editorial Hierarchy:** Always pair a `display-sm` headline with a significantly smaller `label-md` uppercase sub-header. This creates a "Power vs. Precision" dynamic that feels curated and intentional.

---

## 4. Elevation & Depth

### The Layering Principle

Depth is achieved through **Tonal Layering**, not shadows.

- Place a `surface_container_lowest` card on a `surface_container_low` background to create a "sunken" or "carved" effect.
- Place a `surface_container_highest` element on a `surface` background to create a "natural lift."

### Ambient Shadows

When an element must float (e.g., a bottom sheet or modal), use **Ambient Shadows**:

- **Color:** A tinted version of the surface (e.g., `#000000` at 15%).
- **Blur:** Large and diffused (e.g., `box-shadow: 0 20px 40px rgba(0,0,0,0.4)`).
- **The Ghost Border:** If accessibility requires a stroke, use `outline_variant` at 15% opacity. Never use 100% opaque borders.

---

## 5. Components

### Buttons

- **Primary (Golden):** Background: `primary_container` (#deed00), Text: `on_primary_container` (#2f3300). Bold, rounded-md.
- **Secondary:** Background: `surface_container_high`, Text: `primary` (#FFFFFF).
- **Tertiary:** No background. Text: `primary`. High-energy hover state (opacity shift).

### Cards & Lists

- **The Divider Ban:** Strictly forbid `1px` horizontal lines. Use vertical white space (1.5rem to 2rem) or a subtle change in surface container tokens to differentiate list items.
- **Interactive Cards:** Use `surface_container_low`. On hover, shift to `surface_container_high` with a slight scale (1.02x) for a "magnetic" feel.

### Input Fields

- **Styling:** Fields should be `surface_container_highest` with no border.
- **Focus State:** A 2px "Ghost Border" of `primary_container` at 40% opacity.
- **Helper Text:** Always use `label-sm` in `on_surface_variant` for a refined, small-print look.

### SuperApp Specific: The "Wealth Card"

A signature component for this system. A large-scale card using a glassmorphic blur over a subtle `primary_fixed` gradient, displaying the user's balance in `display-md` typography. No borders, just pure typographic authority.

---

## 6. Do’s and Don'ts

### Do

- **Do** use asymmetrical margins (e.g., 24px left, 32px right) for hero sections to create an editorial feel.
- **Do** allow the vibrant yellow (`primary_container`) to "bleed" into the UI through subtle glows and blurred background accents.
- **Do** prioritize typography size over color for hierarchy.

### Don't

- **Don't** use pure grey. Always use the specified neutral tokens which are slightly warm or cool to maintain the "Golden" atmosphere.
- **Don't** use standard "Material" shadows. Keep them deep, soft, and atmospheric.
- **Don't** clutter the screen. If a section feels crowded, increase the spacing token by two steps (e.g., from `md` to `xl`) rather than adding a divider.

---

## 7. Spacing & Roundedness Scale

| Token  | Value   | Application                       |
| :----- | :------ | :-------------------------------- |
| `none` | 0px     | Hard edges for brutalist sections |
| `sm`   | 0.25rem | Internal button padding           |
| `md`   | 0.75rem | Standard card radius              |
| `xl`   | 1.5rem  | Main container margins            |
| `full` | 9999px  | Pills, Chips, and Toggle switches |

_Designers should use `xl` (1.5rem) as the default gutter for the main app container to ensure the layout has room to "breathe."_
