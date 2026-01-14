# Validati10 🇦🇿

Azərbaycan formatlarını yoxlamaq üçün Flutter package - mobil nömrələr, FİN kodları, avtomobil nömrələri və poçt indeksləri.

A comprehensive Flutter package for validating Azerbaijan-specific data formats including phone numbers, FIN codes, vehicle license plates, and postal codes.

## Features ✨

- 📱 **Phone Number Validation** - Validates Azerbaijani mobile numbers (+994, 994, 0 formats)
- 🆔 **FIN Code Validation** - Validates personal identification numbers
- 🚗 **Vehicle Plate Validation** - Validates license plate numbers
- 📮 **Postal Code Validation** - Validates postal codes (AZ format)
- 🔧 **Format Functions** - Auto-format data to standard formats
- 📡 **Operator Detection** - Identifies mobile operators (Azercell, Bakcell, Nar, etc.)
- 🗺️ **Region Detection** - Extracts region codes from vehicle plates

## Installation 📦

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  validati10: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage 🚀

### Import the package

```dart
import 'package:validati10/validati10.dart';
```

### Phone Number Validation

```dart
// Validate phone numbers
bool isValid = Validati10.validatePhoneNumber('+994501234567');
// Returns: true

// Format phone number
String? formatted = Validati10.formatPhoneNumber('0501234567');
// Returns: +994501234567

// Get operator name
String? operator = Validati10.getPhoneOperator('+994501234567');
// Returns: Azercell

// Supported operators:
// 50, 51, 55 - Azercell
// 70, 77 - Bakcell
// 99 - Nar Mobile
// 10 - Nakhtel
// 60 - Ulduz Mobile
```

### FIN Code Validation

```dart
// Validate FIN codes (7 characters: letters + numbers)
bool isValid = Validati10.validateFIN('1AB2C3D');
// Returns: true

// Examples of valid FIN codes:
// 1AB2C3D, AA1BC2D, 7XYZABC
```

### Vehicle Plate Validation

```dart
// Validate vehicle plates
bool isValid = Validati10.validateVehiclePlate('10-AA-123');
// Returns: true

// Format plate number
String? formatted = Validati10.formatVehiclePlate('10AA123');
// Returns: 10-AA-123

// Get region code
String? region = Validati10.getVehicleRegion('10-AA-123');
// Returns: 10 (Baku)

// Supported formats: 10-AA-123, 10AA123, 10 AA 123
```

### Postal Code Validation

```dart
// Validate postal codes
bool isValid = Validati10.validatePostalCode('AZ1000');
// Returns: true

// Format postal code
String? formatted = Validati10.formatPostalCode('AZ1000');
// Returns: AZ 1000

// Supported formats: AZ1000, AZ100000
```

### Extension Methods

You can also use convenient extension methods:

```dart
// Phone number
String phone = '+994501234567';
print(phone.isValidAzPhoneNumber);  // true
print(phone.formattedPhoneNumber);  // +994501234567
print(phone.phoneOperator);         // Azercell

// FIN code
String fin = '1AB2C3D';
print(fin.isValidFIN);  // true

// Vehicle plate
String plate = '10AA123';
print(plate.isValidVehiclePlate);    // true
print(plate.formattedVehiclePlate);  // 10-AA-123
print(plate.vehicleRegion);          // 10

// Postal code
String postal = 'AZ1000';
print(postal.isValidPostalCode);     // true
print(postal.formattedPostalCode);   // AZ 1000
```

## Complete Example 📝

```dart
import 'package:validati10/validati10.dart';

void main() {
  // Phone validation
  if (Validati10.validatePhoneNumber('+994501234567')) {
    print('Valid phone number!');
    print('Operator: ${Validati10.getPhoneOperator('+994501234567')}');
  }
  
  // FIN validation
  if (Validati10.validateFIN('1AB2C3D')) {
    print('Valid FIN code!');
  }
  
  // Vehicle plate validation
  String plate = '10AA123';
  if (plate.isValidVehiclePlate) {
    print('Valid plate: ${plate.formattedVehiclePlate}');
    print('Region: ${plate.vehicleRegion}');
  }
  
  // Postal code validation
  if ('AZ1000'.isValidPostalCode) {
    print('Valid postal code!');
  }
}
```

## API Reference 📚

### Validati10 Class

| Method | Parameters | Returns | Description |
|--------|-----------|---------|-------------|
| `validatePhoneNumber()` | `String phoneNumber` | `bool` | Validates phone number |
| `validateFIN()` | `String fin` | `bool` | Validates FIN code |
| `validateVehiclePlate()` | `String plate` | `bool` | Validates vehicle plate |
| `validatePostalCode()` | `String postalCode` | `bool` | Validates postal code |
| `formatPhoneNumber()` | `String phoneNumber` | `String?` | Formats phone to standard |
| `formatVehiclePlate()` | `String plate` | `String?` | Formats plate to standard |
| `formatPostalCode()` | `String postalCode` | `String?` | Formats postal code |
| `getPhoneOperator()` | `String phoneNumber` | `String?` | Returns operator name |
| `getVehicleRegion()` | `String plate` | `String?` | Returns region code |

### Extension Methods

All validator methods are available as extension methods on `String`:
- `isValidAzPhoneNumber`
- `isValidFIN`
- `isValidVehiclePlate`
- `isValidPostalCode`
- `formattedPhoneNumber`
- `formattedVehiclePlate`
- `formattedPostalCode`
- `phoneOperator`
- `vehicleRegion`

## Supported Formats 📋

### Phone Numbers
- `+994XXXXXXXXX` - International format
- `994XXXXXXXXX` - Without plus
- `0XXXXXXXXX` - Local format
- Operators: 50, 51, 55, 70, 77, 99, 10, 60

### FIN Codes
- 7 characters (letters + numbers)
- Example: `1AB2C3D`

### Vehicle Plates
- Format: `XX-YY-ZZZ`
- XX: 2 digits (region)
- YY: 2 letters
- ZZZ: 3 digits

### Postal Codes
- Format: `AZXXXX` or `AZXXXXXX`
- 4 or 6 digits after AZ prefix

## Contributing 🤝

Contributions are welcome! Please feel free to submit a Pull Request.

## License 📄

This project is licensed under the MIT License - see the LICENSE file for details.

## Support 💬

If you have any questions or issues, please open an issue on GitHub.

---

Made with ❤️ for Azerbaijan 🇦🇿