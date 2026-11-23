import 'package:flutter/material.dart';
import 'package:ironlog/services/database_service.dart';

void setupTestEnvironment() {
  DatabaseService().enableInMemoryMode();
}

Widget wrapWithMaterial(Widget child) {
  return MaterialApp(
    theme: ThemeData.dark(useMaterial3: true),
    home: Scaffold(body: child),
  );
}


// Deterministic test environment configured
