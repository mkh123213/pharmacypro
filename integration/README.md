# PharmaChain Flutter Converted Features

This ZIP contains converted Flutter feature files from the shared Base44/React app using the requested two-layer structure:

```text
features/feature_name/
├── data/
│   ├── data_source/
│   ├── models/
│   └── repos/
└── presentation/
    ├── cubit/
    ├── refactor/
    ├── screens/
    └── widgets/
```

No `domain`, `entities`, or `use_cases` folders are used.

## Included features

- dashboard
- inventory
- medications
- sales
- prescriptions
- customer_orders
- suppliers
- purchase_orders
- staff
- shifts
- branches
- reports

## Required dependencies

Make sure your `pubspec.yaml` includes:

```yaml
dependencies:
  flutter_bloc:
  get_it:
  freezed_annotation:
  json_annotation:
  firebase_core:
  cloud_firestore:
  firebase_auth:
  flutter_screenutil:
  go_router:
  intl:
  qr_flutter:
  mobile_scanner:

dev_dependencies:
  build_runner:
  freezed:
  json_serializable:
```

## After copying files

Run:

```bash
dart run build_runner build --delete-conflicting-outputs
flutter analyze
flutter run
```

## Firestore collections

The converted features use these collections:

```text
branches
suppliers
staff
medications
inventory
sales
customer_orders
prescriptions
purchase_orders
shifts
```

## Dependency injection

See `integration/dependency_injection_registrations.dart` for all GetIt registrations.
Adjust import paths after copying into your own app because the snippet is stored outside `lib/` in this ZIP.

## Important notes

- The card/table/list UI is converted from the shared React screens.
- Some large create forms are implemented as basic Flutter forms; a few complex item-row forms include TODO placeholder widgets to keep the package manageable and compilable after integration.
- QR display uses `qr_flutter`.
- Barcode scanning uses `mobile_scanner`.
- Run `build_runner` after copying because models and Freezed states include generated parts.
