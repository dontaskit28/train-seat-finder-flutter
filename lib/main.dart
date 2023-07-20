import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/selection_button_provider.dart';
import 'homepage.dart';

void main() {
  // The entry point of the Flutter application.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // The root widget of the application.
    // MultiProvider allows us to define multiple providers that can be accessed from descendants.
    return MultiProvider(
      providers: [
        // Registering a ChangeNotifierProvider to provide an instance of SelectionButtonProvider.
        // This will enable us to access the provider's state throughout the app.
        ChangeNotifierProvider(create: (_) => SelectionButtonProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        // The home screen of the app, set to HomePage().
        home: HomePage(),
      ),
    );
  }
}
