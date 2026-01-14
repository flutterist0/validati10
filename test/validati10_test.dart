import 'package:flutter_test/flutter_test.dart';
import 'package:validati10/validati10.dart';

void main() {
  group('Phone Number Validation', () {
    test('Valid phone numbers should pass', () {
      expect(Validati10.validatePhoneNumber('+994501234567'), true);
      expect(Validati10.validatePhoneNumber('994501234567'), true);
      expect(Validati10.validatePhoneNumber('0501234567'), true);
      expect(Validati10.validatePhoneNumber('+994 50 123 45 67'), true);
      expect(Validati10.validatePhoneNumber('050-123-45-67'), true);
    });

    test('All operators should be valid', () {
      expect(Validati10.validatePhoneNumber('+994501234567'), true); 
      expect(Validati10.validatePhoneNumber('+994511234567'), true); 
      expect(Validati10.validatePhoneNumber('+994551234567'), true); 
      expect(Validati10.validatePhoneNumber('+994701234567'), true); 
      expect(Validati10.validatePhoneNumber('+994771234567'), true); 
      expect(Validati10.validatePhoneNumber('+994991234567'), true); 
      expect(Validati10.validatePhoneNumber('+994101234567'), true); 
      expect(Validati10.validatePhoneNumber('+994601234567'), true); 
    });

    test('Invalid phone numbers should fail', () {
      expect(Validati10.validatePhoneNumber('+994401234567'), false); 
      expect(Validati10.validatePhoneNumber('123456789'), false);
      expect(Validati10.validatePhoneNumber(''), false);
      expect(Validati10.validatePhoneNumber('+99450123456'), false); 
    });

    test('Phone number formatting should work', () {
      expect(Validati10.formatPhoneNumber('+994501234567'), '+994501234567');
      expect(Validati10.formatPhoneNumber('994501234567'), '+994501234567');
      expect(Validati10.formatPhoneNumber('0501234567'), '+994501234567');
      expect(Validati10.formatPhoneNumber('invalid'), null);
    });

    test('Operator detection should work', () {
      expect(Validati10.getPhoneOperator('+994501234567'), 'Azercell');
      expect(Validati10.getPhoneOperator('+994511234567'), 'Azercell');
      expect(Validati10.getPhoneOperator('+994551234567'), 'Azercell');
      expect(Validati10.getPhoneOperator('+994701234567'), 'Bakcell');
      expect(Validati10.getPhoneOperator('+994771234567'), 'Bakcell');
      expect(Validati10.getPhoneOperator('+994991234567'), 'Nar Mobile');
      expect(Validati10.getPhoneOperator('+994101234567'), 'Nakhtel');
      expect(Validati10.getPhoneOperator('+994601234567'), 'Ulduz Mobile');
    });
  });

  group('FIN Code Validation', () {
    test('Valid FIN codes should pass', () {
      expect(Validati10.validateFIN('1AB2C3D'), true);
      expect(Validati10.validateFIN('AA1BC2D'), true);
      expect(Validati10.validateFIN('7XYZABC'), true);
      expect(Validati10.validateFIN('1a2b3c4'), true);
    });

    test('Invalid FIN codes should fail', () {
      expect(Validati10.validateFIN('ABCDEFG'), false); 
      expect(Validati10.validateFIN('1234567'), false); 
      expect(Validati10.validateFIN('1AB2C3'), false); 
      expect(Validati10.validateFIN('1AB2C3DE'), false); 
      expect(Validati10.validateFIN(''), false);
    });
  });

  group('Vehicle Plate Validation', () {
    test('Valid vehicle plates should pass', () {
      expect(Validati10.validateVehiclePlate('10-AA-123'), true);
      expect(Validati10.validateVehiclePlate('10AA123'), true);
      expect(Validati10.validateVehiclePlate('10 AA 123'), true);
      expect(Validati10.validateVehiclePlate('77-BB-999'), true);
      expect(Validati10.validateVehiclePlate('01-ZZ-001'), true);
    });

    test('Invalid vehicle plates should fail', () {
      expect(Validati10.validateVehiclePlate('AA-10-123'), false);
      expect(Validati10.validateVehiclePlate('100-AA-123'), false);
      expect(Validati10.validateVehiclePlate('10-A-123'), false); 
      expect(Validati10.validateVehiclePlate(''), false);
    });

    test('Vehicle plate formatting should work', () {
      expect(Validati10.formatVehiclePlate('10AA123'), '10-AA-123');
      expect(Validati10.formatVehiclePlate('10 AA 123'), '10-AA-123');
      expect(Validati10.formatVehiclePlate('invalid'), null);
    });

    test('Region extraction should work', () {
      expect(Validati10.getVehicleRegion('10-AA-123'), '10');
      expect(Validati10.getVehicleRegion('77BB999'), '77');
      expect(Validati10.getVehicleRegion('invalid'), null);
    });
  });

  group('Postal Code Validation', () {
    test('Valid postal codes should pass', () {
      expect(Validati10.validatePostalCode('AZ1000'), true);
      expect(Validati10.validatePostalCode('AZ1001'), true);
      expect(Validati10.validatePostalCode('AZ100000'), true);
      expect(Validati10.validatePostalCode('AZ 1000'), true);
      expect(Validati10.validatePostalCode('az1000'), true); 
    });

    test('Invalid postal codes should fail', () {
      expect(Validati10.validatePostalCode('AZ12345'), false);
      expect(Validati10.validatePostalCode('1000'), false); 
      expect(Validati10.validatePostalCode('AZ'), false);
      expect(Validati10.validatePostalCode(''), false);
    });

    test('Postal code formatting should work', () {
      expect(Validati10.formatPostalCode('AZ1000'), 'AZ 1000');
      expect(Validati10.formatPostalCode('AZ100000'), 'AZ 100000');
      expect(Validati10.formatPostalCode('invalid'), null);
    });
  });

  group('Extension Methods', () {
    test('Phone number extensions should work', () {
      expect('+994501234567'.isValidAzPhoneNumber, true);
      expect('+994501234567'.formattedPhoneNumber, '+994501234567');
      expect('+994501234567'.phoneOperator, 'Azercell');
    });

    test('FIN extensions should work', () {
      expect('1AB2C3D'.isValidFIN, true);
      expect('ABCDEFG'.isValidFIN, false);
    });

    test('Vehicle plate extensions should work', () {
      expect('10AA123'.isValidVehiclePlate, true);
      expect('10AA123'.formattedVehiclePlate, '10-AA-123');
      expect('10AA123'.vehicleRegion, '10');
    });

    test('Postal code extensions should work', () {
      expect('AZ1000'.isValidPostalCode, true);
      expect('AZ1000'.formattedPostalCode, 'AZ 1000');
    });
  });
}