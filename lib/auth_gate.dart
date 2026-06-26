import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:imdbclone/pages/auth_screen.dart';
import 'package:imdbclone/pages/main_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        debugPrint("Connection: ${snapshot.connectionState}");
        debugPrint("Has Data: ${snapshot.hasData}");
        debugPrint("User: ${snapshot.data?.uid}");

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          debugPrint("Opening MainScreen");
          return Builder(
            builder: (_) {
              debugPrint("MainScreen actually returned");
              return const MainScreen();
            },
          );
        }

        debugPrint("Opening Onboarding");
        return const AuthScreen();
      },
    );
  }
}
