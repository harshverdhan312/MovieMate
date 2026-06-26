import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> showForgotPasswordDialog(BuildContext context) async {
  final emailController = TextEditingController();

  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.grey.shade900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

        title: const Text(
          "Reset Password",
          style: TextStyle(color: Colors.white),
        ),

        content: TextField(
          controller: emailController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Enter your email",
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(Icons.email),
          ),
        ),

        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.white)),
          ),

          ElevatedButton(
            onPressed: () async {
              if (emailController.text.trim().isNotEmpty) {
                await FirebaseAuth.instance.sendPasswordResetEmail(
                  email: emailController.text.trim(),
                );

                if (context.mounted) {
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Password reset link sent to your email."),
                    ),
                  );
                }
              }
            },
            child: const Text("Send Link"),
          ),
        ],
      );
    },
  );
}
