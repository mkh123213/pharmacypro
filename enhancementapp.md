# PharmaChain - Professional Enhancement Roadmap

> Organized by priority phases. Each phase builds on the previous one. Estimated effort assumes a small team (1-3 developers).

---

## Phase 1: Foundation & Stability (High Priority - Do First)

> These enhancements fix critical gaps that affect reliability, performance, and data integrity. Without these, scaling the app will create compounding problems.

---

### 1.1 Pagination & Lazy Loading

**Problem:** All features load entire Firestore collections at once. As data grows (thousands of sales, prescriptions, inventory records), the app will become sluggish, consume excessive memory, and hit Firestore read quotas.

**Enhancement:**
- Implement cursor-based pagination using Firestore `startAfterDocument` for all list screens (Sales, Prescriptions, Customer Orders, Purchase Orders, Inventory, Stock Movements, Medications, Staff, Shifts, Suppliers, Branches)
- Add infinite scroll or "Load More" button to list views
- Cache the last document snapshot in each Cubit for cursor tracking
- Implement page size configuration (default 20 items per page)
- Add pull-to-refresh to reset pagination and reload from the beginning
- Paginate dashboard queries separately (e.g., "last 50 sales" instead of "all sales")

**Impact:** Prevents app crashes, reduces Firestore costs, enables scaling to thousands of records per collection.

**Files Affected:**
- All `*_remote_data_source.dart` files (add pagination parameters to queries)
- All `*_cubit.dart` files (manage pagination state, cursor tracking)
- All `*_state.dart` files (add `hasMore`, `isLoadingMore` flags)
- All list screens/refactor files (add scroll listeners or load-more widgets)

---

### 1.2 Offline-First Data Sync

**Problem:** The app detects connectivity loss and shows a no-network screen, but doesn't allow users to continue working offline. Pharmacies need to operate even during internet outages.

**Enhancement:**
- Enable Firestore offline persistence (already configured, but not leveraged in the UI)
- Remove the blocking `NoNetworkScreen` — instead show a subtle offline indicator banner
- Queue write operations (sales, prescriptions, inventory changes) locally when offline
- Implement optimistic UI updates — reflect changes immediately, sync when online
- Add a sync status indicator (synced / syncing / pending changes)
- Handle conflict resolution for concurrent offline edits (last-write-wins or merge strategy)
- Show pending transaction count in the dashboard when offline
- Add manual "Force Sync" button for users

**Impact:** Enables pharmacy operations during internet outages, prevents lost sales, builds trust for mission-critical use.

**Files Affected:**
- `connectivity_controller.dart` (change from blocking to advisory)
- `app.dart` (remove NoNetworkScreen gate, add sync banner)
- All data sources (add offline queue support)
- New: `core/sync/sync_manager.dart`, `core/sync/sync_status_cubit.dart`

---

### 1.3 Comprehensive Testing Suite

**Problem:** Zero test coverage. Any code change risks breaking existing features without detection. Refactoring becomes dangerous.

**Enhancement:**

**Unit Tests (Priority 1):**
- Test all Cubit logic: state transitions, data transformations, filtering, error handling
- Test all Repository methods: delegation correctness, parameter passing
- Test all Model classes: `fromJson`/`toJson` serialization, computed properties (`isLowStock`, `isExpired`, `isExpiringSoon`)
- Test `AppValidators`: all validation rules with edge cases
- Test `ErrorMapper`: all error code mappings
- Test `PermissionHelper`: all role/route/edit/delete combinations

**Widget Tests (Priority 2):**
- Test form validation flows (branch form, medication form, sale form, etc.)
- Test medication picker bottom sheets (search, selection, quantity)
- Test status chip rendering for all status values
- Test empty state and loading state rendering

**Integration Tests (Priority 3):**
- End-to-end sale creation flow
- End-to-end prescription workflow (create → verify → dispense)
- Login → dashboard → navigate to feature → perform CRUD
- Purchase order receipt with inventory update verification

**Infrastructure:**
- Set up mock Firebase services (`fake_cloud_firestore`, `firebase_auth_mocks`)
- Create test fixtures for all models
- Add test coverage reporting
- Integrate test execution into CI/CD pipeline (GitHub Actions)

**Target:** 80%+ coverage on Cubit and model layers, 60%+ on widget layer.

**Files Affected:**
- New: `test/` directory with mirror structure of `lib/`
- `pubspec.yaml` (add test dependencies: `mocktail`, `bloc_test`, `fake_cloud_firestore`)
- `.github/workflows/deploy.yml` (add test step before build)

---

### 1.4 Error Handling & Crash Reporting

**Problem:** Errors are shown via toast messages, but there's no centralized error logging, no crash reporting, and no way to diagnose production issues.

**Enhancement:**
- Integrate Firebase Crashlytics for automatic crash reporting
- Add structured error logging with severity levels (info, warning, error, fatal)
- Log all Firestore operation failures with context (collection, operation, user, branch)
- Add error boundaries around critical screens (prevent white screen of death)
- Implement retry logic for transient Firestore failures (network timeouts)
- Add user-facing error screens with "Retry" and "Report Issue" options
- Log failed authentication attempts for security monitoring
- Track and log slow Firestore queries (>2 seconds)

**Files Affected:**
- `pubspec.yaml` (add `firebase_crashlytics`)
- `main.dart` (initialize Crashlytics, set up Flutter error handlers)
- All data sources (wrap Firestore calls with structured logging)
- New: `core/error/error_logger.dart`, `core/error/crash_reporter.dart`

---

### 1.5 Data Validation Hardening

**Problem:** Validation exists at the UI level but some backend-level validations are missing. Firestore has no schema enforcement, so malformed data can enter the system.

**Enhancement:**
- Add Firestore Security Rules to enforce:
  - Required fields per collection
  - Data type constraints (e.g., quantity must be integer >= 0)
  - Role-based write permissions (only admins can create staff)
  - Branch scoping (users can only modify data for their branch)
- Add server-side validation in data sources before Firestore writes:
  - Validate medication exists and is active before adding to sale/order/prescription
  - Validate sufficient stock before completing a sale or dispense
  - Validate supplier exists and is active before creating purchase order
  - Prevent negative inventory quantities
  - Validate branch exists for all branch-scoped operations
- Add data integrity checks on app startup (detect orphaned records, negative stock)

**Files Affected:**
- New: `firestore.rules` (Firestore Security Rules)
- All `*_remote_data_source.dart` files (add pre-write validations)
- New: `core/utils/data_integrity_checker.dart`

---

### 1.6 Localization Completion

**Problem:** English has ~680 translation keys but Arabic has only ~520. Missing Arabic translations will show as raw English keys or empty strings for Arabic users.

**Enhancement:**
- Audit all translation keys — identify missing Arabic translations
- Complete Arabic translations for all 680+ keys
- Add translation validation in CI/CD (check both files have identical key sets)
- Add placeholders for dynamic values (e.g., `"low_stock_alert": "تنبيه: {count} أصناف منخفضة المخزون"`)
- Review Arabic medical/pharmaceutical terminology for accuracy
- Add number and date formatting per locale (Arabic numerals, Hijri calendar option)

**Files Affected:**
- `lang/ar.json` (complete missing translations)
- `lang/en.json` (audit for unused keys)
- New: CI script to validate translation key parity

---

## Phase 2: Core Business Features (High Priority - Essential for Operations)

> These features address real operational needs that pharmacies encounter daily but the app doesn't yet handle.

---

### 2.1 Returns & Refund Management

**Problem:** The app can mark a sale as "Refunded" or "Voided" via status change, but there's no actual refund workflow, no inventory restock, no partial refund support, and no refund history.

**Enhancement:**
- Create a dedicated **Returns** feature module (`features/returns/`)
- Support full and partial refunds:
  - Full refund: all items returned, full amount refunded
  - Partial refund: select specific items and quantities to return
- Automatically restock returned items in inventory
- Create stock movement records for returns (new type: `return`)
- Track refund reason (defective, wrong item, customer request, expired)
- Link refund to original sale record
- Generate refund receipt
- Dashboard: add "Refunds Today" metric
- Reports: add refund analysis report (refund rate, reasons, amounts)
- Permission: only Manager and Admin can process refunds

**Data Model:**
```
RefundModel {
  id, refundNumber, originalSaleId, originalSaleNumber,
  branchId, branchName, customerName,
  items[{medicationId, medicationName, quantity, unitPrice, total}],
  totalRefundAmount, reason, reasonDetails,
  processedBy, status (pending/approved/completed/rejected),
  createdAt, updatedAt
}
```

---

### 2.2 Inter-Branch Stock Transfer

**Problem:** Multi-branch pharmacies need to move stock between locations. Currently, this requires a manual adjustment at both branches — error-prone and creates inconsistent stock movement history.

**Enhancement:**
- Create a **Stock Transfer** feature module (`features/stock_transfers/`)
- Transfer workflow: Request → Approve → Ship → Receive
- Source branch initiates transfer, destination branch confirms receipt
- Automatically decrement source inventory and increment destination inventory
- Create paired stock movement records (type: `transfer_out` / `transfer_in`)
- Track in-transit stock (shipped but not yet received)
- Allow partial receipt (received quantity may differ from shipped)
- Notifications to destination branch when transfer is shipped
- Dashboard: show "Pending Transfers" for branch managers

**Data Model:**
```
StockTransferModel {
  id, transferNumber,
  sourceBranchId, sourceBranchName,
  destinationBranchId, destinationBranchName,
  items[{medicationId, medicationName, requestedQty, shippedQty, receivedQty}],
  status (requested/approved/shipped/received/cancelled),
  requestedBy, approvedBy, shippedBy, receivedBy,
  notes, requestedAt, shippedAt, receivedAt,
  createdAt, updatedAt
}
```

---

### 2.3 Push Notifications

**Problem:** Staff must manually check the app for alerts. Low stock, expiring medications, new orders, and shift reminders go unnoticed until someone opens the relevant screen.

**Enhancement:**
- Integrate **Firebase Cloud Messaging (FCM)** for push notifications
- **Inventory alerts:**
  - Low stock threshold reached (configurable per medication)
  - Medication expired or expiring within 7 days
  - Stock transfer pending at your branch
- **Order alerts:**
  - New customer order received
  - Order status changed (for all relevant staff)
  - Purchase order confirmed by supplier
  - Purchase order delivered
- **Shift alerts:**
  - Shift reminder 1 hour before start
  - Shift assignment notification
  - Shift cancellation notification
- **System alerts:**
  - New staff member added to your branch
  - Branch deactivated/reactivated
- Notification preferences per user (toggle categories on/off)
- In-app notification center with read/unread status
- Badge count on app icon

**Technical Implementation:**
- Firebase Cloud Functions for server-side notification triggers
- FCM topic subscriptions per branch and per role
- Local notification scheduling for shift reminders
- Notification history stored in Firestore per user

**Files Affected:**
- `pubspec.yaml` (add `firebase_messaging`, `flutter_local_notifications`)
- New: `features/notifications/` module
- New: `firebase/functions/` for Cloud Functions
- All data sources that trigger events (sales, orders, inventory, shifts)

---

### 2.4 Barcode Scanning Enhancement

**Problem:** The app has barcode scanning capability (`mobile_scanner`) but it's limited to medication lookup. Pharmacies use barcodes extensively across their operations.

**Enhancement:**
- **Sale screen:** Scan medication barcode to instantly add to cart (currently supported but can be faster)
- **Inventory screen:** Scan to quickly look up stock details
- **Batch scanning mode:** Continuously scan multiple items without closing the scanner
- **Expiry date scanning (OCR):** Use ML Kit or similar to read expiry dates from packaging
- **QR code generation:** Generate QR codes for:
  - Prescription verification (patient scans to verify authenticity)
  - Sale receipts (link to digital receipt)
  - Medication information (patient scans for usage instructions)
- **Barcode printing integration:** Generate and print shelf labels with barcodes
- **Inventory counting mode:** Scan items to count physical stock, compare with system quantity, flag discrepancies

**Files Affected:**
- `core/common/widgets/smart_barcode_scanner.dart` (add batch mode, OCR)
- Sale, Inventory, Prescription screens (integrate enhanced scanning)
- New: `core/services/barcode_generator.dart`
- `pubspec.yaml` (add `google_mlkit_text_recognition` for OCR)

---

### 2.5 Advanced Search & Filtering

**Problem:** Each feature has basic search within its own screen. There's no global search, limited filter combinations, and no saved filters.

**Enhancement:**
- **Global Search:**
  - Unified search bar in the top bar
  - Search across: medications, sales, prescriptions, orders, customers, staff
  - Results grouped by category with count
  - Recent searches history
  - Quick actions from search results (e.g., search medication → "Add to Sale")
- **Advanced Filters per Feature:**
  - Sales: date range, payment method, amount range, customer name, linked prescription
  - Inventory: branch, stock level range, expiry date range, category, location
  - Prescriptions: date range, status, patient name, doctor name, medication
  - Orders: date range, status, type (pickup/delivery), payment method
  - Medications: category, dosage form, price range, manufacturer, prescription requirement
- **Saved Filters:** Allow users to save frequently used filter combinations
- **Filter Chips:** Visual active filter indicators with quick-remove

**Files Affected:**
- New: `core/common/widgets/global_search_bar.dart`
- New: `features/search/` module (global search cubit and screen)
- All feature filter/refactor files (enhance existing filters)

---

### 2.6 Receipt & Invoice Generation

**Problem:** Sales are completed but no receipt is generated. Purchase orders have no printable document. Prescriptions have no formal printed record.

**Enhancement:**
- **Sale Receipts:**
  - Generate PDF receipts with pharmacy branding
  - Include: sale number, date, items, quantities, prices, discount, total, payment method
  - QR code for digital verification
  - Print via Bluetooth thermal printer
  - Share via WhatsApp/email
  - Auto-print option after sale completion
- **Purchase Order Documents:**
  - Generate formal PO document to send to suppliers
  - Include: PO number, supplier details, items, quantities, unit costs, expected delivery
  - PDF export for email attachment
- **Prescription Labels:**
  - Generate medication labels with patient name, dosage, instructions
  - Print via label printer
- **Invoice Generation:**
  - Monthly invoice summary for insurance companies
  - Customer invoice for large orders

**Technical Implementation:**
- Use `pdf` package for PDF generation
- Use `printing` package for printer discovery and printing
- Use `share_plus` for sharing via other apps
- Store generated PDFs in Firebase Storage (optional)

**Files Affected:**
- `pubspec.yaml` (add `pdf`, `printing`, `share_plus`)
- New: `core/services/pdf_generator.dart`
- New: `core/services/printer_service.dart`
- Sales, Purchase Orders, Prescriptions screens (add print/share buttons)

---

## Phase 3: Analytics & Intelligence (Medium Priority - Competitive Advantage)

> These features transform raw data into actionable insights, helping pharmacy owners make better business decisions.

---

### 3.1 Advanced Reporting & PDF Export

**Problem:** Reports are view-only within the app. Managers need to export, share, and present data. Current reports are limited to predefined time ranges.

**Enhancement:**
- **Export Options:**
  - Export any report as PDF with professional formatting and pharmacy branding
  - Export raw data as CSV/Excel for custom analysis
  - Share reports via email, WhatsApp, or other apps
  - Schedule automatic report generation (daily/weekly/monthly)
- **New Report Types:**
  - **Profit & Loss Statement:** Revenue, COGS, gross profit, expenses by period
  - **Inventory Valuation Report:** Total stock value by branch, category, expiry status
  - **Medication Performance:** Sales velocity, turnover rate, dead stock identification
  - **Staff Performance:** Sales per staff member, prescriptions processed, shifts worked
  - **Customer Analysis:** Repeat customers, average order value, preferred payment methods
  - **Supplier Performance:** Delivery timeliness, order accuracy, price trends
  - **Expiry Waste Report:** Value of expired medications, waste percentage
  - **Prescription Analysis:** Most prescribed medications, doctor referral patterns
  - **Branch Comparison:** Revenue, sales volume, stock efficiency across branches
- **Custom Date Ranges:** Allow any date range selection, not just last 7/30 days
- **Comparative Analysis:** Compare current period vs. previous period (MoM, YoY)
- **Report Scheduling:** Auto-generate and email reports on a recurring schedule

**Files Affected:**
- `features/reports/` (major expansion)
- New: `core/services/report_exporter.dart`
- `pubspec.yaml` (add `pdf`, `csv`, `excel`)

---

### 3.2 Inventory Forecasting & Smart Reordering

**Problem:** Low stock alerts are reactive (trigger after stock drops below threshold). Pharmacies need proactive inventory management to prevent stockouts.

**Enhancement:**
- **Demand Forecasting:**
  - Analyze sales history to predict future demand per medication
  - Factor in seasonality (e.g., flu medications in winter, allergy meds in spring)
  - Factor in trends (increasing/decreasing demand)
  - Display "Days of Stock Remaining" based on average daily sales
- **Smart Reorder Suggestions:**
  - Auto-generate purchase order drafts when stock is predicted to run low
  - Calculate Economic Order Quantity (EOQ) based on demand, holding cost, ordering cost
  - Suggest reorder point (when to order) and reorder quantity (how much)
  - Factor in supplier lead time
- **ABC Analysis:**
  - Classify medications: A (high value, 80% revenue), B (medium), C (low value)
  - Different stock policies per classification
  - Visual inventory heat map
- **Expiry-Aware Ordering:**
  - Avoid over-ordering medications that have short shelf life
  - Suggest FEFO (First Expiry, First Out) dispensing sequence
  - Alert when reorder quantity would result in excess before expiry

**Files Affected:**
- New: `features/forecasting/` module
- `features/inventory/` (add forecasting widgets to inventory screens)
- `features/purchase_orders/` (add auto-suggestion for PO creation)

---

### 3.3 Dashboard Enhancements

**Problem:** The dashboard shows basic metrics but lacks drill-down, customization, and real-time updates.

**Enhancement:**
- **Real-Time Updates:** Use Firestore snapshots for live dashboard data (not just on load)
- **KPI Cards with Trends:** Show metric + percentage change vs. previous period (up/down arrows)
- **Drill-Down Navigation:** Tap any metric to navigate to the detailed view (e.g., tap "Low Stock" → inventory alerts screen)
- **Customizable Layout:** Allow users to reorder, show/hide dashboard widgets
- **Time Period Selector:** Toggle between Today, This Week, This Month, This Quarter, This Year
- **Branch Selector:** View dashboard for specific branch or all branches
- **Quick Actions Panel:**
  - Quick Sale button
  - Quick Prescription button
  - Scan Barcode button
  - Quick Inventory Adjustment button
- **Activity Feed:** Recent actions across all features (sale completed, prescription dispensed, order received) as a live feed
- **Goal Tracking:** Set daily/weekly/monthly revenue targets, show progress bar

**Files Affected:**
- `features/dashboard/` (significant expansion)
- New dashboard widgets for each metric
- Dashboard cubit (add real-time listeners, time period management)

---

### 3.4 Audit Trail & Activity Logging

**Problem:** Stock movements track inventory changes, but there's no system-wide audit trail. Who changed what, when, and why is not recorded for non-inventory actions.

**Enhancement:**
- **System-Wide Audit Log:**
  - Log all CRUD operations across all features
  - Record: who (userId, userName), what (action, entity, entityId), when (timestamp), where (branchId), details (old value → new value)
  - Immutable log (write-only, no edits or deletes)
- **Tracked Events:**
  - Authentication: login, logout, failed login, password reset
  - Staff: create, edit, deactivate, role change
  - Medications: create, edit, price change, deactivate
  - Inventory: manual adjustments with reason
  - Sales: creation, void, refund
  - Prescriptions: status changes (verify, dispense, reject)
  - Orders: status transitions
  - Purchase Orders: status transitions, receipt
  - Settings: theme/language changes (per user)
  - Branch: create, edit, activate/deactivate
- **Audit Screen:**
  - Filterable by user, action type, date range, feature
  - Search within audit logs
  - Export audit trail as CSV/PDF for compliance
- **Access Control:** Only Admin can view full audit trail

**Data Model:**
```
AuditLogModel {
  id, userId, userName, userRole,
  action (create/update/delete/status_change/login/logout),
  entityType (sale/medication/prescription/etc),
  entityId, entityName,
  branchId, branchName,
  details (Map: field → {oldValue, newValue}),
  ipAddress, deviceInfo,
  createdAt
}
```

**Files Affected:**
- New: `features/audit/` module
- New: `core/services/audit_logger.dart` (inject into all data sources)
- All data sources (add audit logging calls)

---

## Phase 4: User Experience & Engagement (Medium Priority)

> These enhancements improve daily usability, reduce friction, and make the app more pleasant to use.

---

### 4.1 Enhanced UI/UX

**Problem:** The app is functional but can be more intuitive, especially for fast-paced pharmacy environments.

**Enhancement:**
- **Keyboard Shortcuts (Desktop/Tablet):**
  - `Ctrl+N` → New Sale
  - `Ctrl+P` → New Prescription
  - `Ctrl+F` → Global Search
  - `Ctrl+B` → Barcode Scanner
  - Tab navigation through form fields
- **Quick Actions Floating Button:**
  - Speed dial FAB with: New Sale, New Prescription, Scan Barcode, Quick Adjustment
  - Context-aware: show relevant actions based on current screen
- **Skeleton Loading:**
  - Replace generic loading spinner with skeleton screens
  - Shimmer effect on list items, cards, and charts while loading
- **Animations & Transitions:**
  - Smooth page transitions (slide, fade)
  - Card entrance animations (staggered)
  - Status change animations (color morph)
  - Number counting animations on dashboard metrics
- **Gesture Support:**
  - Swipe-to-delete on list items (with undo)
  - Pull-to-refresh on all list screens
  - Long-press for quick actions
- **Onboarding Flow:**
  - First-launch tutorial highlighting key features
  - Role-specific tips (show Cashier only POS features)
  - Dismissable coach marks on each screen
- **Accessibility:**
  - Semantic labels on all interactive elements
  - Screen reader support
  - Minimum touch target sizes (48x48dp)
  - High contrast mode option

---

### 4.2 Multi-Language Enhancement

**Problem:** Only English and Arabic are supported. The app could serve pharmacies in more regions.

**Enhancement:**
- **Add Languages:**
  - French (for North African markets)
  - Turkish
  - Urdu
  - Kurdish
- **RTL Improvements:**
  - Ensure all custom widgets respect `Directionality`
  - Test all screens in both LTR and RTL
  - Fix any layout breaking in RTL mode
- **Dynamic Language Loading:** Load translations from Firebase Remote Config (no app update needed for translation fixes)
- **Medical Terminology Glossary:** Built-in glossary for pharmaceutical terms per language

---

### 4.3 Dark Mode Refinement

**Problem:** Dark mode exists but may have inconsistencies in charts, custom widgets, and third-party components.

**Enhancement:**
- Audit all screens in dark mode for contrast issues
- Ensure charts and graphs have dark-mode-appropriate colors
- Add AMOLED dark theme option (pure black background for OLED screens)
- Ensure all status chips, alerts, and badges are readable in both modes
- Test medication picker bottom sheets in dark mode
- Ensure barcode scanner overlay is visible in dark mode

---

### 4.4 Performance Optimization

**Problem:** As data grows, the app may become slower. Proactive optimization prevents future performance issues.

**Enhancement:**
- **Image Optimization:**
  - Implement image caching with `cached_network_image`
  - Compress prescription images before upload
  - Generate thumbnails for list views
  - Lazy-load images in scrollable lists
- **List Performance:**
  - Use `ListView.builder` everywhere (verify, not `ListView(children: [])`)
  - Implement `AutomaticKeepAliveClientMixin` for tab views
  - Add `const` constructors where possible
- **Firestore Optimization:**
  - Use composite indexes for common query patterns
  - Denormalize frequently accessed data (medication names in inventory records — already done)
  - Use batch writes for multi-document operations
  - Implement Firestore data bundles for initial load
- **Memory Management:**
  - Dispose all controllers, listeners, and streams properly
  - Profile memory usage with Flutter DevTools
  - Identify and fix memory leaks in long-running screens
- **App Size Reduction:**
  - Tree-shake unused icons
  - Use `--split-debug-info` for smaller APK
  - Analyze and remove unused dependencies

**Files Affected:**
- All list screens (verify builder pattern)
- All screens with images
- `pubspec.yaml` (add `cached_network_image`)
- Build configuration for APK optimization

---

## Phase 5: Security & Compliance (Medium-High Priority)

> Essential for pharmacies handling sensitive health data and regulated substances.

---

### 5.1 Two-Factor Authentication (2FA)

**Problem:** Email/password authentication is the only layer. Admin and Manager accounts with full system access need stronger security.

**Enhancement:**
- **SMS OTP Verification:** Send OTP on login for Admin and Manager roles
- **Email OTP Option:** Alternative for users without phone access
- **Remember Device:** Allow users to trust a device for 30 days
- **Forced 2FA:** Admin can enforce 2FA for all users or specific roles
- **Recovery Codes:** Generate backup codes for account recovery
- **Login History:** Show last 10 login attempts with device/IP info

**Technical Implementation:**
- Firebase Auth phone verification for SMS OTP
- Firebase Auth multi-factor authentication
- Store trusted devices in Firestore per user

---

### 5.2 Data Encryption & Privacy

**Problem:** Sensitive patient data (names, phone numbers, prescriptions) is stored in Firestore without field-level encryption.

**Enhancement:**
- **Patient Data Encryption:** Encrypt PII fields (patient name, phone, DOB) at rest
- **Secure Storage:** Move sensitive tokens and credentials to `flutter_secure_storage` (partially done)
- **Data Masking:** Mask patient phone numbers in list views (show last 4 digits)
- **Session Management:**
  - Auto-logout after configurable inactivity period (default 30 minutes)
  - Force logout on all devices when password is changed
  - Concurrent session limit per user
- **Data Retention Policy:**
  - Auto-archive records older than configurable period
  - Purge patient PII after retention period
  - Export before purge option
- **Firestore Security Rules Hardening:**
  - Validate all write operations server-side
  - Prevent unauthorized field modifications
  - Rate limiting on sensitive operations

---

### 5.3 Controlled Substance Tracking

**Problem:** Pharmacies handle controlled/scheduled medications that require special tracking and reporting. The app doesn't distinguish controlled substances from regular medications.

**Enhancement:**
- **Medication Classification:**
  - Add `scheduleClass` field (None, Schedule I-V, or local equivalents)
  - Flag medications as controlled substances
- **Controlled Substance Dispensing:**
  - Require pharmacist verification for controlled substances
  - Mandatory patient ID verification
  - Quantity limits per dispensing
  - Double-count verification
- **Controlled Substance Reporting:**
  - Dedicated report for controlled substance movements
  - Daily controlled substance log
  - Discrepancy alerts
  - Export for regulatory reporting
- **Access Control:** Only licensed pharmacists can dispense controlled substances

---

## Phase 6: Integration & Ecosystem (Lower Priority - Future Growth)

> These features connect PharmaChain to external systems and expand its ecosystem.

---

### 6.1 Customer-Facing Mobile App

**Problem:** Customers must call or visit the pharmacy to place orders, check medication availability, or get prescription updates.

**Enhancement:**
- **Separate Flutter App** for pharmacy customers
- **Features:**
  - Browse medication catalog (prices, availability)
  - Place orders (pickup or delivery)
  - Upload prescription images for processing
  - Track order status in real-time
  - View prescription history
  - Refill requests for recurring medications
  - Pharmacy branch locator with map
  - Push notifications for order updates
  - In-app chat with pharmacist (optional)
- **Integration Points:**
  - Shares Firestore backend with main app
  - Customer orders appear in main app's order queue
  - Prescription uploads appear in prescription queue
  - Real-time status sync

---

### 6.2 Insurance Company Integration

**Problem:** Many sales involve insurance. Currently, insurance is just a payment method label with no actual integration.

**Enhancement:**
- **Insurance Company Management:**
  - Insurance company database (name, contact, contract terms)
  - Formulary management (which medications each insurer covers)
  - Co-pay calculation (automatic based on insurance plan)
  - Coverage verification before dispensing
- **Claims Processing:**
  - Auto-generate insurance claims from sales
  - Track claim status (submitted, approved, rejected, paid)
  - Batch submission of claims
  - Reconciliation of payments
- **Reporting:**
  - Revenue by insurance company
  - Claim rejection analysis
  - Outstanding payments aging

---

### 6.3 Accounting Integration

**Problem:** Financial data stays within the app. Pharmacy owners use separate accounting software and must re-enter data.

**Enhancement:**
- **Export to Accounting Software:**
  - Generate journal entries from sales, purchases, and refunds
  - Export in standard formats (CSV, QIF, OFX)
  - Map PharmaChain accounts to chart of accounts
- **Integration APIs:**
  - REST API endpoints for third-party integrations
  - Webhook support for real-time events
  - QuickBooks / Xero integration (if applicable to target market)
- **Tax Reporting:**
  - Tax calculation per sale (configurable tax rates)
  - Tax summary report by period
  - Tax-exempt medication handling

---

### 6.4 Supplier Portal Integration

**Problem:** Purchase orders are created in the app but must be communicated to suppliers manually (email, phone). No automated ordering.

**Enhancement:**
- **Electronic Ordering:**
  - Email PO documents directly from the app
  - WhatsApp integration for PO submission
  - EDI integration for large suppliers (long-term)
- **Supplier Self-Service Portal:**
  - Suppliers log in to view their purchase orders
  - Suppliers update delivery status
  - Suppliers upload invoices
  - Automatic price catalog updates
- **Order Automation:**
  - Auto-generate POs based on inventory forecasting (Phase 3.2)
  - Standing order support (recurring POs)
  - Bulk ordering across branches

---

### 6.5 Web Dashboard

**Problem:** The app is mobile-only. Pharmacy owners and managers need a web-based dashboard for office/desktop use.

**Enhancement:**
- **Flutter Web Build:**
  - Responsive layout for desktop browsers
  - Full feature parity with mobile app
  - Optimized for keyboard/mouse interaction
  - Print support for reports, receipts, and documents
- **Web-Specific Features:**
  - Multi-window support (open sale + inventory side by side)
  - Bulk data import/export via CSV upload
  - Advanced charting with interactive tooltips
  - Keyboard-driven workflows (no mouse required for common tasks)

---

## Phase 7: Advanced Features (Low Priority - Differentiation)

> These features differentiate PharmaChain from competitors and add significant value for larger pharmacy operations.

---

### 7.1 Loyalty & Rewards Program

**Enhancement:**
- **Customer Database:**
  - Customer profiles (name, phone, email, purchase history)
  - Customer segmentation (new, regular, VIP)
- **Points System:**
  - Earn points per sale (configurable rate)
  - Redeem points for discounts
  - Point expiry management
  - Bonus point campaigns
- **Tier System:**
  - Bronze, Silver, Gold tiers based on spend
  - Tier-specific discounts and benefits
- **Communication:**
  - SMS/WhatsApp notifications for point balance
  - Birthday/anniversary offers
  - Personalized medication reminders

---

### 7.2 Drug Interaction Checker

**Enhancement:**
- **Integration with Drug Interaction Database:**
  - Check for interactions when adding medications to a sale or prescription
  - Severity levels: minor, moderate, major, contraindicated
  - Display warning with interaction details
  - Allow pharmacist override with reason documentation
- **Allergy Checking:**
  - Record patient allergies
  - Cross-reference against prescription/sale medications
  - Alert for potential allergic reactions
- **Dosage Verification:**
  - Age-appropriate dosage checking (requires patient age)
  - Maximum daily dose alerts
  - Therapeutic duplication warnings

---

### 7.3 AI-Powered Features

**Enhancement:**
- **Smart Medication Suggestions:**
  - Suggest alternatives when a medication is out of stock
  - Recommend generic alternatives for cost savings
  - "Frequently bought together" suggestions
- **Demand Prediction:**
  - ML-based demand forecasting using historical data
  - Seasonal trend detection
  - Pandemic/outbreak response predictions
- **Natural Language Search:**
  - Search medications by symptoms or conditions
  - Voice-to-text for medication entry
  - Handwriting recognition for prescription images
- **Chatbot for Customers:**
  - AI-powered medication information bot
  - Drug interaction queries
  - Dosage information

---

### 7.4 Multi-Tenant SaaS Architecture

**Enhancement:**
- Transform PharmaChain into a multi-tenant SaaS platform
- **Tenant Isolation:**
  - Separate Firestore databases per tenant
  - Tenant-specific configuration and branding
  - Custom domain support for web dashboard
- **Subscription Management:**
  - Free tier (single branch, limited features)
  - Professional tier (multi-branch, all features)
  - Enterprise tier (custom integrations, dedicated support)
- **Admin Panel:**
  - Tenant management dashboard
  - Usage analytics per tenant
  - Feature flag management
  - Billing and subscription management

---

## Implementation Priority Matrix

| Phase | Priority | Effort | Impact | Dependencies |
|-------|----------|--------|--------|-------------|
| 1. Foundation & Stability | Critical | 4-6 weeks | High | None |
| 2. Core Business Features | High | 6-8 weeks | High | Phase 1 |
| 3. Analytics & Intelligence | Medium | 4-6 weeks | Medium-High | Phase 1, 2 |
| 4. User Experience | Medium | 3-4 weeks | Medium | Phase 1 |
| 5. Security & Compliance | Medium-High | 3-4 weeks | High | Phase 1 |
| 6. Integration & Ecosystem | Lower | 8-12 weeks | Medium | Phase 1-3 |
| 7. Advanced Features | Low | 12-16 weeks | Medium | Phase 1-6 |

---

## Quick Wins (Can Be Done Independently)

These small improvements can be implemented at any time without waiting for a full phase:

1. **Pull-to-refresh** on all list screens (1-2 hours)
2. **Skeleton loading** instead of spinner (2-3 hours)
3. **Confirm before delete** — ensure all delete actions show confirmation dialog (1-2 hours)
4. **Empty state illustrations** — add relevant illustrations to empty list states (2-3 hours)
5. **Sale number auto-generation** — auto-increment sale numbers per branch (1 hour)
6. **Copy to clipboard** — tap to copy phone numbers, emails, order numbers (1 hour)
7. **WhatsApp integration** — tap phone number to open WhatsApp chat (30 minutes)
8. **Date/time display formatting** — consistent date display format across all screens (1-2 hours)
9. **Staff initials avatar** — show colored initials when no avatar image is set (1 hour)
10. **Search debounce** — add 300ms debounce to all search fields to reduce Firestore reads (30 minutes)
