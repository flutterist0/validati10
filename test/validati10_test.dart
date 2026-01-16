import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:validati10/validati10.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const String mockRulesJson = '''
  {
    "AZ": {
      "phone": {
        "regex": "^(\\\\+994|994|0)(50|51|55|70|77|99|10|60)\\\\d{7}\$",
        "format_clean_regex": "[\\\\s\\\\-\\\\(\\\\)]",
        "operators": { "50": "Azercell", "70": "Bakcell" }
      },
      "identity": { "regex": "^[A-Z0-9]{7}\$", "length": 7, "requires_digit": true, "requires_letter": true },
      "vehicle": { "regex": "^[0-9]{2}[A-Z]{2}[0-9]{3}\$", "region_index": [0, 2] },
      "postal": { "regex": "^AZ\\\\d{4}(\\\\d{2})?\$" }
    },
    "TR": {
      "phone": { "regex": "^(\\\\+90|90|0)?5\\\\d{9}\$", "operators": { "53": "Turkcell" } },
      "identity": { "regex": "^[1-9]{1}[0-9]{9}[02468]{1}\$", "length": 11 }
    }
  }
  ''';

  setUpAll(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (ByteData? message) async {
      return ByteData.view(
          Uint8List.fromList(utf8.encode(mockRulesJson)).buffer);
    });

    await Validati10.initialize();
  });

  group('AZ Country Tests', () {
    test('Validates Phone Numbers correctly', () {
      expect(
          Validati10.validatePhoneNumber('+994501234567', country: 'AZ'), true);
      expect(
          Validati10.validatePhoneNumber('+15551234567', country: 'AZ'), false);
    });

    test('Detects Operators correctly', () {
      expect(Validati10.getPhoneOperator('+994501234567', country: 'AZ'),
          'Azercell');
    });

    test('Validates Identity (FIN)', () {
      expect(Validati10.validateIdentity('1AB2C3D', country: 'AZ'), true);
    });

    test('Validates Vehicle Plate', () {
      expect(Validati10.validateVehiclePlate('10-AA-123', country: 'AZ'), true);
    });
  });

  group('TR Country Tests', () {
    test('Validates TR Phone correctly', () {
      expect(
          Validati10.validatePhoneNumber('05321234567', country: 'TR'), true);
      expect(Validati10.validatePhoneNumber('+994501234567', country: 'TR'),
          false);
    });
  });
}
