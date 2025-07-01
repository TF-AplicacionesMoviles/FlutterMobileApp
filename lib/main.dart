import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'navigation/dentify_app.dart';

void main() {
  runApp(
    ProviderScope(child: DentifyApp()),
  );
}
