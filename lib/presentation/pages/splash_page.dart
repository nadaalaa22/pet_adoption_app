import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:pet_adoption_app/presentation/pages/form_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Icons.pets_outlined,
      nextScreen: FormPage(),
      splashTransition: SplashTransition.slideTransition,
      duration: 3000,
    );
  }
}
