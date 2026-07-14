import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: SmartRepApp()));
}

/// Placeholder app entry. Real screens (dashboard, weigh-in, history, chart,
/// goal wizard, settings) are built in later task groups per SPEC §2.5.
class SmartRepApp extends StatelessWidget {
  const SmartRepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartRep',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const _PlaceholderHome(),
    );
  }
}

class _PlaceholderHome extends StatelessWidget {
  const _PlaceholderHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SmartRep')),
      body: const Center(child: Text('SmartRep is under construction.')),
    );
  }
}
