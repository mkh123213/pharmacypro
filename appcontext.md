# PharmaChain - Application Context Document

## 1. Product Overview

**PharmaChain** (package: `pharmacypro`) is a comprehensive pharmacy management system built with Flutter and Firebase. It serves as an all-in-one platform for managing pharmacy operations including inventory control, sales processing, prescription management, customer orders, supplier relations, staff scheduling, and multi-branch coordination.

- **Version:** 1.0.0+1
- **SDK:** Flutter 3.11.5+
- **Backend:** Firebase (Firestore, Auth, App Check)
- **Languages:** English & Arabic (RTL support)
- **Themes:** Light & Dark mode
- **Target Platforms:** Android (primary), with potential for iOS/Web

---

## 2. Business Domain

### 2.1 Who Uses This App?

PharmaChain is designed for pharmacy businesses operating one or more branches. The system supports five distinct user roles, each with tailored access:

| Role | Description | Primary Functions |
|------|-------------|-------------------|
| **Admin** | Pharmacy owner / IT admin | Full system access, staff management, all configuration |
| **Manager** | Branch manager | All operations except staff management |
| **Pharmacist** | Licensed pharmacist | Inventory, medications, sales, prescriptions, orders, reports |
| **Technician** | Pharmacy technician | Inventory and medications only |
| **Cashier** | POS operator | Sales and customer orders only |

### 2.2 Core Business Processes

#### Sales Workflow (POS)
```
Customer arrives → Pharmacist/Cashier selects medications →
System checks stock → Applies discount (if any) →
Selects payment method (Cash/Card/Insurance/Online) →
Completes sale → Inventory automatically decremented →
Stock movement recorded → Receipt generated
```

#### Prescription Workflow
```
Patient submits prescription → Staff creates record →
Patient/Doctor info captured → Medications listed with dosage →
Pharmacist verifies prescription → Prescription dispensed →
Stock automatically decremented → Stock movement recorded
```
- Expired prescriptions cannot be dispensed
- Same prescription cannot be dispensed twice
- Prescription image/photo can be attached

#### Customer Order Workflow
```
Customer places order → Order type selected (Pickup/Delivery) →
Items and quantities added → Order created (Pending) →
Confirmed → Processing → Ready for Pickup / Out for Delivery →
Delivered → Stock decremented → Movement recorded
```
- Delivery orders require a delivery address
- Supports 4 payment methods

#### Purchase Order Workflow (Supplier Ordering)
```
Manager creates PO (Draft) → Selects supplier →
Adds items with quantities and unit costs →
Sends to supplier → Supplier confirms →
Goods received → Stock increased → Movement recorded
```
- Only draft POs can be edited
- Receiving triggers automatic inventory increase

#### Inventory Management
```
Real-time stock tracking per branch →
Automatic alerts for:
  - Low stock (quantity ≤ minStockLevel)
  - Expiring soon (within 30 days)
  - Expired items
Stock movements create an audit trail
```

---

## 3. Data Architecture

### 3.1 Firestore Collections

```
/branches/{branchId}
/medications/{medicationId}
/inventory/{inventoryId}
/sales/{saleId}
/prescriptions/{prescriptionId}
/customer_orders/{orderId}
/purchase_orders/{poId}
/shifts/{shiftId}
/staff/{staffId}
/suppliers/{supplierId}
/stock_movements/{movementId}
```

### 3.2 Entity Models (Key Fields)

#### Branch
```
id, name, address, city, phone, email,
managerName, openingHours, isActive,
createdAt, updatedAt
```

#### Medication
```
id, name, genericName, category, dosageForm,
strength, manufacturer, barcode, price, costPrice,
requiresPrescription, description, imageUrl, isActive,
createdAt, updatedAt
```
- 12 categories: Analgesic, Antibiotic, Antiviral, Antifungal, Antihistamine, Cardiovascular, Dermatological, Gastrointestinal, Hormonal, Neurological, Respiratory, Vitamins & Supplements
- 9 dosage forms: Tablet, Capsule, Syrup, Injection, Cream, Ointment, Drops, Inhaler, Suppository

#### Inventory
```
id, medicationId, medicationName, branchId, branchName,
quantity, minStockLevel, batchNumber,
expiryDate, locationInStore,
createdAt, updatedAt
```

#### Stock Movement
```
id, medicationId, medicationName, branchId, branchName,
type, quantityChange, quantityBefore, quantityAfter,
reason, referenceId, referenceType, createdAt
```
- Movement types: `sale`, `purchase_received`, `customer_order_delivered`, `prescription_dispensed`, `manual_adjustment`

#### Sale
```
id, saleNumber, branchId, branchName,
customerName, customerPhone, prescriptionId,
items[], subtotal, discount, totalAmount,
paymentMethod, status, notes,
createdAt, updatedAt
```
- Statuses: Completed, Refunded, Voided
- Payment methods: Cash, Card, Insurance, Online

#### Prescription
```
id, prescriptionNumber, patientName, patientPhone, patientDob,
doctorName, doctorLicense, issueDate, expiryDate,
branchId, branchName, status,
items[], imageUrl, notes,
createdAt, updatedAt
```
- Statuses: Pending, Verified, Dispensed, Rejected, Expired

#### Customer Order
```
id, orderNumber, customerName, customerEmail, customerPhone,
deliveryAddress, branchId, branchName,
orderType, items[], totalAmount, status,
paymentMethod, notes,
createdAt, updatedAt
```
- Order types: Pickup, Delivery
- Statuses: Pending, Confirmed, Processing, Ready, Out for Delivery, Delivered, Cancelled

#### Purchase Order
```
id, orderNumber, supplierId, supplierName,
branchId, branchName, status, orderDate,
expectedDelivery, totalAmount, items[],
notes, receivedAt, createdAt, updatedAt
```
- Statuses: Draft, Sent, Confirmed, Received, Cancelled

#### Staff
```
id, fullName, email, phone, role,
branchId, branchName, licenseNumber,
hireDate, isActive, avatarUrl,
createdAt, updatedAt
```

#### Shift
```
id, staffId, staffName, branchId, branchName,
date, startTime, endTime, status, notes,
createdAt, updatedAt
```
- Statuses: Scheduled, In Progress, Absent, Completed, Cancelled

#### Supplier
```
id, name, contactPerson, phone, email,
address, paymentTerms, isActive, notes,
createdAt, updatedAt
```

---

## 4. Technical Architecture

### 4.1 Project Structure

```
lib/
├── main.dart                          # App initialization
├── app.dart                           # Root widget (GoRouter, BlocProviders, theme)
├── firebase_options.dart              # Firebase config
├── core/
│   ├── app/
│   │   ├── app_cubit/                 # Global theme & language state
│   │   └── connectivity_controller.dart
│   ├── common/widgets/                # 20+ reusable UI components
│   ├── di/dependency_injection.dart   # GetIt service locator
│   ├── extensions/                    # Context, Date, String extensions
│   ├── language/                      # Localization setup & delegate
│   ├── permissions/permission_helper.dart
│   ├── routing/                       # GoRouter config, route definitions
│   ├── screens/                       # No-network, WebView, Under-build
│   ├── services/shared_pref/          # SharedPreferences wrapper
│   ├── style/                         # Colors, fonts, themes (light/dark)
│   └── utils/                         # Validators, error mapper
├── features/
│   ├── auth/                          # Firebase email/password auth
│   ├── branches/                      # Multi-branch management
│   ├── customer_orders/               # Order management (pickup/delivery)
│   ├── dashboard/                     # Home screen with stats & charts
│   ├── inventory/                     # Stock tracking, alerts, movements
│   ├── medications/                   # Drug catalog management
│   ├── prescriptions/                 # Prescription lifecycle
│   ├── purchase_orders/               # Supplier purchase orders
│   ├── reports/                       # Analytics and charts
│   ├── sales/                         # POS / sales transactions
│   ├── shifts/                        # Staff scheduling
│   ├── staff/                         # Employee management
│   └── suppliers/                     # Vendor database
```

### 4.2 Feature Module Pattern

Each feature follows clean architecture:
```
feature/
├── data/
│   ├── data_source/    # Firebase queries, business validation
│   ├── models/         # JSON serialization (fromJson/toJson)
│   └── repos/          # Thin delegation to data sources
├── presentation/
│   ├── cubit/          # State management (BLoC/Cubit)
│   ├── screens/        # Entry point screen (30-70 lines)
│   ├── refactor/       # Body sections, filters, helpers
│   └── widgets/        # Feature-specific UI components
```

### 4.3 Technology Stack

| Category | Technology |
|----------|------------|
| **Framework** | Flutter 3.11.5+ |
| **State Management** | flutter_bloc + Cubit pattern |
| **Code Generation** | freezed + json_serializable + injectable |
| **Routing** | go_router with auth guards |
| **DI** | get_it + injectable |
| **Database** | Cloud Firestore (with local persistence) |
| **Auth** | Firebase Authentication |
| **Security** | Firebase App Check, flutter_secure_storage |
| **Responsive** | flutter_screenutil (375x812 baseline) |
| **Localization** | Custom JSON-based (en/ar) |
| **Barcode** | mobile_scanner + qr_flutter |
| **Connectivity** | connectivity_plus |
| **CI/CD** | GitHub Actions + Fastlane + Firebase App Distribution |

### 4.4 Authentication & Authorization

- **Auth method:** Firebase email/password
- **Session management:** Firebase Auth state listener
- **User profile:** Linked to `staff` collection via `staffId`
- **Role resolution:** Fetched from Firestore on login
- **Route protection:** GoRouter redirect guard checks auth state
- **Feature protection:** `PermissionHelper` validates route access, edit, and delete permissions per role

### 4.5 Dependency Injection Setup

```
Firebase instances (singletons):
  → FirebaseFirestore
  → FirebaseAuth

Per feature (singletons):
  → RemoteDataSource (requires Firestore)
  → Repository (requires DataSource)
  → Cubit (requires Repository)

Global:
  → AppCubit
  → AuthCubit
```

### 4.6 Navigation Architecture

- **Shell route** wraps authenticated pages with `AppShell` (sidebar + top bar)
- **Login** route is outside the shell
- **Auth guard** redirects unauthenticated users to `/login`
- **Role guard** validates route access based on user role
- **Routes:** `/`, `/inventory`, `/medications`, `/sales`, `/prescriptions`, `/orders`, `/suppliers`, `/purchase-orders`, `/staff`, `/shifts`, `/branches`, `/reports`, `/stock-history`, `/inventory-alerts`

---

## 5. Dashboard & Reporting

### 5.1 Dashboard Metrics

The dashboard aggregates data from all features to display:

| Metric | Source |
|--------|--------|
| Total Revenue | Sum of all sale totals |
| Total Cost | Calculated from inventory cost prices |
| Total Profit | Revenue minus cost |
| Profit Margin | Percentage calculation |
| Total Sales Count | Count of sale records |
| Low Stock Alerts | Items where quantity <= minStockLevel |
| Pending Prescriptions | Prescriptions in "Pending" status |
| Active Staff | Staff with isActive = true |
| Revenue (7-day chart) | Daily revenue aggregation |
| Sales Count (7-day chart) | Daily sales count |
| Low Stock Items List | Detailed item breakdown |
| Recent Customer Orders | Latest order activity |
| Recent Stock Movements | Last 5 movements |

### 5.2 Reports Module

Available reports with filtering by date range and branch:

1. **Revenue Report** - Daily revenue for the last 30 days (line/bar chart)
2. **Sales Analysis** - Top selling medications, total orders
3. **Revenue by Branch** - Branch performance comparison (pie/bar chart)
4. **Payment Methods** - Breakdown by payment type (pie chart)
5. **Order Status** - Distribution of order statuses (pie chart)
6. **Stock Movements** - Movement types analysis
7. **Most Moved Medications** - High-activity medications
8. **Profit Analysis** - Daily profit for the last 30 days
9. **Top Profitable Medications** - Highest margin items

---

## 6. Localization

- **Primary language:** Arabic (ar)
- **Secondary language:** English (en)
- **String count:** ~680 English keys, ~520 Arabic keys
- **Location:** `lang/en.json`, `lang/ar.json`
- **Pattern:** `context.translate(LangKeys.keyName)` or `LangKeys.keyName.tr()`
- **Persistence:** Language preference saved in SharedPreferences

---

## 7. Common UI Components

The app includes 20+ reusable widgets in `core/common/widgets/`:

- **Form fields:** AppTextField, AppDateField, AppTimeField, AppDropdownField, AppSwitchField, AppQuantityStepper
- **Layout:** AppCard, AppShell, AppPageHeader, AppTopBar, AppSidebarLogo
- **Feedback:** AppLoading, AppEmptyState, AppStatusChip, AppDeleteConfirmationDialog, ShowToast
- **Navigation:** AppLanguageToggleButton, AppThemeToggleButton
- **Feature pickers:** SaleMedicationPickerBottomSheet, PurchaseOrderMedicationPickerBottomSheet, CustomerOrderMedicationPickerBottomSheet
- **Scanning:** SmartBarcodeScanner (QR/Barcode)

---

## 8. Current Implementation Status

### Fully Implemented
- Firebase Authentication with role-based access (5 roles)
- Multi-branch management (CRUD + activate/deactivate)
- Medication catalog (12 categories, 9 dosage forms, barcode support)
- Inventory tracking (stock levels, expiry alerts, low stock alerts, batch tracking)
- Stock movement audit trail (5 movement types with before/after tracking)
- POS / Sales (multi-item, 4 payment methods, discount, automatic stock deduction)
- Prescription management (create, verify, dispense workflow with stock deduction)
- Customer orders (pickup/delivery, full status workflow, stock deduction)
- Purchase orders (draft-to-received workflow, automatic stock increase)
- Staff management (CRUD, Firebase Auth account creation, license tracking)
- Shift scheduling (week view, status workflow)
- Supplier management (CRUD, payment terms)
- Dashboard (13+ metrics, 7-day charts, alerts)
- Reports (9 report types with charts)
- Responsive UI (ScreenUtil-based)
- Dark/Light theme (persisted)
- English/Arabic localization
- Connectivity monitoring with offline screen
- CI/CD (GitHub Actions + Fastlane + Firebase App Distribution)

### Not Implemented
- Push notifications
- Pagination (all data loaded at once)
- Offline-first mode (data sync)
- Unit / integration / widget tests
- PDF report export
- Advanced audit logging
- Two-factor authentication
- Customer-facing app
- Insurance company integration
- Loyalty / rewards program
- Expiry date scanning (OCR)
- Inter-branch stock transfers
- Returns & refund processing (beyond status change)

---

## 9. Key Business Rules

1. **Inventory is the source of truth** - Every sale, dispense, delivery, and receipt must update inventory and create a stock movement record.
2. **Prescriptions expire** - Cannot dispense past expiry date. Cannot dispense twice.
3. **Purchase orders are immutable after sending** - Only drafts can be edited.
4. **Discounts cannot exceed subtotal** - Sales discount validation enforced.
5. **Delivery orders require address** - Customer order validation.
6. **Shift times must be valid** - End time must be after start time.
7. **Staff creation = Auth creation** - Creating a staff member also creates their Firebase Auth account.
8. **Soft deletes** - Medications and branches use `isActive` flag instead of hard deletes.
9. **Branch scoping** - Inventory, sales, orders, shifts are scoped to specific branches.
10. **Role-based access** - UI routes, edit capabilities, and delete permissions are controlled per role.
