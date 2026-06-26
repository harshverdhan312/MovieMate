import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class TmdbService {
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  final String _token = dotenv.env['TMDB_TOKEN'] ?? '';

  Map<String, String> get _headers => {
    'accept': 'application/json',
    'Authorization': 'Bearer $_token',
  };

  Future<List<dynamic>> getTrending() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/trending/all/week'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results'];
    }

    throw Exception('Failed to load trending content');
  }

  Future<List<dynamic>> getMovies() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/popular'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results'];
    }

    throw Exception('Failed to load movies');
  }

  Future<List<dynamic>> getShows() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/tv/popular'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results'];
    }

    throw Exception('Failed to load shows');
  }

  Future<List<dynamic>> getNewContent() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/movie/now_playing'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['results'];
    }

    throw Exception('Failed to load new content');
  }
}
