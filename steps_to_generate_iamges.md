# Steps to Generate Images & Replace All Icons — PharmaChain

**Goal:** replace **every Material `Icon(Icons.*)` in the app** with a **JPG image** that has a
**light and a dark variant**, loaded automatically per theme via `context.assets.<name>`.

This file is the master plan (process + full catalog). The copy-paste prompts live in
**`ASSETSTOGENBERATE.md`**; the extra icons found in the code are added at the bottom of THIS file.

---

## 0) Reality check (read once)

- The app uses **193 `Icons.*` calls across 88 files**, but only **~70 unique icons**. After merging
  synonyms (e.g. `schedule` + `schedule_outlined`) it's about **55 unique images** to generate.
- Each becomes **2 files** (light + dark) → **~110 icon images**, plus the content images
  (empty states, avatars, stat thumbnails, brand) already in `ASSETSTOGENBERATE.md`.
- **Honest trade-offs of going all-image (so you decide with eyes open):**
  1. Material icons recolor for free (active/inactive nav, red delete, amber warning). Baked JPGs
     can't — we fix it with the light/dark variants and, where needed, accent colors baked in.
  2. ~110+ JPGs add weight (a few MB) vs ~0 for the icon font.
  3. **A few icons should stay as system icons** — see §5. Converting directional/structural icons to
     images breaks RTL (Arabic) and looks worse. I recommend keeping those; tell me if you disagree.
- Because of the trade-offs, the smart order is **content images first** (empty states, avatars,
  stats — biggest visual win), then nav/action icons.

---

## 1) Conventions

- **Folder:** all images go in `assets/images2/` (already registered in `pubspec.yaml`).
- **Filenames:** `<group>_<name>_light.jpg` and `<group>_<name>_dark.jpg` (exact, lowercase).
  - groups: `nav_`, `action_`, `new_`, `empty_`, `role_`, `stat_`, `status_`, `brand_`, `ic_` (generic).
- **Colors baked into each prompt:**
  - Light → `#FFFFFF` background, `#14233B` navy lines.
  - Dark → `#0F172A` background, `#F8FAFC` off-white lines.
  - Avatars → grey backgrounds (`#EAF1F4` / `#1E293B`).
  - Status badges → keep the accent color (amber/green/blue/teal/red), only bg flips.
- **Prompt style:** one short line — *name + "for a pharmacy management app" + background + lines + no text*.
  (See `ASSETSTOGENBERATE.md`.)

---

## 2) How it gets wired (so 193 call-sites stay sane)

Do NOT scatter `AppImageAssetPreviewer(...)` everywhere. The plan uses one catalog + one widget:

1. **`AppImages`** (`lib/core/constants/app_images.dart`) — add `xLight` / `xDark` path constants.
2. **`MyAssets`** (`lib/core/style/theme/assets_extension.dart`) — add one field per image, set in
   `light` and `dark`. This is what makes `context.assets.x` theme-correct.
3. **One reusable widget** `AppIcon` (new, `lib/core/common/widgets/app_icon.dart`):

   ```dart
   // Drop-in replacement for Icon(Icons.x). Shows the themed JPG, and falls
   // back to a Material icon if the asset isn't generated yet.
   class AppIcon extends StatelessWidget {
     const AppIcon({required this.image, required this.fallback, this.size = 24, super.key});
     final String image;        // e.g. context.assets.search
     final IconData fallback;   // e.g. Icons.search
     final double size;

     @override
     Widget build(BuildContext context) {
       return ClipRRect(
         borderRadius: BorderRadius.circular(size * 0.22),
         child: AppImageAssetPreviewer(
           image, width: size, height: size, fit: BoxFit.cover,
           errorBuilder: (_, _, _) => Icon(fallback, size: size),
         ),
       );
     }
   }
   ```
4. **Replace** `Icon(Icons.search, size: 20)` → `AppIcon(image: context.assets.search, fallback: Icons.search, size: 20)`.
   The `fallback` means the app keeps working before every image exists — migrate gradually.

---

## 3) Step-by-step process

1. **Generate** the images (prompts in `ASSETSTOGENBERATE.md` for items 1–67, plus §6 below for the
   generic `ic_*` icons). Save each as `*_light.jpg` / `*_dark.jpg` in `assets/images2/`.
2. **Tell me which group is done** (e.g. "nav done", "actions done").
3. I add the `*Light`/`*Dark` constants to `AppImages` and the fields to `MyAssets`.
4. I create the `AppIcon` widget (once).
5. I replace the `Icon(...)` call-sites **feature by feature**, run `flutter analyze`, and report.
6. Repeat per group until done.

> Migrate in this order for best payoff: **empty states → avatars → stat thumbnails → nav → actions → generic icons.**

---

## 4) Full catalog — what each unique icon maps to

Synonyms are merged into one image. "Replaces" = the `Icons.*` it stands in for.

### Navigation (prompts: `ASSETSTOGENBERATE.md` §A, items 1–12)
| Image name | Replaces |
|---|---|
| `nav_dashboard` | dashboard_outlined |
| `nav_inventory` | inventory_2, inventory_2_outlined |
| `nav_medications` | medication_outlined |
| `nav_sales_pos` | point_of_sale, point_of_sale_outlined |
| `nav_prescriptions` | receipt_long, receipt_long_outlined |
| `nav_customer_orders` | shopping_cart, shopping_cart_outlined, shopping_bag_outlined |
| `nav_suppliers` | local_shipping_outlined |
| `nav_purchase_orders` | assignment_outlined |
| `nav_staff` | people, people_outline, people_outlined, person_outline |
| `nav_shifts` | schedule, schedule_outlined, access_time_outlined |
| `nav_branches` | store_outlined |
| `nav_reports` | bar_chart_outlined |

### Actions (prompts: `ASSETSTOGENBERATE.md` §B, items 13–21)
| Image name | Replaces |
|---|---|
| `action_edit` | edit_outlined, edit_note |
| `action_delete` | delete_outline |
| `action_search` | search |
| `action_refresh` | refresh |
| `action_qr` | qr_code_scanner, qr_code_2 |
| `action_calendar` | calendar_today_outlined, calendar_month_outlined |
| `action_language` | language_outlined |
| `action_theme` | light_mode_outlined, dark_mode_outlined |
| `action_logout` | logout_outlined |

### Stat / money (prompts: `ASSETSTOGENBERATE.md` §F, items 46–60)
| Image name | Replaces |
|---|---|
| `stat_total_revenue` | attach_money |
| `stat_total_cost` | money_off |
| `stat_stock_in` | trending_up |
| `stat_stock_out` | trending_down |
| `stat_profit_margin` | pie_chart |
| `stat_manual_adjustment` | tune |

### Status (prompts: `ASSETSTOGENBERATE.md` §G, items 61–65)
| Image name | Replaces |
|---|---|
| `status_confirmed` | check_circle_outline, verified_outlined |
| `status_cancelled` | cancel_outlined |
| `status_sent` | send_outlined |

### Generic icons — NOT yet in `ASSETSTOGENBERATE.md` → prompts in §6 below
| Image name | Replaces |
|---|---|
| `ic_add` | add |
| `ic_error` | error_outline |
| `ic_warning` | warning_amber |
| `ic_visibility` | visibility_outlined |
| `ic_visibility_off` | visibility_off_outlined |
| `ic_person` | person_outline (standalone profile use) |
| `ic_phone` | phone_outlined |
| `ic_email` | mail_outline, email_outlined |
| `ic_location` | location_on_outlined |
| `ic_lock` | lock_outline, lock_outlined |
| `ic_notifications` | notifications_none_outlined, notifications_outlined |
| `ic_inbox` | inbox_outlined |
| `ic_history` | history, history_outlined |
| `ic_notes` | notes_outlined |
| `ic_no_network` | cloud_off |
| `ic_pharmacy` | local_pharmacy_outlined, local_pharmacy_rounded (use `brand_logo` instead if you prefer) |

---

## 5) Icons to KEEP as system icons (my recommendation)

These are structural/directional and should **not** become images — converting them breaks RTL
mirroring (your app is Arabic-primary) and hurts tap targets. Leave them as `Icons.*`:

- `arrow_back_rounded`, `arrow_upward`, `arrow_downward` (direction flips in RTL)
- `menu` (drawer hamburger)
- `close` (dialog/sheet dismiss)
- `more_vert` (overflow menu)

If you truly want these as images too, say so and I'll add `ic_back` / `ic_menu` / `ic_close` /
`ic_more` prompts — but I advise against it.

---

## 6) Prompts for the generic `ic_*` icons (light + dark)

Same compact format. Save each with its exact filename into `assets/images2/`.

### G1 — Add
**Light → `ic_add_light.jpg`**
```
An "Add / plus" icon for a pharmacy management app. Solid flat white #FFFFFF background, dark navy #14233B lines. No text, no letters.
```
**Dark → `ic_add_dark.jpg`**
```
An "Add / plus" icon for a pharmacy management app. Solid flat dark navy #0F172A background, light off-white #F8FAFC lines. No text, no letters.
```

### G2 — Error
**Light → `ic_error_light.jpg`**
```
An "Error / something went wrong" icon for a pharmacy management app, red accent. Solid flat white #FFFFFF background, dark navy #14233B lines. No text, no letters.
```
**Dark → `ic_error_dark.jpg`**
```
An "Error / something went wrong" icon for a pharmacy management app, red accent. Solid flat dark navy #0F172A background, light off-white #F8FAFC lines. No text, no letters.
```

### G3 — Warning
**Light → `ic_warning_light.jpg`**
```
A "Warning" triangle icon for a pharmacy management app, amber accent. Solid flat white #FFFFFF background, dark navy #14233B lines. No text, no letters.
```
**Dark → `ic_warning_dark.jpg`**
```
A "Warning" triangle icon for a pharmacy management app, amber accent. Solid flat dark navy #0F172A background, light off-white #F8FAFC lines. No text, no letters.
```

### G4 — Show password (eye)
**Light → `ic_visibility_light.jpg`**
```
A "Show password / visible eye" icon for a pharmacy management app. Solid flat white #FFFFFF background, dark navy #14233B lines. No text, no letters.
```
**Dark → `ic_visibility_dark.jpg`**
```
A "Show password / visible eye" icon for a pharmacy management app. Solid flat dark navy #0F172A background, light off-white #F8FAFC lines. No text, no letters.
```

### G5 — Hide password (eye off)
**Light → `ic_visibility_off_light.jpg`**
```
A "Hide password / crossed-out eye" icon for a pharmacy management app. Solid flat white #FFFFFF background, dark navy #14233B lines. No text, no letters.
```
**Dark → `ic_visibility_off_dark.jpg`**
```
A "Hide password / crossed-out eye" icon for a pharmacy management app. Solid flat dark navy #0F172A background, light off-white #F8FAFC lines. No text, no letters.
```

### G6 — Person
**Light → `ic_person_light.jpg`**
```
A "Person / user profile" icon for a pharmacy management app. Solid flat white #FFFFFF background, dark navy #14233B lines. No text, no letters.
```
**Dark → `ic_person_dark.jpg`**
```
A "Person / user profile" icon for a pharmacy management app. Solid flat dark navy #0F172A background, light off-white #F8FAFC lines. No text, no letters.
```

### G7 — Phone
**Light → `ic_phone_light.jpg`**
```
A "Phone / call" icon for a pharmacy management app. Solid flat white #FFFFFF background, dark navy #14233B lines. No text, no letters.
```
**Dark → `ic_phone_dark.jpg`**
```
A "Phone / call" icon for a pharmacy management app. Solid flat dark navy #0F172A background, light off-white #F8FAFC lines. No text, no letters.
```

### G8 — Email
**Light → `ic_email_light.jpg`**
```
An "Email / envelope" icon for a pharmacy management app. Solid flat white #FFFFFF background, dark navy #14233B lines. No text, no letters.
```
**Dark → `ic_email_dark.jpg`**
```
An "Email / envelope" icon for a pharmacy management app. Solid flat dark navy #0F172A background, light off-white #F8FAFC lines. No text, no letters.
```

### G9 — Location
**Light → `ic_location_light.jpg`**
```
A "Location / map pin" icon for a pharmacy management app. Solid flat white #FFFFFF background, dark navy #14233B lines. No text, no letters.
```
**Dark → `ic_location_dark.jpg`**
```
A "Location / map pin" icon for a pharmacy management app. Solid flat dark navy #0F172A background, light off-white #F8FAFC lines. No text, no letters.
```

### G10 — Lock
**Light → `ic_lock_light.jpg`**
```
A "Lock / password" icon for a pharmacy management app. Solid flat white #FFFFFF background, dark navy #14233B lines. No text, no letters.
```
**Dark → `ic_lock_dark.jpg`**
```
A "Lock / password" icon for a pharmacy management app. Solid flat dark navy #0F172A background, light off-white #F8FAFC lines. No text, no letters.
```

### G11 — Notifications
**Light → `ic_notifications_light.jpg`**
```
A "Notifications / bell" icon for a pharmacy management app. Solid flat white #FFFFFF background, dark navy #14233B lines. No text, no letters.
```
**Dark → `ic_notifications_dark.jpg`**
```
A "Notifications / bell" icon for a pharmacy management app. Solid flat dark navy #0F172A background, light off-white #F8FAFC lines. No text, no letters.
```

### G12 — Inbox
**Light → `ic_inbox_light.jpg`**
```
An "Inbox / tray" icon for a pharmacy management app. Solid flat white #FFFFFF background, dark navy #14233B lines. No text, no letters.
```
**Dark → `ic_inbox_dark.jpg`**
```
An "Inbox / tray" icon for a pharmacy management app. Solid flat dark navy #0F172A background, light off-white #F8FAFC lines. No text, no letters.
```

### G13 — History
**Light → `ic_history_light.jpg`**
```
A "History / clock with backward arrow" icon for a pharmacy management app. Solid flat white #FFFFFF background, dark navy #14233B lines. No text, no letters.
```
**Dark → `ic_history_dark.jpg`**
```
A "History / clock with backward arrow" icon for a pharmacy management app. Solid flat dark navy #0F172A background, light off-white #F8FAFC lines. No text, no letters.
```

### G14 — Notes
**Light → `ic_notes_light.jpg`**
```
A "Notes / document with lines" icon for a pharmacy management app. Solid flat white #FFFFFF background, dark navy #14233B lines. No text, no letters.
```
**Dark → `ic_notes_dark.jpg`**
```
A "Notes / document with lines" icon for a pharmacy management app. Solid flat dark navy #0F172A background, light off-white #F8FAFC lines. No text, no letters.
```

### G15 — No network
**Light → `ic_no_network_light.jpg`**
```
A "No network / offline cloud with a slash" icon for a pharmacy management app. Solid flat white #FFFFFF background, dark navy #14233B lines. No text, no letters.
```
**Dark → `ic_no_network_dark.jpg`**
```
A "No network / offline cloud with a slash" icon for a pharmacy management app. Solid flat dark navy #0F172A background, light off-white #F8FAFC lines. No text, no letters.
```

---

## 7) Progress checklist

**Content (do first):**
- [ ] Empty states (ASSETSTOGENBERATE §D, 30–40)
- [ ] Role avatars (§E, 41–45)
- [ ] Stat thumbnails (§F, 46–60)
- [ ] Brand (§H, 66–67)

**Icons:**
- [ ] Navigation (§A, 1–12)
- [ ] Actions (§B, 13–21)
- [ ] "New / Add" buttons (§C, 22–29)
- [ ] Generic `ic_*` (this file, §6, G1–G15)
- [ ] Status badges (§G, 61–65) — optional

**Kept as system icons (no image):** arrows, menu, close, more_vert (see §5).

When a checkbox group is done, tell me — I add the constants + `MyAssets` fields, create/extend the
`AppIcon` widget, and replace the `Icon(...)` usages in those files.
