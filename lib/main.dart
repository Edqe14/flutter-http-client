import 'package:flutter/material.dart';
import 'package:flutter_http_client/pages/home.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        theme: ThemeData(
          fontFamily: 'Aspekta',
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF1F7CE9),
              brightness: Brightness.dark,
              background: const Color(0xFF0E0E0E)),
          primaryColor: Colors.white,
        ));
  }
}
