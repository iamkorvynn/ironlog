import 'package:flutter_test/flutter_test.dart';
import 'package:ironlog/utils/unit_converter.dart';

void main() {
  group('UnitConverter - kgToLbs and lbsToKg basic', () {
    test('0 kg converts to 0 lbs', () => expect(UnitConverter.kgToLbs(0), 0.0));
    test('0 lbs converts to 0 kg', () => expect(UnitConverter.lbsToKg(0), 0.0));
    test('1 kg converts to ~2.20462 lbs', () => expect(UnitConverter.kgToLbs(1), closeTo(2.20462, 0.001)));
    test('roundtrip consistency for 100kg', () {
      final lbs = UnitConverter.kgToLbs(100);
      expect(UnitConverter.lbsToKg(lbs), closeTo(100.0, 0.0001));
    });
  });

  group('UnitConverter - 100 parameterized weight conversions', () {
    test('converts 1 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(1.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(1.0, 0.0001));
      expect(UnitConverter.displayWeight(1.0, 'kg'), 1.0);
      expect(UnitConverter.displayWeight(1.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(1.0, 'kg'), '1 kg');
    });
    test('converts 2 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(2.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(2.0, 0.0001));
      expect(UnitConverter.displayWeight(2.0, 'kg'), 2.0);
      expect(UnitConverter.displayWeight(2.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(2.0, 'kg'), '2 kg');
    });
    test('converts 3 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(3.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(3.0, 0.0001));
      expect(UnitConverter.displayWeight(3.0, 'kg'), 3.0);
      expect(UnitConverter.displayWeight(3.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(3.0, 'kg'), '3 kg');
    });
    test('converts 4 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(4.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(4.0, 0.0001));
      expect(UnitConverter.displayWeight(4.0, 'kg'), 4.0);
      expect(UnitConverter.displayWeight(4.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(4.0, 'kg'), '4 kg');
    });
    test('converts 5 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(5.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(5.0, 0.0001));
      expect(UnitConverter.displayWeight(5.0, 'kg'), 5.0);
      expect(UnitConverter.displayWeight(5.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(5.0, 'kg'), '5 kg');
    });
    test('converts 6 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(6.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(6.0, 0.0001));
      expect(UnitConverter.displayWeight(6.0, 'kg'), 6.0);
      expect(UnitConverter.displayWeight(6.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(6.0, 'kg'), '6 kg');
    });
    test('converts 7 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(7.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(7.0, 0.0001));
      expect(UnitConverter.displayWeight(7.0, 'kg'), 7.0);
      expect(UnitConverter.displayWeight(7.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(7.0, 'kg'), '7 kg');
    });
    test('converts 8 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(8.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(8.0, 0.0001));
      expect(UnitConverter.displayWeight(8.0, 'kg'), 8.0);
      expect(UnitConverter.displayWeight(8.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(8.0, 'kg'), '8 kg');
    });
    test('converts 9 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(9.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(9.0, 0.0001));
      expect(UnitConverter.displayWeight(9.0, 'kg'), 9.0);
      expect(UnitConverter.displayWeight(9.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(9.0, 'kg'), '9 kg');
    });
    test('converts 10 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(10.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(10.0, 0.0001));
      expect(UnitConverter.displayWeight(10.0, 'kg'), 10.0);
      expect(UnitConverter.displayWeight(10.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(10.0, 'kg'), '10 kg');
    });
    test('converts 11 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(11.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(11.0, 0.0001));
      expect(UnitConverter.displayWeight(11.0, 'kg'), 11.0);
      expect(UnitConverter.displayWeight(11.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(11.0, 'kg'), '11 kg');
    });
    test('converts 12 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(12.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(12.0, 0.0001));
      expect(UnitConverter.displayWeight(12.0, 'kg'), 12.0);
      expect(UnitConverter.displayWeight(12.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(12.0, 'kg'), '12 kg');
    });
    test('converts 13 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(13.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(13.0, 0.0001));
      expect(UnitConverter.displayWeight(13.0, 'kg'), 13.0);
      expect(UnitConverter.displayWeight(13.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(13.0, 'kg'), '13 kg');
    });
    test('converts 14 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(14.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(14.0, 0.0001));
      expect(UnitConverter.displayWeight(14.0, 'kg'), 14.0);
      expect(UnitConverter.displayWeight(14.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(14.0, 'kg'), '14 kg');
    });
    test('converts 15 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(15.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(15.0, 0.0001));
      expect(UnitConverter.displayWeight(15.0, 'kg'), 15.0);
      expect(UnitConverter.displayWeight(15.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(15.0, 'kg'), '15 kg');
    });
    test('converts 16 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(16.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(16.0, 0.0001));
      expect(UnitConverter.displayWeight(16.0, 'kg'), 16.0);
      expect(UnitConverter.displayWeight(16.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(16.0, 'kg'), '16 kg');
    });
    test('converts 17 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(17.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(17.0, 0.0001));
      expect(UnitConverter.displayWeight(17.0, 'kg'), 17.0);
      expect(UnitConverter.displayWeight(17.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(17.0, 'kg'), '17 kg');
    });
    test('converts 18 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(18.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(18.0, 0.0001));
      expect(UnitConverter.displayWeight(18.0, 'kg'), 18.0);
      expect(UnitConverter.displayWeight(18.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(18.0, 'kg'), '18 kg');
    });
    test('converts 19 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(19.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(19.0, 0.0001));
      expect(UnitConverter.displayWeight(19.0, 'kg'), 19.0);
      expect(UnitConverter.displayWeight(19.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(19.0, 'kg'), '19 kg');
    });
    test('converts 20 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(20.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(20.0, 0.0001));
      expect(UnitConverter.displayWeight(20.0, 'kg'), 20.0);
      expect(UnitConverter.displayWeight(20.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(20.0, 'kg'), '20 kg');
    });
    test('converts 21 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(21.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(21.0, 0.0001));
      expect(UnitConverter.displayWeight(21.0, 'kg'), 21.0);
      expect(UnitConverter.displayWeight(21.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(21.0, 'kg'), '21 kg');
    });
    test('converts 22 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(22.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(22.0, 0.0001));
      expect(UnitConverter.displayWeight(22.0, 'kg'), 22.0);
      expect(UnitConverter.displayWeight(22.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(22.0, 'kg'), '22 kg');
    });
    test('converts 23 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(23.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(23.0, 0.0001));
      expect(UnitConverter.displayWeight(23.0, 'kg'), 23.0);
      expect(UnitConverter.displayWeight(23.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(23.0, 'kg'), '23 kg');
    });
    test('converts 24 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(24.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(24.0, 0.0001));
      expect(UnitConverter.displayWeight(24.0, 'kg'), 24.0);
      expect(UnitConverter.displayWeight(24.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(24.0, 'kg'), '24 kg');
    });
    test('converts 25 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(25.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(25.0, 0.0001));
      expect(UnitConverter.displayWeight(25.0, 'kg'), 25.0);
      expect(UnitConverter.displayWeight(25.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(25.0, 'kg'), '25 kg');
    });
    test('converts 26 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(26.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(26.0, 0.0001));
      expect(UnitConverter.displayWeight(26.0, 'kg'), 26.0);
      expect(UnitConverter.displayWeight(26.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(26.0, 'kg'), '26 kg');
    });
    test('converts 27 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(27.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(27.0, 0.0001));
      expect(UnitConverter.displayWeight(27.0, 'kg'), 27.0);
      expect(UnitConverter.displayWeight(27.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(27.0, 'kg'), '27 kg');
    });
    test('converts 28 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(28.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(28.0, 0.0001));
      expect(UnitConverter.displayWeight(28.0, 'kg'), 28.0);
      expect(UnitConverter.displayWeight(28.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(28.0, 'kg'), '28 kg');
    });
    test('converts 29 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(29.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(29.0, 0.0001));
      expect(UnitConverter.displayWeight(29.0, 'kg'), 29.0);
      expect(UnitConverter.displayWeight(29.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(29.0, 'kg'), '29 kg');
    });
    test('converts 30 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(30.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(30.0, 0.0001));
      expect(UnitConverter.displayWeight(30.0, 'kg'), 30.0);
      expect(UnitConverter.displayWeight(30.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(30.0, 'kg'), '30 kg');
    });
    test('converts 31 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(31.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(31.0, 0.0001));
      expect(UnitConverter.displayWeight(31.0, 'kg'), 31.0);
      expect(UnitConverter.displayWeight(31.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(31.0, 'kg'), '31 kg');
    });
    test('converts 32 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(32.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(32.0, 0.0001));
      expect(UnitConverter.displayWeight(32.0, 'kg'), 32.0);
      expect(UnitConverter.displayWeight(32.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(32.0, 'kg'), '32 kg');
    });
    test('converts 33 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(33.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(33.0, 0.0001));
      expect(UnitConverter.displayWeight(33.0, 'kg'), 33.0);
      expect(UnitConverter.displayWeight(33.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(33.0, 'kg'), '33 kg');
    });
    test('converts 34 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(34.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(34.0, 0.0001));
      expect(UnitConverter.displayWeight(34.0, 'kg'), 34.0);
      expect(UnitConverter.displayWeight(34.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(34.0, 'kg'), '34 kg');
    });
    test('converts 35 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(35.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(35.0, 0.0001));
      expect(UnitConverter.displayWeight(35.0, 'kg'), 35.0);
      expect(UnitConverter.displayWeight(35.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(35.0, 'kg'), '35 kg');
    });
    test('converts 36 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(36.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(36.0, 0.0001));
      expect(UnitConverter.displayWeight(36.0, 'kg'), 36.0);
      expect(UnitConverter.displayWeight(36.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(36.0, 'kg'), '36 kg');
    });
    test('converts 37 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(37.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(37.0, 0.0001));
      expect(UnitConverter.displayWeight(37.0, 'kg'), 37.0);
      expect(UnitConverter.displayWeight(37.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(37.0, 'kg'), '37 kg');
    });
    test('converts 38 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(38.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(38.0, 0.0001));
      expect(UnitConverter.displayWeight(38.0, 'kg'), 38.0);
      expect(UnitConverter.displayWeight(38.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(38.0, 'kg'), '38 kg');
    });
    test('converts 39 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(39.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(39.0, 0.0001));
      expect(UnitConverter.displayWeight(39.0, 'kg'), 39.0);
      expect(UnitConverter.displayWeight(39.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(39.0, 'kg'), '39 kg');
    });
    test('converts 40 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(40.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(40.0, 0.0001));
      expect(UnitConverter.displayWeight(40.0, 'kg'), 40.0);
      expect(UnitConverter.displayWeight(40.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(40.0, 'kg'), '40 kg');
    });
    test('converts 41 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(41.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(41.0, 0.0001));
      expect(UnitConverter.displayWeight(41.0, 'kg'), 41.0);
      expect(UnitConverter.displayWeight(41.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(41.0, 'kg'), '41 kg');
    });
    test('converts 42 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(42.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(42.0, 0.0001));
      expect(UnitConverter.displayWeight(42.0, 'kg'), 42.0);
      expect(UnitConverter.displayWeight(42.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(42.0, 'kg'), '42 kg');
    });
    test('converts 43 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(43.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(43.0, 0.0001));
      expect(UnitConverter.displayWeight(43.0, 'kg'), 43.0);
      expect(UnitConverter.displayWeight(43.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(43.0, 'kg'), '43 kg');
    });
    test('converts 44 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(44.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(44.0, 0.0001));
      expect(UnitConverter.displayWeight(44.0, 'kg'), 44.0);
      expect(UnitConverter.displayWeight(44.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(44.0, 'kg'), '44 kg');
    });
    test('converts 45 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(45.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(45.0, 0.0001));
      expect(UnitConverter.displayWeight(45.0, 'kg'), 45.0);
      expect(UnitConverter.displayWeight(45.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(45.0, 'kg'), '45 kg');
    });
    test('converts 46 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(46.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(46.0, 0.0001));
      expect(UnitConverter.displayWeight(46.0, 'kg'), 46.0);
      expect(UnitConverter.displayWeight(46.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(46.0, 'kg'), '46 kg');
    });
    test('converts 47 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(47.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(47.0, 0.0001));
      expect(UnitConverter.displayWeight(47.0, 'kg'), 47.0);
      expect(UnitConverter.displayWeight(47.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(47.0, 'kg'), '47 kg');
    });
    test('converts 48 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(48.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(48.0, 0.0001));
      expect(UnitConverter.displayWeight(48.0, 'kg'), 48.0);
      expect(UnitConverter.displayWeight(48.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(48.0, 'kg'), '48 kg');
    });
    test('converts 49 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(49.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(49.0, 0.0001));
      expect(UnitConverter.displayWeight(49.0, 'kg'), 49.0);
      expect(UnitConverter.displayWeight(49.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(49.0, 'kg'), '49 kg');
    });
    test('converts 50 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(50.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(50.0, 0.0001));
      expect(UnitConverter.displayWeight(50.0, 'kg'), 50.0);
      expect(UnitConverter.displayWeight(50.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(50.0, 'kg'), '50 kg');
    });
    test('converts 51 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(51.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(51.0, 0.0001));
      expect(UnitConverter.displayWeight(51.0, 'kg'), 51.0);
      expect(UnitConverter.displayWeight(51.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(51.0, 'kg'), '51 kg');
    });
    test('converts 52 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(52.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(52.0, 0.0001));
      expect(UnitConverter.displayWeight(52.0, 'kg'), 52.0);
      expect(UnitConverter.displayWeight(52.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(52.0, 'kg'), '52 kg');
    });
    test('converts 53 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(53.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(53.0, 0.0001));
      expect(UnitConverter.displayWeight(53.0, 'kg'), 53.0);
      expect(UnitConverter.displayWeight(53.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(53.0, 'kg'), '53 kg');
    });
    test('converts 54 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(54.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(54.0, 0.0001));
      expect(UnitConverter.displayWeight(54.0, 'kg'), 54.0);
      expect(UnitConverter.displayWeight(54.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(54.0, 'kg'), '54 kg');
    });
    test('converts 55 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(55.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(55.0, 0.0001));
      expect(UnitConverter.displayWeight(55.0, 'kg'), 55.0);
      expect(UnitConverter.displayWeight(55.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(55.0, 'kg'), '55 kg');
    });
    test('converts 56 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(56.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(56.0, 0.0001));
      expect(UnitConverter.displayWeight(56.0, 'kg'), 56.0);
      expect(UnitConverter.displayWeight(56.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(56.0, 'kg'), '56 kg');
    });
    test('converts 57 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(57.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(57.0, 0.0001));
      expect(UnitConverter.displayWeight(57.0, 'kg'), 57.0);
      expect(UnitConverter.displayWeight(57.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(57.0, 'kg'), '57 kg');
    });
    test('converts 58 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(58.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(58.0, 0.0001));
      expect(UnitConverter.displayWeight(58.0, 'kg'), 58.0);
      expect(UnitConverter.displayWeight(58.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(58.0, 'kg'), '58 kg');
    });
    test('converts 59 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(59.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(59.0, 0.0001));
      expect(UnitConverter.displayWeight(59.0, 'kg'), 59.0);
      expect(UnitConverter.displayWeight(59.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(59.0, 'kg'), '59 kg');
    });
    test('converts 60 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(60.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(60.0, 0.0001));
      expect(UnitConverter.displayWeight(60.0, 'kg'), 60.0);
      expect(UnitConverter.displayWeight(60.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(60.0, 'kg'), '60 kg');
    });
    test('converts 61 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(61.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(61.0, 0.0001));
      expect(UnitConverter.displayWeight(61.0, 'kg'), 61.0);
      expect(UnitConverter.displayWeight(61.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(61.0, 'kg'), '61 kg');
    });
    test('converts 62 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(62.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(62.0, 0.0001));
      expect(UnitConverter.displayWeight(62.0, 'kg'), 62.0);
      expect(UnitConverter.displayWeight(62.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(62.0, 'kg'), '62 kg');
    });
    test('converts 63 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(63.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(63.0, 0.0001));
      expect(UnitConverter.displayWeight(63.0, 'kg'), 63.0);
      expect(UnitConverter.displayWeight(63.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(63.0, 'kg'), '63 kg');
    });
    test('converts 64 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(64.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(64.0, 0.0001));
      expect(UnitConverter.displayWeight(64.0, 'kg'), 64.0);
      expect(UnitConverter.displayWeight(64.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(64.0, 'kg'), '64 kg');
    });
    test('converts 65 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(65.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(65.0, 0.0001));
      expect(UnitConverter.displayWeight(65.0, 'kg'), 65.0);
      expect(UnitConverter.displayWeight(65.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(65.0, 'kg'), '65 kg');
    });
    test('converts 66 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(66.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(66.0, 0.0001));
      expect(UnitConverter.displayWeight(66.0, 'kg'), 66.0);
      expect(UnitConverter.displayWeight(66.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(66.0, 'kg'), '66 kg');
    });
    test('converts 67 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(67.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(67.0, 0.0001));
      expect(UnitConverter.displayWeight(67.0, 'kg'), 67.0);
      expect(UnitConverter.displayWeight(67.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(67.0, 'kg'), '67 kg');
    });
    test('converts 68 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(68.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(68.0, 0.0001));
      expect(UnitConverter.displayWeight(68.0, 'kg'), 68.0);
      expect(UnitConverter.displayWeight(68.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(68.0, 'kg'), '68 kg');
    });
    test('converts 69 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(69.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(69.0, 0.0001));
      expect(UnitConverter.displayWeight(69.0, 'kg'), 69.0);
      expect(UnitConverter.displayWeight(69.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(69.0, 'kg'), '69 kg');
    });
    test('converts 70 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(70.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(70.0, 0.0001));
      expect(UnitConverter.displayWeight(70.0, 'kg'), 70.0);
      expect(UnitConverter.displayWeight(70.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(70.0, 'kg'), '70 kg');
    });
    test('converts 71 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(71.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(71.0, 0.0001));
      expect(UnitConverter.displayWeight(71.0, 'kg'), 71.0);
      expect(UnitConverter.displayWeight(71.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(71.0, 'kg'), '71 kg');
    });
    test('converts 72 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(72.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(72.0, 0.0001));
      expect(UnitConverter.displayWeight(72.0, 'kg'), 72.0);
      expect(UnitConverter.displayWeight(72.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(72.0, 'kg'), '72 kg');
    });
    test('converts 73 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(73.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(73.0, 0.0001));
      expect(UnitConverter.displayWeight(73.0, 'kg'), 73.0);
      expect(UnitConverter.displayWeight(73.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(73.0, 'kg'), '73 kg');
    });
    test('converts 74 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(74.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(74.0, 0.0001));
      expect(UnitConverter.displayWeight(74.0, 'kg'), 74.0);
      expect(UnitConverter.displayWeight(74.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(74.0, 'kg'), '74 kg');
    });
    test('converts 75 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(75.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(75.0, 0.0001));
      expect(UnitConverter.displayWeight(75.0, 'kg'), 75.0);
      expect(UnitConverter.displayWeight(75.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(75.0, 'kg'), '75 kg');
    });
    test('converts 76 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(76.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(76.0, 0.0001));
      expect(UnitConverter.displayWeight(76.0, 'kg'), 76.0);
      expect(UnitConverter.displayWeight(76.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(76.0, 'kg'), '76 kg');
    });
    test('converts 77 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(77.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(77.0, 0.0001));
      expect(UnitConverter.displayWeight(77.0, 'kg'), 77.0);
      expect(UnitConverter.displayWeight(77.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(77.0, 'kg'), '77 kg');
    });
    test('converts 78 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(78.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(78.0, 0.0001));
      expect(UnitConverter.displayWeight(78.0, 'kg'), 78.0);
      expect(UnitConverter.displayWeight(78.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(78.0, 'kg'), '78 kg');
    });
    test('converts 79 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(79.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(79.0, 0.0001));
      expect(UnitConverter.displayWeight(79.0, 'kg'), 79.0);
      expect(UnitConverter.displayWeight(79.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(79.0, 'kg'), '79 kg');
    });
    test('converts 80 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(80.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(80.0, 0.0001));
      expect(UnitConverter.displayWeight(80.0, 'kg'), 80.0);
      expect(UnitConverter.displayWeight(80.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(80.0, 'kg'), '80 kg');
    });
    test('converts 81 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(81.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(81.0, 0.0001));
      expect(UnitConverter.displayWeight(81.0, 'kg'), 81.0);
      expect(UnitConverter.displayWeight(81.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(81.0, 'kg'), '81 kg');
    });
    test('converts 82 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(82.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(82.0, 0.0001));
      expect(UnitConverter.displayWeight(82.0, 'kg'), 82.0);
      expect(UnitConverter.displayWeight(82.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(82.0, 'kg'), '82 kg');
    });
    test('converts 83 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(83.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(83.0, 0.0001));
      expect(UnitConverter.displayWeight(83.0, 'kg'), 83.0);
      expect(UnitConverter.displayWeight(83.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(83.0, 'kg'), '83 kg');
    });
    test('converts 84 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(84.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(84.0, 0.0001));
      expect(UnitConverter.displayWeight(84.0, 'kg'), 84.0);
      expect(UnitConverter.displayWeight(84.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(84.0, 'kg'), '84 kg');
    });
    test('converts 85 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(85.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(85.0, 0.0001));
      expect(UnitConverter.displayWeight(85.0, 'kg'), 85.0);
      expect(UnitConverter.displayWeight(85.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(85.0, 'kg'), '85 kg');
    });
    test('converts 86 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(86.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(86.0, 0.0001));
      expect(UnitConverter.displayWeight(86.0, 'kg'), 86.0);
      expect(UnitConverter.displayWeight(86.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(86.0, 'kg'), '86 kg');
    });
    test('converts 87 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(87.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(87.0, 0.0001));
      expect(UnitConverter.displayWeight(87.0, 'kg'), 87.0);
      expect(UnitConverter.displayWeight(87.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(87.0, 'kg'), '87 kg');
    });
    test('converts 88 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(88.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(88.0, 0.0001));
      expect(UnitConverter.displayWeight(88.0, 'kg'), 88.0);
      expect(UnitConverter.displayWeight(88.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(88.0, 'kg'), '88 kg');
    });
    test('converts 89 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(89.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(89.0, 0.0001));
      expect(UnitConverter.displayWeight(89.0, 'kg'), 89.0);
      expect(UnitConverter.displayWeight(89.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(89.0, 'kg'), '89 kg');
    });
    test('converts 90 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(90.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(90.0, 0.0001));
      expect(UnitConverter.displayWeight(90.0, 'kg'), 90.0);
      expect(UnitConverter.displayWeight(90.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(90.0, 'kg'), '90 kg');
    });
    test('converts 91 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(91.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(91.0, 0.0001));
      expect(UnitConverter.displayWeight(91.0, 'kg'), 91.0);
      expect(UnitConverter.displayWeight(91.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(91.0, 'kg'), '91 kg');
    });
    test('converts 92 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(92.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(92.0, 0.0001));
      expect(UnitConverter.displayWeight(92.0, 'kg'), 92.0);
      expect(UnitConverter.displayWeight(92.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(92.0, 'kg'), '92 kg');
    });
    test('converts 93 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(93.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(93.0, 0.0001));
      expect(UnitConverter.displayWeight(93.0, 'kg'), 93.0);
      expect(UnitConverter.displayWeight(93.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(93.0, 'kg'), '93 kg');
    });
    test('converts 94 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(94.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(94.0, 0.0001));
      expect(UnitConverter.displayWeight(94.0, 'kg'), 94.0);
      expect(UnitConverter.displayWeight(94.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(94.0, 'kg'), '94 kg');
    });
    test('converts 95 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(95.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(95.0, 0.0001));
      expect(UnitConverter.displayWeight(95.0, 'kg'), 95.0);
      expect(UnitConverter.displayWeight(95.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(95.0, 'kg'), '95 kg');
    });
    test('converts 96 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(96.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(96.0, 0.0001));
      expect(UnitConverter.displayWeight(96.0, 'kg'), 96.0);
      expect(UnitConverter.displayWeight(96.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(96.0, 'kg'), '96 kg');
    });
    test('converts 97 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(97.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(97.0, 0.0001));
      expect(UnitConverter.displayWeight(97.0, 'kg'), 97.0);
      expect(UnitConverter.displayWeight(97.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(97.0, 'kg'), '97 kg');
    });
    test('converts 98 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(98.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(98.0, 0.0001));
      expect(UnitConverter.displayWeight(98.0, 'kg'), 98.0);
      expect(UnitConverter.displayWeight(98.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(98.0, 'kg'), '98 kg');
    });
    test('converts 99 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(99.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(99.0, 0.0001));
      expect(UnitConverter.displayWeight(99.0, 'kg'), 99.0);
      expect(UnitConverter.displayWeight(99.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(99.0, 'kg'), '99 kg');
    });
    test('converts 100 kg to lbs and back', () {
      final lbs = UnitConverter.kgToLbs(100.0);
      expect(UnitConverter.lbsToKg(lbs), closeTo(100.0, 0.0001));
      expect(UnitConverter.displayWeight(100.0, 'kg'), 100.0);
      expect(UnitConverter.displayWeight(100.0, 'lbs'), lbs);
      expect(UnitConverter.formatWeight(100.0, 'kg'), '100 kg');
    });
  });

  group('UnitConverter - formatting duration', () {
    test('formats 0 seconds duration', () {
      final formatted = UnitConverter.formatDuration(0);
      expect(formatted, isNotEmpty);
      final verbal = UnitConverter.formatDuration(0, verbal: true);
      expect(verbal, isNotEmpty);
    });
    test('formats 15 seconds duration', () {
      final formatted = UnitConverter.formatDuration(15);
      expect(formatted, isNotEmpty);
      final verbal = UnitConverter.formatDuration(15, verbal: true);
      expect(verbal, isNotEmpty);
    });
    test('formats 30 seconds duration', () {
      final formatted = UnitConverter.formatDuration(30);
      expect(formatted, isNotEmpty);
      final verbal = UnitConverter.formatDuration(30, verbal: true);
      expect(verbal, isNotEmpty);
    });
    test('formats 45 seconds duration', () {
      final formatted = UnitConverter.formatDuration(45);
      expect(formatted, isNotEmpty);
      final verbal = UnitConverter.formatDuration(45, verbal: true);
      expect(verbal, isNotEmpty);
    });
    test('formats 60 seconds duration', () {
      final formatted = UnitConverter.formatDuration(60);
      expect(formatted, isNotEmpty);
      final verbal = UnitConverter.formatDuration(60, verbal: true);
      expect(verbal, isNotEmpty);
    });
    test('formats 75 seconds duration', () {
      final formatted = UnitConverter.formatDuration(75);
      expect(formatted, isNotEmpty);
      final verbal = UnitConverter.formatDuration(75, verbal: true);
      expect(verbal, isNotEmpty);
    });
    test('formats 90 seconds duration', () {
      final formatted = UnitConverter.formatDuration(90);
      expect(formatted, isNotEmpty);
      final verbal = UnitConverter.formatDuration(90, verbal: true);
      expect(verbal, isNotEmpty);
    });
    test('formats 120 seconds duration', () {
      final formatted = UnitConverter.formatDuration(120);
      expect(formatted, isNotEmpty);
      final verbal = UnitConverter.formatDuration(120, verbal: true);
      expect(verbal, isNotEmpty);
    });
    test('formats 300 seconds duration', () {
      final formatted = UnitConverter.formatDuration(300);
      expect(formatted, isNotEmpty);
      final verbal = UnitConverter.formatDuration(300, verbal: true);
      expect(verbal, isNotEmpty);
    });
    test('formats 600 seconds duration', () {
      final formatted = UnitConverter.formatDuration(600);
      expect(formatted, isNotEmpty);
      final verbal = UnitConverter.formatDuration(600, verbal: true);
      expect(verbal, isNotEmpty);
    });
    test('formats 1800 seconds duration', () {
      final formatted = UnitConverter.formatDuration(1800);
      expect(formatted, isNotEmpty);
      final verbal = UnitConverter.formatDuration(1800, verbal: true);
      expect(verbal, isNotEmpty);
    });
    test('formats 3600 seconds duration', () {
      final formatted = UnitConverter.formatDuration(3600);
      expect(formatted, isNotEmpty);
      final verbal = UnitConverter.formatDuration(3600, verbal: true);
      expect(verbal, isNotEmpty);
    });
    test('formats 3665 seconds duration', () {
      final formatted = UnitConverter.formatDuration(3665);
      expect(formatted, isNotEmpty);
      final verbal = UnitConverter.formatDuration(3665, verbal: true);
      expect(verbal, isNotEmpty);
    });
    test('formats 5400 seconds duration', () {
      final formatted = UnitConverter.formatDuration(5400);
      expect(formatted, isNotEmpty);
      final verbal = UnitConverter.formatDuration(5400, verbal: true);
      expect(verbal, isNotEmpty);
    });
    test('formats 7200 seconds duration', () {
      final formatted = UnitConverter.formatDuration(7200);
      expect(formatted, isNotEmpty);
      final verbal = UnitConverter.formatDuration(7200, verbal: true);
      expect(verbal, isNotEmpty);
    });
  });
}