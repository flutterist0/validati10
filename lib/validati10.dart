import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Validati10 {
  static Map<String, dynamic> _rules = {};

  static Future<void> initialize({
    String? customPath,
  }) async {
    try {
      String jsonString;

      if (customPath != null) {
        jsonString = await rootBundle.loadString(customPath);
      } else {
        jsonString = await rootBundle
            .loadString('packages/validati10/assets/rules.json');
      }

      _rules = json.decode(jsonString);
    } catch (e) {
      _rules = {};
    }
  }

  static Map<String, dynamic>? _getCountryRules(String countryCode) {
    return _rules[countryCode.toUpperCase()];
  }

  static bool validatePhoneNumber(String phoneNumber,
      {required String country}) {
    var rules = _getCountryRules(country)?['phone'];
    if (rules == null || phoneNumber.isEmpty) return false;

    String cleanRegex = rules['format_clean_regex'] ?? r'[\s\-\(\)]';
    String cleaned = phoneNumber.replaceAll(RegExp(cleanRegex), '');

    return RegExp(rules['regex']).hasMatch(cleaned);
  }

  static String? getPhoneOperator(String phoneNumber,
      {required String country}) {
    if (!validatePhoneNumber(phoneNumber, country: country)) return null;

    var rules = _getCountryRules(country)?['phone'];
    if (rules == null) return null;

    String cleanRegex = rules['format_clean_regex'] ?? r'[\s\-\(\)]';
    String cleaned = phoneNumber.replaceAll(RegExp(cleanRegex), '');
    Map<String, dynamic> operators = rules['operators'] ?? {};

    for (var prefix in operators.keys) {
      if (cleaned.contains(prefix)) {
        if (country.toUpperCase() == 'AZ') {
          if (cleaned.startsWith('0') && cleaned.startsWith(prefix, 1)) {
            return operators[prefix];
          }
          if ((cleaned.startsWith('994') || cleaned.startsWith('+994')) &&
              cleaned.contains(prefix)) {
            return operators[prefix];
          }
        } else {
          return operators[prefix];
        }
      }
    }
    return null;
  }

  static bool validateIdentity(String id, {required String country}) {
    var rules = _getCountryRules(country)?['identity'];
    if (rules == null || id.isEmpty) return false;

    String cleaned = id.toUpperCase().trim();

    if (rules['length'] != null && cleaned.length != rules['length']) {
      return false;
    }

    bool matchesRegex = RegExp(rules['regex']).hasMatch(cleaned);
    bool hasDigit = rules['requires_digit'] == true
        ? RegExp(r'[0-9]').hasMatch(cleaned)
        : true;
    bool hasLetter = rules['requires_letter'] == true
        ? RegExp(r'[A-Z]').hasMatch(cleaned)
        : true;

    return matchesRegex && hasDigit && hasLetter;
  }

  static bool validateVehiclePlate(String plate, {required String country}) {
    var rules = _getCountryRules(country)?['vehicle'];
    if (rules == null || plate.isEmpty) return false;

    String cleaned = plate.toUpperCase().replaceAll(RegExp(r'[\s\-]'), '');
    return RegExp(rules['regex']).hasMatch(cleaned);
  }

  static String? getVehicleRegion(String plate, {required String country}) {
    if (!validateVehiclePlate(plate, country: country)) return null;

    var rules = _getCountryRules(country)?['vehicle'];

    if (rules != null && rules['region_index'] != null) {
      String cleaned = plate.toUpperCase().replaceAll(RegExp(r'[\s\-]'), '');
      List<dynamic> idx = rules['region_index'];
      if (idx.length == 2) {
        return cleaned.substring(idx[0], idx[1]);
      }
    }
    return null;
  }

  static bool validatePostalCode(String postalCode, {required String country}) {
    var rules = _getCountryRules(country)?['postal'];
    if (rules == null || postalCode.isEmpty) return false;

    String cleaned = postalCode.toUpperCase().replaceAll(RegExp(r'\s'), '');
    return RegExp(rules['regex']).hasMatch(cleaned);
  }
}
