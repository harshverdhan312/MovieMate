import 'package:flutter/material.dart';
import 'login_page.dart';
import 'onboarding_page.dart';
import 'signup_page.dart';

enum AuthPage { onboarding, login, signup }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthPage currentPage = AuthPage.onboarding;

  @override
  Widget build(BuildContext context) {
    switch (currentPage) {
      case AuthPage.onboarding:
        return OnboardingPage(
          openSignup: () {
            setState(() {
              currentPage = AuthPage.signup;
            });
          },
        );

      case AuthPage.signup:
        return SignupPage(
          openLogin: () {
            setState(() {
              currentPage = AuthPage.login;
            });
          },
        );

      case AuthPage.login:
        return LoginPage(
          openSignup: () {
            setState(() {
              currentPage = AuthPage.signup;
            });
          },
        );
    }
  }
}
