import 'package:flutter/material.dart';
import 'package:imdbclone/widgets/info_chips.dart';

class HeroSection extends StatelessWidget {
  final int selectedCategory;
  final int currentPage;
  final int currentMovieIndex;

  final Function(Map) onMovieTap;

  final PageController _pageController;

  final Function(int) onPageChanged;
  final List movies;
  const HeroSection({
    super.key,
    required this.selectedCategory,
    required this.currentPage,
    required this.currentMovieIndex,
    required this._pageController,
    required this.onPageChanged,
    required this.movies,
    required this.onMovieTap,
  });
  @override
  Widget build(BuildContext context) {
    final currentMovie = movies[currentMovieIndex];
    return Column(
      children: [
        SizedBox(
          width: 400,
          height: 400,
          child: PageView.builder(
            onPageChanged: onPageChanged,
            controller: _pageController,
            itemCount: 10000,
            itemBuilder: (context, index) {
              final movieIndex = index % movies.length;
              bool isSelected = currentPage == index;
              return AnimatedScale(
                scale: isSelected ? 1.00 : 0.85,
                duration: const Duration(milliseconds: 300),
                child: Padding(
                  padding: EdgeInsetsGeometry.all(10),
                  child: GestureDetector(
                    onTap: () {
                      onMovieTap(currentMovie);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500${movies[movieIndex]['poster_path']}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          height: 70,
          child: Center(
            child: Text(
              (currentMovie['title'] ?? currentMovie['name']).toString(),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InfoChips(
              information:
                  '⭐ ${currentMovie['vote_average'].toStringAsFixed(1)}',
            ),

            InfoChips(
              information: (currentMovie['media_type'] ?? 'Movie').toString(),
            ),

            InfoChips(
              information:
                  (currentMovie['release_date'] ??
                          currentMovie['first_air_date'] ??
                          '')
                      .toString()
                      .substring(0, 4),
            ),
          ],
        ),
      ],
    );
  }
}
