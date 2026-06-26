import 'package:flutter/material.dart';

class ForYouSection extends StatelessWidget {
  final List forYou;
  final Function(Map) onMovieTap;
  const ForYouSection({
    super.key,
    required this.forYou,
    required this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "For You",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
        SizedBox(
          height: 400,
          child: GridView.builder(
            itemCount: forYou.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.7,
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final movie = forYou[index];
              return GestureDetector(
                onTap: () {
                  onMovieTap(movie);
                },
                child: SizedBox(
                  width: 400,
                  height: 400,
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
