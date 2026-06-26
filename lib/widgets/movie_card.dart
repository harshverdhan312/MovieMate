import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String image;

  const MovieCard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage('https://image.tmdb.org/t/p/w500$image'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
