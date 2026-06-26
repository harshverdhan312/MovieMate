import 'package:flutter/material.dart';
import 'package:imdbclone/pages/movie_detail_page.dart';
import 'package:imdbclone/widgets/for_you_section.dart';
import 'package:imdbclone/widgets/gradient_background.dart';
import 'package:imdbclone/widgets/hero_section.dart';
import 'package:imdbclone/services/tmdb_services.dart';
import 'package:imdbclone/widgets/upper_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(
    viewportFraction: 0.75,
    initialPage: 5000,
  );
  int currentPage = 0;
  int selectedCategory = 0;
  int currentMovieIndex = 0;

  final tmdb = TmdbService();
  List trending = [];
  List movies = [];
  List shows = [];

  bool showDetails = false;
  Map? selectedMovie;

  List get currentMovies {
    switch (selectedCategory) {
      case 0:
        return trending;

      case 1:
        return movies;

      case 2:
        return movies;

      case 3:
        return shows;

      default:
        return trending;
    }
  }

  List combined = [];

  bool isLoading = true;

  Future<void> loadData() async {
    try {
      trending = await tmdb.getTrending();
      movies = await tmdb.getMovies();
      shows = await tmdb.getShows();
      combined = [...movies, ...shows];
      combined.shuffle();
      combined = combined.take(20).toList();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page?.round() ?? 0;
      });
    });
    loadData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          GradientBackground(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        UpperNavigationBar(
                          selectedCategory: selectedCategory,
                          onCategorySelected: (index) {
                            setState(() {
                              selectedCategory = index;
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        HeroSection(
                          movies: currentMovies,
                          selectedCategory: selectedCategory,
                          pageController: _pageController,
                          currentPage: currentPage,
                          currentMovieIndex: currentMovieIndex,
                          onPageChanged: (index) {
                            setState(() {
                              currentPage = index;
                              currentMovieIndex = index % currentMovies.length;
                            });
                          },
                          onMovieTap: (movie) {
                            setState(() {
                              selectedMovie = movie;
                              showDetails = true;
                            });
                          },
                        ),
                        SizedBox(height: 40),
                        ForYouSection(
                          forYou: combined,
                          onMovieTap: (movie) {
                            setState(() {
                              selectedMovie = movie;
                              showDetails = true;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          if (showDetails)
            Positioned.fill(
              child: MovieDetailPage(
                movie: selectedMovie!,
                onClose: () {
                  setState(() {
                    showDetails = false;
                  });
                },
              ),
            ),
        ],
      ),
    );
  }
}
