import 'package:flutter/material.dart';
import 'package:raven_assessment/getit.dart';
import 'package:raven_assessment/utilities/color_utils.dart';
import 'package:raven_assessment/view/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItGetUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: const ColorScheme.dark(),
          fontFamily: 'Satoshi',
          primaryColor: kcPrimaryColor,
          primarySwatch: const MaterialColor(0xFF02136B, <int, Color>{
            50: kcPrimaryColor, //10%
            100: kcPrimaryColor, //20%
            200: kcPrimaryColor, //30%
            300: kcPrimaryColor, //40%
            400: kcPrimaryColor, //50%
            500: kcPrimaryColor, //60%
            600: kcPrimaryColor, //70%
            700: kcPrimaryColor, //80%
            800: kcPrimaryColor, //90%
            900: kcPrimaryColor, //100%
          })),
      title: 'Reven Assessment',
      home: const HomeScreen(),
    );
  }
}


