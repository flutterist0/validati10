# Validati10 🌍

**Dynamic Data Validation Package for Flutter**

A comprehensive, configuration-driven Flutter package for validating data formats like phone numbers, identity codes, vehicle plates, and postal codes. Supports multiple countries via a dynamic JSON rule engine.

---

## Features ✨

- 🌐 **Dynamic & Extensible** - Rules are loaded from a JSON file included in the package.
- 📱 **Phone Number Validation** - Validates mobile numbers and detects operators dynamically.
- 🆔 **Identity Validation** - Validates national ID formats (e.g., AZ FIN, TR TCKN).
- 🚗 **Vehicle Plate Validation** - Validates license plate numbers and extracts region codes.
- 📮 **Postal Code Validation** - Validates postal codes based on country patterns.

---

## Installation 📦

### 1. Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  validati10: ^1.0.0
```

### 2. Run:

```bash
flutter pub get
```

---

## Setup & Initialization 🚀

Before using the validators, you must initialize the package (usually in your `main.dart`).

```dart
import 'package:validati10/validati10.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize the package to load rules
  await Validati10.initialize();

  runApp(MyApp());
}
```

### Optional: If you want to provide your own rules file:

```dart
await Validati10.initialize(
  customPath: 'assets/my_custom_rules.json',
);
```

---

## Usage 💻

**Important:** You must always specify the `country` code (e.g., 'AZ', 'TR') for every validation call.

### 1. Azerbaijan (AZ) Example 🇦🇿

```dart
// Validate phone numbers
bool isValid = Validati10.validatePhoneNumber('+994501234567', country: 'AZ');
// Returns: true

// Get operator name
String? operator = Validati10.getPhoneOperator('+994501234567', country: 'AZ');
// Returns: Azercell

// Validate Vehicle Plate
bool isPlateValid = Validati10.validateVehiclePlate('10-AA-123', country: 'AZ');
// Returns: true
```

### 2. Turkey (TR) Example 🇹🇷

```dart
// Validate Turkish Phone Number
bool isTrValid = Validati10.validatePhoneNumber('05321234567', country: 'TR');
// Returns: true

// Get TR Operator
String? trOperator = Validati10.getPhoneOperator('05321234567', country: 'TR');
// Returns: Turkcell

// Validate Turkish Identity (TCKN)
bool isTCKN = Validati10.validateIdentity('12345678902', country: 'TR');
```

---

## API Reference 📚

All methods require the `country` parameter.

| Method | Parameters | Returns | Description |
|--------|-----------|---------|-------------|
| `initialize()` | `customPath?` | `Future<void>` | Loads JSON rules. Required. |
| `validatePhoneNumber()` | `String, required country` | `bool` | Validates phone based on country rules. |
| `validateIdentity()` | `String, required country` | `bool` | Validates ID (FIN, TCKN, etc.). |
| `validateVehiclePlate()` | `String, required country` | `bool` | Validates vehicle plate. |
| `validatePostalCode()` | `String, required country` | `bool` | Validates postal code. |
| `getPhoneOperator()` | `String, required country` | `String?` | Returns operator name if defined. |
| `getVehicleRegion()` | `String, required country` | `String?` | Returns region code if defined. |

---

## Contributing 🤝

Contributions are welcome! If you add rules for a new country in `rules.json`, please submit a Pull Request.

---

## License 📄

This project is licensed under the MIT License - see the LICENSE file for details.

---

Made with ❤️ and dynamic code logic.