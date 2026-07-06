// import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:imdbclone/services/cloudinary_services.dart';
import 'package:imdbclone/widgets/gradient_background.dart';
import 'package:image_picker/image_picker.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback openLogin;
  const SignupPage({super.key, required this.openLogin});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController genreController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  final cloudinary = CloudinaryService();

  bool isPasswordHidden = true;
  XFile? selectedImage;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    genreController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final XFile? image = (await picker.pickImage(source: ImageSource.gallery));

    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    }
  }

  Future<void> signUp() async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );

      final user = credential.user;

      String imageUrl = "";

      if (selectedImage != null) {
        imageUrl = await cloudinary.uploadImage(selectedImage!) ?? "";
      }

      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'name': nameController.text.trim(),
        'genre': genreController.text.trim(),
        'email': emailController.text.trim(),
        'profileImage': imageUrl,
        'watchList': [],
      });
    } catch (e) {
      debugPrint("ERROR: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  const Text(
                    "MovieMate",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 30),
                  const Text(
                    "Create Account",
                    style: TextStyle(fontSize: 28, color: Colors.white),
                  ),

                  const SizedBox(height: 30),

                  GestureDetector(
                    onTap: pickImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: selectedImage != null
                          ? FileImage(File(selectedImage!.path))
                          : null,
                      child: selectedImage == null
                          ? const Icon(Icons.add_a_photo)
                          : null,
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    style: TextStyle(color: Colors.white),
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    style: TextStyle(color: Colors.white),
                    controller: genreController,
                    decoration: const InputDecoration(
                      labelText: "Genre",
                      prefixIcon: Icon(Icons.category),
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    style: TextStyle(color: Colors.white),
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    style: TextStyle(color: Colors.white),
                    controller: passwordController,
                    obscureText: isPasswordHidden,
                    decoration: InputDecoration(
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordHidden = !isPasswordHidden;
                          });
                        },
                        icon: Icon(
                          isPasswordHidden
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await signUp();
                      },
                      child: const Text("Sign Up"),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: widget.openLogin,
                        child: const Text(
                          "Log In",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
