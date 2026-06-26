import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:imdbclone/widgets/gradient_background.dart';
import 'package:imdbclone/widgets/info_chips.dart';

class MovieDetailPage extends StatelessWidget {
  final Map<dynamic, dynamic> movie;
  final VoidCallback onClose;
  const MovieDetailPage({
    super.key,
    required this.movie,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final title = movie['title'] ?? movie['name'];
    return Scaffold(
      backgroundColor: Colors.black,
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: onClose,
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 500,
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(20),
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500${movie['poster_path']}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    title.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InfoChips(
                        information:
                            '⭐ ${movie['vote_average'].toStringAsFixed(1)}',
                      ),

                      InfoChips(
                        information: (movie['media_type'] ?? 'Movie')
                            .toString(),
                      ),

                      InfoChips(
                        information:
                            (movie['release_date'] ??
                                    movie['first_air_date'] ??
                                    '')
                                .toString()
                                .substring(0, 4),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      movie['overview'],
                      maxLines: 4,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),

                  StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(user?.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const CircularProgressIndicator();
                      }

                      final userData =
                          snapshot.data!.data() as Map<String, dynamic>;

                      final watchList = userData['watchList'] ?? [];

                      final isAdded = watchList.any(
                        (item) => item['id'] == movie['id'],
                      );

                      return SizedBox(
                        width: 220,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: isAdded
                              ? null
                              : () async {
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(user?.uid)
                                      .update({
                                        'watchList': FieldValue.arrayUnion([
                                          movie,
                                        ]),
                                      });
                                },
                          child: Text(
                            isAdded ? "Added to Watchlist" : "Add to Watchlist",
                          ),
                        ),
                      );
                    },
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
