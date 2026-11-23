import 'package:ironlog/utils/constants.dart';

class Exercise {
  final String id;
  final String name;
  final String muscleGroup;
  final String notes;
  final bool isCustom;
  final DateTime createdAt;

  const Exercise({
    required this.id,
    required this.name,
    required this.muscleGroup,
    this.notes = '',
    this.isCustom = false,
    required this.createdAt,
  });
}
