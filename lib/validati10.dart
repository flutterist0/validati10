
class Validati10 {
  static bool validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) return false;
    
    String cleaned = phoneNumber.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    
    RegExp regex = RegExp(
      r'^(\+994|994|0)(50|51|55|70|77|99|10|60)\d{7}$'
    );
    
    return regex.hasMatch(cleaned);
  }

  static bool validateFIN(String fin) {
    if (fin.isEmpty) return false;
    
    String cleaned = fin.toUpperCase().trim();
    
    if (cleaned.length != 7) return false;
    
    bool hasLetter = RegExp(r'[A-Z]').hasMatch(cleaned);
    bool hasDigit = RegExp(r'[0-9]').hasMatch(cleaned);
    bool onlyValidChars = RegExp(r'^[A-Z0-9]+$').hasMatch(cleaned);
    
    return hasLetter && hasDigit && onlyValidChars;
  }
  static bool validateVehiclePlate(String plate) {
    if (plate.isEmpty) return false;
    
    String cleaned = plate.toUpperCase().replaceAll(RegExp(r'[\s\-]'), '');
    
    RegExp regex = RegExp(r'^[0-9]{2}[A-Z]{2}[0-9]{3}$');
    
    return regex.hasMatch(cleaned);
  }

  static bool validatePostalCode(String postalCode) {
    if (postalCode.isEmpty) return false;
    
    String cleaned = postalCode.toUpperCase().replaceAll(RegExp(r'\s'), '');
    
    RegExp regex = RegExp(r'^AZ\d{4}(\d{2})?$');
    
    return regex.hasMatch(cleaned);
  }

  static String? formatPhoneNumber(String phoneNumber) {
    if (!validatePhoneNumber(phoneNumber)) return null;
    
    String cleaned = phoneNumber.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    
    if (cleaned.startsWith('+994')) {
      return cleaned;
    } else if (cleaned.startsWith('994')) {
      return '+$cleaned';
    } else if (cleaned.startsWith('0')) {
      return '+994${cleaned.substring(1)}';
    }
    
    return null;
  }

  static String? formatVehiclePlate(String plate) {
    if (!validateVehiclePlate(plate)) return null;
    
    String cleaned = plate.toUpperCase().replaceAll(RegExp(r'[\s\-]'), '');
    
    return '${cleaned.substring(0, 2)}-${cleaned.substring(2, 4)}-${cleaned.substring(4, 7)}';
  }

  static String? formatPostalCode(String postalCode) {
    if (!validatePostalCode(postalCode)) return null;
    
    String cleaned = postalCode.toUpperCase().replaceAll(RegExp(r'\s'), '');
    
    return '${cleaned.substring(0, 2)} ${cleaned.substring(2)}';
  }


  static String? getPhoneOperator(String phoneNumber) { 
    if (!validatePhoneNumber(phoneNumber)) return null;
    
    String cleaned = phoneNumber.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    
    String operatorCode = '';
    if (cleaned.startsWith('+994') || cleaned.startsWith('994')) {
      operatorCode = cleaned.substring(cleaned.indexOf('994') + 3, cleaned.indexOf('994') + 5);
    } else if (cleaned.startsWith('0')) {
      operatorCode = cleaned.substring(1, 3);
    }
    
    switch (operatorCode) {
      case '50':
      case '51':
      case '55':
        return 'Azercell';
      case '70':
      case '77':
        return 'Bakcell';
      case '99':
        return 'Nar Mobile';
      case '10':
        return 'Nakhtel';
      case '60':
        return 'Ulduz Mobile';
      default:
        return null;
    }
  }


  static String? getVehicleRegion(String plate) {
    if (!validateVehiclePlate(plate)) return null;
    
    String cleaned = plate.replaceAll(RegExp(r'[\s\-]'), '');
    return cleaned.substring(0, 2);
  }
}

extension Validati10Extension on String {
  bool get isValidAzPhoneNumber => Validati10.validatePhoneNumber(this);
  
  bool get isValidFIN => Validati10.validateFIN(this);
  
  bool get isValidVehiclePlate => Validati10.validateVehiclePlate(this);
  
  bool get isValidPostalCode => Validati10.validatePostalCode(this);
  
  String? get formattedPhoneNumber => Validati10.formatPhoneNumber(this);
  
  String? get formattedVehiclePlate => Validati10.formatVehiclePlate(this);
  
  String? get formattedPostalCode => Validati10.formatPostalCode(this);
  
  String? get phoneOperator => Validati10.getPhoneOperator(this);
  
  String? get vehicleRegion => Validati10.getVehicleRegion(this);
}