import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/profile_provider.dart';
import 'screens/list_profile.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProfileProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ListProfile(),
    );
  }
}
