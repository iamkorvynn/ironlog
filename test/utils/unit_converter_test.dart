import 'package:flutter_test/flutter_test.dart';
import 'package:ironlog/utils/unit_converter.dart';

void main() {
  group('UnitConverter - kgToLbs', () {
    test('converts 0 kg to 0 lbs', () {
      expect(UnitConverter.kgToLbs(0), 0.0);
    });

    test('converts 1 kg to ~2.20462 lbs', () {
      expect(UnitConverter.kgToLbs(1), closeTo(2.20462, 0.001));
    });

    test('converts 100 kg to ~220.462 lbs', () {
      expect(UnitConverter.kgToLbs(100), closeTo(220.462, 0.01));
    });

    test('converts fractional kg', () {
      expect(UnitConverter.kgToLbs(2.5), closeTo(5.5115, 0.01));
    });

    test('handles negative kg mathematically', () {
      expect(UnitConverter.kgToLbs(-10), closeTo(-22.046, 0.01));
    });
  });

  group('UnitConverter - lbsToKg', () {
    test('converts 0 lbs to 0 kg', () {
      expect(UnitConverter.lbsToKg(0), 0.0);
    });

    test('converts 2.20462262 lbs to 1 kg', () {
      expect(UnitConverter.lbsToKg(2.20462262), closeTo(1.0, 0.0001));
    });

    test('converts 225 lbs to ~102.058 kg', () {
      expect(UnitConverter.lbsToKg(225), closeTo(102.058, 0.01));
    });

    test('round trip conversion preserves value', () {
      const original = 85.5;
      final lbs = UnitConverter.kgToLbs(original);
      final backToKg = UnitConverter.lbsToKg(lbs);
      expect(backToKg, closeTo(original, 0.0001));
    });
  });

  group('UnitConverter - displayWeight', () {
    test('returns kg value unchanged when unit is kg', () {
      expect(UnitConverter.displayWeight(75.0, 'kg'), 75.0);
    });

    test('returns kg value unchanged when unit is KG (case insensitive)', () {
      expect(UnitConverter.displayWeight(75.0, 'KG'), 75.0);
    });

    test('returns lbs value when unit is lbs', () {
      expect(UnitConverter.displayWeight(100.0, 'lbs'), closeTo(220.462, 0.01));
    });

    test('returns lbs value when unit is LBS (case insensitive)', () {
      expect(UnitConverter.displayWeight(50.0, 'LBS'), closeTo(110.231, 0.01));
    });
  });

  group('UnitConverter - inputToKg', () {
    test('returns input value unchanged when unit is kg', () {
      expect(UnitConverter.inputToKg(80.0, 'kg'), 80.0);
    });

    test('converts lbs input to kg when unit is lbs', () {
      expect(UnitConverter.inputToKg(220.462, 'lbs'), closeTo(100.0, 0.01));
    });
  });

  group('UnitConverter - formatWeight', () {
    test('formats whole kg with unit', () {
      expect(UnitConverter.formatWeight(100.0, 'kg'), '100 kg');
    });

    test('formats decimal kg with unit', () {
      expect(UnitConverter.formatWeight(102.5, 'kg'), '102.5 kg');
    });

    test('formats weight without unit when requested', () {
      expect(UnitConverter.formatWeight(80.0, 'kg', includeUnit: false), '80');
    });

    test('formats in lbs correctly', () {
      expect(UnitConverter.formatWeight(100.0, 'lbs'), '220.5 lbs');
    });

    test('formats zero weight correctly', () {
      expect(UnitConverter.formatWeight(0.0, 'kg'), '0 kg');
    });
  });

  group('UnitConverter - formatVolume', () {
    test('formats 0 kg volume', () {
      expect(UnitConverter.formatVolume(0, 'kg'), '0 kg');
    });

    test('formats volume under 1000 without comma', () {
      expect(UnitConverter.formatVolume(950, 'kg'), '950 kg');
    });

    test('formats thousands with comma', () {
      expect(UnitConverter.formatVolume(12500, 'kg'), '12,500 kg');
    });

    test('formats millions with comma', () {
      expect(UnitConverter.formatVolume(1250000, 'kg'), '1,250,000 kg');
    });

    test('formats volume in lbs with comma', () {
      final formatted = UnitConverter.formatVolume(1000, 'lbs');
      expect(formatted, contains('lbs'));
      expect(formatted, contains('2,205'));
    });

    test('formats volume without unit', () {
      expect(UnitConverter.formatVolume(5000, 'kg', includeUnit: false), '5,000');
    });
  });

  group('UnitConverter - formatDuration', () {
    test('formats 0 seconds to 00:00', () {
      expect(UnitConverter.formatDuration(0), '00:00');
    });

    test('formats negative seconds to 00:00', () {
      expect(UnitConverter.formatDuration(-10), '00:00');
    });

    test('formats 45 seconds to 00:45', () {
      expect(UnitConverter.formatDuration(45), '00:45');
    });

    test('formats 60 seconds to 01:00', () {
      expect(UnitConverter.formatDuration(60), '01:00');
    });

    test('formats 90 seconds to 01:30', () {
      expect(UnitConverter.formatDuration(90), '01:30');
    });

    test('formats 599 seconds to 09:59', () {
      expect(UnitConverter.formatDuration(599), '09:59');
    });

    test('formats 3600 seconds to 01:00:00', () {
      expect(UnitConverter.formatDuration(3600), '01:00:00');
    });

    test('formats 3665 seconds to 01:01:05', () {
      expect(UnitConverter.formatDuration(3665), '01:01:05');
    });

    test('formats verbal duration 0s to 0m', () {
      expect(UnitConverter.formatDuration(0, verbal: true), '0m');
    });

    test('formats verbal duration minutes only', () {
      expect(UnitConverter.formatDuration(1800, verbal: true), '30m');
    });

    test('formats verbal duration hours and minutes', () {
      expect(UnitConverter.formatDuration(5400, verbal: true), '1h 30m');
    });
  });

  group('UnitConverter - formatDate', () {
    test('formats DateTime correctly', () {
      final dt = DateTime(2026, 11, 23, 14, 30);
      final formatted = UnitConverter.formatDate(dt);
      expect(formatted, contains('Nov'));
      expect(formatted, contains('2026'));
      expect(formatted, contains('23'));
    });
  });

  group('UnitConverter - formatRelativeDate', () {
    test('formats today correctly', () {
      final now = DateTime.now();
      expect(UnitConverter.formatRelativeDate(now), 'Today');
    });

    test('formats yesterday correctly', () {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      expect(UnitConverter.formatRelativeDate(yesterday), 'Yesterday');
    });

    test('formats 3 days ago correctly', () {
      final threeDays = DateTime.now().subtract(const Duration(days: 3));
      expect(UnitConverter.formatRelativeDate(threeDays), '3 days ago');
    });

    test('formats older dates with month and year', () {
      final old = DateTime(2025, 5, 10);
      final formatted = UnitConverter.formatRelativeDate(old);
      expect(formatted, contains('May'));
      expect(formatted, contains('2025'));
    });
  });
}
