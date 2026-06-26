import 'package:flutter/material.dart';
import 'package:imdbclone/posters.dart';
import 'package:imdbclone/widgets/gradient_background.dart';
import 'package:imdbclone/widgets/movie_card.dart';

class OnboardingPage extends StatelessWidget {
  final VoidCallback openSignup;
  const OnboardingPage({super.key, required this.openSignup});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GradientBackground(
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: posters.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: MovieCard(image: posters[index]),
                );
              },
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withAlpha(100),
                    Colors.black,
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "MOVIE MATE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 12),

                  Text(
                    "Get Movie Recommendations At Your Fingertips",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),

                  SizedBox(height: 30),

                  SizedBox(
                    width: 220,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: openSignup,
                      child: Text("GET STARTED"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
