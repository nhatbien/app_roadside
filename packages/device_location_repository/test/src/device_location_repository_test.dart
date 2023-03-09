// ignore_for_file: prefer_const_constructors
import 'package:device_location_repository/device_location_repository.dart';
import 'package:test/test.dart';

void main() {
  group('DeviceLocationRepository', () {
    test('can be instantiated', () {
      expect(DeviceLocationRepository(), isNotNull);
    });
  });
}
